#include <stdio.h>

// TODO: zaimplementować w assemblerze
// Zwraca xn, gdzie xn=(x_{n-1} / a) + b
long double oblicz(int a, float b, long double x0, int n);
int main(){
    printf("%Lf\n", oblicz(2, 1., 1., 1));
    printf("%Lf\n", oblicz(2, 1., 512., 10));
    printf("%Lf\n", oblicz(-4, -1., -1., 5));
    printf("%Lf\n", oblicz(2, 32., 128., 7));
    
    return 0;
}
/* Spodziewane wyjście:
1.500000
2.498047
-0.799805
64.500000
*/