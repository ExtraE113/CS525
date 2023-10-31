(* ****** ****** *)
(*
CS525-2023-Fall: midterm
*)
(* ****** ****** *)
#include
"share/atspre_staload.hats"
(* ****** ****** *)
//
#staload "./../midterm.sats"//opened
//
(* ****** ****** *)
#staload "./../../../mylib/mylib.dats"
(* ****** ****** *)
exception TypeError of ()
(* ****** ****** *)
val TPnil = TPbas("nil")
val TPint = TPbas("int")
val TPbtf = TPbas("bool")
val TPchr = TPbas("char")
val TPstr = TPbas("string")
(* ****** ****** *)
implement
tpxyz_new() =
TPxyz(ref(myoptn_nil()))
(* ****** ****** *)
//
implement
type_norm(T0) =
(
case+ T0 of
|
TPxyz(r1) =>
(
case+ !r1 of
|
myoptn_cons
(    T1    ) =>
type_norm(T1) // chasing
|
_(*unsolved*) => (  T0  ))
|
_(* non-TPxyz *) => ( T0 ))
//
(* ****** ****** *)

implement
txyz_solve(r1, T2) =
let
//
fun
occurs(T0: type): bool =
(
case+ T0 of
|
TPbas _ => false
|
TPxyz(r2) => (r1 = r2)
//
|
TPref(T1) => occurs(T1)
//
|
TPlist(T1) => occurs(T1)
|
TPllist(T1) => occurs(T1)
//
|
TPfun(T1, T2) =>
occurs(T1) || occurs(T2)
|
TPtup(T1, T2) =>
occurs(T1) || occurs(T2)
//
) where
{
  val T0 = type_norm(T0) }
//
in//let
  if
  occurs(T2)
  then false else
  (!r1 := myoptn_cons(T2); true)
end // end of [txyz_solve(r1, T2)]

(* ****** ****** *)

#symload
unify with type_unify

(* ****** ****** *)
//
implement
type_unify
( T1, T2 ) =
let
//
val T1 = type_norm(T1)
val T2 = type_norm(T2)
//
in
  f0_helper1(T1, T2) end
where
{
//
fun
f0_helper1
( T1: type
, T2: type): bool =
(
case+ T1 of
|
TPxyz(r1) =>
(
case+ T2 of
|
TPxyz(r2) =>
if
(r1 = r2)
then true else txyz_solve(r1, T2)
|
_(*non-TPxyz*) => txyz_solve(r1, T2))
|
_(*non-TPxyz*) =>
(
case+ T2 of
| TPxyz(r2) => txyz_solve(r2, T1)
| _(*non-TPxyz*) => f0_helper2(T1, T2))
)
//
and
f0_helper2
( T1: type
, T2: type): bool =
(
case+ T1 of
|
TPbas(nm1) =>
(case+ T2 of
//
|
TPbas(nm2) =>
(nm1 = nm2) | _ => false)
//
|
TPxyz( _ ) =>
exit(1) where
{
val () =
println!
("type_unify: f0_helper2: T1 = ", T1) }
//
|
TPref(T10) =>
(
case+ T2 of
|
TPref(T20) =>
unify(T10, T20) | _(*non-TPref*) => false)
//
|
TPlist(T10) =>
(
case+ T2 of
|
TPlist(T20) =>
unify(T10, T20) | _(*non-TPlist*) => false)
|
TPllist(T10) =>
(
case+ T2 of
|
TPllist(T20) =>
unify(T10, T20) | _(*non-TPllist*) => false)
//
|
TPfun(T11, T12) =>
(case+ T2 of
|
TPfun(T21, T22) =>
(unify(T11, T21)
 &&
 unify(T12, T22)) | _(*non-TPtup*) => false)
//
|
TPtup(T11, T12) =>
(case+ T2 of
|
TPtup(T21, T22) =>
(unify(T11, T21)
 &&
 unify(T12, T22)) | _(*non-TPtup*) => false)
//
)
} (*where*) // end of [ type_unify(T1, T2) ]
//
(* ****** ****** *)

implement
term_type0
 (  t0  ) =
term_type1
(t0, mylist_nil(*void*))

(* ****** ****** *)
//
fun
type_funize
(T0: type): void =
(
case+ T0 of
//
|
TPxyz(r1) =>
let
val T1 = tpxyz_new()
val T2 = tpxyz_new()
in
!r1 :=
myoptn_cons(TPfun(T1, T2))
end
//
| TPfun _ => ()
| _(*else*) =>
  $raise TypeError()
) where
{
  val T0 = type_norm(T0) }
