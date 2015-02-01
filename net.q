/ table to hold active and inactive connection information
handle:.util.sattr 1!flip `h`active`user`host`address`time!"ibss*p"$\:()

/ record new client connection
.z.po:{[h]`handle upsert (h;1b;.z.u;.Q.host .z.a;"i"$0x0 vs .z.a;.z.P);}
.z.po 0i / simulate opening of 0

/ mark client connection as inactive
.z.pc:{[h]`handle upsert `h`active`time!(h;0b;.z.P);}

/ modify log header to include user, handle and host
\d .log
hdr:{string[(.z.D;.z.T;.z.u;.z.w;`handle . (.z.w;`host))],mem get"\\w"}
