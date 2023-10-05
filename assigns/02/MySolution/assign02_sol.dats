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
(* ****** ****** *)
(*
implement
main0 = lam () => ()
*)
(* ****** ****** *)
typedef tvar = string
typedef topr = string
(* ****** ****** *)
datatype term =
//
| TMint of int
| TMbtf of bool
//
| TMvar of tvar
| TMlam of (tvar, term)
| TMapp of (term, term)
//
| TMopr of (topr, termlst)
//
| TMif0 of (term, term, term)
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
TMint(i0) =>
fprint!(out, "TMint(", i0, ")")
|
TMbtf(b0) =>
fprint!(out, "TMbtf(", b0, ")")
|
TMvar(v0) =>
fprint!(out, "TMvar(", v0, ")")
|
TMlam(v0, t1) =>
fprint!(out, "TMlam(", v0, ";", t1, ")")
|
TMapp(t1, t2) =>
fprint!(out, "TMapp(", t1, ";", t2, ")")
|
TMopr(nm, ts) =>
fprint!(out, "TMopr(", nm, ";", ts, ")")
|
TMif0(t1, t2, t3) =>
fprint!(out, "TMif0(", t1, ";", t2, ";", t3, ")")
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
//
|TMint _ => t0
|TMbtf _ => t0
//
|TMvar _ => t0
//
|TMlam _ => t0
//
(*
// HX: please note
// no evaluagtion under lambda!!!
|
TMlam(x1, t1) =>
TMlam(x1, t1) where
{
val t1 = term_interp(t1)
}
*)
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
//
|
TMopr(nm, ts) =>
let
val ts = termlst_interp(ts)
in//let
//
case- nm of
| "+" =>
let
val-mylist_cons(t1, ts) = ts
val-mylist_cons(t2, ts) = ts
val-TMint(i1) = t1 and TMint(i2) = t2
in
  TMint(i1 + i2)
end
| "-" =>
let
val-mylist_cons(t1, ts) = ts
val-mylist_cons(t2, ts) = ts
val-TMint(i1) = t1 and TMint(i2) = t2
in
  TMint(i1 - i2)
end
| "*" =>
let
val-mylist_cons(t1, ts) = ts
val-mylist_cons(t2, ts) = ts
val-TMint(i1) = t1 and TMint(i2) = t2
in
  TMint(i1 * i2)
end
| "<" =>
let
val-mylist_cons(t1, ts) = ts
val-mylist_cons(t2, ts) = ts
val-TMint(i1) = t1 and TMint(i2) = t2
in
  TMbtf(i1 < i2)
end
| ">" =>
let
val-mylist_cons(t1, ts) = ts
val-mylist_cons(t2, ts) = ts
val-TMint(i1) = t1 and TMint(i2) = t2
in
  TMbtf(i1 > i2)
end
| "<=" =>
let
val-mylist_cons(t1, ts) = ts
val-mylist_cons(t2, ts) = ts
val-TMint(i1) = t1 and TMint(i2) = t2
in
  TMbtf(i1 <= i2)
end
| ">=" =>
let
val-mylist_cons(t1, ts) = ts
val-mylist_cons(t2, ts) = ts
val-TMint(i1) = t1 and TMint(i2) = t2
in
  TMbtf(i1 >= i2)
end
//
end // end of [TMopr(nm, ts)]
//
|
TMif0(t1, t2, t3) =>
let
val t1 = term_interp(t1)
in//let
case+ t1 of
|
TMbtf(b1) =>
if b1
then term_interp(t2) else term_interp(t3)
|
_(*non-TMbtf*) =>
TMif0(t1, term_interp(t2), term_interp(t3)) // type-error
end // let // end of [TMif0]
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
| TMint _ => t0
| TMbtf _ => t0
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
| TMopr(nm, ts) =>
  TMopr(nm, ts) where
  {
    val ts =
    termlst_subst0(ts, x0, sub)
  }
