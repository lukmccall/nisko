#include <iostream> 
using namespace std;  

int DefaultFlags = 0x1F80;
int RoundUp = DefaultFlags & ~(1 << 13) & ~(1 << 14) | (1 << 14);
int RoundDown = DefaultFlags & ~(1 << 13) & ~(1 << 14) | (1 << 13);;

class Interval{ 	
  double left, right;   
public: 	
  Interval(double left, double right) 
  : left(left), right(right){ 	} 	
  double inf() { return left; } 	
  double sup() { return right; }	   	
  friend Interval operator+ (const Interval & a, const Interval &b); 	
  friend Interval operator- (const Interval & a, const Interval &b); 
};

Interval operator+ (const Interval & a, const Interval &b) {
    asm(
        "ldmxcsr (%%rax)"
        :
        : "a"(&RoundDown)
    );
    auto left = a.left + b.left;
    asm(
        "ldmxcsr (%%rax)"
        :
        : "a"(&RoundUp)
    );
    auto right = a.right + b.right;
    return {left, right};
}

Interval operator- (const Interval & a, const Interval &b) {
    asm(
        "ldmxcsr (%%rax)"
        :
        : "a"(&RoundDown)
    );
    auto left = a.left - b.left;
    asm(
        "ldmxcsr (%%rax)"
        :
        : "a"(&RoundUp)
    );
    auto right = a.right - b.right;
    return {left, right};
}

int main(){ 	
  Interval a(1.,1.); 	
  Interval b(1e-20,1e-20);  	
  Interval c = a + b; 	
  if( (c.inf() == c.sup()) or (c.sup() <= 1.0)  or (c.inf() != 1.0)) 	  
    cout << "Blad operatora +!\n";    
  c = a - b; 	
  if( (c.inf() == c.sup()) or (c.sup() != 1.0) or (c.inf() >= 1.0)) 	  
    cout << "Blad operatora -!\n";  	
  return 0; 
}