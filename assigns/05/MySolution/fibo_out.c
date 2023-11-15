/* ****** ****** */
// HX: 10 points
/* ****** ****** */

#include "runtime2.h"

/* ****** ****** */


/* ****** ****** */

/*
HX-2023-11-05:
Please translate the following function
into C code of the style given in fact_out.c

fun fibo(n: int): int =
if n >= 2 then fibo(n-2)+fibo(n-1) else n
*/


lamval1
fibo(lamval1 x){

  lamval1 ret0;

  lamval1 test = LAMOPR_ige(x, LAMVAL_int(2));
  if (((lamval1_int)test)->data) {
    ret0 = LAMOPR_add(fibo(LAMOPR_sub(x, LAMVAL_int(2))), fibo(LAMOPR_sub(x, LAMVAL_int(1))));
  } else {
    ret0 = x;
  }
  return ret0;
}


int main() {
  int N = 10;
  printf("fibo(%i) = ", N);
  LAMVAL_print(fibo(LAMVAL_int(N))); printf("\n"); return 0;
}

/* end of [CS525-2023-Fall/assigns/assign05/Solution/fibo_out.c] */