//
| TMif0(t1, t2, t3) =>
  TMif0(t1, t2, t3) where
  {
    val t1 = term_subst0(t1, x0, sub)
    val t2 = term_subst0(t2, x0, sub)
    val t3 = term_subst0(t3, x0, sub)
  }
//
(*
| _ (* otherwise *) =>
(
assert(false); exit(0)) where
{
  val () = print!("term_subst0: t0 = ", t0)
}
*)
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
//
fun
TMlt
( t1: term
, t2: term): term =
TMopr("<", mylist_pair(t1, t2))
fun
TMgt
( t1: term
, t2: term): term =
TMopr(">", mylist_pair(t1, t2))
fun
TMlte
( t1: term
, t2: term): term =
TMopr("<=", mylist_pair(t1, t2))
fun
TMgte
( t1: term
, t2: term): term =
TMopr(">=", mylist_pair(t1, t2))
//
fun
TMadd
( t1: term
, t2: term): term =
TMopr("+", mylist_pair(t1, t2))
fun
TMsub
( t1: term
, t2: term): term =
TMopr("-", mylist_pair(t1, t2))
fun
TMmul
( t1: term
, t2: term): term =
TMopr("*", mylist_pair(t1, t2))
//
(* ****** ****** *)
//
val test1 = println!
("TMadd(TMint(1), TMint(2)) = ", term_interp(TMadd(TMint(1), TMint(2))))
val test2 = println!
("TMsub(TMint(1), TMint(2)) = ", term_interp(TMsub(TMint(1), TMint(2))))
val test3 = println!
("TMmul(TMint(1), TMint(2)) = ", term_interp(TMmul(TMint(1), TMint(2))))
//
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

val TMnum0 = Church_numeral(0)
val TMnum1 = Church_numeral(1)
val TMnum2 = Church_numeral(2)
val TMnum3 = Church_numeral(3)
val TMnum4 = Church_numeral(4)
val () = println!("TMnum0 = ", TMnum0)
val () = println!("TMnum1 = ", TMnum1)
val () = println!("TMnum2 = ", TMnum2)
val () = println!("TMnum3 = ", TMnum3)
val () = println!("TMnum4 = ", TMnum4)

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

val
TMsucf = // successor
TMlam("x", TMadd(TMvar"x", TMint(1)))

fun Church_num2int(n: term): term =
term_interp(TMapp(TMapp(n, TMsucf), TMint(0)))

(* ****** ****** *)

val () = println!
("Church_num(TMnum3) = ", Church_num2int(TMnum3))

(* ****** ****** *)

val
TMnum_add_2_3 =
TMapp(TMapp(Church_add, TMnum2), TMnum3)
val () =
println!("TMnum_add_2_3 = ", Church_num2int(TMnum_add_2_3))
val
TMnum_add_3_4 =
TMapp(TMapp(Church_add, TMnum3), TMnum4)
val () =
println!("TMnum_add_3_4 = ", Church_num2int(TMnum_add_3_4))

(* ****** ****** *)

val
TMnum_mul_2_3 =
TMapp(TMapp(Church_mul, TMnum2), TMnum3)
val () =
println!("TMnum_mul_2_3 = ", Church_num2int(TMnum_mul_2_3))
val
TMnum_mul_3_3 =
TMapp(TMapp(Church_mul, TMnum3), TMnum3)
val () =
println!("TMnum_mul_3_3 = ", Church_num2int(TMnum_mul_3_3))
val
TMnum_mul_4_4 =
TMapp(TMapp(Church_mul, TMnum4), TMnum4)
val () =
println!("TMnum_mul_4_4 = ", Church_num2int(TMnum_mul_4_4))

(* ****** ****** *)

val
TMnum_pow_3_4 =
TMapp(TMapp(Church_pow, TMnum3), TMnum4)
val () =
println!("TMnum_pow_3_4 = ", Church_num2int(TMnum_pow_3_4))

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

