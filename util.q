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
 t:$[n;n!@[;c;a#]0!t;@[;c;a#]t];
 t}

/ rename columns of (t)able based on (d)ictionary
mapcol:{[d;t](c^d c:cols t) xcol t}

/ sort dictionary (or keyed table) by key
kasc:{$[`s=attr k:key x;x;(`s#k i)!value[x]i:iasc k]}

/ string implementaion of pivot
/ (t)able, pivot (c)olumns, (g)roup column, (d)ata column
pivots:{[t;c;g;d]
 s:"exec (`$string asc distinct t ", (-3!c),")";
 s,:"#(`$string ",string[c],")!",string[d];
 s,:" by ",string[g],":",string[g]," from t";
 p:eval parse s;
 p}

/ parse-tree implementaion of pivot
/ (t)able, pivot (c)olumns, (g)roup column, (d)ata column
pivotp:{[t;c;g;d]
 u:`$string asc distinct t c;
 p:?[t;();g!g;({x#(`$string y)!z};`u;c;d)];
 p}

/ q implementaion of pivot
/ (t)able, pivot (c)olumns, (g)roup column, (d)ata column
pivotq:{[t;c;g;d]
 u:`$string asc distinct t c;
 g:asc[key g]#g:group g#t;
 p:u#/:(`$string t c)[g]!'t[d] g;
 p}

/ keyed-(t)able implementaion of pivot
/ last column of key are pivot columns
/ remaing columns of key are group by columns
/ last column of table is data
pivot:{[t]
 c:last f:flip k:key t;
 d:last flip value t;
 u:`$string asc distinct c;
 g:asc[key g]#g:group (-1_ key f)#k;
 p:u#/:(`$string c)[g]!'d g;
 p}

/ splay table to disk without enumerating sym columns
splay:{@[x;`.d,c;:;enlist[c],y c:cols y]}

/ generate a list of nodes(files or variables) within tree node
tree:{$[x~k:key x;x;11h=type k;raze (.z.s ` sv x,) each k;()]}

/ bid-ask volume (example HDB query)
/ (t)rade table, (q)uote table, (d)a(t)e
bav:{[t;q;dt]
 t:select id,time,tp,ts from t where date=dt;
 t:aj[`id`time;t] select id,time,bp,ap from q where date=dt;
 t:update bv:ts*tp<=bp,av:ts*tp>=ap from t;
 t:0!select date:dt,sum bv,sum av,tv:sum ts by id from t;
 t}
