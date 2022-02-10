#include <iostream>

using namespace std;

class A{

  public:

  virtual int oblicz(int n){

    return n*n;

  }

};

extern "C" void zmien(A & a);

int main(){

  A a, b; 

  A *pa = &a, *pb = &b; 

  cout << pa->oblicz(1) << " " << pa->oblicz(2)<< " "<< pb->oblicz(2) << endl;

  zmien(a);

  cout << pa->oblicz(1) << " " << pa->oblicz(2)<< " "<< pb->oblicz(2) << endl;

   

  return 0;

}