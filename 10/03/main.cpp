#include <iostream>
#include <cmath>
#include <immintrin.h>

using namespace std;

// width powinien dzielic sie przez 4

const int width = 300, height = 168;

template <typename T>
void CoutM128(__m128 m)
{
  T *m_ = (T *)&m;
  size_t N = 16 / sizeof(T);
  for (size_t n = 0; n < N; ++n)
  {
    std::cout << m_[n] << ", ";
  }
  std::cout << std::endl;
}

void boundValue(float image[height][width], int i, int j)
{
  if (image[i][j] > 255)
  {
    image[i][j] = 255;
  }
  else if (image[i][j] < 0)
  {
    image[i][j] = 0;
  }
}

void filtr(int imageWidth, int imageHeight, float image[height][width],
           float weight[3][3], float result[height][width])
{
  __m128 r[3][3];
  __m128 w[3][3];
  float weightSum = 0;

  for (int i = 0; i < 3; i++)
  {
    for (int j = 0; j < 3; j++)
    {
      weightSum += weight[i][j];
      w[i][j] = _mm_load_ps1(&weight[i][j]);
    }
  }

  if (weightSum == 0)
  {
    weightSum = 1;
  }

  __m128 weightSumVector = _mm_load_ps1(&weightSum);

  for (int i = 1; i < imageHeight - 1; i += 1)
  {
    for (int j = 1; j < imageWidth - 1; j += 4)
    {
      for (int dx = -1; dx <= 1; dx++)
      {
        for (int dy = -1; dy <= 1; dy++)
        {
          float *target = &(image[i + dx][j + dy]);
          r[dx + 1][dy + 1] = _mm_loadu_ps(target);
        }
      }

      for (int dx = 0; dx < 3; dx++)
      {
        for (int dy = 0; dy < 3; dy++)
        {
          r[dx][dy] = _mm_mul_ps(r[dx][dy], w[dx][dy]);
        }
      }

      auto output = _mm_setzero_ps();
      for (int dx = 0; dx < 3; dx++)
      {
        for (int dy = 0; dy < 3; dy++)
        {
          output = _mm_add_ps(output, r[dx][dy]);
        }
      }

      output = _mm_div_ps(output, weightSumVector);

      _mm_storeu_ps((float *)(&result[i][j]), output);
      boundValue(result, i, j);
      boundValue(result, i, j + 1);
      boundValue(result, i, j + 2);
      boundValue(result, i, j + 3);
    }
  }

  for (int i = 0; i < imageWidth; i++)
  {
    result[0][i] = image[0][i];
    result[imageHeight - 1][i] = image[imageHeight - 1][i];
  }

  for (int i = 0; i < imageHeight; i++)
  {
    result[i][0] = image[i][0];
    result[i][imageWidth - 1] = image[i][imageWidth - 1];
  }
}

int main(void)
{
  const int headerLength = 122; // 64; //sizeof(BMPHEAD);
  char header[headerLength];
  float data[3][height][width];
  float result[3][height][width];
  float weight[3][3] = {{0, -2, 0}, {-2, 11, -2}, {0, -2, 0}};
  // float weight[3][3] = {{-1, -1, -1}, {-1, 8, -1}, {-1, -1, -1}};

  int i, j, k;

  FILE *file;

  file = fopen("pigeon.bmp", "rb");
  if (!file)
  {
    std::cerr << " Error opening file !";
    exit(1);
  }

  fread(header, headerLength, 1, file);

  for (i = 0; i < height; i++)
    for (j = 0; j < width; j++)
      for (k = 0; k < 3; ++k)
        data[k][i][j] = fgetc(file);

  fclose(file);

  for (i = 0; i < 3; i++)
    filtr(width, height, data[i], weight, result[i]);

  file = fopen("result.bmp", "wb");

  fwrite(header, headerLength, 1, file);

  for (i = 0; i < height; i++)
    for (j = 0; j < width; j++)
      for (k = 0; k < 3; ++k)
        fputc((unsigned char)result[k][i][j], file);

  fclose(file);
}