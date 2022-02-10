#include <stdio.h>

long oblicz(short param_1,int param_2,long param_3)
{
  unsigned int  uVar1;
  short local_a;
  int local_8;
  
  local_8 = 1;
  for (local_a = 0; local_a < param_1; local_a = local_a + 1) {
    local_8 = local_8 * param_2;
  }
  uVar1 = (unsigned int)(local_8 >> 31) >> 27;
  return param_3 + ((local_8 + uVar1 & 0b00011111) - uVar1);
}

long oblicz2(short a, int b, long c) {
  int sum = 1;

  for (short counter = 0; counter < a; counter++) {
    sum *= b;
  }

  unsigned int offset = ((unsigned int)sum >> 31) * 31;
  return c + (sum + offset & 31) - offset;
}

int main(){ 
  {
    short a = 1;
    int  b = -10;
    long c = 30;
    // printf(" Podaj trzy liczby : ");
    // scanf("%hd %d %ld", &a, &b, &c);	
    printf(" Wynik : %ld \n", oblicz(a, b, c));
    printf(" Wynik : %ld \n", oblicz2(a, b, c));
  }

  {
    short a = 1;
    int  b = -5;
    long c = 5;
    // printf(" Podaj trzy liczby : ");
    // scanf("%hd %d %ld", &a, &b, &c);	
    printf(" Wynik : %ld \n", oblicz(a, b, c));
    printf(" Wynik : %ld \n", oblicz2(a, b, c));

  }

  {
    short a = 1;
    int  b = -14;
    long c = 1;
    // printf(" Podaj trzy liczby : ");
    // scanf("%hd %d %ld", &a, &b, &c);	
    printf(" Wynik : %ld \n", oblicz(a, b, c));
    printf(" Wynik : %ld \n", oblicz2(a, b, c));

  }

  {
    short a = -10;
    int  b = -14;
    long c = 1;
    // printf(" Podaj trzy liczby : ");
    // scanf("%hd %d %ld", &a, &b, &c);	
    printf(" Wynik : %ld \n", oblicz(a, b, c));
    printf(" Wynik : %ld \n", oblicz2(a, b, c));

  }

  {
    short a = 1;
    int  b = 4294967295;
    long c = -1;
    // printf(" Podaj trzy liczby : ");
    // scanf("%hd %d %ld", &a, &b, &c);	
    printf(" Wynik : %ld \n", oblicz(a, b, c));
    printf(" Wynik : %ld \n", oblicz2(a, b, c));
  }

  {
    short a = 1;
    int  b = -2147483647;
    long c = 1;
    // printf(" Podaj trzy liczby : ");
    // scanf("%hd %d %ld", &a, &b, &c);	
    printf(" Wynik : %ld \n", oblicz(a, b, c));
    printf(" Wynik : %ld \n", oblicz2(a, b, c));
  }

  {
    short a = 30;
    int  b = -2147483647;
    long c = 2147483647;
    // printf(" Podaj trzy liczby : ");
    // scanf("%hd %d %ld", &a, &b, &c);	
    printf(" Wynik : %ld \n", oblicz(a, b, c));
    printf(" Wynik : %ld \n", oblicz2(a, b, c));
  }
  
	return 0;
}