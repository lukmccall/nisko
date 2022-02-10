#include <iostream>

using namespace std;

void kopiuj(unsigned int * cel, unsigned int * zrodlo, unsigned int n) {
  asm(
    "rep movsd"
    : 
    : "c"(n), "S"(zrodlo), "D"(cel)
  );
}

int main(){
  unsigned int z1[] = {1, 2, 3, 4, 5};
  unsigned int c1[5];

  kopiuj(c1, z1, 5);

  for (size_t i = 0; i < 5; i++) {
    cout << c1[i] << " ";
  }
  cout << endl;
}

