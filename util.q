\d .util

/ import designated function or entire directory
use:{system["d"] upsert $[99h=type v:get x;v;(-1#` vs x)!1#v]}

/ return weekdays from list of dates
wday:{x where 1<x mod 7}

/ return a range of numbers between (s)tart and (e)nd 
/ with specified (w)indow size
rng:{[w;s;e]s+w*til ceiling(e-s)%w}

/ round y to nearest x
rnd:{x*"j"$y%x}

/ generate (n) uniform random numbers between (s)tart and (e)nd
randrng:{[n;s;e]s+n?e-s}

/ automatically set attributes on first column of (t)able
sattr:{[t]
 c:first cols t;
 a:`g`u 1=n:count keys t;
 t:n!@[;c;a#]0!t;
 t}

/ rename columns of (t)able based on (d)ictionary
mapcol:{[d;t](c^d c:cols t) xcol t}

/ sort dictionary (or keyed table) by key
kasc:{$[`s=attr k:key x;x;(`s#k i)!value[x]i:iasc k]}

/ string implementation of pivot
/ pivot (c)olumns, (g)roup column, (d)ata column, (t)able
pivots:{[c;g;d;t]
 s:"exec (`$exec string asc distinct ",string[c]," from t)";
 s,:"#(`$string ",string[c],")!",string d;
 s,:" by ", "," sv ":" sv'string flip 2#enlist g,();
 s,:" from t";
 p:eval @[parse s;1;:;t];
 p}

/ parse-tree implementation of pivot
/ pivot (c)olumns, (g)roup column, (d)ata column, (t)able
pivotp:{[c;g;d;t]
 u:`$string asc distinct t c;
 pf:{x#(`$string y)!z};
 p:?[t;();g!g,:();(pf;`u;c;d)];
 p}

/ q implementation of pivot
/ pivot (c)olumns, (g)roup column, (d)ata column, (t)able
pivotq:{[c;g;d;t]
 u:`$string asc distinct t c;
 p:asc[key p]#p:group (g,())#t;
 p:u#/:(`$string t c)[p]!'t[d] p;
 p}

/ keyed-(t)able implementation of pivot
/ last column of key are pivot columns
/ remaing columns of key are group by columns
/ last column of table is data
pivot:{[t]
 u:`$string asc distinct last f:flip key t;
 pf:{x#(`$string y)!z};
 p:?[t;();g!g:-1_ k;(pf;`u;last k:key f;last key flip value t)];
 p}

/ splay table to disk without enumerating sym columns
splay:{@[x;`.d,c;:;enlist[c],y c:cols y]}

/ generate a list of nodes(files or variables) within tree node
tree:{$[x~k:key x;x;11h=type k;raze (.z.s ` sv x,) each k;()]}

/ unenumerate any enumerated columns in table
unenum:{@[x;where (type each flip x) within 20 76;get]}

/ bid-ask volume (example HDB query)
/ (t)rade table, (q)uote table, (d)a(t)e
bav:{[t;q;dt]
 r:select id,time,tp,ts from t where date=dt;
 r:aj[`id`time;r] select id,time,bp,ap from q where date=dt;
 r:update bv:ts*tp<=bp,av:ts*tp>=ap from r;
 r:0!select date:dt,sum bv,sum av,tv:sum ts by id from r;
 r}
