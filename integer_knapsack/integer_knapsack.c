#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "integer_knapsack.h"

#define MAX(A,B) ((A) > (B) ? A : B)

int compare_int(const void *first, const void *second) {
  return *(int *)first - *(int *)second;
}

int *copy_and_sort(int *list, int size) {
  int *sorted_list = calloc(size, sizeof(int));
  memcpy(sorted_list, list, size * sizeof(int));
  qsort(sorted_list, size, sizeof(int), compare_int);
  return sorted_list;
}

void print_arr(int *list, int size) {
  for (int i = 0; i < size; i ++) {
    printf("%d\n", list[i]);
  }
}

// Print out solution and return weight
int solve_knapsack(int *list, unsigned int size, int weight)
{
  //list = copy_and_sort(list, size);

  int MEMOIZED[size + 1][weight + 1];
  memset(MEMOIZED, 0, sizeof(int) * (size + 1) * (weight + 1));

  for (int i = 1; i <= size; i++) {
    for (int w = 1; w <= weight; w++) {

      int index = i - 1;
      int el_weight = list[index];
      if (el_weight > w) {
        MEMOIZED[i][w] = MEMOIZED[i-1][w];
      } else {
        MEMOIZED[i][w] = 
          MAX(MEMOIZED[i-1][w], MEMOIZED[i-1][w-el_weight] + el_weight);
      }
    }
  }

  return MEMOIZED[size][weight];
}
