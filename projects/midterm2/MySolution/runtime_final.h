/* ****** ****** */
/*
// HX-2023-11-05:
// A basic runtime for LAMBDA
*/
/* ****** ****** */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* ****** ****** */
extern
void *
mymalloc(size_t n) {
  void *p0;
  p0 = malloc(n);
  if (p0 != 0) return p0;
  fprintf(stderr, "myalloc failed!!!\n");
  exit(1);
}

/* ****** ****** */

#define TAGint 1
#define TAGstr 2
#define TAGcfp 3 // closure-function-pointer
#define TAGtup 4 // tuple

/* ****** ****** */

/*
typedef
lamval0 =
struct{ int tag; }
*/
typedef
struct {
    int tag;
} lamval0;

/* ****** ****** */

typedef lamval0 *lamval1;

/* ****** ****** */

int
LAMVAL_tag
  (lamval1 x) { return x->tag; }

/* ****** ****** */

typedef
struct {
    int tag;
    int data;
} lamval0_int;

//
// HX:
// 1 for true
// 0 for false
//
typedef
lamval0_int lamval0_btf;

typedef
struct {
    int tag;
    char data[];
} lamval0_str;

typedef lamval0_int *lamval1_int;
typedef lamval0_str *lamval1_str;


typedef
struct {
    int tag;
    lamval1 fst;
    lamval1 snd;
} lamval0_tup;

typedef lamval0_tup *lamval1_tup;


#define HASH_MAP_SIZE 100
#define Context HashMap

typedef struct Node {
    char *key;
    lamval1 value;
    struct Node *next;
} Node;

typedef struct HashMap {
    Node *array[HASH_MAP_SIZE];
} HashMap;



/* ****** ****** */

typedef lamval1 (*FunctionPtr)(lamval1, Context);

typedef
struct {
    int tag;
    Context *c;
    FunctionPtr fp;
} lamval0_clo;
typedef lamval0_clo *lamval1_clo;


/* ****** ****** */

/*
boxing for lamval_int
*/
extern
lamval1
LAMVAL_int(int i);

extern
lamval1
LAMVAL_tup(lamval1 fst, lamval1 snd);

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
LAMVAL_int(int i) {
  lamval1_int p0;
  p0 = mymalloc(sizeof(lamval0_int));
  p0->tag = TAGint;
  p0->data = i;
  return (lamval1) p0;
}

extern
lamval1
LAMVAL_tup(lamval1 fst, lamval1 snd) {
  lamval1_tup p0;
  p0 = mymalloc(sizeof(lamval0_tup));
  p0->tag = TAGtup;
  p0->fst = fst;
  p0->snd = snd;
  return (lamval1) p0;
}
/* ****** ****** */

extern
lamval1
LAMOPR_ilt(lamval1 x, lamval1 y) {
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
    LAMVAL_int(((lamval1_int) x)->data < ((lamval1_int) y)->data ? 1 : 0);
}

extern
lamval1
LAMOPR_ile(lamval1 x, lamval1 y) {
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
    LAMVAL_int(((lamval1_int) x)->data <= ((lamval1_int) y)->data ? 1 : 0);
}

/* ****** ****** */

extern
lamval1
LAMOPR_igt(lamval1 x, lamval1 y) {
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
    LAMVAL_int(((lamval1_int) x)->data > ((lamval1_int) y)->data ? 1 : 0);
}

/* ****** ****** */

extern
lamval1
LAMOPR_ige(lamval1 x, lamval1 y) {
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
    LAMVAL_int(((lamval1_int) x)->data >= ((lamval1_int) y)->data ? 1 : 0);
}

/* ****** ****** */

extern
lamval1
LAMOPR_add(lamval1 x, lamval1 y) {
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
    LAMVAL_int(((lamval1_int) x)->data + ((lamval1_int) y)->data);
}

extern
lamval1
LAMOPR_sub(lamval1 x, lamval1 y) {
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
    LAMVAL_int(((lamval1_int) x)->data - ((lamval1_int) y)->data);
}

/* ****** ****** */

extern
lamval1
LAMOPR_mul(lamval1 x, lamval1 y) {
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
    LAMVAL_int(((lamval1_int) x)->data * ((lamval1_int) y)->data);
}

/* ****** ****** */

extern
lamval1
LAMOPR_div(lamval1 x, lamval1 y) {
  /*
  assert(x->tag == TAGint);
  assert(y->tag == TAGint);
  */
  return
    LAMVAL_int(((lamval1_int) x)->data / ((lamval1_int) y)->data);
}

extern
lamval1
LAMOPR_fst(lamval1 x) {
  /*
  assert(x->tag == TAGtup);
  */
  return ((lamval1_tup) x)->fst;
}

extern
lamval1
LAMOPR_snd(lamval1 x) {
  /*
  assert(x->tag == TAGtup);
  */
  return ((lamval1_tup) x)->snd;
}

/* ****** ****** */

unsigned int hash(char *str) {
  unsigned int hash = 0;
  for (int i = 0; str[i] != '\0'; i++) {
    hash = 31 * hash + str[i];
  }
  return hash % HASH_MAP_SIZE;
}

HashMap *create_hash_map() {
  HashMap *map = malloc(sizeof(HashMap));
  for (int i = 0; i < HASH_MAP_SIZE; i++) {
    map->array[i] = NULL;
  }
  return map;
}

void insert(HashMap *map, char *key, void *value) {
  unsigned int index = hash(key);

  // Check if the key already exists in the map
  Node *current = map->array[index];
  while (current != NULL) {
    if (strcmp(current->key, key) == 0) {
      // Key found, update the value
      current->value = value;
      return;
    }
    current = current->next;
  }

  // Key not found, insert a new node
  Node *new_node = malloc(sizeof(Node));
  new_node->key = strdup(key);
  new_node->value = value;
  new_node->next = map->array[index];
  map->array[index] = new_node;
}


lamval1 get(HashMap *map, char *key) {
  unsigned int index = hash(key);
  Node *list = map->array[index];
  while (list != NULL) {
    if (strcmp(list->key, key) == 0) {
      return list->value;
    }
    list = list->next;
  }
  printf("Key not found: %s\n", key);
  fflush(stdout);
  return NULL;
}

HashMap* deepContextCopy(HashMap *c) {
  HashMap *new_map = create_hash_map();
  for (int i = 0; i < HASH_MAP_SIZE; i++) {
    for (Node *node = c->array[i]; node != NULL; node = node->next) {
      insert(new_map, node->key, node->value);
    }
  }
  return new_map;
}

HashMap* extend_context(HashMap *c, char *name, lamval1 value) {
  HashMap *new_map = deepContextCopy(c);
  insert(new_map, name, value);
  return new_map;
}

lamval1 retrieve_variable(HashMap *c, char *name) {
  return get(c, name);
}


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


lamval1 close(FunctionPtr fp, Context c) {
  // Allocate memory for the struct
  lamval0_clo *newClosure = (lamval0_clo *) malloc(sizeof(lamval0_clo));

  // Check if memory allocation was successful
  if (newClosure == NULL) {
    return NULL; // Return NULL if memory allocation failed
  }

  // Initialize the struct fields
  newClosure->fp = fp;
  HashMap* new_c = deepContextCopy(&c);
  newClosure->c = new_c;
  newClosure->tag = TAGcfp;
  // Return the pointer to the new struct
  return (lamval1) newClosure;
}

/* end of [CS525-2023-Fall/assigns/assign05/runtime.h] */
