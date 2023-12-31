(* ****** ****** *)
(*
CS525-2023-Fall: midterm
*)
(* ****** ****** *)
#include "share/atspre_staload.hats"
(* ****** ****** *)
//
#staload "./../midterm.sats"//opened
//
(* ****** ****** *)
#staload "./../../../mylib/mylib.dats"

#include "./../Examples/mylib.dats"

(* ****** ****** *)
//
fun
str_tabulate
( n0: int
, fopr: int -<cloref1> char): string =
string_make_mylist
(foreach_to_map_list(int_foreach)(n0, fopr))
//
(* ****** ****** *)
//
fun
str_fset_at
(cs: string, i0: int, c0: char) =
str_tabulate
(
str_length(cs),
lam i1 =>
if i1 != i0 then str_get_at(cs, i1) else c0)
//
(* ****** ****** *)

(* ****** ****** *)
exception EXNstr_get_at
exception EXNstr_set_at
(* ****** ****** *)
exception EXNoptn_uncons1
(* ****** ****** *)
exception EXNlist_uncons1
exception EXNlist_uncons2
(* ****** ****** *)
exception EXNllist_uncons1
exception EXNllist_uncons2
(* ****** ****** *)
//
implement
term_eval0(t0) =
term_eval1(t0, e0) where
{
  val e0 = mylist_nil(*void*) }
//
(* ****** ****** *)

