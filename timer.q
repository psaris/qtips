/timer events
timer:flip `name`func`time!"s*p"$\:()
timer,:(`;();0Wp)

\d .timer

/ merge record(y) into table(x) in reverse chronological order
merge:`time xdesc upsert

/ add new timer (f)unction with (n)ame and (t)i(m)e into (t)able
add:{[t;n;f;tm]
 r:(n;f;gtime tm);
 t:merge[t;$[0h>type tm;r;reverse flip r]];
 t}

/ run timer event at (i)ndex from (t)able and current time tm
run:{[t;i;tm]
 e:t i;
 t:.[t;();_;i];
 r:value (f:e `func),ltime tm;
 if[not null r;merge[t;(e `name;f;tm+r)]];
 t}

/ scan timer (t)able for runable events
loop:{[t;tm]
 while[tm>=last tms:t `time;t:run[t;-1+count tms;tm]];
 t}

/ helper function to generate repeating events
/ (d)elay, (e)nd (t)ime, (f)unction, tm:current time
until:{[d;et;f;tm]if[tm<et;@[value;f,tm;0N!];:d]}

.z.ts:loop[`timer]

