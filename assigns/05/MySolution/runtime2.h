/* ****** ****** */
#include "./../runtime.h"
#include <gc.h>

/* ****** ****** */

extern
void*
mymalloc(size_t n) {
  void* p0;
  p0 = malloc(n);
  if (p0 != 0) return p0;
  fprintf(stderr, "myalloc failed!!!\n");
  exit(1);
}

/*
HX: Please add whatever you need below.
*/

/* ****** ****** */
typedef
struct{
    int tag;
    lamval1 (*fp)(lamval1[], ...);
    lamval1 (*env); // array of unknown size
} lamval0_cfp;

typedef lamval0_cfp *lamval1_cfp;



/* ****** ****** */


extern
lamval1
LAMVAL_print(lamval1 x)
{
  int tag;
  tag = x->tag;
  switch( tag )
  {
    case TAGcfp:
      printf("<lamval1_cfp>"); break;
    case TAGint:
      printf("%i", ((lamval1_int)x)->data); break;
    case TAGstr:
      printf("%s", ((lamval1_str)x)->data); break;
    default: printf("Unrecognized tag = %i", tag);
  }
}

/* ****** ****** */





/* end of [CS525-2023-Fall/assigns/assign05/Solution/runtime2.h] */