implement
term_eval1(t0, e0) =
(
case+ t0 of
//
|TMvar(x0) =>
envir_lookup(e0, x0)
//
|TMnil() => VALnil()
//
|TMint(i0) => VALint(i0)
|TMbtf(b0) => VALbtf(b0)
|TMchr(c0) => VALchr(c0)
|TMstr(s0) => VALstr(s0)
//
|TMlam _ => VALlam(t0, e0)
|TMtypecheckprint(t, _) => term_eval1(t, e0)
|TMfix _ => VALfix(t0, e0)
//
|TMapp(t1, t2) =>
let
//
val v1 = term_eval1(t1, e0)
val v2 = term_eval1(t2, e0) // call-by-value
//
in
case- v1 of
|
VALlam(t1, e1) =>
let
val-TMlam(x1, tt) = t1
in
term_eval1
(tt, mylist_cons((x1, v2), e1))
end
|
VALfix(t1, e1) =>
let
val-
TMfix(f1, x2, tt) = t1
in
term_eval1
(tt, mylist_cons((f1, v1), mylist_cons((x2, v2), e1)))
end
end
//
|
TMopr(nm, ts) =>
let
val vs = termlst_eval1(ts, e0)
in//let
//
case- nm of
//
| "<" =>
let
val-mylist_cons(v1, vs) = vs
val-mylist_cons(v2, vs) = vs
val-VALint(i1) = v1 and VALint(i2) = v2
in
  VALbtf(i1 < i2)
end
| ">" =>
let
val-mylist_cons(v1, vs) = vs
val-mylist_cons(v2, vs) = vs
val-VALint(i1) = v1 and VALint(i2) = v2
in
  VALbtf(i1 > i2)
end
| "<=" =>
let
val-mylist_cons(v1, vs) = vs
val-mylist_cons(v2, vs) = vs
val-VALint(i1) = v1 and VALint(i2) = v2
in
  VALbtf(i1 <= i2)
end
| ">=" =>
let
val-mylist_cons(v1, vs) = vs
val-mylist_cons(v2, vs) = vs
val-VALint(i1) = v1 and VALint(i2) = v2
in
  VALbtf(i1 >= i2)
end
//
| "+" =>
let
val-mylist_cons(v1, vs) = vs
val-mylist_cons(v2, vs) = vs
val-VALint(i1) = v1 and VALint(i2) = v2
in
  VALint(i1 + i2)
end
| "-" =>
let
val-mylist_cons(v1, vs) = vs
val-mylist_cons(v2, vs) = vs
val-VALint(i1) = v1 and VALint(i2) = v2
in
  VALint(i1 - i2)
end
| "*" =>
let
val-mylist_cons(v1, vs) = vs
val-mylist_cons(v2, vs) = vs
val-VALint(i1) = v1 and VALint(i2) = v2
in
  VALint(i1 * i2)
end
| "/" =>
let
val-mylist_cons(v1, vs) = vs
val-mylist_cons(v2, vs) = vs
val-VALint(i1) = v1 and VALint(i2) = v2
in
  VALint(i1 / i2)
end
| "%" =>
let
val-mylist_cons(v1, vs) = vs
val-mylist_cons(v2, vs) = vs
val-VALint(i1) = v1 and VALint(i2) = v2
in
  VALint(i1 % i2)
end

| "=" =>
let
    val-mylist_cons(v1, vs) = vs
    val-mylist_cons(v2, vs) = vs
    val-VALint(i1) = v1 and VALint(i2) = v2
in
    VALbtf(i1 = i2)
end
//
(* ****** ****** *)
//
| "print" =>
let
val-mylist_cons(v1, vs) = vs
in//let
let
val-
VALint(i0) = v1 in print(i0); VALnil() end
end
| "prchr" =>
let
val-mylist_cons(v1, vs) = vs
in//let
let
val-
VALchr(c0) = v1 in print(c0); VALnil() end
end
| "prstr" =>
let
val-mylist_cons(v1, vs) = vs
in//let
let
val-
VALstr(cs) = v1 in print(cs); VALnil() end
end
//
(* ****** ****** *)
//
| "str_len" =>
let
val-mylist_cons(v1, vs) = vs
in
let
val-
VALstr(cs) = v1 in
  VALint(g0u2i(string_length(cs))) end
end
//
| "str_get_at" =>
let
val-mylist_cons(v1, vs) = vs
val-mylist_cons(v2, vs) = vs
val-VALstr(cs) = v1 and VALint(i0) = v2
in//let
let
val i0 = g1ofg0_int(i0)
val cs = g1ofg0_string(cs)
val n0 = g1u2i(string1_length(cs))
in//let
if
i0 < 0
then $raise EXNstr_get_at else
(
if
i0 >= n0
then $raise EXNstr_get_at
else VALchr(string_get_at(cs, i0)) ) end
end // end of [str_get_at]
//
| "str_set_at" =>
let
val-mylist_cons(v1, vs) = vs
val-mylist_cons(v2, vs) = vs
val-mylist_cons(v3, vs) = vs
val-VALstr(cs) = v1 and VALint(i0) = v2 and VALchr(cr) = v3
in//let
let
val i0 = g1ofg0_int(i0)
val cs = g1ofg0_string(cs)
val n0 = g1u2i(string1_length(cs))
in//let
if
i0 < 0
then $raise EXNstr_set_at else
(
if
i0 >= n0
then $raise EXNstr_set_at
else VALstr(str_fset_at(cs, i0, cr))) end
end // end of [str_set_at]
//
(* ****** ****** *)
//
| "str_eq" =>
let
        val-mylist_cons(v1, vs) = vs
        val-mylist_cons(v2, vs) = vs
        val-VALstr(s1) = v1 and VALstr(s2) = v2
in//let
VALbtf(s1 = s2)
end
| "not" =>
let
val-mylist_cons(v1, vs) = vs
val-VALbtf(b1) = v1
in
VALbtf(~b1)
end
| "ref_get" =>
let
val-
mylist_cons(v1, vs) = vs
in
  let val-VALref(vr) = v1 in !vr end
end
| "ref_set" =>
let
val-
mylist_cons(v1, vs) = vs
val-
mylist_cons(v2, vs) = vs
in
let
val-
VALref(vr) = v1 in !vr := v2; VALnil() end
//
end
| "ref_new" =>
let
val-
mylist_cons(v1, vs) = vs in VALref(ref(v1))
end // end of [ref_new]
| "list_new"  => VALlst(mylist_nil())
| "list_cons" => let
val-mylist_cons(v1, vs) = vs
val-mylist_cons(v2, vs) = vs
val-VALlst(tail) = v2
in
VALlst(mylist_cons(v1, tail))
end
| "list_nilq" =>
let
val-mylist_cons(v1, vs) = vs
val-VALlst(a) = v1
in
  case+ a of
  | mylist_cons(x, y) => VALbtf(false)
  | mylist_nil() => VALbtf(true)
end
| "list_consq" =>
let
val-mylist_cons(v1, vs) = vs
val-VALlst(a) = v1
in
  case+ a of
  | mylist_cons(x, y) => VALbtf(true)
  | mylist_nil() => VALbtf(false)
end
| "list_uncons1" =>
let
val-mylist_cons(v1, vs) = vs
val-VALlst(a) = v1
in
    case+ a of
    | mylist_cons(x, y) => x
    | mylist_nil() => $raise EXNlist_uncons1
end
| "list_uncons2" =>
let
val-mylist_cons(v1, vs) = vs
val-VALlst(a) = v1
in
case+ a of
| mylist_cons(x, y) => VALlst(y) (* need to re-wrap in VAL*)
| mylist_nil() => $raise EXNlist_uncons2
end
| "llist_new" => VALnil()
| "llist_nilq" =>
let
val-mylist_cons(v1, vs) = vs
in
case- v1 of
| VALtup(x, y) => VALbtf(false)
| VALnil() => VALbtf(true)
end
| "llist_consq" =>
let
val-mylist_cons(v1, vs) = vs
in
    case- v1 of
    | VALtup(a, b) => VALbtf(true)
    | VALnil() => VALbtf(false)
end
| "llist_uncons1" =>
let
val-mylist_cons(v1, vs) = vs
val-VALtup(a, b) = v1
in
a
end
| "llist_uncons2" =>
let
val-mylist_cons(v1, vs) = vs
val-VALtup(a, b) = v1
in
b
end
| "llist_cons" =>
let
val-mylist_cons(v1, vs) = vs
val-mylist_cons(v2, vs) = vs
in
VALtup(v1, v2)
end

//
(* ****** ****** *)
(*
list_nilq, list_consq,
list_uncons1, list_uncons2
llist_nilq, llist_consq
llist_uncons1, llist_uncons2
*)
(* ****** ****** *)
//
| _(*unsupported*) =>
(
exit(1) ) where
{
  val () = println!("term_eval1: t0 = ", t0) }
//
end // end of [TMopr(nm, ts)]
//
|
TMif0(t1, t2, t3) =>
let
val t1 = term_eval1(t1, e0)
in//let
case- t1 of
|
VALbtf(b1) =>
(
  if b1 then term_eval1(t2, e0)
        else term_eval1(t3, e0))
end // let // end of [TMif0(...)]
//
|
TMlet(x1, t1, t2) =>
let
val t1_evaluated = term_eval1(t1, e0)
in
  term_eval1
  (t2, mylist_cons((x1, t1_evaluated), e0))
end
//
|
TMfst(tt) =>
let
val-
VALtup(v1, _) =
term_eval1(tt, e0) in v1 end
|
TMsnd(tt) =>
let
val-
VALtup(_, v2) =
term_eval1(tt, e0) in v2 end
//
|
TMtup(t1, t2) =>
(
  VALtup(v1, v2)) where
{
  val v1 = term_eval1(t1, e0)
  val v2 = term_eval1(t2, e0) }
//
|
TManno(t1, T1) => term_eval1(t1, e0)
//
|
TMlamt
( x1
, Tx, tt) => VALlam(TMlam(x1, tt), e0)
|
TMfixt
( f0, x1
, Tf, tt) => VALlam(TMfix(f0, x1, tt), e0)
//
(*
| _(*otherwise*) =>
(
exit(1) ) where
{
val () = println!("term_eval1: t0 = ", t0)
}
*)
) where
{
(*
  val () = println!("term_eval1: t0 = ", t0)
*)
}

(* ****** ****** *)

implement
termlst_eval1(ts, e0) =
(
case+ ts of
|
mylist_nil() => mylist_nil()
|
mylist_cons(t1, ts) =>
mylist_cons
(term_eval1(t1, e0), termlst_eval1(ts, e0))
)

(* ****** ****** *)

implement
envir_lookup
(xvs, x0) =
(
case+ xvs of
|
mylist_nil() => exit(1) where
{
  val () = println!("envir_lookup: x0 = ", x0)
}
|
mylist_cons(xv1, xvs) =>
if x0 = xv1.0 then xv1.1 else envir_lookup(xvs, x0)
)

(* ****** ****** *)

(* end of [CS525-2022-Fall/projects/midterm/Solution/midterm_eval.dats] *)
