\d .opt

/ empty getopt configuration 
config:1#flip `opt`def`doc!"s**"$\:()

/ parse x according to (c)onfig and list of (h)syms
getopt:{[c;h;x]
 p:(!).(1_c)`opt`def;
 p:.Q.def[p] .Q.opt x;
 p:@[p;h;hsym];
 p}

/ wrap a list of (s)trings (l)eft and (r)ight text
wrap:{[l;r;s](max count each s)$s:l,/:s,\:r}

/ print usage according to (c)onfig and (f)ile
usage:{[c;f]
 u:enlist "usage: q ",(string f)," [option]...";
 a:wrap[(7#" "),"-";" "] string 1_c `opt;
 a:a,'wrap["<";"> "] 1_c `doc;
 a:a,'wrap["(";")"] -3!'1_c `def;
 u,a}