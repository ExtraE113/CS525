(* ****** ****** *)
(*
CS525-2023-Fall: midterm
*)
(* ****** ****** *)
#include "share/atspre_staload.hats"

(* ****** ****** *)
//
#staload "./../midterm.sats" //opened
//
(* ****** ****** *)
#staload "./../../../mylib/mylib.dats"
//
(* ****** ****** *)
#include "../MySolution/header.dats"


// first things first, a get_at function for lists.
fun
TMget_at(t: term, i: term) : term =
TMapp(TMapp(TMget_at_raw, t), i) where {
val TMget_at_raw =
let
val element_type = tpxyz_new()
val input = TManno(TMvar"input", TPlist(element_type))
val index = TManno(TMvar"index", TPint)
in
TMfix(
        "cont",
        "input",
        TMlam(
                "index",
                TMif0(
                        TMeq(index, TMint(0)),
                        TMlist_head(input),
                        TMapp(TMapp(TMvar"cont", TMlist_tail(input)), TMsub(index, TMint(1)))
                      )
                )
        )
end
}
val board = TMlist_cons(TMint(0), TMlist_cons(TMint(2), TMlist_cons(TMint(4), TMlist_cons(TMint(6), TMlist_cons(TMint(1), TMlist_cons(TMint(3), TMlist_cons(TMint(5), TMlist_cons(TMint(7), TMlist_nil()))))))))

//val () = println!("get at 0 ", term_eval0(TMget_at(board, TMint(0))))
//
//val () = println!("get at 1 ", term_eval0(TMget_at(board, TMint(1))))
//
//val () = println!("get at 3 ", term_eval0(TMget_at(board, TMint(3))))

// set at
fun
TMset_at(t: term, i: term, v: term) : term =
TMapp(TMapp(TMapp(TMget_at_raw, t), i), v) where {
val TMget_at_raw =
let
val element_type = tpxyz_new()
val input = TManno(TMvar"input", TPlist(element_type))
val index = TManno(TMvar"index", TPint)
val new_v = TManno(TMvar"new_v", TPint)
in
TMfix(
        "cont",
        "input",
        TMlam(
                "index",
                TMlam(
                        "new_v",
                        TMif0(
                                TMeq(index, TMint(0)),
                                TMlist_cons(new_v, TMlist_tail(input)),
                                TMlist_cons(TMlist_head(input), TMapp(TMapp(TMapp(TMvar"cont", TMlist_tail(input)), TMsub(index, TMint(1))), new_v))
                            )
                        )
                )
        )
end
}

//val () = println!("set at 0 ", term_eval0(TMset_at(board, TMint(0), TMint(1000))))
//
//val () = println!("set at 1 ", term_eval0(TMset_at(board, TMint(1), TMint(1000))))
//
//val () = println!("set at 3 ", term_eval0(TMset_at(board, TMint(3), TMint(1000))))


// now an abs function, I guess
val TMabs =
TMlam(
        "a",
        TMif0(
                TMlt(TMvar"a", TMint(0)),
                     TMmul(TMvar"a", TMint(~1)),
                     TMvar"a"
                 )
            )

(*
val () = println!(type_norm(term_type0(TMabs)))

val () = println!(term_eval0(
        TMapp(TMabs, TMint(~5))
        ))

val () = println!(term_eval0(
        TMapp(TMabs, TMint(25))
))
*)



fun
TMmap(input: term, func: term): term =
TMapp(TMapp(TMmap_raw, input), func) where {
val
TMmap_raw =
let
val before_type = tpxyz_new()
val after_type = tpxyz_new()
val input = TManno(TMvar"input", TPlist(before_type))
val func = TManno(TMvar"func", TPfun(before_type, after_type))
in
TMfix
(
"cont",
"input",
TMlam(
"func",
      TMif0(
          TMlist_nilq(input),
          TMlist_nil(),
          TMlist_cons(
                  TMapp(func, TMlist_head(input)),
                  TMapp(TMapp(TMvar"cont", TMlist_tail(input)), func)

          )
      ))
)
end

}

