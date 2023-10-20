(* ****** ****** *)
//
// How to test
// ./assign04_sol_dats
//
// How to compile:
// myatscc assign04_sol.dats
// or
// patscc -o assign04_sol_dats -DATS_MEMALLOC_LIBC assign04_sol.dats
//
(* ****** ****** *)
#include "share/atspre_staload.hats"
(* ****** ****** *)
#staload "./../../../mylib/mylib.dats"
(* ****** ****** *)

(*
//
HX-2023-10-12: 50 points (Due: 2023-10-18)
//
Please study the code in lecture-10-11 and then
        copy/paste/modify it. Afterwards, please construct
a type-checker of the following type:
//
extern fun assign03_tpcheck(t0: term): type
//
*)

(* ****** ****** *)

implement main0() = () where
{
val () =
println!
("Assign04: the first type-checker!") }

(* ****** ****** *)
(*
Please give your implementation below:
*)
(* ****** ****** *)

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
implement
fprint_type
(out, tp) =
(
case+ tp of
|
TPbas(nm) =>
fprint!(out, "TPbas(", nm, ")")
|
TPfun(tp1, tp2) =>
fprint!(out, "TPfun(", tp1, ";", tp2, ")")
|
TPtup(tp1, tp2) =>
fprint!(out, "TPtup(", tp1, ";", tp2, ")")
)
(* ****** ****** *)
//
extern
fun
type_equal
(t1: type, t2: type): bool
overload = with type_equal
//
(* ****** ****** *)
//
implement
type_equal
( t1, t2 ) =
(
case+ t1 of
|
TPbas(nm1) =>
(case+ t2 of
|
TPbas(nm2) => (nm1 = nm2) | _ => false)
|
TPfun(t11, t12) =>
(case+ t2 of
|
TPfun(t21, t22) =>
( t11 = t21 && t12 = t22 ) | _ => false)
|
TPtup(t11, t12) =>
(case+ t2 of
|
TPtup(t21, t22) =>
( t11 = t21 && t12 = t22 ) | _ => false)
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
//| TMtup of (term, term)
//
| TMopr of (topr, termlst)
//
| TMif0 of (term, term, term)
//
| TMlet of
( tvar(*x*)
, term(*t1*), term(*t2*))
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
term_type0(t) = term_type1(t, mylist_nil)


implement
term_type1
(t0, e0) =
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
//| TMtup(t1, t2) => TPtup(term_type1(t1, e0), term_type1(t2, e0))
//| TMfst(t1) => T11 where {
//        val T1 = term_type1(t1, e0)
//        val T11 = case+ T1 of
//        | TPtup(Ta, Tb) => Ta
//        | _ => todo
//
//}
| TMvar(x0) =>
tpctx_lookup(e0, x0)
//
|
TMapp(t1, t2) =>
(
  T12 ) where
{
val T1 =
term_type1(t1, e0)
val-
TPfun(T11, T12) = T1
val () =
term_type1_ck(t2, T11, e0)
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
(t1, TPbtf, e0)
val T2 =
term_type1(t2, e0)
val () =
term_type1_ck(t3, T2, e0)
}
//
|
TMlam2
(x0, Tx, tt) =>
let
val e1 =
mylist_cons((x0, Tx), e0)
in//let
  TPfun(Tx, Tt) where
{
  val Tt = term_type1(tt, e1)
}
end//end-of-[TMlam2(x0,Tx,tt)]
//
|
TMfix2
(f0, x0, Tf, tt) =>
let
val-
TPfun(Tx, Ty) = Tf
val e1 =
mylist_cons((x0, Tx), e0)
val e2 =
mylist_cons((f0, Tf), e1)
in//let
  Tf where
{
  val () =
  term_type1_ck(tt, Ty, e2)
}
end//end-of-[TMlam2(x0,Tx,tt)]
| TMopr(opr, tl) => (
case- opr of
| "+"  => twoArgOpr(opr, tl, e0, "plus",  TPint, TPint, TPint)
| "-"  => twoArgOpr(opr, tl, e0, "minus", TPint, TPint, TPint)
| "*"  => twoArgOpr(opr, tl, e0, "mult",  TPint, TPint, TPint)
| "/"  => twoArgOpr(opr, tl, e0, "div",   TPint, TPint, TPint)
| "%"  => twoArgOpr(opr, tl, e0, "mod",   TPint, TPint, TPint)
| "<"  => twoArgOpr(opr, tl, e0, "lt",    TPint, TPint, TPbtf)
| ">"  => twoArgOpr(opr, tl, e0, "gt",    TPint, TPint, TPbtf)
| "<=" => twoArgOpr(opr, tl, e0, "lte",   TPint, TPint, TPbtf)
| ">=" => twoArgOpr(opr, tl, e0, "gte",   TPint, TPint, TPbtf)
)
//
| _(*unsupported*) =>
(
exit(1) ) where
{
val () =
println!("term_type1: t0 = ", t0)
}
//
)
where
{
     fun twoArgOpr(opr, tl: termlst, ctx, name: string, arg1_type: type, arg2_type: type, result_type: type) =
     (
        result_type
        where
        {
            val () = case- tl of
                    | mylist_cons(v, mylist_cons(v2, mylist_nil)) => (
                            term_type1_ck(v, arg1_type, ctx) where {
                                val () = term_type1_ck(v2, arg2_type, ctx)
                            }
                            )
                    | _ => println!(name, " got wrong arg count ", TMopr(opr, tl))


        }
    )


}


