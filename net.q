/ table to hold active and inactive connection information
handle:1!flip `h`active`user`host`address`time!"ibss*n"$\:()

/ record new client connection
.z.po:{[h]`handle upsert (h;1b;.z.u;.z.h;"i"$0x0 vs .z.a;.z.N)}

/ mark client connection as inactive
.z.pc:{[h]`handle upsert `h`active`time!(h;0b;.z.N)}

/ modify log header to include user, handle and host
\d .log
hdr:{string[(.z.D;.z.T;.z.u;.z.w;.Q.host .z.a)],mem get"\\w"}
