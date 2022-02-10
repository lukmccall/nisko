long oblicz2(short a, int b, long c) {
  int sum = 1;

  for (short counter = 0; counter < a; counter++) {
    sum *= b;
  }

  
  unsigned int offset = ((unsigned int)sum >> 31) * 31;
  return c + (sum + offset & 31) - offset;

  // return c + sum % 32;
}
