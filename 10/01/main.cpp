#include <cstdlib>
#include <cstdio>
#include <ctime>
#include <emmintrin.h>

using namespace std;

int main(){
  int rozmiar = 100;
  unsigned char tab[rozmiar];

  //srand(time(0));

  srand(2016);

  for(int i=0; i<rozmiar; ++i){
    tab[i] = rand() % 250;
  }

  __m128i max = _mm_loadu_si128((const __m128i*)tab);

  for (int i = 1; i < rozmiar / 16; i++) {
    __m128i current = _mm_loadu_si128((const __m128i*)(tab + i * 16));
    max = _mm_max_epu8(max, current);
  }

  unsigned char storedMax[16];
  _mm_storeu_si128((__m128i*)storedMax, max);

  unsigned char charMax = 0;
  for (int i=0; i < 16; ++i) {
    if (storedMax[i] > charMax) { 
      charMax = storedMax[i];
    }
  }

  unsigned int offset = (rozmiar / 16) * 16;
  for (int i = 0; i < rozmiar % 16; i++) {
    if (tab[offset + i] > charMax) { 
      charMax = tab[offset + i];
    }
  }


  printf("%d\n", charMax);
  return 0;
}
