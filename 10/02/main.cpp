#include <stdio.h>
#include <emmintrin.h>
#include <xmmintrin.h>
#include <immintrin.h>
#include <pmmintrin.h>

void scaleSSE(float* output, float* data, int size) {
  float quarter = 0.25;
  auto q = _mm_load_ps1(&quarter);

  for(int offset = 0; offset < size / 2; offset += 4) {
    float* currentData = data + (offset * 2);
    float* currentOutput = output + offset;

    __m128 a = _mm_loadu_ps(currentData);
    __m128 b = _mm_loadu_ps(currentData + 4);
    __m128 c = _mm_loadu_ps(currentData + size);
    __m128 d = _mm_loadu_ps(currentData + size + 4);
  
    auto ac = _mm_add_ps(a, c);
    auto bd = _mm_add_ps(b, d);
    
    auto abcd = _mm_hadd_ps(ac, bd);
  
    auto result = _mm_mul_ps(abcd, q);

    _mm_store_ps(currentOutput, result);
  }
}

int main(void)
{
    float data[400][400],dum[200][200];
    unsigned char header[1078];
    unsigned char ch;
    int N=400,HL=1078;
    int i,j;

    FILE *strm;
    strm=fopen("circle3.bmp","rb");
    for(i=0;i<HL;i++) header[i]=fgetc(strm);
    for(i=0;i<N;i++)
        for(j=0;j<N;j++)
            data[i][j]=(float)fgetc(strm);
    fclose(strm);

    for(i=0;i<N/2;i++) scaleSSE(dum[i],data[2*i],N);
    
// Modyfikujemy rozmiar bitmapy w nagłówku
    header[4]=0;
    header[3]=160;
    header[2]=118;

    header[18]=200;
    header[19]=0;
    header[22]=200;
    header[23]=0;

    strm=fopen("wynik.bmp","wb");
    for(i=0;i<HL;i++) fputc(header[i],strm);      
    for(i=0;i<N/2;i++)
        for(j=0;j<N/2;j++)
            fputc((unsigned char)dum[i][j],strm);
    fclose(strm);
}