/* ****** ****** */
/*
// HX-2023-11-05:
// A basic runtime for LAMBDA
*/
/* ****** ****** */

#include <stdio.h>
#include <stdlib.h>

/* ****** ****** */

extern
void*
mymalloc(size_t);

/* ****** ****** */

#define TAGint 1
#define TAGstr 2
#define TAGcfp 3 // closure-function-pointer

/* ****** ****** */

/*
typedef
lamval0 =
struct{ int tag; }
*/
typedef
struct{ int tag; } lamval0;

/* ****** ****** */

typedef lamval0 *lamval1;

/* ****** ****** */

int
LAMVAL_tag
(lamval1 x){ return x->tag; }

/* ****** ****** */

typedef
struct{
  int tag; int data;
} lamval0_int;

//
// HX:
// 1 for true
// 0 for false
//
typedef
lamval0_int lamval0_btf;

typedef
struct{
  int tag; char data[];
} lamval0_str;

typedef lamval0_int *lamval1_int;
typedef lamval0_str *lamval1_str;

/* ****** ****** */

typedef
struct{
  int tag; void* fenv;
} lamval0_clo;
typedef lamval0_clo *lamval1_clo;

/* ****** ****** */

/*
boxing for lamval_int
*/
extern
lamval1
LAMVAL_int(int i);

/* ****** ****** */

extern
lamval1
LAMOPR_ilt(lamval1 x, lamval1 y);
extern
lamval1
LAMOPR_ile(lamval1 x, lamval1 y);
extern
lamval1
LAMOPR_igt(lamval1 x, lamval1 y);
extern
lamval1
LAMOPR_ige(lamval1 x, lamval1 y);

/* ****** ****** */

extern
lamval1
LAMOPR_add(lamval1 x, lamval1 y);
extern
lamval1
LAMOPR_sub(lamval1 x, lamval1 y);
extern
lamval1
LAMOPR_mul(lamval1 x, lamval1 y);
extern
lamval1
LAMOPR_div(lamval1 x, lamval1 y);
extern
lamval1
LAMOPR_mod(lamval1 x, lamval1 y);

/* ****** ****** */

extern
lamval1
LAMVAL_int(int i)
{
  lamval1_int p0;
  p0 = mymalloc(sizeof(lamval0_int));
  p0->tag = TAGint; p0->data = i; return (lamval1)p0;
}

/* ****** ****** */

extern
lamval1
LAMOPR_ilt(lamval1 x, lamval1 y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
  LAMVAL_int(((lamval1_int)x)->data < ((lamval1_int)y)->data ? 1 : 0);
}

extern
lamval1
LAMOPR_ile(lamval1 x, lamval1 y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
  LAMVAL_int(((lamval1_int)x)->data <= ((lamval1_int)y)->data ? 1 : 0);
}

/* ****** ****** */

extern
lamval1
LAMOPR_igt(lamval1 x, lamval1 y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
  LAMVAL_int(((lamval1_int)x)->data > ((lamval1_int)y)->data ? 1 : 0);
}

/* ****** ****** */

extern
lamval1
LAMOPR_ige(lamval1 x, lamval1 y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
  LAMVAL_int(((lamval1_int)x)->data >= ((lamval1_int)y)->data ? 1 : 0);
}

/* ****** ****** */

extern
lamval1
LAMOPR_add(lamval1 x, lamval1 y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
  LAMVAL_int(((lamval1_int)x)->data + ((lamval1_int)y)->data);
}

extern
lamval1
LAMOPR_sub(lamval1 x, lamval1 y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
  LAMVAL_int(((lamval1_int)x)->data - ((lamval1_int)y)->data);
}

/* ****** ****** */

extern
lamval1
LAMOPR_mul(lamval1 x, lamval1 y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
  LAMVAL_int(((lamval1_int)x)->data * ((lamval1_int)y)->data);
}

/* ****** ****** */

extern
lamval1
LAMOPR_div(lamval1 x, lamval1 y)
{
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
  LAMVAL_int(((lamval1_int)x)->data / ((lamval1_int)y)->data);
}

/* ****** ****** */

/* end of [CS525-2023-Fall/assigns/assign05/runtime.h] */
