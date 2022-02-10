#include <stdio.h>

extern "C" int iloczyn (int n, ...);


int main(){
  int r = iloczyn(4, 1, 2, 3, 4);
  printf("%d", r);
  
  return 0;
}