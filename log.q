\d .log

h:-2                              / handle to print log
lvl:2                             / log level
unit:"BKMGTP"                     / memory unit character
mult:1024 xexp neg til count unit / memory multiplier

/ magnitude of memory
mag:{floor 1024 xlog x}

/ build memory string
mem:{@[string"i"$mult[m]*3#x;2;,;unit m:mag x 2]}

/ build log header
hdr:{string[(.z.D;.z.T)],mem system "w"}

/ build log message
msg:{if[x<=lvl;h " " sv hdr[],(y;$[10h=type z;z;-3!z])]}

/ user lever functions to log messages
err:msg[0;"[E]"]
wrn:msg[1;"[W]"]
inf:msg[2;"[I]"]
dbg:msg[3;"[D]"]
trc:msg[4;"[T]"]
