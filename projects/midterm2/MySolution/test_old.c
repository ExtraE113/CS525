#include "runtime_final.h"





lamval1 
sym121(lamval1 x, Context c) 
{
  c = *extend_context(&c, "x", x);
  c = *extend_context(&c, "unused", close(sym121, c));
  lamval1 ret0;

  lamval1 tmp0 = LAMOPR_igt(retrieve_variable(&c, "x"), LAMVAL_int(5));
  ret0 = tmp0;
  return ret0;
}


int main(void) {
  Context c = *create_hash_map();
    LAMVAL_print((((lamval1_clo)close(sym121, c))->fp)(LAMVAL_int(15), *(((lamval1_clo)close(sym121, c))->c)));
}

