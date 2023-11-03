My implementation can be compiled and run.

Lambda calculus implementations of 8 queen, list permute, and word dublets 
can be found in the appropriately named files in `/Examples/`.

Some test code is commented out to make reading the output cleaner/easier to read,
but feel free to uncomment it.

To run the code, just compile and run the appropriate file.

I make extensive use of list-transformation functions, specifically:
- map
- filter
- forall
- fold_left (reduce)
- range

Those are all implemented in pure lambda calculus, and for the most part have (commented out)
tests.

I've also made some minor changes to midterm.sats.

term_type1_ck now takes another argument `msg`; if the typecheck fails it prints msg.

There's a new term type, TMtypecheckprint. It is ignored during execution but triggers
the type checker to print something. It's useful for debugging to figure out where the 
type checking failed.