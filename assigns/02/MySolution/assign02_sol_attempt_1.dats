(* ****** ****** *)
//
// How to test
// ./assign02_sol_dats
//
// How to compile:
// myatscc assign02_sol.dats
// or
// patscc -o assign02_sol_dats -DATS_MEMALLOC_LIBC assign02_sol.dats
//

#include "./../assign02.dats"

(* ****** ****** *)

//implement
//main0 = lam () => ()

(* ****** ****** *)
typedef tvar = string
typedef topr = string
(* ****** ****** *)
datatype term =
//
//| TMint of int
//| TMbtf of bool
//
| TMvar of tvar
| TMlam of (tvar, term)
| TMapp of (term, term)
//
//| TMopr of (topr, termlst)
//
//| TMif0 of (term, term, term)
//
where termlst = mylist(term)
//
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

implement
fprint_term
(out, t0) =
(
case+ t0 of
|
TMvar(v0) =>
fprint!(out, "TMvar(", v0, ")")
|
TMlam(v0, t1) =>
fprint!(out, "TMlam(", v0, ";", t1, ")")
|
TMapp(t1, t2) =>
fprint!(out, "TMapp(", t1, ";", t2, ")")
)

(* ****** ****** *)

val x = TMvar("x")
val y = TMvar("y")
val z = TMvar("z")

(* ****** ****** *)

val I = TMlam("x", x) // lam x. x
val K = TMlam("x", TMlam("y", x)) // lam x. lam y. x
val K' = TMlam("x", TMlam("y", y)) // lam x. lam y. y
val S = TMlam("x", TMlam("y", TMlam("z", TMapp(TMapp(x, z), TMapp(y, z)))))

(* ****** ****** *)

