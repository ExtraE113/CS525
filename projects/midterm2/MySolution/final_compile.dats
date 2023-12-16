//staload "libats/ML/SATS/list0.sats"
(* ****** ****** *)
#include "share/atspre_staload.hats"
(* ****** ****** *)
//
#staload "./../midterm.sats"//opened
//
(* ****** ****** *)
#staload "./../../../mylib/mylib.dats"

#staload "./final_compile.sats"
#staload "prelude/SATS/tostring.sats"


staload
STDLIB =
"libats/libc/SATS/stdlib.sats"
staload
TIME = "libats/libc/SATS/time.sats"
staload UN = "prelude/SATS/unsafe.sats"


extern
fun
unique_symbol(): string

implement
unique_symbol() =
(symbol) where {
  val num: int = g0float2int($STDLIB.drand48 () * 1000000)
  val num_string: string = tostring_int(num)
  val symbol: string = strptr2string(stringlst_concat($list{string}("sym", num_string)))
}


implement
term_compile(t0) =
  out where
{
  val (a, hoisted) = term_compile1(t0, "")
  val out = strptr2string(stringlst_concat($list{string}("#include \"runtime_final.h\"", hoisted,
    "int main(void) {\n",
    "  Context c = *create_hash_map();\n",
    "  LAMVAL_print(",
    a,
    ");\n}\n"

    )))
}

(*****)



