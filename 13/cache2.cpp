#include <iostream>
#include <chrono>
#include <ctime>
#include <climits>
#include <algorithm>
using namespace std;
int main()
{
  const int M = 256 * 256; // array size
  const int ITER = 10000;  // number of iterations
  const int THRESHOLD = 128;
  int i, k;
  unsigned char tab[M];
  std::srand(0);
  std::generate(tab, tab + M, []
                { return std::rand() % 256; });

  std::sort(tab, tab + M); ///<<<<<<<<<<<<<<<<<<< SORT

  std::chrono::time_point<std::chrono::system_clock> start, end;
  start = std::chrono::system_clock::now();
  int sum = 0;
  for (k = 0; k < ITER; k++)
  {
    for (i = 0; i < M; i++)
    {
      if (tab[i] < THRESHOLD)
      {
        sum += tab[i];
      }
    }
  }
  end = std::chrono::system_clock::now();
  std::chrono::duration<double> elapsed_seconds = end - start;
  std::cout << "\nelapsed time: " << elapsed_seconds.count() << "s\n";
  std::cout << sum << std::endl;
}