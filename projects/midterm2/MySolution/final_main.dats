#include "./header.dats"


#include "share/atspre_staload.hats"

staload "libats/ML/SATS/list0.sats"

(*

We will start by compiling this simple lambda function:

*)

//val () = $STDLIB.srand48 ($UN.cast {lint} ($TIME.time_get ()))
// instead keep seed constant, so that we can compare the output
val () = $STDLIB.srand48 ($UN.cast {lint} 12345)

//val TMisFiveOrBigger = TMlam("x", TMopr(">=", mylist_pair(TMvar"x", TMint(5))))

//val TMisFiveOrBiggerApplied = TMapp(TMisFiveOrBigger, TMint(15))
//
//val () =
//println!("id(15) = ", term_eval0(TMapp(TMisFiveOrBigger, TMint(15))))
//
//val out = term_compile(TMisFiveOrBiggerApplied)
//
//val () = println!(out)

// This requires closure conversion!

//val TMxPlusY = TMlam("x", TMlam("y", TMadd(TMvar"x", TMvar"y")))
//val TMxPlusYApplied = TMapp(TMapp(TMxPlusY, TMint(5)), TMint(10))
//
//val out = term_compile(TMxPlusYApplied)
//val () = println!(out)



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

//val
//TMfibo =
//let
//val f = TMvar"f"
//val x = TMvar"x" in
//TMfix("f", "x",
//TMif0(
//TMgte(x, TMint(2)),
//TMadd(
//TMapp(f, TMsub(x, TMint(2))),
//TMapp(f, TMsub(x, TMint(1)))
// )
//, x)) end
//
//val TMfibo10 = TMapp(TMfibo, TMint(10))

//val () = println!("fibo(10) = ", term_eval0(TMfibo10))

  //
//val out = term_compile(TMfibo10)
//
//val () = println!(out)

//val TM10IfIsFiveOrBigger = TMlam("x",
//                               TMif0(TMopr(">=", mylist_pair(TMvar"x", TMint(5))),
//                                     TMint(10), TMint(0)))
//
//val TM10IfIsFiveOrBiggerApplied = TMapp(TM10IfIsFiveOrBigger, TMint(15))
//
//val out = term_compile(TM10IfIsFiveOrBiggerApplied)

// simplest possible recursive function
// start at 3, and count down to 0
//val TMcountDown = TMfix("fix", "x",
//                        TMif0(TMgte(TMvar"x", TMint(0)),
//                              TMapp(TMvar"fix", TMsub(TMvar"x", TMint(1))),
//                              TMint(0)))
//
//val out = term_compile(TMapp(TMcountDown, TMint(3)))
//
//val () = println!(out)


(* ****** ******

fun
kfact(nk) =
let
  val n = fst(nk)
val k = snd(nk)
in//let
if n > 0
then
kfact(n-1, lam(r) => k(n * r))
else k(1)
end (*let*) // end of [kfact(nk)]

****** ****** *)

// lambda calculus implementation of exact same function
val TMkfact = TMfix(
                    "kfact", "nk",
                    TMlet("n", TMfst(TMvar"nk"),
                          TMlet("k", TMsnd(TMvar"nk"),
                                TMif0(TMgt(TMvar"n", TMint(0)),
                                      TMapp(TMvar"kfact", TMtup(TMsub(TMvar"n", TMint(1)), TMlam("r", TMapp(TMvar"k", TMmul(TMvar"n", TMvar"r"))))),
                                      TMapp(TMvar"k", TMint(1))
                                      )
                                )
                          )
                    )

//val () = println!("kfact(5) = ", term_eval0(TMapp(TMkfact, TMtup(TMint(5), TMlam("x", TMvar"x")))))

//val out = term_compile(TMapp(TMkfact, TMtup(TMint(5), TMlam("x", TMvar"x"))))
//val () = println!(out)

//val
//closureTest =
//TMapp(
//    TMlam("x", TMlam("y", TMadd(TMvar"x", TMvar"y"))),
//    TMint(10)
//)
//val out = term_compile(closureTest)
//val () = println!(out)