val FIBO =
let
val f = TMvar"f"
val x = TMvar"x" in
TMlam("f",
TMlam("x",
TMif0(
TMgte(x, TMint(2)),
TMadd(
TMapp(f, TMsub(x, TMint(2))),
TMapp(f, TMsub(x, TMint(1)))), x))) end

(* ****** ****** *)

val TMfibo = TMapp(Y, FIBO)

(* ****** ****** *)

val () = println!
("TMfibo5 = ", term_interp(TMapp(TMfibo, TMint(5))))
val () = println!
("TMfibo10 = ", term_interp(TMapp(TMfibo, TMint(10))))

(* ****** ****** *)

val () = println!("*******************************")

val TMzeroPure = TMlam("f", TMlam("x", TMvar"x"))

val () = println!("Impure zero   = ", Church_numeral(0))
val () = println!("Pure lam zero = ", TMzeroPure)
val () = println!("Evaluates to ", Church_num2int(TMzeroPure))

val TMonePure = TMlam("f", TMlam("x", TMapp(TMvar("f"), TMvar"x")))

val () = println!("Impure one   = ", Church_numeral(1))
val () = println!("Pure lam one = ", TMonePure)
val () = println!("Evaluates to ", Church_num2int(TMonePure))


val
TMsucfPure = // successor
TMapp(Church_add, TMonePure) // Church_add is pure

val TMtwoPure = TMapp(TMsucfPure, TMonePure)

val () = println!("Impure two   = ", Church_numeral(2))
val () = println!("Pure lam two = ", TMtwoPure)
val () = println!("Evaluates to ", Church_num2int(TMtwoPure))


// pair is lam a. lam b. lam f. f a b

val TMpair = TMlam("a",
 TMlam("b",
  TMlam("f",
        TMapp(
            TMapp(TMvar"f", TMvar"a"),
            TMvar"b"
         )
  )
 )
)



// T = lam ab. a

val T = TMlam("a", TMlam("b", TMvar"a"))

// F = lam ab. b

val F = TMlam("a", TMlam("b", TMvar"b"))


// pair x y T --> x
//   ((lam abf. f a b) x y) (lam ab. a)
//   (lam ab. (lam a1b1. a1)) x y
//    x


val pair_5_6 = TMapp(TMapp(TMpair, Church_numeral(5)), Church_numeral(6))
val five_from_pair = TMapp(pair_5_6, T)
val six_from_pair = TMapp(pair_5_6, F)

val () = println!("Should be 5 ", Church_num2int(five_from_pair))
val () = println!("Should be 6 ", Church_num2int(six_from_pair))



// need func (a, b) and returns (b, b+1)
// apply that func b times on (0, 0) to get (b-1, b). Then apply T

// inc_pair = lam x. (pair x (x+1))
// prev = lam z. ((inc_pair 0) z) T


val TMinc_pair  = TMlam("x",
    TMapp(TMapp(TMpair, TMvar"x"), TMapp(TMsucfPure, TMvar"x"))
)

val pair_0_1 = TMapp(TMinc_pair, Church_numeral(0))

val () = println!("Pair 0 1 is ",term_interp(pair_0_1))

val zero_from_pair = TMapp(pair_0_1, T)
val one_from_pair = TMapp(pair_0_1, F)

val () = println!("Should be 0 ", Church_num2int(zero_from_pair))
val () = println!("Should be 1 ", Church_num2int(one_from_pair))

val TMincPair = TMlam("x",
    TMapp(TMinc_pair,
        TMapp(TMvar"x", F) //get the second element and run inc_pair on it
    )
)

val pair_1_2 = TMapp(TMincPair, pair_0_1)
val one_from_pair_prime = TMapp(pair_1_2, T)
val two_from_pair = TMapp(pair_1_2, F)

