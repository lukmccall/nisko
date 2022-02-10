#include <stdio.h>

extern "C" int suma(int n, int* tab);

int main(){
  int tab[] ={1, 2, 3, 4};
  int r = suma(4, tab);
  
  printf("\n Suma = %d \n", r);
  
  return 0;
}