val TMrange =
TMfix(
"cont",
"from",
TMlam(
"to",
TMif0(
        TMeq(TMvar"to", TMvar"from"),
        TMlist_nil(),
        TMlist_cons(
                TMvar"from",
                TMapp(TMapp(TMvar"cont", TMadd(TMvar"from", TMint(1))), TMvar"to")
                )
        )
    )
)

fun
TMrange_fn(b: int, e: int) =
TMapp(TMapp(TMrange, TMint(b)), TMint(e))

val TMlist_concat_raw =
let
val element_type = tpxyz_new()
val input1 = TManno(TMvar"input1", TPlist(element_type))
val input2 = TManno(TMvar"input2", TPlist(element_type))
in
TMfix
(
"cont",
"input1",
TMlam(
"input2",
      TMif0(
          TMlist_nilq(input1),
          input2,
          TMlist_cons(
                  TMlist_head(input1),
                  TMapp(TMapp(TMvar"cont", TMlist_tail(input1)), input2)

          )
      ))
)
end

fun
TMlist_concat(a: term, b: term): term =
TMapp(TMapp(TMlist_concat_raw, a), b)


fun TMflatten(t:term):term =
TMapp(TMflatten_raw, t) where {
val TMflatten_raw =
let
val element_type = tpxyz_new()
val input = TManno(TMvar"input", TPlist(TPlist(element_type)))
in
TMfix
(
"cont",
"input",
  TMif0(
      TMlist_nilq(input),
      TMlist_nil(),
      TMlist_concat(TMlist_head(input),
                    TMapp(TMvar"cont", TMlist_tail(input))
                    )
  )
)
end
}

//let rec fold_left op acc = function
//  | []   -> acc
//  | h :: t -> fold_left op (op acc h) t

val TMfold_left =
TMfix(
  "cont",
  "fn",
  TMlam("accumulator", TMlam("list",
     TMif0(
       TMlist_nilq(TMvar"list"),
       TMvar"accumulator",
       TMapp(TMapp(TMapp(TMvar"cont", TMvar"fn"), TMapp(TMapp(TMvar"fn", TMvar"accumulator"), TMlist_head(TMvar"list"))), TMlist_tail(TMvar"list"))
       )
     ))
  )

//val () = println!(type_norm(term_type0(TMfold_left)))

val pairs = TMflatten(TMmap(
        TMapp(TMapp(TMrange, TMint(0)), TMint(8)),
        TMlam(
                "x",
                TMmap(TMapp(TMapp(TMrange, TMadd(TMvar"x", TMint(1))), TMint(8)),
                    TMlam(
                            "y",
                            TMtup(TMvar"x", TMvar"y")
                          )
                    )
                )
        ))

//val () = println!(type_norm(term_type0(pairs)))
//val () = println!(term_eval0(pairs))


fun TMfilter(imp_list: term, test: term): term =
TMapp(TMapp(TMfilter_raw, imp_list), test) where {
val TMfilter_raw =
let
val inp_type = tpxyz_new()
val inp = TManno(TMvar"inp", TPlist(inp_type))
val test_fun = TManno(TMvar"test_fun", TPfun(inp_type, TPbtf))
in
TMfix(
      "cont",
      "inp",
      TMlam(
              "test_fun",
              TMif0(
                      TMlist_nilq(inp),
                      TMlist_nil(),
                      TMif0(
                      TMapp(test_fun, TMlist_head(inp)),
                      TMlist_cons(
                              TMlist_head(inp), TMapp(TMapp(TMvar"cont", TMlist_tail(inp)), test_fun)
                              ),
                      TMapp(TMapp(TMvar"cont", TMlist_tail(inp)), test_fun)
                      )
              )))
end
}

