(* ****** ****** *)
#include
"share\
/atspre_staload.hats"
(* ****** ****** *)
#include "./mylib.dats"
(* ****** ****** *)
(*
Please enumerate all the permuations of a
given list. The enumeration is required to be
in order. For instance, say xs = [1;2;3], then
the enumeration should be of the following order
[1;2;3], [1;3;2], [2;1;3], [2;3;1], [3;1;2], [3;2;1].
*)
(* ****** ****** *)
(*
Compile and test:
myatscc list_permute_stream.dats && ./list_permute_stream_dats
*)
(* ****** ****** *)
//
fun
{x0:t@ype}
mylist_takeouts
(xs: mylist(x0)): mylist@(x0, mylist(x0)) =
(
case xs of
|
mylist_nil() =>
mylist_nil()
|
mylist_cons(x1, xs) =>
mylist_cons
(
@(x1, xs)
,
mylist_map<(x0,mylist(x0))><(x0,mylist(x0))>
( mylist_takeouts(xs)
, lam(xxs) => (xxs.0, mylist_cons(x1, xxs.1))))
)
//
(* ****** ****** *)
//
fun
{x0:t@ype}
mystream_concat_list
( xss
: mylist(mystream(x0))): mystream(x0) =
(
  auxmain(xss) ) where
{
fun
auxmain
( xss
: mylist(mystream(x0))): mystream(x0) = lam() =>
(
case+ xss of
|
mylist_nil() => myllist_nil()
|
mylist_cons(fxs, xss) => mystream_append<x0>(fxs, auxmain(xss))()) }
//
(* ****** ****** *)

fun
{x0:t@ype}
mylist_permute
(xs: mylist(x0)): mystream(mylist(x0)) = lam() =>
(
case+ xs of
|
mylist_nil() =>
myllist_sing(mylist_nil())
|
mylist_cons(_, _) =>
mystream_concat_list<mylist(x0)>
(mylist_map(mylist_takeouts(xs), lam(xxs) => mystream_map(mylist_permute(xxs.1), lam xs => mylist_cons(xxs.0, xs))))())

(* ****** ****** *)
(* ****** ****** *)
//
implement
main0() = () where
{
//
val xs0 =
foreach_to_listize
 (  int_foreach  )(10)
//
val fxss =
mylist_permute<int>(xs0)
val-
myllist_cons(xs1, fxss) = fxss()
val (  ) = println!("xs1 = ", xs1)
val-
myllist_cons(xs2, fxss) = fxss()
val (  ) = println!("xs2 = ", xs2)
val-
myllist_cons(xs3, fxss) = fxss()
val (  ) = println!("xs3 = ", xs3)
val-
myllist_cons(xs4, fxss) = fxss()
val (  ) = println!("xs4 = ", xs4)
val-
myllist_cons(xs5, fxss) = fxss()
val (  ) = println!("xs5 = ", xs5)
val-
myllist_cons(xs6, fxss) = fxss()
val (  ) = println!("xs6 = ", xs6) }
//
(* ****** ****** *)
(* ****** ****** *)

(* end of [CS525-2022-Fall/exams/midterm/list_permuate_stream.dats] *)
