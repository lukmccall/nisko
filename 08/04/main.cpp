#include <iostream>
#include <sstream>
#include <cassert>
#include <cstring>

using namespace std;

void kopiuj(unsigned int * cel, unsigned int * zrodlo, unsigned int n);
void zeruj(unsigned int * tablica, unsigned int n);


class BigInt{  
  unsigned int rozmiar;   
  unsigned int * dane;      
public:  
  explicit BigInt(unsigned int rozmiar) 
  : rozmiar(rozmiar), dane( new unsigned[rozmiar] ){
    zeruj(dane, rozmiar); 
  }  

  BigInt(const BigInt & x) :  rozmiar(x.rozmiar),       dane(new unsigned[x.rozmiar]) {     
    kopiuj(dane, x.dane, x.rozmiar); 
  }   

  BigInt & operator=(const BigInt & x) {    
    if(rozmiar != x.rozmiar){      
      unsigned * tmp = new unsigned[x.rozmiar];      
      delete[] dane;       
      rozmiar = x.rozmiar;      
      dane = tmp;    
    }    
    kopiuj(dane, x.dane, x.rozmiar);    
    return *this;  
  }  

  ~BigInt(){		    
    delete[] dane;  
  }

  bool isZero() {
    for (int i = 0; i < rozmiar; i++) {
      if (dane[i] != 0) {
        return false;
      }
    }

    return true;
  }

  // do zaimplementowania w zadaniu 3  
  int dodaj(unsigned int n);  
  int pomnoz(unsigned int n);  
  int podzielZReszta(unsigned int n);

  BigInt & operator=(const char * liczba) {
    size_t len = strlen(liczba);

    if (rozmiar != len){      
      unsigned * tmp = new unsigned[len];      
      delete[] dane;       
      rozmiar = len;      
      dane = tmp;    
    } else {
      zeruj(dane, len);    
    }

    int i = 0;
    while (liczba[i] != 0) {
      pomnoz(10);
      dodaj(liczba[i] - '0');
      i++;
    }

    return *this;
  }

  friend std::ostream & operator << (std::ostream & str, const BigInt & x);

  friend BigInt operator+ (const BigInt & a, const BigInt & b);  
  friend BigInt operator- (const BigInt & a, const BigInt & b);
};

std::ostream & operator << (std::ostream & str, const BigInt & x) {
  BigInt copy(x);
  stringstream ss; 
  do {
    int rest = copy.podzielZReszta(10);
    ss << rest;
  } while (!copy.isZero());
  
  string tmp(ss.str());
  string result(tmp.rbegin(), tmp.rend());
  str << result;
  return str;
}


void testOverflow() {
  BigInt a(1);
  assert(a.dodaj(4294967295) == 0);
  assert(a.dodaj(1) == 1);

  BigInt b(1);
  b.dodaj(4294967295);
  assert(b.pomnoz(2) == 1);

  BigInt c(2);
  c.dodaj(4294967295);
  assert(c.pomnoz(2) == 0);
}

void testMultiplication() {
  BigInt a(2);
  a.dodaj(4294967295);
  a.pomnoz(2);
  cout << a << endl; // 8589934590
  a.pomnoz(48);
  cout << a << endl; // 412316860320

  BigInt b(1);
  b.dodaj(1);
  b.pomnoz(12);
  cout << b << endl; // 12
}

void testAddition() {
  BigInt a(1);
  a.dodaj(4294967295);
  cout << a << endl; // 4294967295

  BigInt b(1);
  b.dodaj(156);
  b.dodaj(98); 
  cout << b << endl; // 254
}

void testAssignment() {
  BigInt x(1);
  x = "123456789";
  cout << x << endl; // 123456789
  x = "1234214243543543543243543534";
  cout << x << endl; // 1234214243543543543243543534
}

void testPlus() {
  BigInt a(1);
  BigInt b(1);
  a = "1234";
  b = "1234";
  BigInt c = a + b;
  cout << c << endl; // 2468

  a = "999";
  b = "1";
  c = a + b;
  cout << c << endl; // 1000
}

void testMinus() {
  BigInt a(1);
  BigInt b(1);
  a = "1234";
  b = "1234";
  BigInt c = a - b;
  cout << c << endl; // 0

  a = "999";
  b = "111";
  c = a - b;
  cout << c << endl; // 888
}

int main() {
  testOverflow();
  testAddition();
  testMultiplication();
  testAssignment();
  testPlus();
  testMinus();
}