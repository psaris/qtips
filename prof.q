/ empty events table
prof.events:flip `id`pid`func`time!"jjsn"$\:()

/ view of profile statistics report
prof.rpt::.prof.stats prof.events

\d .prof

pid:id:0

/ instrument (f)unction
instr:{[f]
 p:get get f;
 a:";" sv string count[p 1]#.Q.a;
 s:"{[",a,"]";
 s,:"t:.z.p;";
 s,:"id:.prof.id+:1;";
 s,:"pid:.prof.pid;.prof.pid:id;";
 s,:"r:",last[p],"[",a,"];";
 s,:".prof.pid:pid;";
 s,:"t:.z.p-t;";
 s,:"`prof.events upsert (id;pid;`",string[f],";t);";
 s,:"r}";
 system "d .",string first p 3;
 f set parse s except "\n";
 system "d .";
 f}

/ generate list of directories
dirs:{(` sv x,) each key[x] except `q`Q`h`j`o`prof}

/ generate list of profilable functions
lambdas:{x where 100h=(type get@) each x} 

/ instrument all functions
instrall:{instr each lambdas raze .util.tree each `.,dirs`}

/ generate profile statistics report given an (e)vents table
stats:{[e]
 c:select sum time,nc:count i by id:pid from e;
 e:e pj update neg time from c;
 s:select sum time*1e-6,n:count i,avg nc by func from e;
 s:update timepc:time%n from s;
 s:`pct xdesc update pct:100*time%sum time from s;
 s}
