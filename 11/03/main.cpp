// Kompilacja: g++ -std=c++11 -o main.o -c main.cpp
#include <iostream>
#include <vector>
#include <emmintrin.h>
#include <smmintrin.h>
#include <algorithm>
#include <immintrin.h>

using namespace std;
const int dim=256;
const int N=dim;

float buffor[N];


void matmulSSE_v2(float mat1[N][N], float mat2[N][N], float result[N][N]) {
    __m256 vA, vB, vR, zero;

   zero = _mm256_setzero_ps();
   for (int i = 0; i < N; ++i) {
      for (int j = 0; j < N; j += 8) {
         _mm256_storeu_ps(&result[i][j], zero);
      }
   }

    for(int k = 0; k < N; ++k) {       
      for(int i = 0; i < N; ++i) {
         
            vA = _mm256_set1_ps(mat1[i][k]);

            for(int j = 0; j < N; j += 8) {
                vB = _mm256_loadu_ps((float*)&mat2[k][j]);
                vR = _mm256_loadu_ps((float*)&result[i][j]);
                vR = _mm256_add_ps(vR, _mm256_mul_ps(vA, vB));
                _mm256_storeu_ps((float*)&result[i][j], vR);
            }
        }
    }
}


void matmulSSE_v3(float mat1[N][N], float mat2[N][N], float result[N][N]) {
    __m256 vA, vB, vR, zero;

   zero = _mm256_setzero_ps();
   for (int i = 0; i < N; ++i) {
      for (int j = 0; j < N; j += 8) {
         _mm256_storeu_ps(&result[i][j], zero);
      }
   }

    for(int k = 0; k < N; ++k) {
        for(int j = 0; j < N; j += 8) {
           vB = _mm256_loadu_ps((float*)&mat2[k][j]);
           _mm256_storeu_ps(buffor + j, vB);
        }
        
      for(int i = 0; i < N; ++i) {
            
            vA = _mm256_set1_ps(mat1[i][k]);

            for(int j = 0; j < N; j += 8) {
                vB = _mm256_loadu_ps(buffor + j);
                vR = _mm256_loadu_ps((float*)&result[i][j]);
                vR = _mm256_add_ps(vR, _mm256_mul_ps(vA, vB));
                _mm256_storeu_ps((float*)&result[i][j], vR);
            }
        }
    }
}


void matmulSSE_v4(float mat1[N][N], float mat2[N][N], float result[N][N]) {
   size_t kb = 24u;

   for (size_t kk = 0; kk < N; kk += kb)
   {
      for (size_t i = 0; i < N; i += 1) {
         for (size_t j = 0; j < N; j += 16) {
            __m256 sumA_1, sumB_1;
            if (kk == 0) {
               sumA_1 = sumB_1 = _mm256_setzero_ps();
            }
            else {
               sumA_1 = _mm256_loadu_ps(&result[i][j]);
               sumB_1 = _mm256_loadu_ps(&result[i][j + 8]);
            }
            size_t limit = kk + kb;
            if (limit > N) {
               limit = N;
            }
            for (size_t k = kk; k < limit; k++) {
               auto bc_mat1_1 = _mm256_set1_ps(mat1[i][k]);
               auto vecA_mat2 = _mm256_loadu_ps(&mat2[k][j]);
               auto vecB_mat2 = _mm256_loadu_ps(&mat2[k][j + 8]);
               sumA_1 = _mm256_add_ps(sumA_1, _mm256_mul_ps(bc_mat1_1, vecA_mat2));
               sumB_1 = _mm256_add_ps(sumB_1, _mm256_mul_ps(bc_mat1_1, vecB_mat2));
            }
            _mm256_storeu_ps(&result[i][j], sumA_1);
            _mm256_storeu_ps(&result[i][j + 8], sumB_1);
         }
      }
   }
}



extern "C" void multiply(float A[dim][dim], float B[dim][dim], float C[dim][dim]);

int main(int argc, char **argv){
   float C1[dim][dim];
   int C2[dim][dim];
    float C3[dim][dim];
   {
      float A[dim][dim]; 
      float B[dim][dim]; 
      for(int i=0; i<dim; i++){
         for(int j=0; j<dim; j++){
            A[i][j] = i;
            B[i][j] = (i-j)%19;
         }
      }

      multiply(A, B, C1);

      int coeff[]={0, 1, 2, 3, 4, 100, 255}; 
      for(int i: coeff){
         for(int j : coeff){
            cout << C1[i][j] << " ";
         }
         cout << "\n";
      }
     
  }


   // {
   //    float A[dim][dim]; 
   //    float B[dim][dim]; 
   //    for(int i=0; i<dim; i++){
   //       for(int j=0; j<dim; j++){
   //          A[i][j] = i ;
   //          B[i][j] = (i-j)%19;
   //          C3[i][j] = 0;
   //       }
   //    }
   //    for(int i = 0; i < dim; ++i)
   //       for(int j = 0; j < dim; ++j)
   //             for(int k = 0; k < dim; ++k)
   //             {
   //                C3[i][j] += A[i][k] * B[k][j];
   //             }
   // }

   // for (int i = 0; i < 256; i++) {
   //    for (int j = 0; j < 256; j++) {
   //       // if ((int)C1[i][j] != C2[i][j]) {
   //       //    cout << "Blad" << endl;
   //       // }

   //       if (C1[i][j] != C3[i][j]) {
   //          cout << i << " " << j << endl;
   //          cout << C1[i][j] << " != " << C3[i][j] << endl;
   //          return 0;
   //       } 
   //    }
   // }
  return 0;
}
/**
 * Oczekiwane wyjście
 * 
0 0 0 0 0 0 0 
2259 2250 2241 2232 2223 504 -2259 
4518 4500 4482 4464 4446 1008 -4518 
6777 6750 6723 6696 6669 1512 -6777 
9036 9000 8964 8928 8892 2016 -9036 
225900 225000 224100 223200 222300 50400 -225900 
576045 573750 571455 569160 566865 128520 -576045 
*/