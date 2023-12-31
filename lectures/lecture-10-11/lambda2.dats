(* ****** ****** *)
#include
"share\
/atspre_staload.hats"
(* ****** ****** *)
#staload
"./../../mylib/mylib.dats"
(* ****** ****** *)
implement
main0 = lam () => ()
(* ****** ****** *)
//
typedef tbas = string
//
(* ****** ****** *)
//
datatype type =
//
|
TPbas of tbas // base types:
// int, bool, float, string, etc
|
TPfun of (type, type) // T1 -> T2
|
TPtup of (type, type) // T1 * T2
//
(*
| TPref of type
| TParray of type
| TPlist of type // for lists
| TPllist of type // for lazy lists
*)
//
where typelst = mylist(type)
//
(* ****** ****** *)
val TPint = TPbas("int")
val TPbtf = TPbas("bool")
val TPstr = TPbas("string")
(* ****** ****** *)
extern
fun
print_type(type): void
extern
fun
fprint_type
(out:FILEref, tp:type): void
(* ****** ****** *)
implement
print_type(tp) =
fprint_type(stdout_ref, tp)
(* ****** ****** *)
implement
fprint_val<type> = fprint_type
(* ****** ****** *)
overload print with print_type
overload fprint with fprint_type
(* ****** ****** *)
//
implement
fprint_type
(out, T0) =
(
case+ T0 of
|
TPbas(nm) =>
fprint!(out, "TPbas(", nm, ")")
|
TPfun(T1, T2) =>
fprint!(out, "TPfun(", T1, ";", T2, ")")
|
TPtup(T1, T2) =>
fprint!(out, "TPtup(", T1, ";", T2, ")")
)
//
(* ****** ****** *)
//
extern
fun
type_equal
(T1: type, T2: type): bool
overload = with type_equal
//
(* ****** ****** *)
//
implement
type_equal
( T1, T2 ) =
(
case+ T1 of
|
TPbas(nm1) =>
(case+ T2 of
|
TPbas(nm2) => (nm1 = nm2) | _ => false)
|
TPfun(T11, T12) =>
(case+ T2 of
|
TPfun(T21, T22) =>
( T11 = T21 && T12 = T22 ) | _ => false)
|
TPtup(T11, T12) =>
(case+ T2 of
|
TPtup(T21, T22) =>
( T11 = T21 && T12 = T22 ) | _ => false)
)
//
(* ****** ****** *)
typedef tvar = string
typedef topr = string
(* ****** ****** *)
//
datatype term =
//
| TMint of int
| TMbtf of bool
| TMstr of string
//
| TMvar of tvar
| TMlam of (tvar, term)
| TMapp of (term, term)
//
| TMopr of (topr, termlst)
//
| TMif0 of (term, term, term)
//
| TMlet of
( tvar(*x*)
, term(*t1*), term(*t2*))
//
| TMfst of (term)
| TMsnd of (term)
| TMtup of (term, term)
//
| TMfix of
  (tvar(*f*), tvar(*x*), term)
//
| TMlam2 of
  (tvar, type, term)
| TMfix2 of
  (tvar(*f*), tvar(*x*), type, term)
//
where termlst = mylist(term)
//
(* ****** ****** *)

typedef tpctx = mylist(@(tvar, type))

(* ****** ****** *)
extern
fun
print_term(t0:term): void
extern
fun
fprint_term
(out:FILEref, t0:term): void
(* ****** ****** *)
implement
print_term(t0) =
fprint_term(stdout_ref, t0)
(* ****** ****** *)
implement
fprint_val<term> = fprint_term
(* ****** ****** *)
overload print with print_term
overload fprint with fprint_term
(* ****** ****** *)
//
implement
fprint_term
(out, t0) =
(
case+ t0 of
|
TMint(i0) =>
fprint!(out, "TMint(", i0, ")")
|
TMbtf(b0) =>
fprint!(out, "TMbtf(", b0, ")")
|
TMstr(s0) =>
fprint!(out, "TMstr(", s0, ")")
|
TMvar(v0) =>
fprint!(out, "TMvar(", v0, ")")
|
TMlam(v0, t1) =>
fprint!(out, "TMlam(", v0, ";", t1, ")")
|
TMapp(t1, t2) =>
fprint!(out, "TMapp(", t1, ";", t2, ")")
//
|
TMopr(nm, ts) =>
fprint!(out, "TMopr(", nm, ";", ts, ")")
|
TMif0(t1, t2, t3) =>
fprint!
(out, "TMif0(", t1, ";", t2, ";", t3, ")")
//
|
TMlet(x, t1, t2) =>
fprint!
(out, "TMlet(", x, ";", t1, ";", t2, ")")
//
|
TMfst(tt) =>
fprint!(out, "TMfst(", tt, ")")
|
TMsnd(tt) =>
fprint!(out, "TMsnd(", tt, ")")
|
TMtup(t1, t2) =>
(
 fprint!(out, "TMtup(", t1, ";", t2, ")"))
//
|
TMfix(f, x, tt) =>
fprint!(out, "TMfix(", f, ";", x, ";", tt, ")")
//
|
TMlam2(x, Tx, tt) =>
fprint!(out, "TMlam2(", x, ";", Tx, ";", tt, ")")
|
TMfix2(f, x, Tf, tt) =>
fprint!(out, "TMfix2(", f, ";", x, ";", Tf, ";", tt, ")")
//
)
//
(* ****** ****** *)

