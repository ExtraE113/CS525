/* ****** ****** */

#include "runtime2.h"


/* ****** ****** */


/*
fun
fact(x) = if x > 0 then x * fact(x-1) else 1
*/

/* ****** ****** */

lamval1
fact(lamval1 x)
{

  lamval1 ret0;
  lamval1 tmp1, tmp2, tmp3;

  tmp1 = LAMOPR_igt(x, LAMVAL_int(0));

  if (((lamval1_int)tmp1)->data) {
    tmp2 = LAMOPR_sub(x, LAMVAL_int(1));
    tmp3 = fact(tmp2);
    ret0 = LAMOPR_mul(x, tmp3);
  } else {
    ret0 = LAMVAL_int(1);
  }

  return ret0;
}

int main() {
  int N = 10;
  printf("fact(%i) = ", N);
  LAMVAL_print(fact(LAMVAL_int(N))); printf("\n"); return 0;
}

/* ****** ****** */

/* end of [CS525-2023-Fall/assigns/assign05/Solution/fact_out.c] */
