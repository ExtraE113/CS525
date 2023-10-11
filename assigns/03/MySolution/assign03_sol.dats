(* ****** ****** *)
(*
Due: Wednesday, the 4th of October
*)
(* ****** ****** *)
(* ****** ****** *)
#include "share/atspre_staload.hats"
(* ****** ****** *)
#staload "./../../../mylib/mylib.dats"

implement main0 () = ()
(* ****** ****** *)
(*
implement main() = 0 // HX: this is a dummy
*)
(* ****** ****** *)
(*
//HX-2023-10-04: 50 points (Due: 2023-10-11)
//Please study the code in lecture-10-04 and then
copy/paste/modify it. Afterwards, please construct
a compiler that compiles the LAMBDA1 (which extends
the pure lambda-calculus) into the pure core that
contains only three constructs: TMvar, TMlam, and
TMapp. The name of the main compiling function is
given below:
//
extern
fun assign03_compile(t0: term): term
//Please note that new constructs TMtup, TMfst, and
TMsnd are added for representing tuples. You need
to first implement these constructs in term_eval1:
//
|
TMtup(t1, t2) =>
VALtup(v1, v2) where
{
  val v1 = term_eval1(t1, e0)
  val v2 = term_eval1(t2, e0)
}
|
TMfst(tt) => // fst projection
(
case- vv of
|VALtup(v1, v2) => v1
) where
{
  val vv = term_eval1(tt, e0) }
|
TMsnd(tt) => // snd projection
(
case- vv of
|VALtup(v1, v2) => v2
) where
{
  val vv = term_eval1(tt, e0) }
//
Please note that you need to compile TMint and TMbtf
into Church numerals and Church booleans. In addition,
the primitive operators need to be implemented accordingly
Also, the handling of TMif0 can be a little bit tricky
because LAMBDA1 is a call-by-value language.
//
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
| TMfst of term
| TMsnd of term
| TMtup of (term, term)
//
| TMopr of (topr, termlst)
//
| TMif0 of (term, term, term)
//
where termlst = mylist(term)
//
(* ****** ****** *)

datatype
value =
//
| VALint of int
| VALbtf of bool
//
| VALtup of (value, value)
//
| VALlam of (term(*lam*), envir)

where envir = mylist(@(tvar, value))

(* ****** ****** *)

typedef
valuelst = mylist(value)

(* ****** ****** *)
extern
fun
print_term(t0:term): void
extern
fun
fprint_term
(out:FILEref, t0:term): void
(* ****** ****** *)
extern
fun
print_value(v0:value): void
extern
fun
fprint_value
(out:FILEref, v0:value): void
(* ****** ****** *)
//
implement
print_term(t0) =
fprint_term(stdout_ref, t0)
//
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
TMfst(tt) =>
fprint!(out, "TMfst(", tt, ")")
|
TMsnd(tt) =>
fprint!(out, "TMsnd(", tt, ")")
|
TMtup(t1, t2) =>
fprint!(out, "TMtup(", t1, ";", t2, ")")
//
|
TMopr(nm, ts) =>
fprint!(out, "TMopr(", nm, ";", ts, ")")
|
TMif0(t1, t2, t3) =>
fprint!(out, "TMif0(", t1, ";", t2, ";", t3, ")")
)
//
(* ****** ****** *)
implement
print_value(t0) =
fprint_value(stdout_ref, t0)
(* ****** ****** *)
implement
fprint_val<value> = fprint_value
(* ****** ****** *)
overload print with print_value
overload fprint with fprint_value
(* ****** ****** *)
//
implement
fprint_value
(out, v0) =
(
case+ v0 of
|
VALint(i0) =>
fprint!(out, "VALint(", i0, ")")
|
VALbtf(b0) =>
fprint!(out, "VALbtf(", b0, ")")
|
VALtup(v1, v2) =>
fprint!(out, "VALtup(", v1, ";", v2, ")")
|
VALlam(t1, env) =>>
fprint!(out, "VALlam(", t1, ";", "...", ")")
)
//
(* ****** ****** *)


