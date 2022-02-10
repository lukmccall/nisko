#include <iostream>

using namespace std;

struct newVf{
  size_t  top_offset;
  void * typeinfo; 
  void *f;         // wskaźnik na nową funkcję   
  void *g;         // wskaźnik na drugą funkcję wirtualną 
  void *vf;        // wskaźnik na starą tablicę funkcji virtualnych
}; 


extern "C" void new_oblicz(void * ptr);

void zmien(void * ptr) {
    newVf* newVt = new newVf;  
    char* vTablePointer = *(char**)ptr;

    newVt->top_offset = *(size_t*)(vTablePointer-16);
    newVt->typeinfo = *(void**)(vTablePointer-8);
    
    newVt->f = (void *)&new_oblicz;
    newVt->g = *(void**)(vTablePointer+8);
    newVt->vf = vTablePointer;

    *(char**)ptr = (char*)((char *)(newVt)+16);
}

class A{
  public:
  virtual int oblicz(int n){
    return n*n;
  }

  virtual void wypisz(){
     cout << "hej! ";
  }

};

class B : public A {
  public:
  int oblicz(int n){
    return 3*n  - 4;
  }
};

class F {
  public:
  virtual int wylicz(int a, int b){
     return a - b;
  }

  virtual int oblicz(int a){
    return 3*a;
  }

};



int main(){
  A a, b; 
  A *pa = new A, *pb = new B, *pc = new B; 
  cout << pa->oblicz(1)<< " "<< pb->oblicz(2) << " " << pc->oblicz(3) << endl;
  zmien(pa); zmien(pb);
  cout << pa->oblicz(1) << " "<< pb->oblicz(2) << " " << pc->oblicz(3)  << endl;
  pa->wypisz();
  pb->wypisz();

  F *pf = new F;
  cout << pf->wylicz(7, 2) << " "<< pf->oblicz(2)  << endl;
  zmien(pf);
  cout << pf->wylicz(7, 2) << " "<< pf->oblicz(2) << endl;
  return 0;

}

// Spodziewane wyjście:

// 1 2 5

// 0 1 5

// hej! hej!

// 5 6

// 4 6