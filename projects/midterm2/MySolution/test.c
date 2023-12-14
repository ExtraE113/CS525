#include "runtime_final.h"

lamval1 
sym724(lamval1 r, Context c) 
{
  c = *extend_context(&c, "r", r);
  c = *extend_context(&c, "unused", close(sym724, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo)retrieve_variable(&c, "k"))->fp)(LAMOPR_mul(retrieve_variable(&c, "n"), retrieve_variable(&c, "r")), *(((lamval1_clo)retrieve_variable(&c, "k"))->c));
  ret0 = tmp0;
  return ret0;
}






lamval1
sym732(Context c) {
  if (((lamval1_int)LAMOPR_igt(retrieve_variable(&c, "n"), LAMVAL_int(0)))->data) {
    return (((lamval1_clo)retrieve_variable(&c, "kfact"))->fp)(LAMVAL_tup(LAMOPR_sub(retrieve_variable(&c, "n"), LAMVAL_int(1)), close(sym724, c)), *(((lamval1_clo)retrieve_variable(&c, "kfact"))->c));
  } else {
    return (((lamval1_clo)retrieve_variable(&c, "k"))->fp)(LAMVAL_int(1), *(((lamval1_clo)retrieve_variable(&c, "k"))->c));
  }
}


lamval1 
sym206(lamval1 k, Context c) 
{
  c = *extend_context(&c, "k", k);
  c = *extend_context(&c, "unused", close(sym206, c));
  lamval1 ret0;

  lamval1 tmp0 = sym732(c);
  ret0 = tmp0;
  return ret0;
}




lamval1 
sym919(lamval1 n, Context c) 
{
  c = *extend_context(&c, "n", n);
  c = *extend_context(&c, "unused", close(sym919, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo)close(sym206, c))->fp)(LAMOPR_snd(retrieve_variable(&c, "nk")), *(((lamval1_clo)close(sym206, c))->c));
  ret0 = tmp0;
  return ret0;
}




lamval1 
sym225(lamval1 nk, Context c) 
{
  c = *extend_context(&c, "nk", nk);
  c = *extend_context(&c, "kfact", close(sym225, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo)close(sym919, c))->fp)(LAMOPR_fst(retrieve_variable(&c, "nk")), *(((lamval1_clo)close(sym919, c))->c));
  ret0 = tmp0;
  return ret0;
}






lamval1 
sym347(lamval1 x, Context c) 
{
  c = *extend_context(&c, "x", x);
  c = *extend_context(&c, "unused", close(sym347, c));
  lamval1 ret0;

  lamval1 tmp0 = retrieve_variable(&c, "x");
  ret0 = tmp0;
  return ret0;
}
int main(void) {
  Context c = *create_hash_map();
  LAMVAL_print((((lamval1_clo)close(sym225, c))->fp)(LAMVAL_tup(LAMVAL_int(5), close(sym347, c)), *(((lamval1_clo)close(sym225, c))->c)));
}