extern
fun
term_type0(term): type
extern
fun
term_type1(term, tpctx): type
extern
fun
term_type1_ck
(t0: term, T0: type, ctx: tpctx): void
extern
fun
termlst_type1
(ts:termlst, e0:tpctx): typelst

(* ****** ****** *)

extern
fun
tpctx_lookup(tpctx, tvar): type

(* ****** ****** *)

implement
term_type1
(t0, c0) =
(
case+ t0 of
//
|
TMint(i0) => TPint
|
TMbtf(b0) => TPbtf
|
TMstr(s0) => TPstr
//
|
TMvar(x0) =>
tpctx_lookup(c0, x0)
//
|
TMapp(t1, t2) =>
(
  T12 ) where
{
val T1 =
term_type1(t1, c0)
val-
TPfun(T11, T12) = T1
val () =
term_type1_ck(t2, T11, c0)
}
//
|
TMif0
(t1, t2, t3) =>
(
  T2 ) where
{
val () =
term_type1_ck
(t1, TPbtf, c0)
val T2 =
term_type1(t2, c0)
val () =
term_type1_ck(t3, T2, c0)
}
//
|TMfst(tt) =>
let
val-
TPtup(T1, _) =
term_type1(tt, c0) in T1 end
//
|TMsnd(tt) =>
let
val-
TPtup(_, T2) =
term_type1(tt, c0) in T2 end
//
|
TMtup
(t1, t2) =>
TPtup(T1, T2) where
{
val T1 = term_type1(t1, c0)
val T2 = term_type1(t2, c0) }
//
|
TMlet
(x1, t1, t2) =>
(
term_type1(t2, c1)) where
{ val T1 =
  term_type1(t1, c0)
  val c1 =
  mylist_cons((x1, T1), c0) }
//
|
TMlam2
(x0, Tx, tt) =>
let
val c1 =
mylist_cons((x0, Tx), c0)
in//let
  TPfun(Tx, Tt) where
{
  val Tt = term_type1(tt, c1)
}
end//end-of-[TMlam2(x0,Tx,tt)]
//
|
TMfix2
(f0, x0, Tf, tt) =>
let
val-
TPfun(Tx, Ty) = Tf
val c1 =
mylist_cons((x0, Tx), c0)
val c2 =
mylist_cons((f0, Tf), c1)
in//let
  Tf where
{
  val () =
  term_type1_ck(tt, Ty, c2)
}
end//end-of-[TMlam2(x0,Tx,tt)]
//
| _(*unsupported*) =>
(
exit(1) ) where
{
val () =
println!("term_type1: t0 = ", t0)
}
//
) (* end-of-[term_type1(t0, c0)] *)

(* ****** ****** *)

implement
tpctx_lookup
(xts, x0) =
(
case+ xts of
|
mylist_nil() => exit(1) where
{
  val () = println!("tpctx_lookup: x0 = ", x0)
}
|
mylist_cons(xt1, xts) =>
if x0 = xt1.0 then xt1.1 else tpctx_lookup(xts, x0)
)

(* ****** ****** *)

implement
term_type1_ck
(t0, Tt, ctx) =
(
assert(T0 = Tt)) where
{
val T0 = term_type1(t0, ctx)
val () = println!("term_type1_ck: t0 = ", t0)
val () = println!("term_type1_ck: T0 = ", T0)
val () = println!("term_type1_ck: Tt = ", Tt)
}

(* ****** ****** *)

(* end of [CS525-2022-Fall/lecture/lecture-10-11/lambda2.dats] *)
