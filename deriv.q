\d .deriv

/ monte carlo
/ (S)pot, (s)igma, (r)ate, (t)ime,
/ (p)ayoff (f)unction, (n)umber of paths
mc:{[S;s;r;t;pf;n]
 z:.stat.bm n?/:count[t]#1f;
 f:S*prds .stat.gbm[s;r;deltas[first t;t]] z;
 v:pf[f]*exp neg r*last t;
 v}

/ monte carlo result statistics
/ (e)xpected (v)alue, (err)or, (n)umber of paths
mcstat:{`ev`err`n!(avg x;1.96*sdev[x]%sqrt n;n:count x)}

/ european option payoff
/ (c)all flag, stri(k)e, (f)uture prices
eu:{[c;k;f]0f|$[c;last[f]-k;k-last f]}

/ asian option payoff
/ (c)all flag, stri(k)e, (f)uture prices
as:{[c;k;f]0f|$[c;avg[f]-k;k-avg f]}

/ lookback payoff
/ (c)all flag, stri(k)e, (f)uture prices
lb:{[c;k;f]0f|$[c;max[f]-k;k-min f]}

/ barrier option
/ (b)arrier (f)unction, (p)ayoff (f)unction
/ (f)uture prices
bo:{[bf;pf;f]bf[f]*pf f}

/ black-scholes-merton
/ (S)pot, stri(k)e, (r)ate, (t)ime,
/ (c)all flag, (s)igma
bsm:{[S;k;r;t;c;s]
 x:(log[S%k]+rt:r*t)%ssrt:s*sqrt t;
 d1:ssrt+d2:x-.5*ssrt;
 n1:m*.stat.cnorm d1*m:-1 1f c;
 n2:exp[neg rt]*m*.stat.cnorm d2*m;
 p:(sn:S*n1)-kn:k*n2;
 g:n1%s*ssrt;
 v:sn*ssrt;
 th:neg (r*kn)+.5*v*s%t;
 rho:t*kn;
 d:`price`delta`gamma`vega`theta`rho;
 d!:(p;n1;g;sn*ssrt;th;rho);
 if[0h<type p;d:flip d];
 d}
