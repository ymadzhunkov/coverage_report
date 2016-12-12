#include "factorial.h"

int factorial(const int number) {
  return number <= 1 ? 1 : factorial(number - 1) * number;
}
