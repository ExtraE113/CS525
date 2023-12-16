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
example_ping_to(Context c){
  lamval1 inp0 = retrieve_variable(&c, "n");
  lamval1 imp1 = LAMVAL_int(0);
  return LAMOPR_igt(inp0, imp1);
}


lamval1
another_example_ping_to(Context c){
  lamval1 inp0 = LAMOPR_sub(retrieve_variable(&c, "n"), LAMVAL_int(1));
  lamval1 inp1 = close(sym724, c);
  lamval1 tmp0 = LAMVAL_tup(inp0, inp1);
  return tmp0;
}


lamval1
sym732(Context c) {

  lamval1 test = example_ping_to(c);

  if (((lamval1_int)test)->data) {
    lamval1 inp0 = another_example_ping_to(c);
    lamval1 tmp0 = (((lamval1_clo)retrieve_variable(&c, "kfact"))->fp)(inp0, *(((lamval1_clo)retrieve_variable(&c, "kfact"))->c));
    return tmp0;
  } else {
    // ignore me, haven't a-normalized this yet
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