(*
(* ****** ****** *)
//
HX-2022-09-14:
How to test:
myatscc lambda0.dats && ./lambda0_dats
*)
//
val () = println!("I = ", I)
val () = println!("K = ", K)
val () = println!("S = ", S)
val () = println!("K' = ", K')
//
(* ****** ****** *)
//
val omega =
TMlam("x", TMapp(x, x))
//
val Omega = TMapp(omega, omega)
//
val () = println!("omega = ", omega)
val () = println!("Omega = ", Omega)
//
(* ****** ****** *)
implement main0() = () // HX: it is a dummy
(* ****** ****** *)

extern
fun
term_interp(t0: term): term
extern
fun
termlst_interp(ts: termlst): termlst

(* ****** ****** *)

extern
fun
term_subst0 // t0[x0 -> sub]
(t0: term, x0: tvar, sub: term): term
extern
fun
termlst_subst0 // t0[x0 -> sub]
(ts: termlst, x0: tvar, sub: term): termlst

(* ****** ****** *)

implement
term_interp(t0) =
(
case+ t0 of
|TMvar _ => t0
//
(*
|TMlam _ => t0
//
*)
// HX: please note
// no evaluagtion under lambda!!!
| TMlam(x1, t1) => TMlam(x1, t1) where
{
val t1 = term_interp(t1)
}

//
|
TMapp(t1, t2) =>
let
val t1 = term_interp(t1)
(*
val t2 = term_interp(t2)
*)
in//let
case+ t1 of
| TMlam(x1, tt) =>
term_interp
(term_subst0(tt, x1, t2))
| _(*non-TMlam*) => TMapp(t1, t2) // type-error
end // let // end of [TMapp]
) (* case+ *) // end of [term_interp]

(* ****** ****** *)

implement
termlst_interp(ts) =
(
case+ ts of
|
mylist_nil() =>
mylist_nil()
|
mylist_cons(t1, ts) =>
mylist_cons
(term_interp(t1), termlst_interp(ts))
)

(* ****** ****** *)

val
SKK = TMapp(TMapp(S, K), K)
val () =
println!("interp(SKK) = ", term_interp(SKK))

(* ****** ****** *)
(*
HX: This is non-terminating evaluation!!!
val () =
println!("interp(Omega) = ", term_interp(Omega))
*)
(* ****** ****** *)

implement
term_subst0(t0, x0, sub) =
(
case+ t0 of
//
| TMvar(x1) =>
  if x0 = x1 then sub else t0
//
| TMlam(x1, tt) =>
  if x0 = x1 then t0 else
  TMlam(x1, term_subst0(tt, x0, sub))
//
| TMapp(t1, t2) =>
  TMapp(t1, t2) where
  {
    val t1 = term_subst0(t1, x0, sub)
    val t2 = term_subst0(t2, x0, sub)
  }
//
) (* end of [term_subst0(t0, x0, sub)] *)

(* ****** ****** *)

implement
termlst_subst0(ts, x0, sub) =
(
case+ ts of
|
mylist_nil() => mylist_nil()
|
mylist_cons(t1, ts) =>
mylist_cons
(term_subst0(t1, x0, sub), termlst_subst0(ts, x0, sub))
) (* end of [termlst_subst0(t0, x0, sub)] *)

(* ****** ****** *)

fun
Church_numeral(n: int): term =
let
val f = TMvar"f"
val x = TMvar"x"
fun helper(n: int): term =
if n <= 0 then x else TMapp(f, helper(n-1))
in
  TMlam("f", TMlam("x", helper(n)))
end

(* ****** ****** *)
//
// lam m. lam n. lam f. lam x. m(f)(n(f)(x))
//
val Church_add =
let
val m = TMvar"m"
and n = TMvar"n"
val f = TMvar"f"
and x = TMvar"x" in
TMlam("m",
TMlam("n",
TMlam("f",
TMlam("x",
TMapp
( TMapp(m, f)
, TMapp(TMapp(n, f), x)))))) end
//
(* ****** ****** *)


val TMzeroPure = TMlam("f", TMlam("x", TMvar"x"))
val TMonePure = TMlam("f", TMlam("x", TMapp(TMvar("f"), TMvar"x")))

val
TMsucfPure = // successor
TMapp(Church_add, TMonePure)

val TMtwoPure = term_interp(TMapp(TMsucfPure, TMonePure))
(* ****** ****** *)


val TMnum0 = Church_numeral(0)
val TMnum1 = Church_numeral(1)
val TMnum2 = Church_numeral(2)
val TMnum3 = Church_numeral(3)
val TMnum4 = Church_numeral(4)
val () = println!("TMnum0 = ", TMnum0)
val () = println!("TMzeroPure = ", TMzeroPure)
val () = println!("TMnum1 =    ", TMnum1)
val () = println!("TMonePure = ", TMonePure)
val () = println!("TMnum2 =    ", TMnum2)
val () = println!("TMtwoPure = ", TMtwoPure)

val () = println!("TMnum3 = ", TMnum3)
val () = println!("TMnum4 = ", TMnum4)

(* ****** ****** *)

//
val Church_mul =
let
val m = TMvar"m"
and n = TMvar"n"
val f = TMvar"f"
and x = TMvar"x" in
TMlam("m",
TMlam("n",
TMlam("f",
TMlam("x",
TMapp(TMapp(m, TMapp(n, f)), x))))) end
//
(* ****** ****** *)

val Church_pow =
let
val m = TMvar"m"
and n = TMvar"n"
val f = TMvar"f"
and x = TMvar"x" in
TMlam("m",
TMlam("n",
TMlam("f",
TMlam("x",
TMapp(TMapp(TMapp(n, m), f), x))))) end

(* ****** ****** *)


//fun Church_num2int(n: term): term =
//term_interp(TMapp(TMapp(n, TMsucf), TMint(0)))

(* ****** ****** *)

//val () = println!
//("Church_num(TMnum3) = ", Church_num2int(TMnum3))

(* ****** ****** *)

val
TMnum_add_2_3 =
TMapp(TMapp(Church_add, TMnum2), TMnum3)
val () =
println!("TMnum_add_2_3 = ", term_interp(TMnum_add_2_3))
val () =
println!("5 =             ", term_interp(Church_numeral(5)))

val
TMnum_add_3_4 =
TMapp(TMapp(Church_add, TMnum3), TMnum4)
//val () =
//println!("TMnum_add_3_4 = ", Church_num2int(TMnum_add_3_4))

(* ****** ****** *)

val
TMnum_mul_2_3 =
TMapp(TMapp(Church_mul, TMnum2), TMnum3)
//val () =
//println!("TMnum_mul_2_3 = ", Church_num2int(TMnum_mul_2_3))
val
TMnum_mul_3_3 =
TMapp(TMapp(Church_mul, TMnum3), TMnum3)
//val () =
//println!("TMnum_mul_3_3 = ", Church_num2int(TMnum_mul_3_3))
val
TMnum_mul_4_4 =
TMapp(TMapp(Church_mul, TMnum4), TMnum4)
//val () =
//println!("TMnum_mul_4_4 = ", Church_num2int(TMnum_mul_4_4))

(* ****** ****** *)

val
TMnum_pow_3_4 =
TMapp(TMapp(Church_pow, TMnum3), TMnum4)
//val () =
//println!("TMnum_pow_3_4 = ", Church_num2int(TMnum_pow_3_4))

(* ****** ****** *)

(*
fun fact(x) =
if x > 0 then x * fact(x-1) else 1
fun fibo(x) =
if x >= 2 then fibo(x-2) + fibo(x-1) else x
*)

(* ****** ****** *)

val Y =
let
val f = TMvar"f"
and x = TMvar"x" in
TMlam("f",
TMapp(
TMlam("x", TMapp(f, TMapp(x, x))),
TMlam("x", TMapp(f, TMapp(x, x))))) end

(* ****** ****** *)

(*
val FIBO =
lam f. lam x.
if x >= 2 then f(x-2) + f(x-1) else x
Y = lam f. (lam x. f(x(x)))(lam x. f(x(x)))
fun fibo = Y(F)
fun fibo = F(fibo) // fibo is a fixed point of F!
*)

(* ****** ****** *)

//val FIBO =
//let
//val f = TMvar"f"
//val x = TMvar"x" in
//TMlam("f",
//TMlam("x",
//TMif0(
//TMgte(x, TMint(2)),
//TMadd(
//TMapp(f, TMsub(x, TMint(2))),
//TMapp(f, TMsub(x, TMint(1)))), x))) end

(* ****** ****** *)

//val TMfibo = TMapp(Y, FIBO)

(* ****** ****** *)

(* ****** ****** *)