extern
fun
term_eval0(term): value
extern
fun
term_eval1(term, envir): value
extern
fun
termlst_eval1
(ts:termlst, e0:envir): valuelst

(* ****** ****** *)

extern
fun
envir_lookup(envir, tvar): value

(* ****** ****** *)
//
implement
term_eval0(t0) =
term_eval1(t0, e0) where
{
  val e0 = mylist_nil(*void*) }
//
(* ****** ****** *)
val I = TMlam("x", TMvar"x") // lam x. x

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
// T = lam ab. a
val T = TMlam("a", TMlam("b", TMvar"a"))

// F = lam ab. b
val F = TMlam("a", TMlam("b", TMvar"b"))
val TMnot = TMlam("p", TMapp(TMapp(TMvar"p", F), T))

// https://en.wikipedia.org/wiki/Lambda_calculus
val TMand = TMlam("p", TMlam("q", TMapp(TMapp(TMvar"p", TMvar"q"), TMvar"p")))
val TMor  = TMlam("p", TMlam("q", TMapp(TMapp(TMvar"p", TMvar"p"), TMvar"q")))
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
fun
TMadd
( t1: term
, t2: term): term =
TMopr("+", mylist_pair(t1, t2))

val
TMsucf: term = // successor
TMlam("x", TMadd(TMvar"x", TMint(1)))

fun Church_num2int(n: term) =
term_eval0(
        TMapp(TMapp(n, TMsucf), TMint(0))
        )

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



(************)

val
TMsucfPure = // successor
TMapp(Church_add, Church_numeral(1)) // Church_add is pure

val TMinc_pair_from_num  = TMlam("x",
                        TMapp(TMapp(TMpair, TMvar"x"), TMapp(TMsucfPure, TMvar"x"))
)

val TMincPair = TMlam("x",
    TMapp(TMinc_pair_from_num,
        TMapp(TMvar"x", F) //get the second element and run TMinc_pair_from_num on it
    )
)


val pair_0_0 = TMapp(TMapp(TMpair, Church_numeral(0)), Church_numeral(0))

val TMinc_pair  = TMlam("x",
                        TMapp(TMapp(TMpair, TMvar"x"), TMapp(TMsucfPure, TMvar"x"))
)
val TMdeced_pair = TMlam("x", TMapp(TMapp(TMvar"x", TMincPair), pair_0_0))


val TMdec = TMlam("x", TMapp(TMapp(TMdeced_pair, TMvar"x"), T))


val is_zero = TMlam("f", TMapp(TMapp(TMvar"f", TMlam("x", F)), T))

val sub = TMlam("y", TMlam("x", TMapp(TMapp(TMvar"x", TMdec), TMvar"y")))



// https://en.wikipedia.org/wiki/Church_encoding#Division

val TMgte_c = TMlam("m",
    TMlam("n",
        TMapp(is_zero,
            TMapp(TMapp(sub, TMvar"n"), TMvar"m")
            )
        )
    )
val Y =
let
val f = TMvar"f"
and x = TMvar"x" in
TMlam("f",
TMapp(
TMlam("x", TMapp(f, TMapp(x, x))),
TMlam("x", TMapp(f, TMapp(x, x))))) end

// modified from https://en.wikipedia.org/wiki/Church_encoding#Division

val div1 = TMlam("f", TMlam("n", TMlam("m",TMapp(
                           TMapp(TMapp(
                                   TMapp(TMapp(TMgte_c, TMvar"n"), TMvar"m"), // conditional
                                    TMlam("x", TMapp(TMsucfPure,
                                            TMapp(TMapp(TMvar"f", TMapp(TMapp(sub, TMvar"n"), TMvar"m")), TMvar"m")
                                         )
                                      )),
                                 TMlam("x", Church_numeral(0)) //else
                           ), TMvar"x")
                           )))

val Z =
let
    val f = TMvar"f"
    val x = TMvar"x"
    val v = TMvar"v"
