#include <iostream>                       //( 1)
using namespace std;                      //( 2)
class Poly{                               //( 3)
  int a = 2;                              //( 4)
  public:                                 //( 5)
  virtual int f(int x) {return 0;}        //( 6)
  virtual int g(int x, int y) {return 0;} //( 7)
  virtual int h(int y)  {return 0;}       //( 8)
};                                        //( 9)
extern "C" void change(void * );          //(10)
                                          //(11)
int main(){                               //(12)
  Poly * p = new Poly();                  //(13)
  change(p);                              //(14)
  cout << p->f(7) << endl;                //(15)
  cout << p->g(7,3) << endl;              //(16)
  cout << p->h(4) << endl;                //(17)
  delete p;                               //(18) 
}                                         //(19)

/*
6
4
9

a = 1
*/