//
(* ****** ****** *)
//
fun
type_tupize
(T0: type): void =
(
case+ T0 of
//
|
TPxyz(r1) =>
let
val T1 = tpxyz_new()
val T2 = tpxyz_new()
in
!r1 :=
myoptn_cons(TPtup(T1, T2))
end
//
| TPtup _ => ()
| _(*else*) =>
  $raise TypeError()
) where
{
  val T0 = type_norm(T0) }
//
(* ****** ****** *)

implement
term_type1
 (t0, c0) =
(
case+ t0 of
//
|
TMnil() => TPnil(*val*)
//
|
TMint(i0) => TPint(*val*)
|
TMbtf(b0) => TPbtf(*val*)
|
TMchr(c0) => TPchr(*val*)
|
TMstr(s0) => TPstr(*val*)
//
|
TMvar(x0) =>
(
  tpctx_lookup(c0, x0))
//
|
TMlam(x0, tt) =>
let
val Tx = tpxyz_new()
val c1 =
mylist_cons((x0, Tx), c0)
in//let
  TPfun(Tx, Tt) where
{
  val Tt = term_type1(tt, c1)
}
end//end-of-[TMlam(x0,Tx,tt)]
//
|
TMapp(t1, t2) =>
(
  T12 ) where
{
val T1 =
term_type1(t1, c0)
//
val () =
type_funize(T1)
val T1 = type_norm(T1)
//
val-
TPfun(T11, T12) = T1
//val () = println!("T11 is ", T11)
//val () = println!("T12 is ", T12)
//val () = println!("t2 is ", t2)
//val () = println!("type of t2 is ", term_type1(t2, c0))
val () =
term_type1_ck(t2, T11, c0, "Error while typechecking TMapp. Code 308")
//val () = println!("type check 308 passed")
}
//
|
TMopr(nm, ts) =>
(
case+ nm of
//
| ">" => TPbtf where
{
val-
mylist_cons(t1, ts) = ts
val-
mylist_cons(t2, ts) = ts
val () =
term_type1_ck(t1, TPint, c0, "Error while type checking >, t1 is not int. Code 323")
val () =
term_type1_ck(t2, TPint, c0, "Error while type checking >, t2 is not int. Code 325") }
//
| "<" => TPbtf where
{
val-
mylist_cons(t1, ts) = ts
val-
mylist_cons(t2, ts) = ts
val () =
term_type1_ck(t1, TPint, c0, "Error while type checking <, t1 is not int. Code 334")
val () =
term_type1_ck(t2, TPint, c0, "Error while type checking <, t2 is not int. Code 336") }
//
| ">=" => TPbtf where
{
val-
mylist_cons(t1, ts) = ts
val-
mylist_cons(t2, ts) = ts
val () =
term_type1_ck(t1, TPint, c0, "Error while type checking >=, t1 is not int. Code 345")
val () =
term_type1_ck(t2, TPint, c0, "Error while type checking >-, t2 is not int. Code 347") }
//
| "<=" => TPbtf where
{
val-
mylist_cons(t1, ts) = ts
val-
mylist_cons(t2, ts) = ts
val () =
term_type1_ck(t1, TPint, c0, "Error while type checking <=, t1 is not int. Code 356")
val () =
term_type1_ck(t2, TPint, c0, "Error while type checking <=, t2 is not int. Code 358") }
//
| "+" => TPint where
{
val-
mylist_cons(t1, ts) = ts
val-
mylist_cons(t2, ts) = ts
val () =
term_type1_ck(t1, TPint, c0, "Error while type checking +, t1 is not int. Code 367")
val () =
term_type1_ck(t2, TPint, c0, "Error while type checking +, t2 is not int. Code 369") }
//
| "-" => TPint where
{
val-
mylist_cons(t1, ts) = ts
val-
mylist_cons(t2, ts) = ts
val () =
term_type1_ck(t1, TPint, c0, "Error while type checking -, t1 is not int. Code 378")
val () =
term_type1_ck(t2, TPint, c0, "Error while type checking -, t2 is not int. Code 380") }
//
| "*" => TPint where
{
val-
mylist_cons(t1, ts) = ts
val-
mylist_cons(t2, ts) = ts
val () =
term_type1_ck(t1, TPint, c0, "Error while type checking *, t1 is not int. Code 389")
val () =
term_type1_ck(t2, TPint, c0, "Error while type checking *, t2 is not int. Code 391") }
//
| "/" => TPint where
{
val-
mylist_cons(t1, ts) = ts
val-
mylist_cons(t2, ts) = ts
val () =
term_type1_ck(t1, TPint, c0, "Error while type checking /, t1 is not int. Code 400")
val () =
term_type1_ck(t2, TPint, c0, "Error while type checking /, t2 is not int. Code 402") }
//
| "%" => TPint where
{
val-
mylist_cons(t1, ts) = ts
val-
mylist_cons(t2, ts) = ts
val () =
term_type1_ck(t1, TPint, c0, "Error while type checking %, t1 is not int. Code 411")
val () =
term_type1_ck(t2, TPint, c0, "Error while type checking %, t2 is not int. Code 413") }
//
(* ****** ****** *)
//
|
"str_len" => TPint where
{
val-
mylist_cons(t1, ts) = ts
val () =
term_type1_ck(t1, TPstr, c0, "Error while type checking str_len, t1 is not str. Code 423") }
//
|
"str_get_at" => TPchr where
{
val-
mylist_cons(t1, ts) = ts
val-
mylist_cons(t2, ts) = ts
val () =
term_type1_ck(t1, TPstr, c0, "Error while type checking str_get_at, t1 is not str. Code 433")
val () =
term_type1_ck(t2, TPint, c0, "Error while type checking str_get_at, t2 is not int. Code 435") }
| "print" => TPnil where {
val-
mylist_cons(t1, ts) = ts
val () =
term_type1_ck(t1, TPint, c0, "Error while type checking print, t1 is not int. Code 440")
}
| "prchr" => TPnil where {
val-
mylist_cons(t1, ts) = ts
val () =
term_type1_ck(t1, TPchr, c0, "Error while type checking prchr, t1 is not str. Code 446")
}
| "prstr" => TPnil where {
val-
mylist_cons(t1, ts) = ts
val () =
term_type1_ck(t1, TPstr, c0, "Error while type checking prstr, t1 is not str. Code 452")
}
| "ref_get" => referenced_type where {
val-
mylist_cons(t1, ts) = ts
val referenced_type = tpxyz_new()
val () = term_type1_ck(t1, TPref(referenced_type), c0, "Error while typechecking ref_get, t1 not a reference. Code 464")
}
| "ref_set" => TPnil where {
val-
mylist_cons(t1, ts) = ts
val-
mylist_cons(t2, ts) = ts
val inp_type = term_type1(t2, c0)
(* check that the first argument (the reference) is of type TPref(imp_type) where imp type is the type of the second argument*)
val () = term_type1_ck(t1, TPref(inp_type), c0, "Error type checking ref_set, t1 is not TPref(inp_type). Code 468")
}
| "ref_new" => TPref(arg_type) where {
val-
mylist_cons(t1, ts) = ts
val arg_type = term_type1(t1, c0)
}
| "list_new" => TPlist(tpxyz_new())
| "list_cons" => TPlist(T1) where {
val-mylist_cons(t1, ts) = ts
val-mylist_cons(t2, ts) = ts
val T1 = term_type1(t1, c0)
val () = term_type1_ck(t2, TPlist(T1), c0, "Error type checking list_cons. t2 is not of type TPlist(T1). Code 480")
}
| "list_nilq" => TPbtf where {
val-mylist_cons(t1, ts) = ts
val-TPlist(_) = term_type1(t1, c0) (* checks that t1 is a list of some type*)
}
| "list_consq" => TPbtf where {
val-mylist_cons(t1, ts) = ts
val-TPlist(_) = term_type1(t1, c0) (* checks that t1 is a list of some type*)
}
| "list_uncons1" => t where {
val-mylist_cons(t1, ts) = ts
val-TPlist(t) = term_type1(t1, c0)
}
| "list_uncons2" => t where {
val-mylist_cons(t1, ts) = ts
val t = term_type1(t1, c0)
}
| "llist_new" => TPllist(tpxyz_new())
| "llist_cons" => TPllist(T1) where {
val-mylist_cons(t1, ts) = ts
val-mylist_cons(t2, ts) = ts
val T1 = term_type1(t1, c0)
val () = term_type1_ck(t2, TPllist(T1), c0,
                       "Error while typechecking llist_cons, t2 is not of type TPllist(T1). Code 504")
}
| "llist_nilq" => TPbtf where {
val-mylist_cons(t1, ts) = ts
val () = term_type1_ck(t1, TPllist(tpxyz_new()), c0,
"Error while typechecking llist_nilq, t1 is not of type TPllist(tpxyz_new()). Code 509")
}
| "list_consq" => TPbtf where {
val-mylist_cons(t1, ts) = ts
val-TPllist(_) = term_type1(t1, c0) (* checks that t1 is a list of some type*)
}
| "llist_uncons1" => T1 where {
val-mylist_cons(t1, ts) = ts
val T1 = tpxyz_new()
val () = term_type1_ck(t1, TPllist(T1), c0,
                       "Error while type checking llist_uncons1, t1 is not TPllist(tpxyz_new()). Code 515")
}
| "llist_uncons2" => T1 where {
val-mylist_cons(t1, ts) = ts
val element_type = tpxyz_new()
val () = term_type1_ck(t1, TPllist(element_type), c0,
"Error while type checking llist_uncons2, t1 is not TPllist(tpxyz_new()). Code 529")
val T = term_type1(t1, c0)
val T1 = TPfun(TPnil, T)
}
//
(* ****** ****** *)
//
| _(*unsupported*) =>
(
exit(1) ) where
{
val () =
println!("term_type1:TMopr:t0 = ", t0)
}
//
) (*case+*) // end-of-[ TMopr(nm, ts) ]
//
|
TMif0
(t1, t2, t3) =>
(
  T2 ) where
{
val () =
term_type1_ck
(t1, TPbtf, c0, "Error while type checking TMif0, t1 is not btf. Code 545")
val T2 =
term_type1(t2, c0)
val () =
term_type1_ck(t3, T2, c0, "Error while type checking TMif0, t1 is not the same type as t2. Code 549")
}
//
|TMfst(tt) =>
let
//
val TT =
term_type1(tt, c0)
//
val () =
type_tupize(TT)
val TT = type_norm(TT)
//
val-
TPtup(T1, _) = TT in T1 end
//
|TMsnd(tt) =>
let
//
val TT =
term_type1(tt, c0)
//
val () =
type_tupize(TT)
val TT = type_norm(TT)
//
val-
TPtup(_, T2) = TT in T2 end
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
TMfix
(f0, x0, tt) =>
let
//
val Tx: type = tpxyz_new()
val Ty: type = tpxyz_new()
val Tf: type = TPfun(Tx, Ty)
//
val c1 =
mylist_cons((x0, Tx), c0)
val c2 =
mylist_cons((f0, Tf), c1)
in//let
  Tf where
{
  val () = println!("tt is of type ", term_type1(tt, c2))
  val () = println!("Ty is ", Ty)
  val () = println!("c2 is ", c2)
val () =
  term_type1_ck(tt, Ty, c2, "Error while typechecking TMfix, tt not of type Ty in c2. Code 619")
}
end//end-of-[TMfix(f0,x0,tt)]
//
|
TManno(t1, T1) =>
(
term_type1_ck(t1,T1,c0, "Error checking type annotation. Code 626"); T1)
//
|
TMlamt
(x0, Tx, tt) =>
let
val c1 =
mylist_cons((x0, Tx), c0)
in//let
  TPfun(Tx, Tt) where
{
  val Tt = term_type1(tt, c1) }
end // let // end-of-[TMlamt(x0,Tx,tt)]
//
|
TMfixt
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
  term_type1_ck(tt, Ty, c2, "Error checking TMfixt. Code 654")
}
end // let // end-of-[TMfixt(x0,Tx,tt)]
//
//
) (*case+*) // end-of-[term_type1(t0, c0)]

(* ****** ****** *)

implement
tpctx_lookup
(xts, x0) =
(
case+ xts of
|
mylist_nil() => exit(1) where
{
  val () =
  println!("tpctx_lookup: x0 = ", x0)
}
|
mylist_cons(xt1, xts) =>
if x0 = xt1.0 then xt1.1 else tpctx_lookup(xts, x0)
)

(* ****** ****** *)

implement
term_type1_ck
(t0, Tt, ctx, msg) =
let
val res =
type_unify(T0, Tt)
in
if res then () else $raise TypeError() where {
    val () = println!(msg)
}
end where
{
val T0 = term_type1(t0, ctx)
(*
val () = println!("term_type1_ck: t0 = ", t0)
val () = println!("term_type1_ck: T0 = ", T0)
val () = println!("term_type1_ck: Tt = ", Tt)
*)
} (*where*) // end of [term_type1_ck(t0, Tt, ctx)]

(* ****** ****** *)

(* end of [CS525-2022-Fall/projects/midterm/Solution/midterm_tpck.dats] *)