in
    TMlam("f", TMapp(TMlam("x", TMapp(f, TMlam("v", TMapp(TMapp(x, x), v)))), TMlam("x", TMapp(f, TMlam("v", TMapp(TMapp(x, x), v))))))
end

val div = TMapp(Z, div1)


val pureMod =
        TMlam("x", TMlam("y",
                           TMapp(
                                 TMapp(sub, TMvar"x"),
                                 TMapp(
                                   TMapp(Church_mul,
                                         TMapp(TMapp(div, TMvar"x"), TMvar"y")
                                         ),
                                   TMvar"y")
                                )
                           ))


// div, mod don't work right under call-by-value, but skipping as per @32 on piazza.
(* ****** ****** *)


implement
term_eval1(t0, e0) =
(
case+ t0 of
|
TMtup(t1, t2) =>
VALtup(v1, v2) where
{
val v1 = term_eval1(t1, e0)
val v2 = term_eval1(t2, e0)
}
|
TMfst(tt) => // fst projection
(
case- vv of
|VALtup(v1, v2) => v1
) where
{
val vv = term_eval1(tt, e0) }
|
TMsnd(tt) => // snd projection
(
case- vv of
|VALtup(v1, v2) => v2
) where
{
val vv = term_eval1(tt, e0) }
//
|
TMvar(x0) =>
envir_lookup(e0, x0)
|
TMint(i0) => VALint(i0)
|
TMbtf(b0) => VALbtf(b0)
//
|TMlam _ => VALlam(t0, e0)
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
end
//
|
TMopr(nm, ts) =>
let
val vs = termlst_eval1(ts, e0)
in//let
//
case- nm of
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
| _(*unsupported*) =>
(
exit(1) ) where
{
val () = println!("term_eval1: t0 = ", t0)
}
//
end // end of [TMopr(nm, ts)]
//
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
fun
TMdiv
( t1: term
, t2: term): term =
TMopr("/", mylist_pair(t1, t2))
fun
TMmod
( t1: term
, t2: term): term =
TMopr("%", mylist_pair(t1, t2))

(* ****** ****** *)

(*
Y = λf· (λx· f (x x)) (λx· f (x x))
*)
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
Y' = λf· (λx· f (λy· x x y)) (λx· f (λy· x x y))
*)
val Y' =
let
val f = TMvar"f"
and x = TMvar"x"
and y = TMvar"y" in
TMlam("f",
TMapp(
TMlam("x",
TMapp(f, TMlam("y", TMapp(TMapp(x, x), y)))),
TMlam("x",
TMapp(f, TMlam("y", TMapp(TMapp(x, x), y)))))) end

(* ****** ****** *)

