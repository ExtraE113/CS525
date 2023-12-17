# LAMBDA -> C Compiler

# Files

The code for this project is in the following files:

- final_compile.dats: The implementation file for the compiler
- final_compile.sats: The header file for the compiler
- final_main.dats: Primary set of tests for the compiler. Uncomment the tests you want to run. (Only uncomment one at a
  time, because each outputs to STDOUT and needs to be piped to a file individually.)
- list_permute_stream_lambda_compile.dats: A set of tests for the compiler that are based on the list_permute_stream
  testcase from the midterm. Uncomment the tests you want to run. (Only uncomment one at a time, because each outputs to
  STDOUT and needs to be piped to a file individually.)

# How to Run

1. Compile the test file you want to run, for example `final_main.dats`.
2. Run the compiled file, piping the output to a file, for example `./final_main_dats > final_main_dats.c`.
3. Compile the generated C file, for example `gcc final_main_dats.c -o final_main_dats`.
4. Run the compiled C file, for example `./final_main_dats`.

For `final_main.dats` you can also do `make run`.

# How it works

Essentially, we traverse the AST and emit C code that maps to that AST. As described in the paper, the C code is split
between `out` and `hoist`, where `out` is an expression to be substituted into the current expression, and `hoist` is a
statement to be hoisted to the top of the function.

We also ship a small runtime in `runtime_final.c` that implements primitive lambda operations in C (eg getting the first
and second terms of a tuple, or wrapping an `int` into a `lamval1`). It also implements variable resolution by name from
a contex, using a hashmap. This uses a hashmap, so it is O(1), but it's still a bit less efficient than direct usage
would be. I've determined that this is an acceptable efficiency-complexity tradeoff. This is used by the generated C
code.

