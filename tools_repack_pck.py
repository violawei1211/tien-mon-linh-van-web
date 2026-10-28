import struct,hashlib,sys
src,gd,out=sys.argv[1:4]
extra=dict(a.split("=",1) for a in sys.argv[4:])
d=open(src,"rb").read()
fb=struct.unpack_from("<Q",d,24)[0]; dir_off=struct.unpack_from("<Q",d,32)[0]
p=dir_off;n=struct.unpack_from("<I",d,p)[0];p+=4
ents=[]
for i in range(n):
    L=struct.unpack_from("<I",d,p)[0];p+=4
    path=d[p:p+L].rstrip(b"\0").decode();p+=L
    off,size=struct.unpack_from("<QQ",d,p);p+=16;md5=d[p:p+16];p+=16;fl=struct.unpack_from("<I",d,p)[0];p+=4
    ents.append([path,d[fb+off:fb+off+size],fl])
ents=[e for e in ents if e[0] not in ("scripts/main.gd.remap","scripts/main.gdc")]
ents.append(["scripts/main.gd",open(gd,"rb").read(),0])
for e in ents:
    if e[0] in extra: e[1]=open(extra[e[0]],"rb").read()
ents.sort(key=lambda e:e[0])
body=bytearray(); offs=[]
for e in ents:
    while len(body)%32: body.append(0)
    offs.append(len(body)); body+=e[1]
while (fb+len(body))%32: body.append(0)
new_dir=fb+len(body)
dr=bytearray(struct.pack("<I",len(ents)))
for e,o in zip(ents,offs):
    pb=e[0].encode(); pad=(4-len(pb)%4)%4; pb+=b"\0"*pad
    dr+=struct.pack("<I",len(pb))+pb+struct.pack("<QQ",o,len(e[1]))+hashlib.md5(e[1]).digest()+struct.pack("<I",e[2])
hdr=bytearray(d[:fb]); struct.pack_into("<Q",hdr,32,new_dir)
open(out,"wb").write(bytes(hdr)+bytes(body)+bytes(dr))
print("ok",len(ents),new_dir)
