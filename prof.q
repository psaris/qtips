/ empty events table
prof.events:flip `id`pid`func`time!"jjsn"$\:()

/ view of profile statistics report
prof.rpt::.prof.stats prof.events

\d .prof

pid:id:0

/ record timing of a (f)unction with (n)ame when called with (a)rgs
time:{[n;f;a]
 s:.z.p;
 id:.prof.id+:1;
 pid:.prof.pid;
 .prof.pid:id;
 r:f . a;
 .prof.pid:pid;
 `prof.events upsert (id;pid;n;.z.p-s);
 r}

/ instrument function (n)ame
instr:{[n]
 m:get f:get n;
 system "d .",string first m 3;
 n set (')[.prof.time[n;f];enlist];
 system "d .";
 n}

/ generate list of directories
dirs:{(` sv x,) each key[x] except `q`Q`h`j`o`prof}

/ generate list of profileable functions
lambdas:{x where 100h=(type get@) each x} 

/ instrument all functions
instrall:{instr each lambdas raze .util.tree each `.,dirs`}

/ generate profile statistics report given an (e)vents table
stats:{[e]
 c:select sum time,nc:count i by id:pid from e;
 e:e pj update neg time from c;
 s:select sum time*1e-6,n:count i,avg nc by func from e;
 s:update timepc:time%n from s;
 s:`pct xdesc update pct:100f*time%sum time from s;
 s}
