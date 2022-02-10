#include <iostream> 
#include <chrono> 
#include <ctime> 
using namespace std;  
int main() {     
  const int M = 256;    // Sprawdź też rozmiary 128, 512, 1024     
  int i, j, k;     
  int tab[M][M];     
  chrono::time_point<chrono::system_clock> start, end;     
  start = chrono::system_clock::now();          
  for(k=0; k<1000; k++){                  
    for(i=0; i<M; i++){             
      for(j=0; j<M; j++){                
        // tab[j][i] =  j*i+k;       // Wersja 1.                
        tab[i][j] = j*i+k;    // Wersja 2.             
      }         
    }     
  }          
  end = chrono::system_clock::now();     
  chrono::duration<double> elapsed_seconds = end-start;     
  cout << "elapsed time: " << elapsed_seconds.count() << "s\n";      
  int suma=0;      
  for(int i=0; i<M; i++){         
    for(int j=0; j<M; j++){             
      suma+= tab[i][j];         
    }     
  }        
  cout << suma <<endl; }