(* end-of-[term_type1(t0, e0)] *)

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
if not(T0 = Tt) then
        (
                exit(1) ) where
{
val () =
println!("type check failed for asserting: T0 = ", T0, " Tt = ", Tt)
}
) where
{
val T0 = term_type1(t0, ctx)
//val () = println!("term_type1_ck: t0 = ", t0)
//val () = println!("term_type1_ck: T0 = ", T0)
//val () = println!("term_type1_ck: Tt = ", Tt)
}

extern
fun
assign03_tpcheck(t0: term): type

implement assign03_tpcheck(t0) = term_type0(t0)

(* ****** ****** *)

(* end of [CS525-2022-Fall/lecture/lecture-10-11/lambda2.dats] *)



(* ****** ****** *)
fun
TMadd
( x: term
, y: term): term =
TMopr("+", mylist_pair(x, y))
fun
TMsub
( x: term
, y: term): term =
TMopr("-", mylist_pair(x, y))
fun
TMmul
( x: term
, y: term): term =
TMopr("*", mylist_pair(x, y))
(* ****** ****** *)
fun
TMlte
( x: term
, y: term): term =
TMopr("<=", mylist_pair(x, y))
fun
TMgte
( x: term
, y: term): term =
TMopr(">=", mylist_pair(x, y))

(* ****** ****** *)
//
val
TMfibo =
let
val f = TMvar"f"
val x = TMvar"x" in
TMfix2
(
"f", "x",
TPfun(TPint, TPint),
TMif0(
  TMgte(x, TMint(2)),
  TMadd(
  TMapp(f, TMsub(x, TMint(2))),
  TMapp(f, TMsub(x, TMint(1)))), x)) end
//
(* ****** ****** *)
val TPfibo_type = assign03_tpcheck(TMfibo)
(* ****** ****** *)
val ( (*void*) ) =
println!("TPfibo_type = ", TPfibo_type)
(* ****** ****** *)

//GTE test
val basic_gte = TMgte(TMint(5), TMint(6))
val () = println!("GTE test 1, should type check to BTF: ", assign03_tpcheck(basic_gte))

val wrong_types_gte = TMgte(TMint(5), TMbtf(true))
val () = println!("GTE test 2, should not type check: ", assign03_tpcheck(wrong_types_gte))

//val wrong_types_gte = TMgte(TMbtf(false), TMint(4))
//val () = println!("GTE test 3, should not type check: ", assign03_tpcheck(wrong_types_gte))



(* end of [assign04_sol.dats] *)
