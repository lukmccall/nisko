#include <stdio.h>                                //( 1)
                                                  //( 2)
double sumuj(double a, double b, double c,        //( 3)
       double d, double e, double * element);     //( 4)
                                                  //( 5)
int main(){                                       //( 6)
  // store in ebx
  register int a = 1;                             //( 7)
  double element =0.0, wynik=0.0;                 //( 8)
  wynik = sumuj(1, 2, 7, 4, 5, &element);         //( 9)
  printf("%f | %f\n", wynik , element );          //(10)
  wynik = sumuj(-1.5,2.5,-3.5,4.5,-5.5,&element); //(11)
  printf("%f | %f\n", wynik, element );           //(12)
  wynik = sumuj(-1, -2, -3, -4, -5, &element);    //(13)
  printf("%f | %f\n", wynik, element );           //(14)
  printf("%d\n", a);                              //(15)
}                                                 //(16)

/*
19.000000 | 0.000000
2.000000 | -5.500000
-10.000000 | -5.000000
1
*/