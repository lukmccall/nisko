#include <iostream>

using namespace std;

double func(double x) {
  return x * x;
}

extern "C" void transform(double* array, int N, double (*func)(double));

extern "C" void transform2(double* array, int N);

int main() {
  double array[] = {1, 2, 3, 4, 5};
  double array2[] = {5, 4, 3, 2, 1};
  const int N = 5;

  transform(array, N, func);

  for (int i = 0; i < N; i++) {
    cout << array[i] << endl;
  }

  cout << endl;

  transform2(array2, N);

  for (int i = 0; i < N; i++) {
    cout << array2[i] << endl;
  }
}