val
TMfact = TMapp(Y', FACT) where
{
val FACT =
let
val f = TMvar"f"
val x = TMvar"x" in
TMlam("f",
TMlam("x",
TMif0(
TMgte(x, TMint(1)),
TMmul(x,
TMapp(f,
TMsub(x, TMint(1)))), TMint(1)))) end
}

(* ****** ****** *)

val
TMfibo = TMapp(Y', FIBO) where
{
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
}
(***********)


extern
fun
assign03_compile(t0: term): term

extern
fun
termlst_compile
(ts:termlst): termlst

implement
assign03_compile(t0) =
case+ t0 of
| TMint(i) => Church_numeral(i)
| TMopr(nm, ts) =>
let
val vs = termlst_compile(ts)
val v1 = case- vs of
| mylist_cons(v, a) => v

val v2 = case- vs of
| mylist_cons(v, a) => (case- a of
        | mylist_cons(v1, a1) => v1)
in//let
//
case- nm of
| "+" => TMapp(TMapp(Church_add, v1), v2)
| "-" => TMapp(TMapp(sub, v1), v2)
| "*" => TMapp(TMapp(Church_mul, v1), v2)
| ">=" => TMapp(TMapp(TMgte_c, v1), v2)
(*
| "/" => TMapp(TMapp(div, v1), v2)
| "%" =>
let
        val-mylist_cons(v1, vs) = vs
        val-mylist_cons(v2, vs) = vs
        val-VALint(i1) = v1 and VALint(i2) = v2
in
        VALint(i1 % i2)
end
*)
//
| "<" => TMapp(TMnot, TMapp(TMapp(TMgte_c, v1), v2))

| ">" => assign03_compile(TMapp(TMapp(TMand, TMgte(v1, v2)), TMapp(TMnot, TMapp(is_zero, TMsub(v1, v2)))))
| "<=" => assign03_compile(
        TMapp(TMapp(TMor, TMapp(is_zero, TMsub(v1, v2))), TMlt(v1, v2))
        )
end // end of [TMopr(nm, ts)]
| TMlam(a, b) => TMlam(a, assign03_compile(b))
| TMvar(a) => TMvar(a)
| TMapp(a, b) => TMapp(assign03_compile(a), assign03_compile(b))
| TMbtf(a) => if a then TMlam("a", TMlam("b", TMvar"a")) else TMlam("a", TMlam("b", TMvar"b"))
| TMif0(t1, t2, t3) =>
        let
//            val () = println!("Match occoured for ", t0)
            val t1_c = assign03_compile(t1)
            val t2_c = assign03_compile(t2)
            val t3_c = assign03_compile(t3)
            val delayed_then = TMlam("aNameNotUsedToPreventShadowing", t2_c)
            val delayed_else = TMlam("aNameNotUsedToPreventShadowing", t3_c)
        in
            TMapp(TMapp(TMapp(t1_c, delayed_then), delayed_else), Church_numeral(0))
        end
| TMtup(a, b) =>
        let
            val a_c = assign03_compile(a)
            val b_c = assign03_compile(b)
        in
            TMapp(TMapp(TMpair, a_c), b_c)
        end
| TMfst(a) => TMapp(a, T)
| TMsnd(a) => TMapp(a, F)
//| _ => _


implement
termlst_compile(ts) =
(
case+ ts of
|
mylist_nil() => mylist_nil()
|
mylist_cons(t1, ts) =>
mylist_cons
(assign03_compile(t1), termlst_compile(ts))
)

(* ****** ****** *)

(*
HX-2023-10-04:
Some testing code will be given later.
*)

(* ****** ****** *)
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
(* ****** ****** *)
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
(* ****** ****** *)

(*
Y' = λf·
(λx· f (λy· x x y)) (λx· f (λy· x x y))
*)
val Y' =
let
val f = TMvar"f"
and x = TMvar"x"
and y = TMvar"y" in
TMlam("f",
TMapp(
TMlam("x",
TMapp(f,
TMlam("y", TMapp(TMapp(x, x), y)))),
TMlam("x",
TMapp(f,
TMlam("y", TMapp(TMapp(x, x), y)))))) end

(* ****** ****** *)

val
TMfact = TMapp(Y', FACT) where
{
val FACT =
let
val f = TMvar"f"
val x = TMvar"x" in
TMlam("f",
TMlam("x",
TMif0(
TMgte(x, TMint(1)),
TMmul(x,
TMapp(f,
TMsub(x, TMint(1)))), TMint(1)))) end
}

(* ****** ****** *)

val
TMfibo = TMapp(Y', FIBO) where
{
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
}

(* ****** ****** *)
fun
assign03_compile_test1
  ( (*void*) ) =
let
val
Church_fact5 =
assign03_compile
(TMapp(TMfact, TMint(5))) in
println!("assign03_compile_test1:");
println!("Church_fact5 = ", Church_fact5);
println!("Church_fact5 = ", Church_num2int(Church_fact5))
end

(* ****** ****** *)


fun
assign03_compile_test2
  ( (*void*) ) =
let
val
Church_fibo5 =
assign03_compile
(TMapp(TMfibo, TMint(5))) in
println!("assign03_compile_test2:");
println!("Church_fibo5 = ", Church_num2int(Church_fibo5)) end

(***************)
fun
assign03_compile_test3
  ( (*void*) ) =
let
val
Church_fibo7 =
assign03_compile
(TMapp(TMfibo, TMint(7))) in
println!("assign03_compile_test3:");
println!("Church_fibo7 = ", Church_num2int(Church_fibo7)) end
(* ****** ****** *)

val addition_practice = TMadd(TMint(5), TMint(6))
val compiled_addition_practice = assign03_compile(addition_practice)
val () = println!(addition_practice)
val () = println!(compiled_addition_practice)
val () = println!("reference 5 + 6 = ", term_eval0(addition_practice))
val () = println!("compiled 5 + 6 = ", Church_num2int(compiled_addition_practice))
val () = println!("******************")

(************)

val subtraction_practice = TMsub(TMint(3), TMint(2))
val compiled_subtraction_practice = assign03_compile(subtraction_practice)
val () = println!(subtraction_practice)
val () = println!(compiled_subtraction_practice)
val () = println!("reference 3 - 2 = ", term_eval0(subtraction_practice))
val () = println!("compiled 3 - 2 = ", Church_num2int(compiled_subtraction_practice))
val () = println!("******************")

(************)

val mul_practice = TMmul(TMint(8), TMint(2))
val compiled_mul_practice = assign03_compile(mul_practice)
val () = println!(mul_practice)
val () = println!(compiled_mul_practice)
val () = println!("reference 8 * 2 = ", term_eval0(mul_practice))
val () = println!("compiled 8 * 2 = ", Church_num2int(compiled_mul_practice))
val () = println!("******************")

(************)

val gte_practice = TMgte(TMint(8), TMint(2))
val compiled_gte_practice = assign03_compile(gte_practice)
val () = println!(gte_practice)
val () = println!(compiled_gte_practice)
val () = println!("reference 8 >= 2 = ", term_eval0(gte_practice))
val () = println!("compiled 8 >= 2 = ", term_eval0(compiled_gte_practice))
val () = println!("******************")

val gte_practice2 = TMgte(TMint(2), TMint(5))
val compiled_gte_practice2 = assign03_compile(gte_practice2)
val () = println!(gte_practice2)
val () = println!(compiled_gte_practice2)
val () = println!("reference 2 >= 5 = ", term_eval0(gte_practice2))
val () = println!("compiled 2 >= 5 = ", term_eval0(compiled_gte_practice2))

(************)

val lt_practice = TMlt(TMint(8), TMint(2))
val compiled_lt_practice = assign03_compile(lt_practice)
val () = println!(lt_practice)
val () = println!(compiled_lt_practice)
val () = println!("reference 8 < 2 = ", term_eval0(lt_practice))
val () = println!("compiled 8 < 2 = ", term_eval0(compiled_lt_practice))
val () = println!("******************")

val lt_practice2 = TMlt(TMint(2), TMint(8))
val compiled_lt_practice2 = assign03_compile(lt_practice2)
val () = println!(lt_practice2)
val () = println!(compiled_lt_practice2)
val () = println!("reference 8 < 2 = ", term_eval0(lt_practice2))
val () = println!("compiled 8 < 2 = ", term_eval0(compiled_lt_practice2))
val () = println!("******************")

(***************)

val infinite_loop = TMapp(Y, Y)

//val crash = term_eval0(infinite_loop) // crash
val test_is0_eval_only_true = TMif0(TMbtf(false), infinite_loop, TMint(0))
val no_crash = term_eval0(test_is0_eval_only_true)
val () = println!("No crash evaluated false branch, gave us 0? ", no_crash)

val test_is0_eval_only_true_compile = assign03_compile(test_is0_eval_only_true)
val no_crash_compile = Church_num2int(test_is0_eval_only_true_compile)
val () = println!("No crash evaluated false branch, gave us 0? ", no_crash_compile)
val () = println!("******************")
(***************)
val () = assign03_compile_test1()
val () = assign03_compile_test2()
val () = assign03_compile_test3()

val () = println!("******************")
val pair_3_4 = TMtup(TMint(3), TMint(4))
val first_from_3_4 = TMfst(pair_3_4)


        (* end of [CS525-2023-Fall/assigns/assign03.dats] *)
