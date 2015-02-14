\d .stat

/ percentile
pctile:{[p;x]x iasc[x] -1+ceiling p*count x}

/ 12 uniforms
u12:{-6f+sum x cut (12*x)?1f}

skew:{avg[x*x2]%sqrt m2*m2*m2:avg x2:x*x-:avg x}
kurt:{-3f+avg[x2*x2]%x*x:avg x2:x*x-:avg x}

/ box-muller
bm:{
 if[count[x] mod 2;'`length];
 x:2 0N#x;
 r:sqrt -2f*log first x;
 theta:2f*acos[-1f]*last x;
 x: r*cos theta;
 x,:r*sin theta;
 x}

/ geometric brownian motion
/ (s)igma, (r)ate, (t)ime, z:uniform random
/ user multiplies by (S)pot
gbm:{[s;r;t;z]exp (t*r-.5*s*s)+z*s*sqrt t}

/ inter quartile range
iqr:{(-) . pctile[.75 .25;x]}

/ auto correlation
ac:{x%first x:x{(y#x)$neg[y]#x}/:c-til c:count x-:avg x}

/ horner's method
/ x:coefficients, y:data
horner:{{z+y*x}[y]/[x]}

/ exponentially weighted moving average
/ x:decay rate, y:data
ewma:{first[y](1f-x)\x*y}

/ central region - normal inverse
cnorminv:{
 a:-25.44106049637 41.39119773534 -18.61500062529 2.50662823884;
 b: 3.13082909833 -21.06224101826 23.08336743743
   -8.47351093090 1;
 x*:horner[a;s]%horner[b] s:x*x-:.5;
 x}

/ tail region - normal inverse
tnorminv:{
 a:0.0000003960315187 0.0000002888167364 0.0000321767881768
   0.0003951896511919 0.0038405729373609 0.0276438810333863
   0.1607979714918209 0.9761690190917186 0.3374754822726147;
 x:horner[a] log neg log 1f-x;
 x}

/ beasley-springer-moro normal inverse approximation
norminv:{
 i:x<.5;
 x:?[i;1f-x;x];
 x:?[x<.92;cnorminv x;tnorminv x];
 x:?[i;neg x;x];
 x}

/ open high low close
ohlc:{`o`h`l`c!(first;max;min;last)@\:x}

/ count, min, max, median, standard deviation of x
summary:{`n`mn`mx`md`dv!(count;min;max;med;sdev)@\:x}

/ error function
erf:{
 a: 1.061405429 -1.453152027 1.421413741
   -0.284496736  0.254829592;
 t:1f%1f+0.3275911*abs x;
 t:1f-t*horner[a;t]*exp neg x*x;
 x:t*1 -1f x<0f;
 x}

/ cumulative normal 
cnorm:{.5*1f+erf x%sqrt 2f}

/ newton-raphson
/ (e)rror tolerance, (f)unction
nr:{[e;f;x]$[e>abs d:first[r]%last r:f x;x;x-d]}

/ function inversion
/ (r)oot-finding (f)unction, (f)unction
invert:{[rf;f;y;x]rf[(neg y;0f)+f@]x}
