local a={}local assert=assert;local error=error;local pairs=pairs;local b=string.byte;local c=string.char;local d=string.find;local e=string.gsub;local f=string.sub;local g=table.concat;local h=table.sort;local tostring=tostring;local type=type;local i={}local j={}local k={}local l={}local m={}local n={}local o={}local p={}local q={}local r={3,4,5,6,7,8,9,10,11,13,15,17,19,23,27,31,35,43,51,59,67,83,99,115,131,163,195,227,258}local s={0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,0}local t={[0]=1,2,3,4,5,7,9,13,17,25,33,49,65,97,129,193,257,385,513,769,1025,1537,2049,3073,4097,6145,8193,12289,16385,24577}local u={[0]=0,0,0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13}local v={16,17,18,0,8,7,9,6,10,5,11,4,12,3,13,2,14,1,15}local w;local x;local y;local z;local A;local B;local C;local D;for E=0,255 do j[E]=c(E)end;do local F=1;for E=0,32 do i[E]=F;F=F*2 end end;for E=1,9 do k[E]={}for G=0,i[E+1]-1 do local H=0;local I=G;for J=1,E do H=H-H%2+((H%2==1 or I%2==1)and 1 or 0)I=(I-I%2)/2;H=H*2 end;k[E][G]=(H-H%2)/2 end end;local K,L,M,J,N=bit.band,bit.bnot,bit.bxor,bit.blshift,bit.blogic_rshift;local O=0xEDB88320;local function P(Q)local R={}local S=setmetatable({},R)function R:__index(T)local U=Q(T)S[T]=U;return U end;return S end;local V=P(function(E)local W=E;for J=1,8 do local X=K(W,1)W=N(W,1)if X==1 then W=M(W,O)end end;return W end)local function Y(Z,W)W=L(W or 0)local _=N(W,8)local a0=V[M(W%256,Z)]return L(M(_,a0))end;local function a1(a2,W)W=W or 0;for E=1,#a2 do W=Y(a2:byte(E),W)end;return W end;function a:C(a2,W)if type(a2)=='string'then return a1(a2,W)else return Y(a2,W)end end;local a3={[0]={false,nil,0,0,0},[1]={false,nil,4,8,4},[2]={false,nil,5,18,8},[3]={false,nil,6,32,32},[4]={true,4,4,16,16},[5]={true,8,16,32,32},[6]={true,8,16,128,128},[7]={true,8,32,128,256},[8]={true,32,128,258,1024},[9]={true,32,258,258,4096}}local function a4(a5)local a6=a5;local a7=#a5;local a8=1;local a9=0;local aa=0;local function ab(ac)local ad=i[ac]local ae;if ac<=a9 then ae=aa%ad;aa=(aa-ae)/ad;a9=a9-ac else local af=i[a9]local ag,ah,ai,aj=b(a6,a8,a8+3)aa=aa+((ag or 0)+(ah or 0)*256+(ai or 0)*65536+(aj or 0)*16777216)*af;a8=a8+4;a9=a9+32-ac;ae=aa%ad;aa=(aa-ae)/ad end;return ae end;local function ak(al,am,an)assert(a9%8==0)local ao=a9/8<al and a9/8 or al;for J=1,ao do local Z=aa%256;an=an+1;am[an]=c(Z)aa=(aa-Z)/256 end;a9=a9-ao*8;al=al-ao;if(a7-a8-al+1)*8+a9<0 then return-1 end;for E=a8,a8+al-1 do an=an+1;am[an]=f(a6,E,E)end;a8=a8+al;return an end;local function ap(aq,ar,as)local ae=0;local at=0;local au=0;local av;if as>0 then if a9<15 and a6 then local af=i[a9]local ag,ah,ai,aj=b(a6,a8,a8+3)aa=aa+((ag or 0)+(ah or 0)*256+(ai or 0)*65536+(aj or 0)*16777216)*af;a8=a8+4;a9=a9+32 end;local ad=i[as]a9=a9-as;ae=aa%ad;aa=(aa-ae)/ad;ae=k[as][ae]av=aq[as]if ae<av then return ar[ae]end;au=av;at=av*2;ae=ae*2 end;for ac=as+1,15 do local bit;bit=aa%2;aa=(aa-bit)/2;a9=a9-1;ae=bit==1 and ae+1-ae%2 or ae;av=aq[ac]or 0;local aw=ae-at;if aw<av then return ar[au+aw]end;au=au+av;at=at+av;at=at*2;ae=ae*2 end;return-10 end;local function ax()return(a7-a8+1)*8+a9 end;local function ay()local az=a9%8;local ad=i[az]a9=a9-az;aa=(aa-aa%ad)/ad end;return ab,ak,ap,ax,ay end;local function aA(aB,aC)local ab,ak,ap,ax,ay=a4(aB)local aD={ReadBits=ab,ReadBytes=ak,Decode=ap,ReaderBitlenLeft=ax,SkipToByteBoundary=ay,buffer_size=0,buffer={},result_buffer={},dictionary=aC}return aD end;local function aE(aF,aG,aH)local aq={}local as=aH;for aI=0,aG do local ac=aF[aI]or 0;as=ac>0 and ac<as and ac or as;aq[ac]=(aq[ac]or 0)+1 end;if aq[0]==aG+1 then return 0,aq,{},0 end;local aJ=1;for aK=1,aH do aJ=aJ*2;aJ=aJ-(aq[aK]or 0)if aJ<0 then return aJ end end;local aL={}aL[1]=0;for aK=1,aH-1 do aL[aK+1]=aL[aK]+(aq[aK]or 0)end;local ar={}for aI=0,aG do local ac=aF[aI]or 0;if ac~=0 then local aM=aL[ac]ar[aM]=aI;aL[ac]=aL[ac]+1 end end;return aJ,aq,ar,as end;local function aN(aD,aO,aP,aQ,aR,aS,aT)local am,an,ab,ap,ax,aU=aD.buffer,aD.buffer_size,aD.ReadBits,aD.Decode,aD.ReaderBitlenLeft,aD.result_buffer;local aC=aD.dictionary;local aV;local aW;local aX=1;if aC and not am[0]then aV=aC.string_table;aW=aC.strlen;aX=-aW+1;for E=0,-aW+1<-257 and-257 or-aW+1,-1 do local X=aV[aW+E]am[E]=j[X]end end;repeat local aI=ap(aO,aP,aQ)if aI<0 or aI>285 then return-10 elseif aI<256 then an=an+1;am[an]=j[aI]elseif aI>256 then aI=aI-256;local ac=r[aI]ac=aI>=8 and ac+ab(s[aI])or ac;aI=ap(aR,aS,aT)if aI<0 or aI>29 then return-10 end;local aY=t[aI]aY=aY>4 and aY+ab(u[aI])or aY;local aZ=an-aY+1;if aZ<aX then return-11 end;if aZ>=-257 then for J=1,ac do an=an+1;am[an]=am[aZ]aZ=aZ+1 end else aZ=aW+aZ;for J=1,ac do an=an+1;local X=aV[aZ]am[an]=j[X]aZ=aZ+1 end end end;if ax()<0 then return 2 end;if an>=65536 then aU[#aU+1]=g(am,"",1,32768)for E=32769,an do am[E-32768]=am[E]end;an=an-32768;am[an+1]=nil end until aI==256;aD.buffer_size=an;return 0 end;local function a_(aD)local am,an,ab,ak,ax,ay,aU=aD.buffer,aD.buffer_size,aD.ReadBits,aD.ReadBytes,aD.ReaderBitlenLeft,aD.SkipToByteBoundary,aD.result_buffer;ay()local al=ab(16)if ax()<0 then return 2 end;local b0=ab(16)if ax()<0 then return 2 end;if al%256+b0%256~=255 then return-2 end;if(al-al%256)/256+(b0-b0%256)/256~=255 then return-2 end;an=ak(al,am,an)if an<0 then return 2 end;if an>=65536 then aU[#aU+1]=g(am,"",1,32768)for E=32769,an do am[E-32768]=am[E]end;an=an-32768;am[an+1]=nil end;aD.buffer_size=an;return 0 end;local function b1(aD)return aN(aD,z,x,7,D,B,5)end;local function b2(aD)local ab,ap=aD.ReadBits,aD.Decode;local b3=ab(5)+257;local b4=ab(5)+1;local b5=ab(4)+4;if b3>286 or b4>30 then return-3 end;local b6={}for E=1,b5 do local X=v[E]b6[X]=ab(3)end;local b7,b8,b9,ba=aE(b6,18,7)if b7~=0 then return-4 end;local aO={}local aR={}local au=0;while au<b3+b4 do local aI;local ac;aI=ap(b8,b9,ba)if aI<0 then return aI elseif aI<16 then if au<b3 then aO[au]=aI else aR[au-b3]=aI end;au=au+1 else ac=0;if aI==16 then if au==0 then return-5 end;if au-1<b3 then ac=aO[au-1]else ac=aR[au-b3-1]end;aI=3+ab(2)elseif aI==17 then aI=3+ab(3)else aI=11+ab(7)end;if au+aI>b3+b4 then return-6 end;while aI>0 do aI=aI-1;if au<b3 then aO[au]=ac else aR[au-b3]=ac end;au=au+1 end end end;if(aO[256]or 0)==0 then return-9 end;local bb,bc,aP,aQ=aE(aO,b3-1,15)if bb~=0 and(bb<0 or b3~=(bc[0]or 0)+(bc[1]or 0))then return-7 end;local bd,be,aS,aT=aE(aR,b4-1,15)if bd~=0 and(bd<0 or b4~=(be[0]or 0)+(be[1]or 0))then return-8 end;return aN(aD,bc,aP,aQ,be,aS,aT)end;local function bf(aD)local ab=aD.ReadBits;local bg;while not bg do bg=ab(1)==1;local bh=ab(2)local bi;if bh==0 then bi=a_(aD)elseif bh==1 then bi=b1(aD)elseif bh==2 then bi=b2(aD)else return nil,-1 end;if bi~=0 then return nil,bi end;if os and os.pullEvent then os.queueEvent("nosleep")os.pullEvent()end end;aD.result_buffer[#aD.result_buffer+1]=g(aD.buffer,"",1,aD.buffer_size)local bj=g(aD.result_buffer)return bj end;local function bk(aB,aC)local aD=aA(aB,aC)local bj,bi=bf(aD)if not bj then return nil,bi end;local bl=aD.ReaderBitlenLeft()local bm=(bl-bl%8)/8;return bj,bm end;function a:d(aB)if b(string.sub(aB,1,1))~=31 or b(string.sub(aB,2,2))~=139 then return nil,-1 end;if K(b(string.sub(aB,4,4)),0xE0)~=0 then return nil,-3 end;if b(string.sub(aB,3,3))~=8 then return nil,-4 end;local aM=10;if K(b(string.sub(aB,4,4)),4)==4 then aM=aM+b(string.sub(aB,11,11))*256+b(string.sub(aB,12,12))end;if K(b(string.sub(aB,4,4)),8)==8 then while b(string.sub(aB,aM,aM))~=0 do aM=aM+1 end end;if K(b(string.sub(aB,4,4)),16)==16 then while b(string.sub(aB,aM,aM))~=0 do aM=aM+1 end end;if K(b(string.sub(aB,4,4)),2)==2 then local bn=b(string.sub(aB,aM+1,aM+1))*256+b(string.sub(aB,aM,aM))local bo=K(self:C(string.sub(aB,1,aM-1)),0xFFFF)if M(bn,bo)~=0xFFFF then return nil,-5 end;aM=aM+2 end;local bp,bq=bk(string.sub(aB,aM+1,-8))if bp==nil then return bp,bq end;local bn=b(string.sub(aB,-5,-5))*0x1000000+b(string.sub(aB,-6,-6))*0x10000+b(string.sub(aB,-7,-7))*256+b(string.sub(aB,-8,-8))bn=L(bn)local bo=self:C(bp)if M(bn,bo)~=0xFFFFFFFF then return nil,-2 end;return bp end;return a
