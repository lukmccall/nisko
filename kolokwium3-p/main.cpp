#include <iostream>

using namespace std;

extern "C" double fun(double* array, int N);

extern "C" float fun_float(float* array, int N);

int main() {
  const int N = 41;
  double array[N];  
  float floatArray[N];

  for (int i = 0; i < N; i++) {
    array[i] = i;
    floatArray[i] = i;
  }

  double expectedSum = 0;
  for (int i = 0; i < N; i++) {
    expectedSum += array[i];
  }

  double actualSum = fun(array, N);
  double actualFloatSum = fun_float(floatArray, N);
  
  cout << "Actual = " << actualSum << endl;
  cout << "Expected = " << expectedSum << endl;
  cout << (expectedSum == actualSum) << endl;

  cout << endl;

  cout << "Actual = " << actualFloatSum << endl;
  cout << "Expected = " << expectedSum << endl;
  cout << (expectedSum == actualFloatSum) << endl;

  return 0;
}