implement
term_compile1(t: term, e0) =
(
case- t of
| TMlet(varname, value, body) => term_compile1(TMapp(TMlam(varname, body), value), e0)
| TMif0(test, t_branch, f_branch) => (out, hoisted) where {
  val (test_term,     hoisted_one)   = term_compile1(test, e0)
  val (t_branch_term, hoisted_two)   = term_compile1(t_branch, e0)
  val (f_branch_term, hoisted_three) = term_compile1(f_branch, e0)

  val if_symbol = unique_symbol()
  val if_expression = strptr2string(stringlst_concat($list{string}(
  "lamval1\n",
  if_symbol, "(Context c) {\n",
  //    (((lamval1_int)tmp1)->data)
  "  if (((lamval1_int)", test_term, ")->data) {\n",
  "    return ", t_branch_term, ";\n",
  "  } else {\n",
  "    return ", f_branch_term, ";\n",
  "  }\n",
  "}\n"
  )))

  val hoisted = strptr2string(stringlst_concat($list{string}(hoisted_one, "\n\n", hoisted_two, "\n\n", hoisted_three, "\n\n", if_expression)))

  val test_symbol = unique_symbol()
  val out = strptr2string(stringlst_concat($list{string}(
    if_symbol, "(c)"
    )))
}
| TMapp(l, a) => (out, hoisted) where {
    val (lam_term, hoisted_one) = term_compile1(l, e0)
    val (arg_term, hoisted_two) = term_compile1(a, e0)

    val hoisted = strptr2string(stringlst_concat($list{string}(hoisted_one, "\n\n", hoisted_two)))
    //                                                    (((lamval1_clo)lam_term)->fp)((((lamval1_clo)lam_term)->c), arg_term)
    val out = strptr2string(stringlst_concat($list{string}("(((lamval1_clo)",lam_term, ")->fp)(", arg_term, ", *(((lamval1_clo)", lam_term, ")->c))")))
  }
| TMlam(varname, body) => (out, hoisted) where {
  val (out, hoisted) = term_compile1(TMfix("unused", varname, body), e0)
}
| TMfix(source_function_name, varname, body) => (out, hoisted) where {
    val varname = strptr2string(stringlst_concat($list{string}("var_", varname)))
    val source_function_name = strptr2string(stringlst_concat($list{string}("var_", source_function_name)))
    val function_name = unique_symbol()
    val function_type = "lamval1 \n"
    val e0_inner = strptr2string(stringlst_concat($list{string}(e0, function_name, "__")))

    val arg_open = "(lamval1 "
    val argument_name = varname
    val arg_close = ", Context c) \n"

    val arg = strptr2string(stringlst_concat($list{string}(arg_open, argument_name, arg_close)))

    val open_fn = strptr2string(stringlst_concat($list{string}(
      "{\n  c = *extend_context(&c, \"", argument_name, "\", ",  argument_name , ");\n",
      "  c = *extend_context(&c, \"", source_function_name, "\", close(", function_name , ", c));\n",
      "  lamval1 ret0;\n\n"
      )))

    val (body: string, hoisted_prime: string) = term_compile1(body, e0_inner)

    val actual_body = strptr2string(stringlst_concat($list{string}("  lamval1 tmp0 = ", body, ";\n  ret0 = tmp0;\n")))

    val function_end = "  return ret0;\n}\n"
    val full_fn_as_pointer = stringlst_concat($list{string}(function_type, function_name, arg, open_fn, actual_body, function_end))
    val full_fn = strptr2string(full_fn_as_pointer)

    val hoisted = strptr2string(stringlst_concat($list{string}(hoisted_prime, "\n\n", full_fn)))
    val out = strptr2string(stringlst_concat($list{string}("close(", function_name, ", c)")))
  }
| TMopr(nm, ts) => (out, hoisted) where {

  val e0_inner_ptr = stringlst_concat($list{string}(e0, "TMopr", nm, "__"))
  val e0_inner = strptr2string(e0_inner_ptr)
  val (bodies, hoisted) = termlst_compile1(ts, e0_inner)

  val out = (
    case- nm of
    | ">=" => gen where {
        val- mylist_cons(a, mylist_cons(b, mylist_nil())) = bodies
        val gen = strptr2string(stringlst_concat($list{string}("LAMOPR_ige(", a, ", ", b, ")")))
      }
    | "+" => gen where {
        val- mylist_cons(a, mylist_cons(b, mylist_nil())) = bodies
        val gen = strptr2string(stringlst_concat($list{string}("LAMOPR_add(", a, ", ", b, ")")))
      }
    | "-" => gen where {
        val- mylist_cons(a, mylist_cons(b, mylist_nil())) = bodies
        val gen = strptr2string(stringlst_concat($list{string}("LAMOPR_sub(", a, ", ", b, ")")))
      }
    | "*" => gen where {
      val- mylist_cons(a, mylist_cons(b, mylist_nil())) = bodies
      val gen = strptr2string(stringlst_concat($list{string}("LAMOPR_mul(", a, ", ", b, ")")))
    }
    | ">" => gen where {
      val- mylist_cons(a, mylist_cons(b, mylist_nil())) = bodies
      val gen = strptr2string(stringlst_concat($list{string}("LAMOPR_igt(", a, ", ", b, ")")))
    }
    | "llist_new" => "LAMVAL_nil()"
    | "llist_nilq" => gen where {
      // check tag. return tag == TAGnil
      val- mylist_cons(a, mylist_nil()) = bodies
      val gen = strptr2string(stringlst_concat($list{string}("LAMVAL_int(LAMVAL_tag(", a, ") == TAGnil ? 1 : 0)")))
    }
    | "llist_cons" => gen where {
      val- mylist_cons(a, mylist_cons(b, mylist_nil())) = bodies
      val gen = strptr2string(stringlst_concat($list{string}("LAMVAL_tup(", a, ", ", b, ")")))
    }
    | "llist_uncons1" => gen where {
      val- mylist_cons(a, mylist_nil()) = bodies
      val gen = strptr2string(stringlst_concat($list{string}("LAMOPR_fst(", a, ")")))
    }
    | "llist_uncons2" => gen where {
      val- mylist_cons(a, mylist_nil()) = bodies
      val gen = strptr2string(stringlst_concat($list{string}("LAMOPR_snd(", a, ")")))
    }

    | "list_new" => "LAMVAL_nil()"
    | "list_cons" => gen where {
      val- mylist_cons(a, mylist_cons(b, mylist_nil())) = bodies
      val gen = strptr2string(stringlst_concat($list{string}("LAMVAL_tup(", a, ", ", b, ")")))
    }

    | "=" => gen where {
      val- mylist_cons(a, mylist_cons(b, mylist_nil())) = bodies
      val gen = strptr2string(stringlst_concat($list{string}("LAMOPR_eq(", a, ", ", b, ")")))
    }

    | a => ""  where {
      val () = println!("Unknown operator: ", a)
    }

    )

  }
| TMint(a) => (
  strptr2string(stringlst_concat($list{string}("LAMVAL_int(", tostring_int(a),")"))),
  ""
 )
| TMvar(a) => (
  strptr2string(stringlst_concat($list{string}("retrieve_variable(&c, \"var_", a, "\")"))),
  ""
  )
| TMtup(a, b) => (out, hoisted) where {
  val (a, hoisted_one) = term_compile1(a, e0)
  val (b, hoisted_two) = term_compile1(b, e0)
  val hoisted = strptr2string(stringlst_concat($list{string}(hoisted_one, "\n\n", hoisted_two)))
  val out = strptr2string(stringlst_concat($list{string}("LAMVAL_tup(", a, ", ", b, ")")))
 }
| TMfst(a) => (out, hoisted) where {
  val (a_term, hoisted) = term_compile1(a, e0)
  val out = strptr2string(stringlst_concat($list{string}("LAMOPR_fst(", a_term, ")")))
 }
| TMsnd(a) => (out, hoisted) where {
val (a_term, hoisted) = term_compile1(a, e0)
  val out = strptr2string(stringlst_concat($list{string}("LAMOPR_snd(", a_term, ")")))
}
| TManno(a, b) => term_compile1(a, e0)
| TMnil() => ("LAMVAL_nil()", "")
| a => ("", "") where {
  val () = println!("Unknown term: ", a)
}
)

fun
termlist_elementwise_compile(ts: termlst, e0) =
(
case+ ts of
|
mylist_nil() => mylist_nil()
|
mylist_cons(t1, ts) =>

  mylist_cons(term_compile1(t1, e0),  termlist_elementwise_compile(ts, e0))
)

typedef stringpair = (string, string)

// Function to process the elementwise compiled list
fun
processList(lst: mylist(stringpair)): (mylist(string), string) =
(case+ lst of
| mylist_nil() => (mylist_nil(), "") // Base case: empty list
| mylist_cons(pair1, rest: mylist(stringpair)) =>
let
// Recursively process the rest of the list
val (a:string, b:string) = pair1
val (alist: mylist(string), bsum: string) = processList(rest)
  in
// Combine current elements with results from recursive call
  (
    mylist_cons(a, alist),
    strptr2string(stringlst_concat($list{string}(bsum, "\n\n", b)))

   )
end
)

// takes in a list of terms
// returns: a list of "bodies", code that can be inserted to retrieve the value at the term
//          AND a hoist string, which should be included in the output as a block of top-level code

implement
termlst_compile1(ts, e0) =
(outs, hoisted) where {
  val elementwise = termlist_elementwise_compile(ts, e0)
  val (outs, hoisted) = processList(elementwise)
}