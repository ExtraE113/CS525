#include "share/atspre_staload.hats"

staload
STDLIB =
"libats/libc/SATS/stdlib.sats"
staload
TIME = "libats/libc/SATS/time.sats"
staload UN = "prelude/SATS/unsafe.sats"

#include
"share/atspre_staload_libats_ML.hats"
#staload "prelude/SATS/tostring.sats"
  (*******)



implement main0 () = () where
{
val () = println! (unique_symbol())
}
