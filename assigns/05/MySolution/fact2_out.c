/* ****** ****** */
// HX: 20 points
/* ****** ****** */

#include "runtime2.h"

/* ****** ****** */

/*
HX-2023-11-05:
Please translate the following function
into C code of the style given in fact_out.c

fun
fact2(n:int): int =
let
//
(* How do you handle an inner function like loop in your translation? *)
//
fun
loop(i: int, r: int): int =
if i < n
then loop(i+1, (i+1) * r) else r
//
in
  loop(0, 1)
end
*/

/* ****** ****** */

lamval1
fact2__inner_function__loop(lamval1 env[], lamval1 i, lamval1 r){
  lamval1 n = env[0];
  lamval1 ret0;
  lamval1 test = LAMOPR_ilt(i, n);
  if (((lamval1_int)test)->data) {
    ret0 = fact2__inner_function__loop(env, LAMOPR_add(i, LAMVAL_int(1)), LAMOPR_mul(LAMOPR_add(i, LAMVAL_int(1)), r));
  } else {
    ret0 = r;
  }
  return ret0;
}

lamval1
fact2(lamval1 x)
{
  lamval1 ret0;
  lamval1 loop;
  loop = mymalloc(sizeof(lamval0_cfp));
  loop->tag = TAGcfp;
  ((lamval1_cfp)loop)->fp = (lamval1 (*)(lamval1 *, ...)) fact2__inner_function__loop;
  lamval1 envc[] = {x};
  ((lamval1_cfp)loop)->env = envc;
  ret0 = ((lamval1_cfp)loop)->fp(((lamval1_cfp)loop)->env, LAMVAL_int(0), LAMVAL_int(1));
  return ret0;
}

int main() {
  int N = 10;
  printf("fact(%i) = ", N);
  LAMVAL_print(fact2(LAMVAL_int(N))); printf("\n"); return 0;
}


/* end of [CS525-2023-Fall/assigns/assign05/Solution/fact2_out.c] */
