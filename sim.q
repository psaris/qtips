\d .sim

/ generate simulated security paths
/ (s)igma, (r)ate, (t)ime
path:{[s;r;t]
 z:.stat.norminv count[t]?1f;
 p:prds .stat.gbm[s;r;deltas[first t;t]] z;
 p}

/ generate price path
/ security (id), (S)pot, (s)igma, (r)ate, (d)ate/(t)i(m)e
genp:{[id;S;s;r;dtm]
 t:abs type dtm;
 tm:("np" t in 12 14 15h)$dtm;
 p:S*path[s;r;tm%365D06];
 c:`id,`time`date[t=14h],`price;
 p:flip c!(id;dtm;p);
 p}
 
/ round price to nearest tick (up and down)
tickrnd:{if[99h=type x;x@:y];(y;x+y:x*floor y%x)}

/ randomly delay a timeseries 
delay:{abs[type x]$x+next deltas[x]*count[x]?1f}

/ randomly throw away elements of list
filter:{y asc (neg"j"$x*n)?n:count y}

/ generate bid/ask quotes
/ (t)ick (s)ize, (q)uote (s)ize, (p)rice path
genq:{[ts;qs;p]
 q:p,'flip `bp`ap!tickrnd[ts] p `price;
 q:q,'flip `bs`as!1+count[p]?/:2#qs;
 q:`id`time`bs`bp`ap`as#q;
 q}

/ generate trade event
/ (b)id/ask flag, pct:percent fills
/ (b)id (s)ize, (b)id (p)rice, (a)sk (p)rice, (a)sk (s)izie
trd:{[b;pct;bs;bp;ap;as](ceiling pct*?[b;bs;as];?[b;bp;ap])}

/ generate trade event
/ (q)uote table and (pct) fill rate
gent:{[pct;q]
 q:filter[pct] raze (-1_@[;`time;delay] q@) each group q `id;
 t:q,' flip `ts`tp!trd[n?0b;(n:count q)?1f] . q `bs`bp`ap`as;
 t:`id`time`ts`tp#t;
 t}