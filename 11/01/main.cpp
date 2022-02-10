#include <cstdio>
#include <time.h>
#include <cstdlib>
using namespace std;

extern "C" void minmax(int n, int * tab, int * max, int * min);

void minmax2(int n, int * tab, int * max, int * min) {
    int minT = tab[0];
    int maxT = tab[0];

    for (int i = 0; i < n; i++) {
        if (tab[i] > maxT) {
            maxT = tab[i];
        }

        if (tab[i] < minT) {
            minT = tab[i];
        }
    }

    *max = maxT;
    *min = minT;
}

int main(){

   const int rozmiar = 16;
   const int liczba_powtorzen = 10000; 

   int tab[rozmiar];
//    srand(2021); 
   srand(time(NULL));
   for(int i=0; i<rozmiar; ++i){
     tab[i] = -(rand() % 20192020);
   }
//    tab[rozmiar-1] = -20000000;
   int min, max;
   
   clock_t start, stop;
   start = clock();

   for(int i=0; i<liczba_powtorzen; i++){
      minmax(rozmiar, tab, &max, &min);
   }
   printf("min = %d    max = %d\n", min, max);
   
   stop = clock();
   printf("\n time = %f ( %d cykli)\n", (stop - start)*1.0/CLOCKS_PER_SEC, (stop - start));
   
   minmax2(rozmiar, tab, &max, &min);
   printf("min = %d    max = %d\n", min, max);

   return 0;
}
/* 
  min = -20000000    max = 10191479
*/