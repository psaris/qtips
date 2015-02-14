\d .hist

/ create range of n buckets between (s)tart and (e)nd
nrng:{[n;s;e]s+til[1+n]*(e-s)%n}

/ group data by a (b)inning (f)unction
bgroup:{[bf;x]
 b:nrng[bf x;min x;max x];
 g:group b bin x;
 g:b!x g til count b;
 g}

/ convert (w)indow size to number of buckets
nw:{[w;x]ceiling (max[x]-min x)%w}

/ square root bucket algorithm
sqrtn:{ceiling sqrt count x}

/ sturges' bucket algorithm
sturges:{ceiling 1f+2f xlog count x}

/ normalized skew used for doane
nskew:{[x].stat.skew[x]%sqrt 6f*(n-2)%(n+1)*3+n:count x}

/ doane's bucket algorithm
doane:{ceiling 1f+(2f xlog count x)+2f xlog 1f+abs nskew x}

/ scott's windowing algorithm
scott:{nw[;x] 3.4908*sdev[x]*count[x] xexp -1f%3f}

/freedman-diaconis windowing algorithm
fd:{nw[;x] 2f*.stat.iqr[x]*count[x] xexp -1f%3f}

/ bar-chart plotting function
/ (c)haracter, (w)indow size, (n)umber of points
bar:{[c;w;n]w$n#c}

/ dot-chart plotting function
/ (c)haracter, (w)indow size, (n)umber of points
dot:{[c;w;n]w$neg[n]$1#c}

/ use (p)lotting (f)unction to chart (d)ata with max (w)idth
chart:{[pf;w;d]
 n:"j"$(m&w)*n%m:max n:value d;
 d:d,'enlist each pf[w] each n;
 d}

/ example freedman-diaconis histogram composition
fdhist:chart[bar"*";30] count each bgroup[fd]@
