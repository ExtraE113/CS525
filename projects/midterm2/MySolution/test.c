#include "runtime_final.h"


lamval1
sym919183(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_unused", close(sym919183, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) LAMOPR_snd(retrieve_variable(&c, "var_input")))->fp)(LAMVAL_nil(),
                                                                                      *(((lamval1_clo) LAMOPR_snd(
                                                                                        retrieve_variable(&c,
                                                                                                          "var_input")))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym206841(Context c) {
  if (((lamval1_int) LAMVAL_int(LAMVAL_tag(retrieve_variable(&c, "var_input")) == TAGnil ? 1 : 0))->data) {
    return LAMVAL_nil();
  } else {
    return LAMVAL_tup(LAMOPR_fst(retrieve_variable(&c, "var_input")),
                      (((lamval1_clo) retrieve_variable(&c, "var_cont"))->fp)(
                        (((lamval1_clo) close(sym919183, c))->fp)(retrieve_variable(&c, "var_input"),
                                                                  *(((lamval1_clo) close(sym919183, c))->c)),
                        *(((lamval1_clo) retrieve_variable(&c, "var_cont"))->c)));
  }
}


lamval1
sym225328(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_cont", close(sym225328, c));
  lamval1 ret0;

  lamval1 tmp0 = sym206841(c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym857880(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_unused", close(sym857880, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) LAMOPR_snd(retrieve_variable(&c, "var_input")))->fp)(LAMVAL_nil(),
                                                                                      *(((lamval1_clo) LAMOPR_snd(
                                                                                        retrieve_variable(&c,
                                                                                                          "var_input")))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym347957(lamval1 var_, Context c) {
  c = *extend_context(&c, "var_", var_);
  c = *extend_context(&c, "var_unused", close(sym347957, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) (((lamval1_clo) retrieve_variable(&c, "var_cont"))->fp)(
    (((lamval1_clo) close(sym857880, c))->fp)(retrieve_variable(&c, "var_input"),
                                              *(((lamval1_clo) close(sym857880, c))->c)),
    *(((lamval1_clo) retrieve_variable(&c, "var_cont"))->c)))->fp)(retrieve_variable(&c, "var_func"),
                                                                   *(((lamval1_clo) (((lamval1_clo) retrieve_variable(
                                                                     &c, "var_cont"))->fp)(
                                                                     (((lamval1_clo) close(sym857880, c))->fp)(
                                                                       retrieve_variable(&c, "var_input"),
                                                                       *(((lamval1_clo) close(sym857880, c))->c)),
                                                                     *(((lamval1_clo) retrieve_variable(&c,
                                                                                                        "var_cont"))->c)))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym415184(Context c) {
  if (((lamval1_int) LAMVAL_int(LAMVAL_tag(retrieve_variable(&c, "var_input")) == TAGnil ? 1 : 0))->data) {
    return LAMVAL_nil();
  } else {
    return LAMVAL_tup(
      (((lamval1_clo) retrieve_variable(&c, "var_func"))->fp)(LAMOPR_fst(retrieve_variable(&c, "var_input")),
                                                              *(((lamval1_clo) retrieve_variable(&c, "var_func"))->c)),
      close(sym347957, c));
  }
}


lamval1
sym906482(lamval1 var_func, Context c) {
  c = *extend_context(&c, "var_func", var_func);
  c = *extend_context(&c, "var_unused", close(sym906482, c));
  lamval1 ret0;

  lamval1 tmp0 = sym415184(c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym732199(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_cont", close(sym732199, c));
  lamval1 ret0;

  lamval1 tmp0 = close(sym906482, c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym524375(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_unused", close(sym524375, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) LAMOPR_snd(retrieve_variable(&c, "var_input")))->fp)(LAMVAL_nil(),
                                                                                      *(((lamval1_clo) LAMOPR_snd(
                                                                                        retrieve_variable(&c,
                                                                                                          "var_input")))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym159635(lamval1 var_, Context c) {
  c = *extend_context(&c, "var_", var_);
  c = *extend_context(&c, "var_unused", close(sym159635, c));
  lamval1 ret0;

  lamval1 tmp0 = LAMVAL_nil();
  ret0 = tmp0;
  return ret0;
}


lamval1
sym655287(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_unused", close(sym655287, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) LAMOPR_snd(retrieve_variable(&c, "var_input")))->fp)(LAMVAL_nil(),
                                                                                      *(((lamval1_clo) LAMOPR_snd(
                                                                                        retrieve_variable(&c,
                                                                                                          "var_input")))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym250792(lamval1 var_, Context c) {
  c = *extend_context(&c, "var_", var_);
  c = *extend_context(&c, "var_unused", close(sym250792, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) (((lamval1_clo) retrieve_variable(&c, "var_cont"))->fp)(
    (((lamval1_clo) close(sym655287, c))->fp)(retrieve_variable(&c, "var_input1"),
                                              *(((lamval1_clo) close(sym655287, c))->c)),
    *(((lamval1_clo) retrieve_variable(&c, "var_cont"))->c)))->fp)(retrieve_variable(&c, "var_input2"),
                                                                   *(((lamval1_clo) (((lamval1_clo) retrieve_variable(
                                                                     &c, "var_cont"))->fp)(
                                                                     (((lamval1_clo) close(sym655287, c))->fp)(
                                                                       retrieve_variable(&c, "var_input1"),
                                                                       *(((lamval1_clo) close(sym655287, c))->c)),
                                                                     *(((lamval1_clo) retrieve_variable(&c,
                                                                                                        "var_cont"))->c)))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym534490(Context c) {
  if (((lamval1_int) LAMVAL_int(LAMVAL_tag(retrieve_variable(&c, "var_input1")) == TAGnil ? 1 : 0))->data) {
    return retrieve_variable(&c, "var_input2");
  } else {
    return LAMVAL_tup(LAMOPR_fst(retrieve_variable(&c, "var_input1")), close(sym250792, c));
  }
}


lamval1
sym382691(lamval1 var_input2, Context c) {
  c = *extend_context(&c, "var_input2", var_input2);
  c = *extend_context(&c, "var_unused", close(sym382691, c));
  lamval1 ret0;

  lamval1 tmp0 = sym534490(c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym4339(lamval1 var_input1, Context c) {
  c = *extend_context(&c, "var_input1", var_input1);
  c = *extend_context(&c, "var_cont", close(sym4339, c));
  lamval1 ret0;

  lamval1 tmp0 = close(sym382691, c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym287857(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_unused", close(sym287857, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) LAMOPR_snd(retrieve_variable(&c, "var_input")))->fp)(LAMVAL_nil(),
                                                                                      *(((lamval1_clo) LAMOPR_snd(
                                                                                        retrieve_variable(&c,
                                                                                                          "var_input")))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym909262(Context c) {
  if (((lamval1_int) LAMVAL_int(LAMVAL_tag(retrieve_variable(&c, "var_input")) == TAGnil ? 1 : 0))->data) {
    return LAMVAL_nil();
  } else {
    return (((lamval1_clo) (((lamval1_clo) close(sym4339, c))->fp)(LAMOPR_fst(retrieve_variable(&c, "var_input")),
                                                                   *(((lamval1_clo) close(sym4339, c))->c)))->fp)(
      (((lamval1_clo) retrieve_variable(&c, "var_cont"))->fp)(
        (((lamval1_clo) close(sym287857, c))->fp)(retrieve_variable(&c, "var_input"),
                                                  *(((lamval1_clo) close(sym287857, c))->c)),
        *(((lamval1_clo) retrieve_variable(&c, "var_cont"))->c)),
      *(((lamval1_clo) (((lamval1_clo) close(sym4339, c))->fp)(LAMOPR_fst(retrieve_variable(&c, "var_input")),
                                                               *(((lamval1_clo) close(sym4339, c))->c)))->c));
  }
}


lamval1
sym126984(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_cont", close(sym126984, c));
  lamval1 ret0;

  lamval1 tmp0 = sym909262(c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym945356(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_unused", close(sym945356, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) LAMOPR_snd(retrieve_variable(&c, "var_input")))->fp)(LAMVAL_nil(),
                                                                                      *(((lamval1_clo) LAMOPR_snd(
                                                                                        retrieve_variable(&c,
                                                                                                          "var_input")))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym265915(lamval1 var_, Context c) {
  c = *extend_context(&c, "var_", var_);
  c = *extend_context(&c, "var_unused", close(sym265915, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) (((lamval1_clo) retrieve_variable(&c, "var_cont"))->fp)(
    (((lamval1_clo) close(sym945356, c))->fp)(retrieve_variable(&c, "var_input"),
                                              *(((lamval1_clo) close(sym945356, c))->c)),
    *(((lamval1_clo) retrieve_variable(&c, "var_cont"))->c)))->fp)(retrieve_variable(&c, "var_func"),
                                                                   *(((lamval1_clo) (((lamval1_clo) retrieve_variable(
                                                                     &c, "var_cont"))->fp)(
                                                                     (((lamval1_clo) close(sym945356, c))->fp)(
                                                                       retrieve_variable(&c, "var_input"),
                                                                       *(((lamval1_clo) close(sym945356, c))->c)),
                                                                     *(((lamval1_clo) retrieve_variable(&c,
                                                                                                        "var_cont"))->c)))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym424689(Context c) {
  if (((lamval1_int) LAMVAL_int(LAMVAL_tag(retrieve_variable(&c, "var_input")) == TAGnil ? 1 : 0))->data) {
    return LAMVAL_nil();
  } else {
    return LAMVAL_tup(
      (((lamval1_clo) retrieve_variable(&c, "var_func"))->fp)(LAMOPR_fst(retrieve_variable(&c, "var_input")),
                                                              *(((lamval1_clo) retrieve_variable(&c, "var_func"))->c)),
      close(sym265915, c));
  }
}


lamval1
sym614806(lamval1 var_func, Context c) {
  c = *extend_context(&c, "var_func", var_func);
  c = *extend_context(&c, "var_unused", close(sym614806, c));
  lamval1 ret0;

  lamval1 tmp0 = sym424689(c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym121100(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_cont", close(sym121100, c));
  lamval1 ret0;

  lamval1 tmp0 = close(sym614806, c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym886175(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_unused", close(sym886175, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) LAMOPR_snd(retrieve_variable(&c, "var_input")))->fp)(LAMVAL_nil(),
                                                                                      *(((lamval1_clo) LAMOPR_snd(
                                                                                        retrieve_variable(&c,
                                                                                                          "var_input")))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym20268(lamval1 var_, Context c) {
  c = *extend_context(&c, "var_", var_);
  c = *extend_context(&c, "var_unused", close(sym20268, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) (((lamval1_clo) retrieve_variable(&c, "var_cont"))->fp)(
    (((lamval1_clo) close(sym886175, c))->fp)(retrieve_variable(&c, "var_input"),
                                              *(((lamval1_clo) close(sym886175, c))->c)),
    *(((lamval1_clo) retrieve_variable(&c, "var_cont"))->c)))->fp)(retrieve_variable(&c, "var_func"),
                                                                   *(((lamval1_clo) (((lamval1_clo) retrieve_variable(
                                                                     &c, "var_cont"))->fp)(
                                                                     (((lamval1_clo) close(sym886175, c))->fp)(
                                                                       retrieve_variable(&c, "var_input"),
                                                                       *(((lamval1_clo) close(sym886175, c))->c)),
                                                                     *(((lamval1_clo) retrieve_variable(&c,
                                                                                                        "var_cont"))->c)))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym654582(Context c) {
  if (((lamval1_int) LAMVAL_int(LAMVAL_tag(retrieve_variable(&c, "var_input")) == TAGnil ? 1 : 0))->data) {
    return LAMVAL_nil();
  } else {
    return LAMVAL_tup(
      (((lamval1_clo) retrieve_variable(&c, "var_func"))->fp)(LAMOPR_fst(retrieve_variable(&c, "var_input")),
                                                              *(((lamval1_clo) retrieve_variable(&c, "var_func"))->c)),
      close(sym20268, c));
  }
}


lamval1
sym499676(lamval1 var_func, Context c) {
  c = *extend_context(&c, "var_func", var_func);
  c = *extend_context(&c, "var_unused", close(sym499676, c));
  lamval1 ret0;

  lamval1 tmp0 = sym654582(c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym455739(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_cont", close(sym455739, c));
  lamval1 ret0;

  lamval1 tmp0 = close(sym499676, c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym339455(lamval1 var_, Context c) {
  c = *extend_context(&c, "var_", var_);
  c = *extend_context(&c, "var_unused", close(sym339455, c));
  lamval1 ret0;

  lamval1 tmp0 = retrieve_variable(&c, "var_x");
  ret0 = tmp0;
  return ret0;
}


lamval1
sym985048(lamval1 var_x, Context c) {
  c = *extend_context(&c, "var_x", var_x);
  c = *extend_context(&c, "var_unused", close(sym985048, c));
  lamval1 ret0;

  lamval1 tmp0 = LAMVAL_tup(LAMOPR_fst(retrieve_variable(&c, "var_elem_remainder_tuple")), close(sym339455, c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym71203(lamval1 var_recursive_result, Context c) {
  c = *extend_context(&c, "var_recursive_result", var_recursive_result);
  c = *extend_context(&c, "var_unused", close(sym71203, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) (((lamval1_clo) close(sym455739, c))->fp)(
    retrieve_variable(&c, "var_recursive_result"), *(((lamval1_clo) close(sym455739, c))->c)))->fp)(close(sym985048, c),
                                                                                                    *(((lamval1_clo) (((lamval1_clo) close(
                                                                                                      sym455739,
                                                                                                      c))->fp)(
                                                                                                      retrieve_variable(
                                                                                                        &c,
                                                                                                        "var_recursive_result"),
                                                                                                      *(((lamval1_clo) close(
                                                                                                        sym455739,
                                                                                                        c))->c)))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym677295(lamval1 var_elem_remainder_tuple, Context c) {
  c = *extend_context(&c, "var_elem_remainder_tuple", var_elem_remainder_tuple);
  c = *extend_context(&c, "var_unused", close(sym677295, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) close(sym71203, c))->fp)((((lamval1_clo) retrieve_variable(&c, "var_cont"))->fp)(
    LAMOPR_snd(retrieve_variable(&c, "var_elem_remainder_tuple")),
    *(((lamval1_clo) retrieve_variable(&c, "var_cont"))->c)), *(((lamval1_clo) close(sym71203, c))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym954757(lamval1 var_elem_remainder_tuples_list, Context c) {
  c = *extend_context(&c, "var_elem_remainder_tuples_list", var_elem_remainder_tuples_list);
  c = *extend_context(&c, "var_unused", close(sym954757, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) close(sym126984, c))->fp)(
    (((lamval1_clo) (((lamval1_clo) close(sym121100, c))->fp)(retrieve_variable(&c, "var_elem_remainder_tuples_list"),
                                                              *(((lamval1_clo) close(sym121100, c))->c)))->fp)(
      close(sym677295, c), *(((lamval1_clo) (((lamval1_clo) close(sym121100, c))->fp)(
        retrieve_variable(&c, "var_elem_remainder_tuples_list"), *(((lamval1_clo) close(sym121100, c))->c)))->c)),
    *(((lamval1_clo) close(sym126984, c))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym129119(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_unused", close(sym129119, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) LAMOPR_snd(retrieve_variable(&c, "var_input")))->fp)(LAMVAL_nil(),
                                                                                      *(((lamval1_clo) LAMOPR_snd(
                                                                                        retrieve_variable(&c,
                                                                                                          "var_input")))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym443657(lamval1 var_, Context c) {
  c = *extend_context(&c, "var_", var_);
  c = *extend_context(&c, "var_unused", close(sym443657, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) (((lamval1_clo) retrieve_variable(&c, "var_cont"))->fp)(
    (((lamval1_clo) close(sym129119, c))->fp)(retrieve_variable(&c, "var_input"),
                                              *(((lamval1_clo) close(sym129119, c))->c)),
    *(((lamval1_clo) retrieve_variable(&c, "var_cont"))->c)))->fp)(retrieve_variable(&c, "var_func"),
                                                                   *(((lamval1_clo) (((lamval1_clo) retrieve_variable(
                                                                     &c, "var_cont"))->fp)(
                                                                     (((lamval1_clo) close(sym129119, c))->fp)(
                                                                       retrieve_variable(&c, "var_input"),
                                                                       *(((lamval1_clo) close(sym129119, c))->c)),
                                                                     *(((lamval1_clo) retrieve_variable(&c,
                                                                                                        "var_cont"))->c)))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym915037(Context c) {
  if (((lamval1_int) LAMVAL_int(LAMVAL_tag(retrieve_variable(&c, "var_input")) == TAGnil ? 1 : 0))->data) {
    return LAMVAL_nil();
  } else {
    return LAMVAL_tup(
      (((lamval1_clo) retrieve_variable(&c, "var_func"))->fp)(LAMOPR_fst(retrieve_variable(&c, "var_input")),
                                                              *(((lamval1_clo) retrieve_variable(&c, "var_func"))->c)),
      close(sym443657, c));
  }
}


lamval1
sym988168(lamval1 var_func, Context c) {
  c = *extend_context(&c, "var_func", var_func);
  c = *extend_context(&c, "var_unused", close(sym988168, c));
  lamval1 ret0;

  lamval1 tmp0 = sym915037(c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym299024(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_cont", close(sym299024, c));
  lamval1 ret0;

  lamval1 tmp0 = close(sym988168, c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym597837(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_unused", close(sym597837, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) LAMOPR_snd(retrieve_variable(&c, "var_input")))->fp)(LAMVAL_nil(),
                                                                                      *(((lamval1_clo) LAMOPR_snd(
                                                                                        retrieve_variable(&c,
                                                                                                          "var_input")))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym480791(lamval1 var_, Context c) {
  c = *extend_context(&c, "var_", var_);
  c = *extend_context(&c, "var_unused", close(sym480791, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) (((lamval1_clo) retrieve_variable(&c, "var_cont"))->fp)(
    (((lamval1_clo) close(sym597837, c))->fp)(retrieve_variable(&c, "var_input"),
                                              *(((lamval1_clo) close(sym597837, c))->c)),
    *(((lamval1_clo) retrieve_variable(&c, "var_cont"))->c)))->fp)(retrieve_variable(&c, "var_func"),
                                                                   *(((lamval1_clo) (((lamval1_clo) retrieve_variable(
                                                                     &c, "var_cont"))->fp)(
                                                                     (((lamval1_clo) close(sym597837, c))->fp)(
                                                                       retrieve_variable(&c, "var_input"),
                                                                       *(((lamval1_clo) close(sym597837, c))->c)),
                                                                     *(((lamval1_clo) retrieve_variable(&c,
                                                                                                        "var_cont"))->c)))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym436147(Context c) {
  if (((lamval1_int) LAMVAL_int(LAMVAL_tag(retrieve_variable(&c, "var_input")) == TAGnil ? 1 : 0))->data) {
    return LAMVAL_nil();
  } else {
    return LAMVAL_tup(
      (((lamval1_clo) retrieve_variable(&c, "var_func"))->fp)(LAMOPR_fst(retrieve_variable(&c, "var_input")),
                                                              *(((lamval1_clo) retrieve_variable(&c, "var_func"))->c)),
      close(sym480791, c));
  }
}


lamval1
sym935688(lamval1 var_func, Context c) {
  c = *extend_context(&c, "var_func", var_func);
  c = *extend_context(&c, "var_unused", close(sym935688, c));
  lamval1 ret0;

  lamval1 tmp0 = sym436147(c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym184443(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_cont", close(sym184443, c));
  lamval1 ret0;

  lamval1 tmp0 = close(sym935688, c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym33990(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_unused", close(sym33990, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) LAMOPR_snd(retrieve_variable(&c, "var_input")))->fp)(LAMVAL_nil(),
                                                                                      *(((lamval1_clo) LAMOPR_snd(
                                                                                        retrieve_variable(&c,
                                                                                                          "var_input")))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym672115(lamval1 var_, Context c) {
  c = *extend_context(&c, "var_", var_);
  c = *extend_context(&c, "var_unused", close(sym672115, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) (((lamval1_clo) retrieve_variable(&c, "var_cont"))->fp)(
    (((lamval1_clo) close(sym33990, c))->fp)(retrieve_variable(&c, "var_input"),
                                             *(((lamval1_clo) close(sym33990, c))->c)),
    *(((lamval1_clo) retrieve_variable(&c, "var_cont"))->c)))->fp)(
    LAMOPR_add(retrieve_variable(&c, "var_cur_index"), LAMVAL_int(1)),
    *(((lamval1_clo) (((lamval1_clo) retrieve_variable(&c, "var_cont"))->fp)(
      (((lamval1_clo) close(sym33990, c))->fp)(retrieve_variable(&c, "var_input"),
                                               *(((lamval1_clo) close(sym33990, c))->c)),
      *(((lamval1_clo) retrieve_variable(&c, "var_cont"))->c)))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym964433(Context c) {
  if (((lamval1_int) LAMVAL_int(LAMVAL_tag(retrieve_variable(&c, "var_input")) == TAGnil ? 1 : 0))->data) {
    return LAMVAL_nil();
  } else {
    return LAMVAL_tup(
      LAMVAL_tup(retrieve_variable(&c, "var_cur_index"), LAMOPR_fst(retrieve_variable(&c, "var_input"))),
      close(sym672115, c));
  }
}


lamval1
sym123157(lamval1 var_cur_index, Context c) {
  c = *extend_context(&c, "var_cur_index", var_cur_index);
  c = *extend_context(&c, "var_unused", close(sym123157, c));
  lamval1 ret0;

  lamval1 tmp0 = sym964433(c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym727520(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_cont", close(sym727520, c));
  lamval1 ret0;

  lamval1 tmp0 = close(sym123157, c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym44664(lamval1 var_inp, Context c) {
  c = *extend_context(&c, "var_inp", var_inp);
  c = *extend_context(&c, "var_unused", close(sym44664, c));
  lamval1 ret0;

  lamval1 tmp0 = LAMOPR_fst(retrieve_variable(&c, "var_inp"));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym30432(lamval1 var_inp, Context c) {
  c = *extend_context(&c, "var_inp", var_inp);
  c = *extend_context(&c, "var_unused", close(sym30432, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) (((lamval1_clo) close(sym184443, c))->fp)(
    (((lamval1_clo) (((lamval1_clo) close(sym727520, c))->fp)(retrieve_variable(&c, "var_inp"),
                                                              *(((lamval1_clo) close(sym727520, c))->c)))->fp)(
      LAMVAL_int(0), *(((lamval1_clo) (((lamval1_clo) close(sym727520, c))->fp)(retrieve_variable(&c, "var_inp"),
                                                                                *(((lamval1_clo) close(sym727520,
                                                                                                       c))->c)))->c)),
    *(((lamval1_clo) close(sym184443, c))->c)))->fp)(close(sym44664, c),
                                                     *(((lamval1_clo) (((lamval1_clo) close(sym184443, c))->fp)(
                                                       (((lamval1_clo) (((lamval1_clo) close(sym727520, c))->fp)(
                                                         retrieve_variable(&c, "var_inp"),
                                                         *(((lamval1_clo) close(sym727520, c))->c)))->fp)(LAMVAL_int(0),
                                                                                                          *(((lamval1_clo) (((lamval1_clo) close(
                                                                                                            sym727520,
                                                                                                            c))->fp)(
                                                                                                            retrieve_variable(
                                                                                                              &c,
                                                                                                              "var_inp"),
                                                                                                            *(((lamval1_clo) close(
                                                                                                              sym727520,
                                                                                                              c))->c)))->c)),
                                                       *(((lamval1_clo) close(sym184443, c))->c)))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym385671(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_unused", close(sym385671, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) LAMOPR_snd(retrieve_variable(&c, "var_input")))->fp)(LAMVAL_nil(),
                                                                                      *(((lamval1_clo) LAMOPR_snd(
                                                                                        retrieve_variable(&c,
                                                                                                          "var_input")))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym902119(Context c) {
  if (((lamval1_int) LAMOPR_eq(retrieve_variable(&c, "var_index"), LAMVAL_int(0)))->data) {
    return LAMOPR_fst(retrieve_variable(&c, "var_input"));
  } else {
    return (((lamval1_clo) (((lamval1_clo) retrieve_variable(&c, "var_cont"))->fp)(
      (((lamval1_clo) close(sym385671, c))->fp)(retrieve_variable(&c, "var_input"),
                                                *(((lamval1_clo) close(sym385671, c))->c)),
      *(((lamval1_clo) retrieve_variable(&c, "var_cont"))->c)))->fp)(
      LAMOPR_sub(retrieve_variable(&c, "var_index"), LAMVAL_int(1)),
      *(((lamval1_clo) (((lamval1_clo) retrieve_variable(&c, "var_cont"))->fp)(
        (((lamval1_clo) close(sym385671, c))->fp)(retrieve_variable(&c, "var_input"),
                                                  *(((lamval1_clo) close(sym385671, c))->c)),
        *(((lamval1_clo) retrieve_variable(&c, "var_cont"))->c)))->c));
  }
}


lamval1
sym646503(lamval1 var_index, Context c) {
  c = *extend_context(&c, "var_index", var_index);
  c = *extend_context(&c, "var_unused", close(sym646503, c));
  lamval1 ret0;

  lamval1 tmp0 = sym902119(c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym617166(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_cont", close(sym617166, c));
  lamval1 ret0;

  lamval1 tmp0 = close(sym646503, c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym476071(lamval1 var_, Context c) {
  c = *extend_context(&c, "var_", var_);
  c = *extend_context(&c, "var_unused", close(sym476071, c));
  lamval1 ret0;

  lamval1 tmp0 = retrieve_variable(&c, "var_next_elements");
  ret0 = tmp0;
  return ret0;
}


lamval1
sym112142(Context c) {
  if (((lamval1_int) LAMOPR_eq(retrieve_variable(&c, "var_index"), LAMVAL_int(0)))->data) {
    return retrieve_variable(&c, "var_next_elements");
  } else {
    return LAMVAL_tup(retrieve_variable(&c, "var_element"), close(sym476071, c));
  }
}


lamval1
sym48463(lamval1 var_next_elements, Context c) {
  c = *extend_context(&c, "var_next_elements", var_next_elements);
  c = *extend_context(&c, "var_unused", close(sym48463, c));
  lamval1 ret0;

  lamval1 tmp0 = sym112142(c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym386383(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_unused", close(sym386383, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) LAMOPR_snd(retrieve_variable(&c, "var_input")))->fp)(LAMVAL_nil(),
                                                                                      *(((lamval1_clo) LAMOPR_snd(
                                                                                        retrieve_variable(&c,
                                                                                                          "var_input")))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym572237(lamval1 var_element, Context c) {
  c = *extend_context(&c, "var_element", var_element);
  c = *extend_context(&c, "var_unused", close(sym572237, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) close(sym48463, c))->fp)(
    (((lamval1_clo) (((lamval1_clo) retrieve_variable(&c, "var_cont"))->fp)(
      (((lamval1_clo) close(sym386383, c))->fp)(retrieve_variable(&c, "var_input"),
                                                *(((lamval1_clo) close(sym386383, c))->c)),
      *(((lamval1_clo) retrieve_variable(&c, "var_cont"))->c)))->fp)(
      LAMOPR_sub(retrieve_variable(&c, "var_index"), LAMVAL_int(1)),
      *(((lamval1_clo) (((lamval1_clo) retrieve_variable(&c, "var_cont"))->fp)(
        (((lamval1_clo) close(sym386383, c))->fp)(retrieve_variable(&c, "var_input"),
                                                  *(((lamval1_clo) close(sym386383, c))->c)),
        *(((lamval1_clo) retrieve_variable(&c, "var_cont"))->c)))->c)), *(((lamval1_clo) close(sym48463, c))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym36747(Context c) {
  if (((lamval1_int) LAMVAL_int(LAMVAL_tag(retrieve_variable(&c, "var_input")) == TAGnil ? 1 : 0))->data) {
    return LAMVAL_nil();
  } else {
    return (((lamval1_clo) close(sym572237, c))->fp)(LAMOPR_fst(retrieve_variable(&c, "var_input")),
                                                     *(((lamval1_clo) close(sym572237, c))->c));
  }
}


lamval1
sym454950(lamval1 var_index, Context c) {
  c = *extend_context(&c, "var_index", var_index);
  c = *extend_context(&c, "var_unused", close(sym454950, c));
  lamval1 ret0;

  lamval1 tmp0 = sym36747(c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym423150(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_cont", close(sym423150, c));
  lamval1 ret0;

  lamval1 tmp0 = close(sym454950, c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym554348(lamval1 var_index, Context c) {
  c = *extend_context(&c, "var_index", var_index);
  c = *extend_context(&c, "var_unused", close(sym554348, c));
  lamval1 ret0;

  lamval1 tmp0 = LAMVAL_tup(
    (((lamval1_clo) (((lamval1_clo) close(sym617166, c))->fp)(retrieve_variable(&c, "var_input"),
                                                              *(((lamval1_clo) close(sym617166, c))->c)))->fp)(
      retrieve_variable(&c, "var_index"),
      *(((lamval1_clo) (((lamval1_clo) close(sym617166, c))->fp)(retrieve_variable(&c, "var_input"),
                                                                 *(((lamval1_clo) close(sym617166, c))->c)))->c)),
    (((lamval1_clo) (((lamval1_clo) close(sym423150, c))->fp)(retrieve_variable(&c, "var_input"),
                                                              *(((lamval1_clo) close(sym423150, c))->c)))->fp)(
      retrieve_variable(&c, "var_index"),
      *(((lamval1_clo) (((lamval1_clo) close(sym423150, c))->fp)(retrieve_variable(&c, "var_input"),
                                                                 *(((lamval1_clo) close(sym423150, c))->c)))->c)));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym944488(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_unused", close(sym944488, c));
  lamval1 ret0;

  lamval1 tmp0 = close(sym554348, c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym764218(lamval1 var_index, Context c) {
  c = *extend_context(&c, "var_index", var_index);
  c = *extend_context(&c, "var_unused", close(sym764218, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) (((lamval1_clo) close(sym944488, c))->fp)(retrieve_variable(&c, "var_inp"),
                                                                           *(((lamval1_clo) close(sym944488,
                                                                                                  c))->c)))->fp)(
    retrieve_variable(&c, "var_index"),
    *(((lamval1_clo) (((lamval1_clo) close(sym944488, c))->fp)(retrieve_variable(&c, "var_inp"),
                                                               *(((lamval1_clo) close(sym944488, c))->c)))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym421235(lamval1 var_inp, Context c) {
  c = *extend_context(&c, "var_inp", var_inp);
  c = *extend_context(&c, "var_unused", close(sym421235, c));
  lamval1 ret0;

  lamval1 tmp0 = close(sym764218, c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym36798(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_unused", close(sym36798, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) (((lamval1_clo) close(sym299024, c))->fp)(
    (((lamval1_clo) close(sym30432, c))->fp)(retrieve_variable(&c, "var_input"),
                                             *(((lamval1_clo) close(sym30432, c))->c)),
    *(((lamval1_clo) close(sym299024, c))->c)))->fp)(
    (((lamval1_clo) close(sym421235, c))->fp)(retrieve_variable(&c, "var_input"),
                                              *(((lamval1_clo) close(sym421235, c))->c)),
    *(((lamval1_clo) (((lamval1_clo) close(sym299024, c))->fp)(
      (((lamval1_clo) close(sym30432, c))->fp)(retrieve_variable(&c, "var_input"),
                                               *(((lamval1_clo) close(sym30432, c))->c)),
      *(((lamval1_clo) close(sym299024, c))->c)))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym502661(Context c) {
  if (((lamval1_int) LAMVAL_int(LAMVAL_tag((((lamval1_clo) close(sym524375, c))->fp)(retrieve_variable(&c, "var_lst"),
                                                                                     *(((lamval1_clo) close(sym524375,
                                                                                                            c))->c))) ==
                                TAGnil ? 1 : 0))->data) {
    return LAMVAL_tup(retrieve_variable(&c, "var_lst"), close(sym159635, c));
  } else {
    return (((lamval1_clo) close(sym954757, c))->fp)(
      (((lamval1_clo) close(sym36798, c))->fp)(retrieve_variable(&c, "var_lst"),
                                               *(((lamval1_clo) close(sym36798, c))->c)),
      *(((lamval1_clo) close(sym954757, c))->c));
  }
}


lamval1
sym267143(Context c) {
  if (((lamval1_int) LAMVAL_int(LAMVAL_tag(retrieve_variable(&c, "var_lst")) == TAGnil ? 1 : 0))->data) {
    return LAMVAL_nil();
  } else {
    return sym502661(c);
  }
}


lamval1
sym685610(lamval1 var_lst, Context c) {
  c = *extend_context(&c, "var_lst", var_lst);
  c = *extend_context(&c, "var_cont", close(sym685610, c));
  lamval1 ret0;

  lamval1 tmp0 = sym267143(c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym52049(lamval1 var_, Context c) {
  c = *extend_context(&c, "var_", var_);
  c = *extend_context(&c, "var_unused", close(sym52049, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) (((lamval1_clo) retrieve_variable(&c, "var_cont"))->fp)(
    LAMOPR_add(retrieve_variable(&c, "var_from"), LAMVAL_int(1)),
    *(((lamval1_clo) retrieve_variable(&c, "var_cont"))->c)))->fp)(retrieve_variable(&c, "var_to"),
                                                                   *(((lamval1_clo) (((lamval1_clo) retrieve_variable(
                                                                     &c, "var_cont"))->fp)(
                                                                     LAMOPR_add(retrieve_variable(&c, "var_from"),
                                                                                LAMVAL_int(1)),
                                                                     *(((lamval1_clo) retrieve_variable(&c,
                                                                                                        "var_cont"))->c)))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym438104(Context c) {
  if (((lamval1_int) LAMOPR_eq(retrieve_variable(&c, "var_to"), retrieve_variable(&c, "var_from")))->data) {
    return LAMVAL_nil();
  } else {
    return LAMVAL_tup(retrieve_variable(&c, "var_from"), close(sym52049, c));
  }
}


lamval1
sym371336(lamval1 var_to, Context c) {
  c = *extend_context(&c, "var_to", var_to);
  c = *extend_context(&c, "var_unused", close(sym371336, c));
  lamval1 ret0;

  lamval1 tmp0 = sym438104(c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym53324(lamval1 var_from, Context c) {
  c = *extend_context(&c, "var_from", var_from);
  c = *extend_context(&c, "var_cont", close(sym53324, c));
  lamval1 ret0;

  lamval1 tmp0 = close(sym371336, c);
  ret0 = tmp0;
  return ret0;
}


lamval1
sym274894(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_unused", close(sym274894, c));
  lamval1 ret0;

  lamval1 tmp0 = (((lamval1_clo) LAMOPR_snd(retrieve_variable(&c, "var_input")))->fp)(LAMVAL_nil(),
                                                                                      *(((lamval1_clo) LAMOPR_snd(
                                                                                        retrieve_variable(&c,
                                                                                                          "var_input")))->c));
  ret0 = tmp0;
  return ret0;
}


lamval1
sym18522(Context c) {
  if (((lamval1_int) LAMVAL_int(LAMVAL_tag(retrieve_variable(&c, "var_input")) == TAGnil ? 1 : 0))->data) {
    return LAMVAL_nil();
  } else {
    return LAMVAL_tup(LAMOPR_fst(retrieve_variable(&c, "var_input")),
                      (((lamval1_clo) retrieve_variable(&c, "var_cont"))->fp)(
                        (((lamval1_clo) close(sym274894, c))->fp)(retrieve_variable(&c, "var_input"),
                                                                  *(((lamval1_clo) close(sym274894, c))->c)),
                        *(((lamval1_clo) retrieve_variable(&c, "var_cont"))->c)));
  }
}


lamval1
sym671114(lamval1 var_input, Context c) {
  c = *extend_context(&c, "var_input", var_input);
  c = *extend_context(&c, "var_cont", close(sym671114, c));
  lamval1 ret0;

  lamval1 tmp0 = sym18522(c);
  ret0 = tmp0;
  return ret0;
}

int main(void) {
  Context c = *create_hash_map();
  LAMVAL_print((((lamval1_clo) close(sym225328, c))->fp)((((lamval1_clo) (((lamval1_clo) close(sym732199, c))->fp)(
                                                           (((lamval1_clo) close(sym685610, c))->fp)((((lamval1_clo) (((lamval1_clo) close(sym53324, c))->fp)(LAMVAL_int(1),
                                                                                                                                                              *(((lamval1_clo) close(
                                                                                                                                                                sym53324,
                                                                                                                                                                c))->c)))->fp)(
                                                                                                       LAMVAL_int(4), *(((lamval1_clo) (((lamval1_clo) close(sym53324, c))->fp)(LAMVAL_int(1),
                                                                                                                                                                                *(((lamval1_clo) close(sym53324,
                                                                                                                                                                                                       c))->c)))->c)),
                                                                                                     *(((lamval1_clo) close(sym685610, c))->c)),
                                                           *(((lamval1_clo) close(sym732199, c))->c)))->fp)(close(sym671114, c),
                                                                                                            *(((lamval1_clo) (((lamval1_clo) close(sym732199, c))->fp)(
                                                                                                              (((lamval1_clo) close(sym685610, c))->fp)(
                                                                                                                (((lamval1_clo) (((lamval1_clo) close(sym53324, c))->fp)(
                                                                                                                  LAMVAL_int(1),
                                                                                                                  *(((lamval1_clo) close(sym53324, c))->c)))->fp)(
                                                                                                                  LAMVAL_int(4),
                                                                                                                  *(((lamval1_clo) (((lamval1_clo) close(sym53324, c))->fp)(
                                                                                                                    LAMVAL_int(1),
                                                                                                                    *(((lamval1_clo) close(sym53324, c))->c)))->c)),
                                                                                                                *(((lamval1_clo) close(sym685610, c))->c)),
                                                                                                              *(((lamval1_clo) close(sym732199, c))->c)))->c)),
                                                         *(((lamval1_clo) close(sym225328, c))->c)));
}