val () = println!("Should be 1 ", Church_num2int(one_from_pair_prime))
val () = println!("Should be 2 ", Church_num2int(two_from_pair))

val pair_0_0 = TMapp(TMapp(TMpair, Church_numeral(0)), Church_numeral(0))

val TMdeced_pair = TMlam("x", TMapp(TMapp(TMvar"x", TMincPair), pair_0_0))

val pair_7_8 = TMapp(TMdeced_pair, Church_numeral(8))

val () = println!("Should be 7 ", Church_num2int(TMapp(pair_7_8, T)))

val TMdec = TMlam("x", TMapp(TMapp(TMdeced_pair, TMvar"x"), T))

val () = println!("Should be 12 ", Church_num2int(TMapp(TMdec, Church_numeral(13))))

(*****************)

// we need iszero
// help from https://pages.cs.wisc.edu/~horwitz/CS704-NOTES/2.LAMBDA-CALCULUS-PART2.html
//   T = lam ab. a
//   F = lam ab. b
//   0 = lam fx. x
//   0 = lam ab. b
//   0 = F // side note that's actually really elegant
//   3 = lam fx. f(f(f(x)))
// we need λf.f(λx.FALSE)TRUE
//
val is_zero = TMlam("f", TMapp(TMapp(TMvar"f", TMlam("x", F)), T))
val is_5_0 = TMapp(is_zero, Church_numeral(5))
val is_0_0 = TMapp(is_zero, Church_numeral(0))
val () = println!("True       ", T)
val () = println!("False      ", F)
val () = println!("Is 5 zero? ", term_interp(is_5_0))
val () = println!("Is 0 zero? ", term_interp(is_0_0))

val sub = TMlam("y", TMlam("x", TMapp(TMapp(TMvar"x", TMdec), TMvar"y")))

val five_minus_3 = TMapp(TMapp(sub, Church_numeral(5)), Church_numeral(3))
val () = println!("should be 2 ", Church_num2int(five_minus_3))

val TMgte = TMlam("m",
    TMlam("n",
        TMapp(is_zero,
            TMapp(TMapp(sub, TMvar"n"), TMvar"m")
            )
        )
    )

val five_gte_3 = TMapp(TMapp(TMgte, Church_numeral(5)), Church_numeral(3))
val five_gte_5 = TMapp(TMapp(TMgte, Church_numeral(5)), Church_numeral(5))
val three_gte_5 = TMapp(TMapp(TMgte, Church_numeral(3)), Church_numeral(5))

val () = println!("should be true ", term_interp(five_gte_3))
val () = println!("should be true ", term_interp(five_gte_5))
val () = println!("should be false ", term_interp(three_gte_5))


(*
val FIBO =
lam f. lam x.
if x >= 2 then f(x-2) + f(x-1) else x
Y = lam f. (lam x. f(x(x)))(lam x. f(x(x)))
fun fibo = Y(F)
fun fibo = F(fibo) // fibo is a fixed point of F!
*)

val pure_fibo =
 let
 val f = TMvar"f"
 val x = TMvar"x" in
TMlam("f", TMlam("x",
    TMapp(
    TMapp(
        TMapp(TMapp(TMgte,x), Church_numeral(2)), //conditional
            //TRUE BRANCH
            TMapp(
            TMapp(Church_add,
                TMapp(f,
                    TMapp(TMapp(sub, x), Church_numeral(2))
                )
            ),
                TMapp(f,
                    TMapp(TMapp(sub, x), Church_numeral(1))
                )
            )

    ),
        x //FALSE BRANCH
    )
))
end

val TMfibo_pure = TMapp(Y, pure_fibo)

val () = println!
("TMfibo_pure5 = ", Church_num2int(
    TMapp(TMfibo_pure, Church_numeral(5))
    )
)

val () = println!
("TMfibo_pure10 = ", Church_num2int(
    TMapp(TMfibo_pure, Church_numeral(10))
    )
)