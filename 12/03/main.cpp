#include <iostream>

using namespace std;

// represents abstract operation #

class Node{

 public:

  // return element such that x # identity() = x

  virtual double identity() = 0;
  // returns solution to x # a = identity()
  virtual double inverse(double a) = 0;
  // compute a # b
  virtual double compute(double a, double b) = 0;
  virtual ~Node(){}

};

class AddNode : public Node {
 public:
  virtual double inverse(double a) { return -a; }
  virtual double compute(double a, double b) { return a + b; }
  virtual double identity(){ return 0.0; }
};

class MulNode : public Node {
 public:
  virtual double inverse(double a) { return 1.0 / a; }
  virtual double compute(double a, double b){ return a*b; }
  virtual double identity(){ return 1.0; }
};

class SubNode : public Node {
  public:
  virtual double inverse(double a){ return a; }
  virtual double compute(double a, double b) { return a - b; }
  virtual double identity() { return 0.0; }
};

// returns sum of results returned by virtual functions calls

// for each element of an array tab (of given size) we call

// virtual function depending on how many floating point arguments are given in ...

extern "C" double sum(Node ** tab, int size, ...);

int main(){
  Node * tab[] = {new AddNode(), new MulNode(), new SubNode() };
  cout << sum(tab, 3) << endl;                   // 1.0
  cout << sum(tab, 3, 4.0, 2.0) << endl;     // 16
  cout << sum(tab, 3, 0.5) << endl;            // 2
  cout << sum(tab, 2, 0.5) << endl;            // 1.5
  return 0;

}