val TMall =
TMlam(
        "inp",
        TMlist_nilq(
                TMfilter(TMvar"inp",
                     TMlam("x",
                           TMif0(
                                   TMvar"x",
                                   TMbtf(false),
                                   TMbtf(true)
                                   )
                           )
                     )
            )
        )

// test TMall
(*
val () = println!(type_norm(term_type0(TMall)))

val true_list = TMlist_cons(TMbtf(true), TMlist_cons(TMbtf(true), TMlist_cons(TMbtf(true), TMlist_cons(TMbtf(true), TMlist_nil()))))
val () = println!("Should be true ", term_eval0(TMapp(TMall, true_list)))

val false_list = TMlist_cons(TMbtf(false), TMlist_cons(TMbtf(false), TMlist_cons(TMbtf(false), TMlist_cons(TMbtf(false), TMlist_nil()))))
val () = println!("Should be false ", term_eval0(TMapp(TMall, false_list)))

val mixed_list = TMlist_cons(TMbtf(true), TMlist_cons(TMbtf(false), TMlist_cons(TMbtf(true), TMlist_cons(TMbtf(false), TMlist_nil()))))
val () = println!("Should be false ", term_eval0(TMapp(TMall, mixed_list)))

*)


val TMlist_len =
TMfix(
        "cont",
        "l",
        TMlam("i",
              TMif0(
                      TMlist_nilq(TMvar"l"),
                      TMvar"i",
                      TMapp(
                              TMapp(TMvar"cont", TMlist_tail(TMvar"l")),
                              TMadd(TMvar"i", TMint(1))
                              )
                      )
              )
        )

//val () = println!(type_norm(term_type0(
//        TMlist_len
//        )))




// ok, time to actually get started
// this function up first
// def is_safe(board: List[int], row: int) -> bool:
//    # Checks if the last queen placed at 'row' doesn't conflict with earlier ones
//    for i in range(row):
//        if board[i] == board[row]:
//            return False
//        else:
//            if abs(board[i] - board[row]) == row - i:
//                return False
//    return True

val TMprint =
        TMlam("b",
              TMlam("i",
                    TMlam("r",
                          TMlet("_", TMopr("print", mylist_sing(TMvar"i")),
                                           TMlet("_", TMopr("print", mylist_sing(TMvar"r")),
                                                 TMlet("_", TMopr("prchr", mylist_sing(TMchr('\n'))), TMbtf(true))
                                                 )
                                 )
                          )))

val TMis_safe =
let
val board = TMvar"board"
val row   = TMvar"row"
val TMcheck_at =
TMlam("b",
    TMlam("i",
          TMlam("r",
                TMlet("board[i]", TMget_at(TMvar"b", TMvar"i"),
                    TMlet("board[row]", TMget_at(TMvar"b", TMvar"r"),
                          TMif0(TMeq(TMvar"board[i]", TMvar"board[row]"),
                                TMbtf(false),
                                TMif0(
                                        TMeq(TMapp(TMabs, TMsub(TMvar"board[i]", TMvar"board[row]")), TMsub(TMvar"r", TMvar"i")),
                                        TMbtf(false),
                                        TMbtf(true)
                                        )
                                )
                          )
                    )
                )
        )
    )
in
TMlam("board", TMlam("row",
                     TMapp(TMall, TMmap(
                             TMapp(TMapp(TMrange, TMint(0)), row),
                             TMlam(
                                     "index",
                                     TMapp(TMapp(TMapp(TMcheck_at, board), TMvar"index"), row)
                                     )
                             ))
                     ))
end

