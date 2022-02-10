#include <cstdio>                               //( 1)
#include "immintrin.h"                          //( 2)
using namespace std;                            //( 3)
double przetworz(double, double);               //( 4)
int przetworz(int, int);                        //( 5)
double przetworz(const double*, const double*); //( 6)
void przetworz(float*, float*);                 //( 7)
                                                //( 8)
int main(){                                     //( 9)
 double x=2.0, y=-3.0;                          //(10)
 printf("%f\n",przetworz(3.0, 5.0));            //(11)
 printf("%d\n",przetworz(15, 12));              //(12)
 printf("%f\n",przetworz(&x, &y));              //(13)
 printf("%f\n",przetworz(&y, &x));              //(14)
 float w[4]={1.0, 6.0, 4.0, 8.0};               //(15)
 float z[4]={5.0, 3.0, 2.0, 1.0};               //(16)
 przetworz(w,z);                                //(17)
 printf("[%f %f %f %f]\n",w[0],w[1],w[2],w[3]); //(18)
 return 0;                                      //(19)
}                                               //(20)
                                                //(21)
void przetworz(float * x, float * y){           //(22)
    __m128 a = _mm_loadu_ps(x);                 //(23)
    __m128 b = _mm_loadu_ps(y);                 //(24)
    // w[0] - w[1], w[2] - w[3], z[0] - z[1], z[2] - z[3]
    __m128 c = _mm_hsub_ps(a, b);               //(25)
    _mm_storeu_ps(x, c);                        //(26)
}                                               //(27)

/*
14.000000
60
1.000000
11.000000
[-5.000000 -4.000000 2.000000 1.000000]
*/