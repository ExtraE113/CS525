# this target is for the compiler. input: final_main.dats and final_compile.dats and final_compile.sats
# output: final_main_dats

final_main_dats: final_main.dats final_compile.dats final_compile.sats
	myatscc final_main.dats

debug: final_main_dats
	./final_main_dats

# this target is for the generated code. input: final_main_dats runtime_final.h
# output: test.c
test.c: final_main_dats runtime_final.h
	./final_main_dats > test.c

# this target is for the executable. input: test.c
# output: test.out
test.out: test.c
	gcc test.c -o test.out

# this target is make all
all: final_main_dats test.c test.out

# this target is for running the executable. input: test.out
# output: the result of the program
run: test.out
	./test.out