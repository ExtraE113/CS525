/* ****** ****** */
// HX: 30 points
/* ****** ****** */

#include "runtime2.h"



/* ****** ****** */

/*
HX-2023-11-05:
Please translate the following function
into C code of the style given in fact_out.c

fun
fact2(n:int): int =
int_foldleft(n, 1, lam(r, i) => r * (i+1))

where 'int_foldleft' is defined as follows:

fun
int_foldleft
(n0, r0, fopr) =
(
  loop(0, r0)) where
{
fun
loop(i0, r0) =
if (i0 >= n0) then r0 else loop(i0+1, fopr(r0, i0))
}

*/

/* ****** ****** */

lamval1
int_foldleft__inner_function__loop(lamval1 env[], lamval1 i0, lamval1 r0) {
  lamval1 ret0;

  lamval1 n0 = env[0];
//  lamval1 r0 = env[0];
  lamval1 fopr = env[2];


  lamval1 test = LAMOPR_ige(i0, n0);
  if (((lamval1_int) test)->data) {
    ret0 = r0;
  } else {
    ret0 = int_foldleft__inner_function__loop(env, LAMOPR_add(i0, LAMVAL_int(1)),
                                              ((lamval1_cfp) fopr)->fp(((lamval1_cfp) fopr)->env, r0, i0)
    );
  }
  return ret0;
}

lamval1
facti__inner_function__int_foldleft(lamval1 env[], lamval1 n0, lamval1 r0, lamval1 fopr) {
  lamval1 ret0;

  lamval1 n = env[0];

  lamval1 loop;
  loop = mymalloc(sizeof(lamval0_cfp));
  loop->tag = TAGcfp;
  ((lamval1_cfp)loop)->fp = (lamval1 (*)(lamval1 *, ...)) int_foldleft__inner_function__loop;
  lamval1 envc[] = {n0, r0, fopr};
  ((lamval1_cfp)loop)->env = envc;
  ret0 = ((lamval1_cfp)loop)->fp(((lamval1_cfp)loop)->env, LAMVAL_int(0), LAMVAL_int(1));
  return ret0;
}

/*
fun
fact2(n:int): int =
int_foldleft(n, 1, lam(r, i) => r * (i+1))
*/
lamval1
facti__inner_function__anonymous0(lamval1 env[], lamval1 r, lamval1 i){
  lamval1 n = env[0];
  lamval1 ret0 = LAMOPR_mul(r, LAMOPR_add(i, LAMVAL_int(1)));
  return ret0;
}

lamval1
facti(lamval1 n) {
  lamval1 ret0;
  lamval1 anonymous0;
  anonymous0 = mymalloc(sizeof(lamval0_cfp));
  anonymous0->tag = TAGcfp;
  ((lamval1_cfp)anonymous0)->fp = (lamval1 (*)(lamval1 *, ...)) facti__inner_function__anonymous0;
  lamval1 envc[] = {n};
  ((lamval1_cfp)anonymous0)->env = envc;

  /* ********************************* */

  lamval1 int_foldleft;
  int_foldleft = mymalloc(sizeof(lamval0_cfp));
  int_foldleft->tag = TAGcfp;
  ((lamval1_cfp)int_foldleft)->fp = (lamval1 (*)(lamval1 *, ...)) facti__inner_function__int_foldleft;
  lamval1 envc2[] = {n};
  ((lamval1_cfp)int_foldleft)->env = envc2;

  ret0 = ((lamval1_cfp)int_foldleft)->fp(((lamval1_cfp)int_foldleft)->env, n, LAMVAL_int(1), anonymous0);
  return ret0;

}

int main() {
  int N = 10;
  printf("facti(%i) = ", N);
  LAMVAL_print(facti(LAMVAL_int(N))); printf("\n"); return 0;
}


/* end of [CS525-2023-Fall/assigns/assign05/Solution/facti_out.c] */
