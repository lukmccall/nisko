#include <iostream>

extern "C" void prostopadloscian( float a, float b, float c, float * objetosc, float * pole);

int main()
{
  float o;
  float p;
  prostopadloscian(2, 3, 4, &o,  &p);

  std::cout << o << "\n";
  std::cout << p << "\n";
  
  return 0;
}
/* Wyjście:
 * 14
 * 2
 */ 