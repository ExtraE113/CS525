#include "./header.dats"

val () =
try
let
val
TPomega =
term_type0
(TMlam("x", TMapp(TMvar"x", TMvar"x")))
in//let
println!
("TPomega = ", TPomega)
end // end-of-let
with ~TypeError() => println!("TPomega: type error!") (* this is correct, Omega cannot be typed *)

(* ****** ****** *)

val () =
try
let
val
TPfact =
term_type0(TMfact)
in
println!("TPfact = ", TPfact);
let
val VALfact_10 =
term_eval0
(TMapp(TMfact, TMint(10))) in
println!("VALfact_10 = ", VALfact_10) end
end with ~TypeError() => println!("TPfact: type error!")

(* ****** ****** *)

val () =
try
let
val
TPfibo =
term_type0(TMfibo)
in
println!
("TPfibo = ", TPfibo);
let
val VALfibo_10 =
term_eval0
(TMapp(TMfibo, TMint(10))) in
println!("VALfibo_10 = ", VALfibo_10) end
end with ~TypeError() => println!("TPfibo: type error!")

(* ****** ****** *)
//
val () =
try
let
val
TPfact2 =
term_type0(TMfact2)
in
//
println!("TPfact2 = ", TPfact2);
//
let
val VALfact2_10 =
term_eval0
(TMapp(TMfact2, TMint(10))) in
println!("VALfact2_10 = ", VALfact2_10) end
//
end with ~TypeError() => println!("TPfact2: type error!")
//
(* ****** ****** *)
//
val () =
try
let
val
TPint_forall =
term_type0(TMint_forall)
in//let
println!
("TPint_forall = ", TPint_forall)
end // end-of-let
with ~TypeError() => println!("TPint_forall: type error!")
//
(* ****** ****** *)
//
val () =
try
let
val
TPstr_forall =
term_type0(TMstr_forall)
in//let
println!
("TPstr_forall = ", TPstr_forall)
end // end-of-let
with ~TypeError() => println!("TPstr_forall: type error!")
//
(* ****** ****** *)
//
val () =
try
let
val
TPforall_foreach =
term_type0(TMforall_foreach)
in//let
println!
("TPforall_foreach = ", TPforall_foreach)
end // end-of-let
with ~TypeError() => println!("TPforall_foreach: type error!")
//
(* ****** ****** *)
//
val () =
try
let
val
TPint_foreach =
term_type0(TMint_foreach)
in//let
println!
("TPint_foreach = ", TPint_foreach)
end // end-of-let
with ~TypeError() => println!("TPint_foreach: type error!")
//
(* ****** ****** *)
//
val () =
try
let
val
TPstr_foreach =
term_type0(TMstr_foreach)
in//let
println!
("TPstr_foreach = ", TPstr_foreach)
end // end-of-let
with ~TypeError() => println!("TPstr_foreach: type error!")
//
(* ****** ****** *)

val-
VALnil() =
term_eval0
(
TMapp(
TMapp(
TMstr_foreach,
TMstr"Hello, world!\n"), TMlam("c", TMprchr(TMvar"c"))))

(* ****** ****** *)

val TMisprime =
let
val i0 = TMvar"i0"
val n0 = TMvar"n0" in
TMlam("n0",
TMapp(
TMapp(
TMint_forall,
TMsub(n0, TMint(2))),
TMlam("i0", TMgt(TMmod(n0, TMadd(i0, TMint(2))), TMint(0)))))
end

(* ****** ****** *)

val () =
println!("isprime(727) = ", term_eval0(TMapp(TMisprime, TMint(727))))

(* ****** ****** *)



val
TMstream_map =
let
val input_stream = TMvar"input_stream"
val input_stream_evaluated = TMvar"input_stream_evaluated"
val aux = TMvar"aux"
val transformer = TMvar"transformer" in
TMfix(
    "aux", (* function name *)
    "input_stream", (* argument name *)
    TMlam("transformer",
        TMlazy(
            TMlet("input_stream_evaluated", TMeval(input_stream),      (*  let input_stream_evaluated = TMeval(input_stream) in     *)
                TMif0(TMllist_empty(input_stream_evaluated),           (*  if input_stream_evaluated is an empty lazy list          *)
                    TMllist_nil(),                                     (*  then return an empty lazy list                           *)
                    (* else, *)
                    TMllist_cons(                                       (*  return a cons of `transformer(head(input_stream_evaluated))`
                                                                            and the recursive application of aux to tail(input_stream_evaluated)
                                                                                                                                    *)
                            TMapp(transformer, TMllist_head(input_stream_evaluated)),
                            TMapp(TMapp(aux, TMllist_tail(input_stream_evaluated)), transformer)  (*  recursive application of aux  *)
                    )
                )
            )
        )
    )
)
end//let//end-of-[TMstream_map]



val error_section_stream_map =
let
val input_stream = TMvar"input_stream"
val input_stream_evaluated = TMvar"input_stream_evaluated"
val aux = TMvar"aux"
val transformer = TMvar"transformer" in
TMfix(
    "aux", (* function name *)
    "input_stream", (* argument name *)
    TMlam("transformer",
        TMlazy(
            TMlet("input_stream_evaluated", TMeval(input_stream),      (*  let input_stream_evaluated = TMeval(input_stream) in     *)
                                TMapp(aux, TMllist_tail(input_stream_evaluated))
            )
        )
    )
)
end


val () = println!("Type checking TMstream_map")
val stream_map_type = term_type0(TMstream_map)

val () = println!("Type of TMstream_map is ", type_norm(stream_map_type))

val () = println!("should be 5?: ", term_eval0(
                    TMapp(
                        TMlam("x", TMref_get(TMvar("x"))),
                        TMref_new(TMint(5))
                        )
            ))

val should_be_int1 = term_type0(
        TMapp(
                TMlam("x", TMref_get(TMvar("x"))),
                TMref_new(TMint(5))
            )
)

val () = println!("should be int pt. 1 ", type_norm(should_be_int1))

val should_be_int = term_type0(
    TMapp(
            TMlam("x",
                  TMlet("_",
                        TMopr("ref_set", mylist_pair(TMvar("x"), TMint(3))),
                        TMopr("ref_get", mylist_sing(TMvar("x")))
                  )
            ),
            TMopr("ref_new", mylist_sing(TMint(5)))
    )
)

val () = println!("Should be int... ", type_norm(should_be_int))

(* end of [CS525-2022-Fall/projects/midterm/Solution/midterm_main.dats] *)
