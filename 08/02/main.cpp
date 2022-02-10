#include <iostream>

using namespace std;

// kopiuje n liczb typu int z zrodla do celu 
void kopiuj(unsigned int * cel, unsigned int * zrodlo, unsigned int n);

// zeruje tablice liczb typu int o rozmiarze n
void zeruj(unsigned int * tablica, unsigned int n);

int main(){
  unsigned int z1[] = {1, 2, 3, 4, 5};
  unsigned int c1[5];

  kopiuj(c1, z1, 5);

  for (size_t i = 0; i < 5; i++) {
    cout << c1[i] << " ";
  }
  cout << endl;

  zeruj(c1, 5);

  for (size_t i = 0; i < 5; i++) {
    cout << c1[i] << " ";
  }
  cout << endl;
}

/** Spodziewane wyjście
2  254
1  127
128  191
--------
2  254
256  32512
2147483648  2147483711
--------
*/