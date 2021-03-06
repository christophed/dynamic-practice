#include <stdbool.h>
#include <assert.h>
#include "./integer_knapsack.h"

void test1() {
  int array[] = {2, 4, 5, 3, 6, 9, 2, 3};
  int best_weight = solve_knapsack(array, 8, 10);
  assert(best_weight == 10);
}

void test2() {
  int array[] = {2, 1, 1, 3};
  int best_weight = solve_knapsack(array, 4, 5);
  assert(best_weight == 5);
}

void test3() {
  int array[] = {1, 3, 2, 1};
  int best_weight = solve_knapsack(array, 4, 3);
  assert(best_weight == 3);
}

int main() {
  test1();
  test2();
  test3();
}
