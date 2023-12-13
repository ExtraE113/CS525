#include "./header.dats"


#include "share/atspre_staload.hats"

staload "libats/ML/SATS/list0.sats"

(*

We will start by compiling this simple lambda function:

*)

val () = $STDLIB.srand48 ($UN.cast {lint} ($TIME.time_get ()))

//val TMisFiveOrBigger = TMlam("x", TMopr(">=", mylist_pair(TMvar"x", TMint(5))))
//
//val () =
//println!("id(15) = ", term_eval0(TMapp(TMisFiveOrBigger, TMint(15))))
//
//val out = term_compile(TMisFiveOrBigger)
//
//val () = println!(out)
//
//
//
//val TMinc = TMfix("fix", "x", TMadd(TMvar"x", TMint(1)))
//val TMsix = TMapp(TMinc, TMint(5))
//
//val () =
//println!("TMsix = ", term_eval0(TMsix))
//
//val out = term_compile(TMsix)
//
//val () = println!(out)

val
TMfibo =
let
val f = TMvar"f"
val x = TMvar"x" in
TMfix("f", "x",
TMif0(
TMgte(x, TMint(2)),
TMadd(
TMapp(f, TMsub(x, TMint(2))),
TMapp(f, TMsub(x, TMint(1)))
 )
, x)) end

val out = term_compile(TMfibo)

val () = println!(out)

//val TM10IfIsFiveOrBigger = TMlam("x",
//                               TMif0(TMopr(">=", mylist_pair(TMvar"x", TMint(5))),
//                                     TMint(10), TMint(0)))
//
//val out = term_compile(TM10IfIsFiveOrBigger)
//
//val () = println!(out)
