\l qtips.q

c:.opt.config
c,:(`ref;`:ref.csv;"file with reference data")
c,:(`eod;0D23:59;"time for end of day event")
c,:(`db;`:db;"end of day dump location")
c,:(`debug;0b;"don't start engine")
c,:(`log;2;"log level")

/ utility function to generate until timer events
/ (e)nd (t)ime, ids, (d)uration, (f)unction
genu:{[et;ids;d;f]flip(`.timer.until;d;et;flip(f;ids))}

/ (p)arameter list, current (t)i(m)e
main:{[p;tm]
 r:("J FFJFF";1#",") 0: p `ref;
 `ref upsert `id`px`ts`qs`vol`rfr xcol r;
 `price upsert flip ((0!ref)`id`px),tm;
 tms:(n:count ids:key[ref]`id)#tm;
 u:genu[p `eod;ids];
 .timer.add[`timer.job;`updp;u[d:n?0D00:00:01;`.md.updp];tms];
 .timer.add[`timer.job;`updq;u[d+:n?0D00:00:01;`.md.updq];tms];
 .timer.add[`timer.job;`updt;u[d+:n?0D00:00:01;`.md.updt];tms];
 .timer.add[`timer.job;`dump;(`.md.dump;p `db);p[`eod]+"d"$tm];
 }

p:.opt.getopt[c;`ref`db] .z.x
if[`help in key p;-1 .opt.usage[1_c;.z.f];exit 1]
.log.lvl:p `log
if[not p`debug;main[p;.z.P]]
