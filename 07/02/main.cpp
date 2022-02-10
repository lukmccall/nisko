#include <stdio.h>

extern "C" double wartosc (double a, double b, double x, int n);


int main(){
  double r = wartosc(4, 3, 2, 2);
  
  printf("%lf", r);
  
  return 0;
}