val example_legal_board =   TMlist_cons(TMint(7), TMlist_cons(TMint(3), TMlist_cons(TMint(0), TMlist_cons(TMint(2), TMlist_cons(TMint(5), TMlist_cons(TMint(1), TMlist_cons(TMint(6), TMlist_cons(TMint(4), TMlist_nil()))))))))
val example_illegal_board = TMlist_cons(TMint(7), TMlist_cons(TMint(3), TMlist_cons(TMint(0), TMlist_cons(TMint(7), TMlist_cons(TMint(5), TMlist_cons(TMint(1), TMlist_cons(TMint(6), TMlist_cons(TMint(4), TMlist_nil()))))))))

//val () = println!(type_norm(term_type0(TMis_safe)))
//val () = println!("should be true ", term_eval0(
//        TMapp(TMapp(TMis_safe, example_legal_board), TMint(7)) // eg. last one
//        ))
//
//
//
//val () = println!("should be false ", term_eval0(
//        TMapp(TMapp(TMis_safe, example_illegal_board), TMint(3)) // check 3rd one, should be illegal
//))
//

// great, now this:
// def place_queen_and_check(board: List[int], row: int, column: int) -> Tuple[bool, List[int]]:
//    new_board = board[:]  # Make a copy to avoid mutation of the original board.
//    new_board[row] = column
//    return (is_safe(new_board, row), new_board)

val TMplace_queen_and_check =
let
val board  = TMvar"board"
val row    = TMvar"row"
val column = TMvar"column"
in
TMlam("board", TMlam("row", TMlam("column",
        TMlet("new_board",
              TMset_at(board, row, column),
              TMtup(
                TMapp(TMapp(TMis_safe, TMvar"new_board"), row),
                TMvar"new_board"
                )
              )
      )))
end

//val () = println!(term_type0(TMplace_queen_and_check))


// on to this one
// def board_extend(boards: List[List[int]], row: int) -> List[List[int]]:
//    N = 8  # Size of the board (8x8)
//    new_boards = []
//    for board in boards:
//        # Generate all possible new boards for the current row
//        possible_boards = [(place_queen_and_check(board, row, col)) for col in range(N)]
//        # Use filter to include only the boards with safe queen placement
//        safe_boards = list(filter(lambda x: x[0], possible_boards))
//        # Extract the board configurations from the filtered tuples
//        new_boards.extend([board for (safe, board) in safe_boards])
//    return new_boards

val TMboard_extend = 
let
val boards = TMvar"boards"
val row    = TMvar"row"
val board  = TMvar"board"
in
TMlam("boards", TMlam("row",
    TMmap(TMflatten(
          TMmap(
               boards,
               TMlam("board",
                   TMlet("possible_boards", TMmap(TMrange_fn(0, 8),
                                                  TMlam("col", TMapp(TMapp(TMapp(TMplace_queen_and_check, board), row), TMvar"col"))),
                      TMfilter(TMvar"possible_boards", TMlam("x", TMfst(TMvar"x")))
                       )
                   )
               )
          ),
          TMlam("x", TMsnd(TMvar"x"))
    )))
end

//val () = println!(type_norm(term_type0(TMboard_extend)))


// initial_board: List[int] = [-1] * N
// current_boards: List[List[int]] = [initial_board]
//
// all_boards = reduce(board_extend, range(N), current_boards)

// note: we're using fold_left, so we need to give it arguments in function accumulator list order
val initial_board = TMlist_cons(TMint(~1), TMlist_cons(TMint(~1), TMlist_cons(TMint(~1), TMlist_cons(TMint(~1), TMlist_cons(TMint(~1), TMlist_cons(TMint(~1), TMlist_cons(TMint(~1), TMlist_cons(TMint(~1), TMlist_nil()))))))))
val current_boards = TMlist_cons(initial_board, TMlist_nil())


val all_boards = TMapp(TMapp(TMapp(
  TMfold_left, TMboard_extend
  ), current_boards), TMrange_fn(0, 8))

val () = println!(type_norm(term_type0(all_boards)))

val () = println!(term_eval0(TMlist_head(all_boards)))
val () = println!(term_eval0(TMlist_head(TMlist_tail(all_boards))))
