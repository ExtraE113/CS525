(* ****** ****** *)
(*
Due: Wednesday, the 27th of September
*)
(* ****** ****** *)
(*
HX-2023-09-20:
This assignment asks you to implement
list-based set oprations.
*)
(* ****** ****** *)
#include "share/atspre_staload.hats"
(* ****** ****** *)
#staload "./../../../mylib/mylib.dats"
(* ****** ****** *)
#include"./../../../lectures/lecture-09-20/lambda0.dats"
(* ****** ****** *)
implement main() = 0 // HX: this is a dummy
        (* ****** ****** *)
//
typedef
tvarset = mylist(tvar)
//
        (*
                 HX:
A tvarset is an *ordered* list of tvars
        (that is, strings)
*)
(* ****** ****** *)
//
extern
fun FV(t0: term): tvarset
//
(* ****** ****** *)
// 1 point
extern
fun // empty set
tvarset_nil(): tvarset

implement tvarset_nil() =
(
        mylist_nil()
        )

// 1 point
extern
        fun // singleton set
tvarset_sing(v0: tvar): tvarset

implement tvarset_sing(v0) =
        (
                mylist_cons(v0, tvarset_nil())
                )

// 10 points
extern
        fun // delete an element from a set
tvarset_del1(tvarset, tvar): tvarset

implement tvarset_del1(l, v) =
(
case+ l of
| mylist_nil() => l
| mylist_cons(v1, l1) => (if v1 = v then l1 else mylist_cons(v1, tvarset_del1(l1, v)))
        )
// 10 points
extern
        fun // form the union of two given sets
tvarset_union(tvarset, tvarset): tvarset

fun tvarset_insert(l: tvarset, v: tvar): tvarset = (
case+ l of
| mylist_nil() => mylist_cons(v, l)
| mylist_cons(v1, l1) => (
        if v1 = v then l
        else mylist_cons(v1, tvarset_insert(l1, v))
        )
)

implement tvarset_union(a, b) =
case+ b of
| mylist_nil() => a
| mylist_cons(v, b1) => tvarset_union(tvarset_insert(a, v), b1)

(* ****** ****** *)
//
implement FV(t0) =
(
case t0 of
|
TMint _ => tvarset_nil()
|
TMvar(x0) => tvarset_sing(x0)
|
TMlam(x0, t1) => tvarset_del1(FV(t1), x0)
|
TMapp(t1, t2) => tvarset_union(FV(t1), FV(t2))
)
//
(* ****** ****** *)
//
fun
        lam_body
        (t0: term): term =
case t0 of
| TMlam(_, t1) => lam_body(t1) | _ => t0
//
(* ****** ****** *)

val omega = TMlam("x", TMapp(x, x))

        (* ****** ****** *)
//val () =
//println!("tvar_insert on empty = ", tvarset_insert(mylist_nil(), "x")) // x
//val () =
//println!("tvar_insert dupes = ", tvarset_insert(mylist_cons("x", mylist_nil()), "x")) // x
//val () =
//println!("tvar_insert no dupes = ", tvarset_insert(mylist_cons("y", mylist_nil()), "x")) // y, x
//val () =
//println!("tvar_insert mix dupes = ", tvarset_insert(mylist_cons("a", mylist_cons("x", mylist_cons("y", mylist_nil()))), "x")) // a, x, y
val () =
println!("FV(body(K)) = ", FV(lam_body(K))) // x
val () =
println!("FV(body(S)) = ", FV(lam_body(S))) // x, y, z
val () =
println!("FV(body(K')) = ", FV(lam_body(K'))) // y
val () =
println!("FV(SKK) = ", FV(TMapp(TMapp(S, K), K))) // empty

(* ****** ****** *)

val () =
println!("FV(body(omega)) = ", FV(lam_body(omega))) // x

(* ****** ****** *)

(* end of [CS525-2023-Fall/assigns/assign01.dats] *)
