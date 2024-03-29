#!/usr/bin/env lua
package.preload['optlex']=(function(...)
local h=_G
local u=require"string"
module"optlex"
local i=u.match
local e=u.sub
local d=u.find
local l=u.rep
local c
error=h.error
warn={}
local n,o,r
local w={
TK_KEYWORD=true,
TK_NAME=true,
TK_NUMBER=true,
TK_STRING=true,
TK_LSTRING=true,
TK_OP=true,
TK_EOS=true,
}
local y={
TK_COMMENT=true,
TK_LCOMMENT=true,
TK_EOL=true,
TK_SPACE=true,
}
local s
local function q(e)
local t=n[e-1]
if e<=1 or t=="TK_EOL"then
return true
elseif t==""then
return q(e-1)
end
return false
end
local function g(e)
local t=n[e+1]
if e>=#n or t=="TK_EOL"or t=="TK_EOS"then
return true
elseif t==""then
return g(e+1)
end
return false
end
local function A(t)
local a=#i(t,"^%-%-%[=*%[")
local a=e(t,a+1,-(a-1))
local e,t=1,0
while true do
local a,n,i,o=d(a,"([\r\n])([\r\n]?)",e)
if not a then break end
e=a+1
t=t+1
if#o>0 and i~=o then
e=e+1
end
end
return t
end
local function k(h,s)
local a=i
local t,e=n[h],n[s]
if t=="TK_STRING"or t=="TK_LSTRING"or
e=="TK_STRING"or e=="TK_LSTRING"then
return""
elseif t=="TK_OP"or e=="TK_OP"then
if(t=="TK_OP"and(e=="TK_KEYWORD"or e=="TK_NAME"))or
(e=="TK_OP"and(t=="TK_KEYWORD"or t=="TK_NAME"))then
return""
end
if t=="TK_OP"and e=="TK_OP"then
local t,e=o[h],o[s]
if(a(t,"^%.%.?$")and a(e,"^%."))or
(a(t,"^[~=<>]$")and e=="=")or
(t=="["and(e=="["or e=="="))then
return" "
end
return""
end
local t=o[h]
if e=="TK_OP"then t=o[s]end
if a(t,"^%.%.?%.?$")then
return" "
end
return""
else
return" "
end
end
local function v()
local i,s,a={},{},{}
local e=1
for t=1,#n do
local n=n[t]
if n~=""then
i[e],s[e],a[e]=n,o[t],r[t]
e=e+1
end
end
n,o,r=i,s,a
end
local function T(d)
local t=o[d]
local t=t
local n
if i(t,"^0[xX]")then
local e=h.tostring(h.tonumber(t))
if#e<=#t then
t=e
else
return
end
end
if i(t,"^%d+%.?0*$")then
t=i(t,"^(%d+)%.?0*$")
if t+0>0 then
t=i(t,"^0*([1-9]%d*)$")
local a=#i(t,"0*$")
local o=h.tostring(a)
if a>#o+1 then
t=e(t,1,#t-a).."e"..o
end
n=t
else
n="0"
end
elseif not i(t,"[eE]")then
local a,t=i(t,"^(%d*)%.(%d+)$")
if a==""then a=0 end
if t+0==0 and a==0 then
n="0"
else
local o=#i(t,"0*$")
if o>0 then
t=e(t,1,#t-o)
end
if a+0>0 then
n=a.."."..t
else
n="."..t
local a=#i(t,"^0*")
local a=#t-a
local o=h.tostring(#t)
if a+2+#o<1+#t then
n=e(t,-a).."e-"..o
end
end
end
else
local t,a=i(t,"^([^eE]+)[eE]([%+%-]?%d+)$")
a=h.tonumber(a)
local o,s=i(t,"^(%d*)%.(%d*)$")
if o then
a=a-#s
t=o..s
end
if t+0==0 then
n="0"
else
local o=#i(t,"^0*")
t=e(t,o+1)
o=#i(t,"0*$")
if o>0 then
t=e(t,1,#t-o)
a=a+o
end
local i=h.tostring(a)
if a==0 then
n=t
elseif a>0 and(a<=1+#i)then
n=t..l("0",a)
elseif a<0 and(a>=-#t)then
o=#t+a
n=e(t,1,o).."."..e(t,o+1)
elseif a<0 and(#i>=-a-#t)then
o=-a-#t
n="."..l("0",o)..t
else
n=t.."e"..a
end
end
end
if n and n~=o[d]then
if s then
c("<number> (line "..r[d]..") "..o[d].." -> "..n)
s=s+1
end
o[d]=n
end
end
local function O(m)
local t=o[m]
local h=e(t,1,1)
local f=(h=="'")and'"'or"'"
local t=e(t,2,-2)
local a=1
local l,n=0,0
while a<=#t do
local m=e(t,a,a)
if m=="\\"then
local o=a+1
local r=e(t,o,o)
local s=d("abfnrtv\\\n\r\"\'0123456789",r,1,true)
if not s then
t=e(t,1,a-1)..e(t,o)
a=a+1
elseif s<=8 then
a=a+2
elseif s<=10 then
local i=e(t,o,o+1)
if i=="\r\n"or i=="\n\r"then
t=e(t,1,a).."\n"..e(t,o+2)
elseif s==10 then
t=e(t,1,a).."\n"..e(t,o+1)
end
a=a+2
elseif s<=12 then
if r==h then
l=l+1
a=a+2
else
n=n+1
t=e(t,1,a-1)..e(t,o)
a=a+1
end
else
local i=i(t,"^(%d%d?%d?)",o)
o=a+1+#i
local c=i+0
local s=u.char(c)
local r=d("\a\b\f\n\r\t\v",s,1,true)
if r then
i="\\"..e("abfnrtv",r,r)
elseif c<32 then
i="\\"..c
elseif s==h then
i="\\"..s
l=l+1
elseif s=="\\"then
i="\\\\"
else
i=s
if s==f then
n=n+1
end
end
t=e(t,1,a-1)..i..e(t,o)
a=a+#i
end
else
a=a+1
if m==f then
n=n+1
end
end
end
if l>n then
a=1
while a<=#t do
local o,n,i=d(t,"([\'\"])",a)
if not o then break end
if i==h then
t=e(t,1,o-2)..e(t,o)
a=o
else
t=e(t,1,o-1).."\\"..e(t,o)
a=o+2
end
end
h=f
end
t=h..t..h
if t~=o[m]then
if s then
c("<string> (line "..r[m]..") "..o[m].." -> "..t)
s=s+1
end
o[m]=t
end
end
local function I(h)
local t=o[h]
local u=i(t,"^%[=*%[")
local a=#u
local c=e(t,-a,-1)
local s=e(t,a+1,-(a+1))
local n=""
local t=1
while true do
local a,o,l,d=d(s,"([\r\n])([\r\n]?)",t)
local o
if not a then
o=e(s,t)
elseif a>=t then
o=e(s,t,a-1)
end
if o~=""then
if i(o,"%s+$")then
warn.lstring="trailing whitespace in long string near line "..r[h]
end
n=n..o
end
if not a then
break
end
t=a+1
if a then
if#d>0 and l~=d then
t=t+1
end
if not(t==1 and t==a)then
n=n.."\n"
end
end
end
if a>=3 then
local e,t=a-1
while e>=2 do
local a="%]"..l("=",e-2).."%]"
if not i(n,a)then t=e end
e=e-1
end
if t then
a=l("=",t-2)
u,c="["..a.."[","]"..a.."]"
end
end
o[h]=u..n..c
end
local function p(r)
local a=o[r]
local h=i(a,"^%-%-%[=*%[")
local t=#h
local u=e(a,-t,-1)
local s=e(a,t+1,-(t-1))
local n=""
local a=1
while true do
local o,t,r,h=d(s,"([\r\n])([\r\n]?)",a)
local t
if not o then
t=e(s,a)
elseif o>=a then
t=e(s,a,o-1)
end
if t~=""then
local a=i(t,"%s*$")
if#a>0 then t=e(t,1,-(a+1))end
n=n..t
end
if not o then
break
end
a=o+1
if o then
if#h>0 and r~=h then
a=a+1
end
n=n.."\n"
end
end
t=t-2
if t>=3 then
local e,a=t-1
while e>=2 do
local t="%]"..l("=",e-2).."%]"
if not i(n,t)then a=e end
e=e-1
end
if a then
t=l("=",a-2)
h,u="--["..t.."[","]"..t.."]"
end
end
o[r]=h..n..u
end
local function j(n)
local t=o[n]
local a=i(t,"%s*$")
if#a>0 then
t=e(t,1,-(a+1))
end
o[n]=t
end
local function E(o,a)
if not o then return false end
local t=i(a,"^%-%-%[=*%[")
local t=#t
local i=e(a,-t,-1)
local e=e(a,t+1,-(t-1))
if d(e,o,1,true)then
return true
end
end
function optimize(t,d,i,a)
local m=t["opt-comments"]
local u=t["opt-whitespace"]
local f=t["opt-emptylines"]
local b=t["opt-eols"]
local x=t["opt-strings"]
local z=t["opt-numbers"]
local _=t.KEEP
s=t.DETAILS and 0
c=c or h.print
if b then
m=true
u=true
f=true
end
n,o,r
=d,i,a
local t=1
local a,d
local h
local function i(a,i,e)
e=e or t
n[e]=a or""
o[e]=i or""
end
while true do
a,d=n[t],o[t]
local s=q(t)
if s then h=nil end
if a=="TK_EOS"then
break
elseif a=="TK_KEYWORD"or
a=="TK_NAME"or
a=="TK_OP"then
h=t
elseif a=="TK_NUMBER"then
if z then
T(t)
end
h=t
elseif a=="TK_STRING"or
a=="TK_LSTRING"then
if x then
if a=="TK_STRING"then
O(t)
else
I(t)
end
end
h=t
elseif a=="TK_COMMENT"then
if m then
if t==1 and e(d,1,1)=="#"then
j(t)
else
i()
end
elseif u then
j(t)
end
elseif a=="TK_LCOMMENT"then
if E(_,d)then
if u then
p(t)
end
h=t
elseif m then
local e=A(d)
if y[n[t+1]]then
i()
a=""
else
i("TK_SPACE"," ")
end
if not f and e>0 then
i("TK_EOL",l("\n",e))
end
if u and a~=""then
t=t-1
end
else
if u then
p(t)
end
h=t
end
elseif a=="TK_EOL"then
if s and f then
i()
elseif d=="\r\n"or d=="\n\r"then
i("TK_EOL","\n")
end
elseif a=="TK_SPACE"then
if u then
if s or g(t)then
i()
else
local a=n[h]
if a=="TK_LCOMMENT"then
i()
else
local e=n[t+1]
if y[e]then
if(e=="TK_COMMENT"or e=="TK_LCOMMENT")and
a=="TK_OP"and o[h]=="-"then
else
i()
end
else
local e=k(h,t+1)
if e==""then
i()
else
i("TK_SPACE"," ")
end
end
end
end
end
else
error("unidentified token encountered")
end
t=t+1
end
v()
if b then
t=1
if n[1]=="TK_COMMENT"then
t=3
end
while true do
a,d=n[t],o[t]
if a=="TK_EOS"then
break
elseif a=="TK_EOL"then
local e,a=n[t-1],n[t+1]
if w[e]and w[a]then
local e=k(t-1,t+1)
if e==""then
i()
end
end
end
t=t+1
end
v()
end
if s and s>0 then c()end
return n,o,r
end
end)
package.preload['optparser']=(function(...)
local e=_G
local a=require"string"
local l=require"table"
module"optparser"
local s="etaoinshrdlucmfwypvbgkqjxz_ETAOINSHRDLUCMFWYPVBGKQJXZ"
local r="etaoinshrdlucmfwypvbgkqjxz_0123456789ETAOINSHRDLUCMFWYPVBGKQJXZ"
local w={}
for e in a.gmatch([[
and break do else elseif end false for function if in
local nil not or repeat return then true until while
self]],"%S+")do
w[e]=true
end
local h,u,
c,o,
m,y,
d,
n
local function f(e)
local o={}
for n=1,#e do
local e=e[n]
local i=e.name
if not o[i]then
o[i]={
decl=0,token=0,size=0,
}
end
local t=o[i]
t.decl=t.decl+1
local o=e.xref
local a=#o
t.token=t.token+a
t.size=t.size+a*#i
if e.decl then
e.id=n
e.xcount=a
if a>1 then
e.first=o[2]
e.last=o[a]
end
else
t.id=n
end
end
return o
end
local function p(e)
local i=a.byte
local n=a.char
local a={
TK_KEYWORD=true,TK_NAME=true,TK_NUMBER=true,
TK_STRING=true,TK_LSTRING=true,
}
if not e["opt-comments"]then
a.TK_COMMENT=true
a.TK_LCOMMENT=true
end
local e={}
for t=1,#h do
e[t]=u[t]
end
for t=1,#o do
local t=o[t]
local a=t.xref
for t=1,t.xcount do
local t=a[t]
e[t]=""
end
end
local t={}
for e=0,255 do t[e]=0 end
for o=1,#h do
local o,e=h[o],e[o]
if a[o]then
for a=1,#e do
local e=i(e,a)
t[e]=t[e]+1
end
end
end
local function a(a)
local e={}
for o=1,#a do
local a=i(a,o)
e[o]={c=a,freq=t[a],}
end
l.sort(e,
function(t,e)
return t.freq>e.freq
end
)
local a={}
for t=1,#e do
a[t]=n(e[t].c)
end
return l.concat(a)
end
s=a(s)
r=a(r)
end
local function v()
local t
local n,h=#s,#r
local e=d
if e<n then
e=e+1
t=a.sub(s,e,e)
else
local o,i=n,1
repeat
e=e-o
o=o*h
i=i+1
until o>e
local o=e%n
e=(e-o)/n
o=o+1
t=a.sub(s,o,o)
while i>1 do
local o=e%h
e=(e-o)/h
o=o+1
t=t..a.sub(r,o,o)
i=i-1
end
end
d=d+1
return t,m[t]~=nil
end
function optimize(e,s,i,t,a)
h,u,c,o
=s,i,t,a
d=0
n={}
m=f(c)
y=f(o)
if e["opt-entropy"]then
p(e)
end
local e={}
for t=1,#o do
e[t]=o[t]
end
l.sort(e,
function(t,e)
return t.xcount>e.xcount
end
)
local a,t,r={},1,false
for o=1,#e do
local e=e[o]
if not e.isself then
a[t]=e
t=t+1
else
r=true
end
end
e=a
local h=#e
while h>0 do
local s,t
repeat
s,t=v()
until not w[s]
n[#n+1]=s
local a=h
if t then
local i=c[m[s].id].xref
local n=#i
for t=1,h do
local t=e[t]
local s,e=t.act,t.rem
while e<0 do
e=o[-e].rem
end
local o
for t=1,n do
local t=i[t]
if t>=s and t<=e then o=true end
end
if o then
t.skip=true
a=a-1
end
end
end
while a>0 do
local t=1
while e[t].skip do
t=t+1
end
a=a-1
local i=e[t]
t=t+1
i.newname=s
i.skip=true
i.done=true
local s,r=i.first,i.last
local h=i.xref
if s and a>0 then
local n=a
while n>0 do
while e[t].skip do
t=t+1
end
n=n-1
local e=e[t]
t=t+1
local n,t=e.act,e.rem
while t<0 do
t=o[-t].rem
end
if not(r<n or s>t)then
if n>=i.act then
for o=1,i.xcount do
local o=h[o]
if o>=n and o<=t then
a=a-1
e.skip=true
break
end
end
else
if e.last and e.last>=i.act then
a=a-1
e.skip=true
end
end
end
if a==0 then break end
end
end
end
local a,t={},1
for o=1,h do
local e=e[o]
if not e.done then
e.skip=false
a[t]=e
t=t+1
end
end
e=a
h=#e
end
for e=1,#o do
local e=o[e]
local a=e.xref
if e.newname then
for t=1,e.xcount do
local t=a[t]
u[t]=e.newname
end
e.name,e.oldname
=e.newname,e.name
else
e.oldname=e.name
end
end
if r then
n[#n+1]="self"
end
local e=f(o)
end
end)
package.preload['llex']=(function(...)
local m=_G
local h=require"string"
module"llex"
local d=h.find
local u=h.match
local i=h.sub
local f={}
for e in h.gmatch([[
and break do else elseif end false for function if in
local nil not or repeat return then true until while]],"%S+")do
f[e]=true
end
local e,
r,
a,
n,
s
local function o(t,a)
local e=#tok+1
tok[e]=t
seminfo[e]=a
tokln[e]=s
end
local function l(t,h)
local n=i
local i=n(e,t,t)
t=t+1
local e=n(e,t,t)
if(e=="\n"or e=="\r")and(e~=i)then
t=t+1
i=i..e
end
if h then o("TK_EOL",i)end
s=s+1
a=t
return t
end
function init(i,t)
e=i
r=t
a=1
s=1
tok={}
seminfo={}
tokln={}
local i,n,e,t=d(e,"^(#[^\r\n]*)(\r?\n?)")
if i then
a=a+#e
o("TK_COMMENT",e)
if#t>0 then l(a,true)end
end
end
function chunkid()
if r and u(r,"^[=@]")then
return i(r,2)
end
return"[string]"
end
function errorline(a,e)
local t=error or m.error
t(h.format("%s:%d: %s",chunkid(),e or s,a))
end
local r=errorline
local function c(t)
local i=i
local n=i(e,t,t)
t=t+1
local o=#u(e,"=*",t)
t=t+o
a=t
return(i(e,t,t)==n)and o or(-o)-1
end
local function w(u,s)
local t=a+1
local i=i
local o=i(e,t,t)
if o=="\r"or o=="\n"then
t=l(t)
end
local o=t
while true do
local o,d,h=d(e,"([\r\n%]])",t)
if not o then
r(u and"unfinished long string"or
"unfinished long comment")
end
t=o
if h=="]"then
if c(t)==s then
n=i(e,n,a)
a=a+1
return n
end
t=a
else
n=n.."\n"
t=l(t)
end
end
end
local function y(u)
local t=a
local s=d
local h=i
while true do
local i,d,o=s(e,"([\n\r\\\"\'])",t)
if i then
if o=="\n"or o=="\r"then
r("unfinished string")
end
t=i
if o=="\\"then
t=t+1
o=h(e,t,t)
if o==""then break end
i=s("abfnrtv\n\r",o,1,true)
if i then
if i>7 then
t=l(t)
else
t=t+1
end
elseif s(o,"%D")then
t=t+1
else
local o,e,a=s(e,"^(%d%d?%d?)",t)
t=e+1
if a+1>256 then
r("escape sequence too large")
end
end
else
t=t+1
if o==u then
a=t
return h(e,n,t-1)
end
end
else
break
end
end
r("unfinished string")
end
function llex()
local h=d
local d=u
while true do
local t=a
while true do
local u,p,s=h(e,"^([_%a][_%w]*)",t)
if u then
a=t+#s
if f[s]then
o("TK_KEYWORD",s)
else
o("TK_NAME",s)
end
break
end
local s,f,u=h(e,"^(%.?)%d",t)
if s then
if u=="."then t=t+1 end
local u,n,l=h(e,"^%d*[%.%d]*([eE]?)",t)
t=n+1
if#l==1 then
if d(e,"^[%+%-]",t)then
t=t+1
end
end
local n,t=h(e,"^[_%w]*",t)
a=t+1
local e=i(e,s,t)
if not m.tonumber(e)then
r("malformed number")
end
o("TK_NUMBER",e)
break
end
local m,u,f,s=h(e,"^((%s)[ \t\v\f]*)",t)
if m then
if s=="\n"or s=="\r"then
l(t,true)
else
a=u+1
o("TK_SPACE",f)
end
break
end
local s=d(e,"^%p",t)
if s then
n=t
local l=h("-[\"\'.=<>~",s,1,true)
if l then
if l<=2 then
if l==1 then
local r=d(e,"^%-%-(%[?)",t)
if r then
t=t+2
local s=-1
if r=="["then
s=c(t)
end
if s>=0 then
o("TK_LCOMMENT",w(false,s))
else
a=h(e,"[\n\r]",t)or(#e+1)
o("TK_COMMENT",i(e,n,a-1))
end
break
end
else
local e=c(t)
if e>=0 then
o("TK_LSTRING",w(true,e))
elseif e==-1 then
o("TK_OP","[")
else
r("invalid long string delimiter")
end
break
end
elseif l<=5 then
if l<5 then
a=t+1
o("TK_STRING",y(s))
break
end
s=d(e,"^%.%.?%.?",t)
else
s=d(e,"^%p=?",t)
end
end
a=t+#s
o("TK_OP",s)
break
end
local e=i(e,t,t)
if e~=""then
a=t+1
o("TK_OP",e)
break
end
o("TK_EOS","")
return
end
end
end
return m.getfenv()
end)
package.preload['lparser']=(function(...)
local L=_G
local b=require"string"
module"lparser"
local F=L.getfenv()
local z,
g,
A,
H,
l,
d,
U,
t,j,n,m,
y,
a,
M,
x,
S,
s,
v,
_
local w,h,p,T,E,k
local e=b.gmatch
local D={}
for e in e("else elseif end until <eof>","%S+")do
D[e]=true
end
local W={}
for e in e("if while do for repeat function local return break","%S+")do
W[e]=e.."_stat"
end
local R={}
local Y={}
for e,a,t in e([[
{+ 6 6}{- 6 6}{* 7 7}{/ 7 7}{% 7 7}
{^ 10 9}{.. 5 4}
{~= 3 3}{== 3 3}
{< 3 3}{<= 3 3}{> 3 3}{>= 3 3}
{and 2 2}{or 1 1}
]],"{(%S+)%s(%d+)%s(%d+)}")do
R[e]=a+0
Y[e]=t+0
end
local X={["not"]=true,["-"]=true,
["#"]=true,}
local Z=8
local function o(e,t)
local a=error or L.error
a(b.format("(source):%d: %s",t or n,e))
end
local function e()
U=A[l]
t,j,n,m
=z[l],g[l],A[l],H[l]
l=l+1
end
local function ee()
return z[l]
end
local function u(a)
local e=t
if e~="<number>"and e~="<string>"then
if e=="<name>"then e=j end
e="'"..e.."'"
end
o(a.." near "..e)
end
local function c(e)
u("'"..e.."' expected")
end
local function i(a)
if t==a then e();return true end
end
local function N(e)
if t~=e then c(e)end
end
local function o(t)
N(t);e()
end
local function C(e,t)
if not e then u(t)end
end
local function r(e,a,t)
if not i(e)then
if t==n then
c(e)
else
u("'"..e.."' expected (to close '"..a.."' at line "..t..")")
end
end
end
local function f()
N("<name>")
local t=j
y=m
e()
return t
end
local function I(e,t)
e.k="VK"
end
local function O(e)
I(e,f())
end
local function c(i,o)
local e=a.bl
local t
if e then
t=e.locallist
else
t=a.locallist
end
local e=#s+1
s[e]={
name=i,
xref={y},
decl=y,
}
if o then
s[e].isself=true
end
local a=#v+1
v[a]=e
_[a]=t
end
local function q(e)
local t=#v
while e>0 do
e=e-1
local e=t-e
local a=v[e]
local t=s[a]
local o=t.name
t.act=m
v[e]=nil
local i=_[e]
_[e]=nil
local e=i[o]
if e then
t=s[e]
t.rem=-a
end
i[o]=a
end
end
local function B()
local t=a.bl
local e
if t then
e=t.locallist
else
e=a.locallist
end
for t,e in L.pairs(e)do
local e=s[e]
e.rem=m
end
end
local function m(e,t)
if b.sub(e,1,1)=="("then
return
end
c(e,t)
end
local function L(o,a)
local t=o.bl
local e
if t then
e=t.locallist
while e do
if e[a]then return e[a]end
t=t.prev
e=t and t.locallist
end
end
e=o.locallist
return e[a]or-1
end
local function b(t,o,e)
if t==nil then
e.k="VGLOBAL"
return"VGLOBAL"
else
local a=L(t,o)
if a>=0 then
e.k="VLOCAL"
e.id=a
return"VLOCAL"
else
if b(t.prev,o,e)=="VGLOBAL"then
return"VGLOBAL"
end
e.k="VUPVAL"
return"VUPVAL"
end
end
end
local function J(o)
local t=f()
b(a,t,o)
if o.k=="VGLOBAL"then
local e=S[t]
if not e then
e=#x+1
x[e]={
name=t,
xref={y},
}
S[t]=e
else
local e=x[e].xref
e[#e+1]=y
end
else
local e=o.id
local e=s[e].xref
e[#e+1]=y
end
end
local function y(t)
local e={}
e.isbreakable=t
e.prev=a.bl
e.locallist={}
a.bl=e
end
local function b()
local e=a.bl
B()
a.bl=e.prev
end
local function P()
local e
if not a then
e=M
else
e={}
end
e.prev=a
e.bl=nil
e.locallist={}
a=e
end
local function V()
B()
a=a.prev
end
local function L(t)
local a={}
e()
O(a)
t.k="VINDEXED"
end
local function K(t)
e()
h(t)
o("]")
end
local function G(e)
local e,a={},{}
if t=="<name>"then
O(e)
else
K(e)
end
o("=")
h(a)
end
local function B(e)
if e.v.k=="VVOID"then return end
e.v.k="VVOID"
end
local function Q(e)
h(e.v)
end
local function B(a)
local n=n
local e={}
e.v={}
e.t=a
a.k="VRELOCABLE"
e.v.k="VVOID"
o("{")
repeat
if t=="}"then break end
local t=t
if t=="<name>"then
if ee()~="="then
Q(e)
else
G(e)
end
elseif t=="["then
G(e)
else
Q(e)
end
until not i(",")and not i(";")
r("}","{",n)
end
local function Q()
local o=0
if t~=")"then
repeat
local t=t
if t=="<name>"then
c(f())
o=o+1
elseif t=="..."then
e()
a.is_vararg=true
else
u("<name> or '...' expected")
end
until a.is_vararg or not i(",")
end
q(o)
end
local function G(s)
local a={}
local i=n
local o=t
if o=="("then
if i~=U then
u("ambiguous syntax (function call x new statement)")
end
e()
if t==")"then
a.k="VVOID"
else
w(a)
end
r(")","(",i)
elseif o=="{"then
B(a)
elseif o=="<string>"then
I(a,j)
e()
else
u("function arguments expected")
return
end
s.k="VCALL"
end
local function ee(a)
local t=t
if t=="("then
local t=n
e()
h(a)
r(")","(",t)
elseif t=="<name>"then
J(a)
else
u("unexpected symbol")
end
end
local function U(a)
ee(a)
while true do
local t=t
if t=="."then
L(a)
elseif t=="["then
local e={}
K(e)
elseif t==":"then
local t={}
e()
O(t)
G(a)
elseif t=="("or t=="<string>"or t=="{"then
G(a)
else
return
end
end
end
local function O(o)
local t=t
if t=="<number>"then
o.k="VKNUM"
elseif t=="<string>"then
I(o,j)
elseif t=="nil"then
o.k="VNIL"
elseif t=="true"then
o.k="VTRUE"
elseif t=="false"then
o.k="VFALSE"
elseif t=="..."then
C(a.is_vararg==true,
"cannot use '...' outside a vararg function");
o.k="VVARARG"
elseif t=="{"then
B(o)
return
elseif t=="function"then
e()
E(o,false,n)
return
else
U(o)
return
end
e()
end
local function j(o,i)
local a=t
local n=X[a]
if n then
e()
j(o,Z)
else
O(o)
end
a=t
local t=R[a]
while t and t>i do
local o={}
e()
local e=j(o,Y[a])
a=e
t=R[a]
end
return a
end
function h(e)
j(e,0)
end
local function O(e)
local t={}
local e=e.v.k
C(e=="VLOCAL"or e=="VUPVAL"or e=="VGLOBAL"
or e=="VINDEXED","syntax error")
if i(",")then
local e={}
e.v={}
U(e.v)
O(e)
else
o("=")
w(t)
return
end
t.k="VNONRELOC"
end
local function j(e,t)
o("do")
y(false)
q(e)
p()
b()
end
local function I(e)
local t=d
m("(for index)")
m("(for limit)")
m("(for step)")
c(e)
o("=")
T()
o(",")
T()
if i(",")then
T()
else
end
j(1,true)
end
local function R(e)
local t={}
m("(for generator)")
m("(for state)")
m("(for control)")
c(e)
local e=1
while i(",")do
c(f())
e=e+1
end
o("in")
local a=d
w(t)
j(e,false)
end
local function Y(e)
local a=false
J(e)
while t=="."do
L(e)
end
if t==":"then
a=true
L(e)
end
return a
end
function T()
local e={}
h(e)
end
local function j()
local e={}
h(e)
end
local function T()
e()
j()
o("then")
p()
end
local function C()
local e,t={}
c(f())
e.k="VLOCAL"
q(1)
E(t,false,n)
end
local function L()
local e=0
local t={}
repeat
c(f())
e=e+1
until not i(",")
if i("=")then
w(t)
else
t.k="VVOID"
end
q(e)
end
function w(e)
h(e)
while i(",")do
h(e)
end
end
function E(a,t,e)
P()
o("(")
if t then
m("self",true)
q(1)
end
Q()
o(")")
k()
r("end","function",e)
V()
end
function p()
y(false)
k()
b()
end
function for_stat()
local o=d
y(true)
e()
local a=f()
local e=t
if e=="="then
I(a)
elseif e==","or e=="in"then
R(a)
else
u("'=' or 'in' expected")
end
r("end","for",o)
b()
end
function while_stat()
local t=d
e()
j()
y(true)
o("do")
p()
r("end","while",t)
b()
end
function repeat_stat()
local t=d
y(true)
y(false)
e()
k()
r("until","repeat",t)
j()
b()
b()
end
function if_stat()
local a=d
local o={}
T()
while t=="elseif"do
T()
end
if t=="else"then
e()
p()
end
r("end","if",a)
end
function return_stat()
local a={}
e()
local e=t
if D[e]or e==";"then
else
w(a)
end
end
function break_stat()
local t=a.bl
e()
while t and not t.isbreakable do
t=t.prev
end
if not t then
u("no loop to break")
end
end
function expr_stat()
local e={}
e.v={}
U(e.v)
if e.v.k=="VCALL"then
else
e.prev=nil
O(e)
end
end
function function_stat()
local o=d
local a,t={},{}
e()
local e=Y(a)
E(t,e,o)
end
function do_stat()
local t=d
e()
p()
r("end","do",t)
end
function local_stat()
e()
if i("function")then
C()
else
L()
end
end
local function o()
d=n
local e=t
local t=W[e]
if t then
F[t]()
if e=="return"or e=="break"then return true end
else
expr_stat()
end
return false
end
function k()
local e=false
while not e and not D[t]do
e=o()
i(";")
end
end
function parser()
P()
a.is_vararg=true
e()
k()
N("<eof>")
V()
return x,s
end
function init(e,o,n)
l=1
M={}
local t=1
z,g,A,H={},{},{},{}
for a=1,#e do
local e=e[a]
local i=true
if e=="TK_KEYWORD"or e=="TK_OP"then
e=o[a]
elseif e=="TK_NAME"then
e="<name>"
g[t]=o[a]
elseif e=="TK_NUMBER"then
e="<number>"
g[t]=0
elseif e=="TK_STRING"or e=="TK_LSTRING"then
e="<string>"
g[t]=""
elseif e=="TK_EOS"then
e="<eof>"
else
i=false
end
if i then
z[t]=e
A[t]=n[a]
H[t]=a
t=t+1
end
end
x,S,s={},{},{}
v,_={},{}
end
return F
end)
package.preload['minichunkspy']=(function(...)
local c,t,u=string,table,math
local a,w,n,e=ipairs,setmetatable,type,assert
local a=__END_OF_GLOBALS__
local m,f,d=c.char,c.byte,c.sub
local z,h,_=u.frexp,u.ldexp,u.abs
local v=t.concat
local a=u.huge
local E=a-a
local o=false
local s=4
local l=4
local r=8
local t={}
local function p()
t[#t+1]
={o,s,l,r}
end
local function y()
o,s,l,r
=unpack(t[#t])
t[#t]=nil
end
local function t(e,t)
return e.new(e,t)
end
local i={}
local t=t{
new=
function(e,a)
local a=a or{}
local t=i[e]or{
__index=e,
__call=t
}
i[e]=t
return w(a,t)
end,
}
local x=t{
unpack=function(t,t,e)return nil,e end,
pack=function(e,e)return""end
}
local i={}
local function b(e)
local t=i[e]or t{
unpack=function(o,a,t)
return d(a,t,t+e-1),t+e
end,
pack=function(a,t)return d(t,1,e)end
}
i[e]=t
return t
end
local j=t{
unpack=function(a,t,e)
return f(t,e,e),e+1
end,
pack=function(t,e)return m(e)end
}
local i=t{
unpack=
function(t,e,n)
local i,a,t,e=f(e,n,n+3)
if o then i,a,t,e=e,t,a,i end
return i+a*256+t*256^2+e*256^3,n+4
end,
pack=
function(t,s)
e(n(s)=="number",
"unexpected value type to pack as an uint32")
local i,a,t,e
e=s%2^32
i=e%256;e=(e-i)/256
a=e%256;e=(e-a)/256
t=e%256;e=(e-t)/256
if o then i,a,t,e=e,t,a,i end
return m(i,a,t,e)
end
}
local q=t{
unpack=
function(t,e,a)
local t=i:unpack(e,a)
local e=i:unpack(e,a+4)
if o then t,e=e,t end
return t+e*2^32,a+8
end,
pack=
function(a,t)
e(n(t)=="number",
"unexpected value type to pack as an uint64")
local e=t%2^32
local t=(t-e)/2^32
if o then e,t=t,e end
return i:pack(e)..i:pack(t)
end
}
local function k(e,a)
local t=i:unpack(e,a)
local e=i:unpack(e,a+4)
if o then t,e=e,t end
local a=e%2^20
local t=t
local o=t+a*2^32
e=(e-a)/2^20
local t=e%2^11
local e=e<=t and 1 or-1
return e,t,o
end
local function m(n,a,t)
local e=t%2^32
local t=(t-e)/2^32
local e=e
local t=((n<0 and 2^11 or 0)+a)*2^20+t
if o then e,t=t,e end
return i.pack(nil,e)..i.pack(nil,t)
end
local function w(e)
if e~=e then return e end
if e==0 then e=1/e end
return e>0 and 1 or-1
end
local d=h(1,-1022-52)
local f=d*2^52
local g=h(2^52-1,-1022-52)
local f=h(2^53-1,1023-52)
e(d~=0 and d/2==0)
e(f~=a)
e(f*2==a)
local h=t{
unpack=
function(t,e,i)
local n,t,o=k(e,i)
local e
if t==0 then
e=h(o,-1022-52)
elseif t==2047 then
e=o==0 and a or E
else
e=h(2^52+o,t-1023-52)
end
e=n*e
return e,i+8
end,
pack=
function(t,e)
if e~=e then
return m(1,2047,2^52-1)
end
local o=w(e)
e=_(e)
if e==a then return m(o,2047,0)end
if e==0 then return m(o,0,0)end
local a,t
if e<=g then
a=0
t=e/d
else
local e,o=z(e)
t=(2*e-1)*2^52
a=o+1022
end
return m(o,a,t)
end
}
local a=j
local d={
[4]=i,
[8]=q
}
local w={
[4]=float,
[8]=h
}
local m=t{
unpack=function(a,e,t)
return d[s]:unpack(e,t)
end,
pack=function(t,e)
return d[s]:pack(e)
end,
}
local i=t{
unpack=function(a,t,e)
return d[l]:unpack(t,e)
end,
pack=function(t,e)
return d[l]:pack(e)
end,
}
local k=t{
unpack=function(a,t,e)
return w[r]:unpack(t,e)
end,
pack=function(t,e)
return w[r]:pack(e)
end,
}
local g=b(4)
local f=t{
unpack=
function(a,s,t)
local i={}
local e,o=1,1
while a[e]do
local n=a[e]
local a=n.name
if not a then a,o=o,o+1 end
i[a],t=n:unpack(s,t)
e=e+1
end
return i,t
end,
pack=
function(t,n)
local i={}
local e,a=1,1
while t[e]do
local o=t[e]
local t=o.name
if not t then t,a=a,a+1 end
i[e]=o:pack(n[t])
e=e+1
end
return v(i)
end
}
local h=t{
unpack=
function(o,t,e)
local i,e=i:unpack(t,e)
local a={}
local n=o.type
for o=1,i do
a[o],e=n:unpack(t,e)
end
return a,e
end,
pack=
function(o,a)
local t=#a
local e={i:pack(t)}
local o=o.type
for t=1,t do
e[#e+1]=o:pack(a[t])
end
return v(e)
end
}
local v=t{
unpack=
function(o,t,a)
local t,a=i:unpack(t,a)
e(t==0 or t==1,
"unpacked an unexpected value "..t.." for a Boolean")
return t==1,a
end,
pack=
function(a,t)
e(n(t)=="boolean",
"unexpected value type to pack as a Boolean")
return i:pack(t and 1 or 0)
end
}
local m=t{
unpack=
function(t,a,e)
local e,t=m:unpack(a,e)
local o=nil
if e>0 then
local e=e-1
o=a:sub(t,t+e-1)
end
return o,t+e
end,
pack=
function(a,t)
e(n(t)=="nil"or n(t)=="string",
"unexpected value type to pack as a String")
if t==nil then
return m:pack(0)
end
return m:pack(#t+1)..t.."\000"
end
}
local b=f{
b(4){name="signature"},
a{name="version"},
a{name="format"},
a{name="endianness"},
a{name="sizeof_int"},
a{name="sizeof_size_t"},
a{name="sizeof_insn"},
a{name="sizeof_Number"},
a{name="integral_flag"},
}
local v={
[0]=x,
[1]=v,
[3]=k,
[4]=m,
}
local v=t{
unpack=
function(i,o,t)
local t,i=a:unpack(o,t)
local a=v[t]
e(a,"unknown constant type "..t.." to unpack")
local a,o=a:unpack(o,i)
if t==3 then
e(n(a)=="number")
end
return{
type=t,
value=a
},o
end,
pack=
function(t,e)
local e,t=e.type,e.value
return a:pack(e)..v[e]:pack(t)
end
}
local k=f{
m{name="name"},
i{name="startpc"},
i{name="endpc"}
}
local a=f{
m{name="name"},
i{name="line"},
i{name="last_line"},
a{name="num_upvalues"},
a{name="num_parameters"},
a{name="is_vararg"},
a{name="max_stack_size"},
h{name="insns",type=g},
h{name="constants",type=v},
h{name="prototypes",type=nil},
h{name="source_lines",type=i},
h{name="locals",type=k},
h{name="upvalues",type=m},
}
e(a[10].name=="prototypes",
"missed the function prototype list")
a[10].type=a
local a=t{
unpack=
function(i,h,t)
local i={}
local t,n=b:unpack(h,t)
e(t.signature=="\027Lua","signature check failed")
e(t.version==81,"version mismatch")
e(t.format==0,"format mismatch")
e(t.endianness==0 or
t.endianness==1,"endianness mismatch")
e(d[t.sizeof_int],"int size unsupported")
e(d[t.sizeof_size_t],"size_t size unsupported")
e(t.sizeof_insn==4,"insn size unsupported")
e(w[t.sizeof_Number],"number size unsupported")
e(t.integral_flag==0,"integral flag mismatch; only floats supported")
p()
o=t.endianness==0
s=t.sizeof_size_t
l=t.sizeof_int
r=t.sizeof_Number
i.header=t
i.body,n=a:unpack(h,n)
y()
return i,n
end,
pack=
function(e,t)
local i
p()
local e=t.header
o=e.endianness==0
s=e.sizeof_size_t
l=e.sizeof_int
r=e.sizeof_Number
i=b:pack(t.header)..a:pack(t.body)
y()
return i
end
}
local function o(e)
if n(e)=="function"then
return o(c.dump(e))
end
local t=a:unpack(e,1)
local a=a:pack(t)
if e==a then return true end
local t
local t=u.min(#e,#a)
for t=1,t do
local a=e:sub(t,t)
local e=e:sub(t,t)
if a~=e then
return false,("chunk roundtripping failed: "..
"first byte difference at index %d"):format(t)
end
end
return false,("chunk round tripping failed: "..
"original length %d vs. %d"):format(#e,#a)
end
return{
disassemble=function(e)return a:unpack(e,1)end,
assemble=function(e)return a:pack(e)end,
validate=o
}
end)
do local e={};
e["vio"]="local vio = {};\
vio.__index = vio; \
	\
function vio.open(string)\
	return setmetatable({ pos = 1, data = string }, vio);\
end\
\
function vio:read(format, ...)\
	if self.pos >= #self.data then return; end\
	if format == \"*a\" then\
		local oldpos = self.pos;\
		self.pos = #self.data;\
		return self.data:sub(oldpos, self.pos);\
	elseif format == \"*l\" then\
		local data;\
		data, self.pos = self.data:match(\"([^\\r\\n]*)\\r?\\n?()\", self.pos)\
		return data;\
	elseif format == \"*n\" then\
		local data;\
		data, self.pos = self.data:match(\"(%d+)()\", self.pos)\
		return tonumber(data);	\
	elseif type(format) == \"number\" then\
		local oldpos = self.pos;\
		self.pos = self.pos + format;\
		return self.data:sub(oldpos, self.pos-1);\
	end\
end\
\
function vio:seek(whence, offset)\
	if type(whence) == \"number\" then\
		whence, offset = \"cur\", whence;\
	end\
	offset = offset or 0;\
	\
	if whence == \"cur\" then\
		self.pos = self.pos + offset;\
	elseif whence == \"set\" then\
		self.pos = offset + 1;\
	elseif whence == \"end\" then\
		self.pos = #self.data - offset;\
	end\
	\
	return self.pos;\
end\
\
local function _readline(f) return f:read(\"*l\"); end\
function vio:lines()\
	return _readline, self;\
end\
\
function vio:write(...)\
	for i=1,select('#', ...) do\
		local dat = tostring(select(i, ...));\
		self.data = self.data:sub(1, self.pos-1)..dat..self.data:sub(self.pos+#dat, -1);\
	end\
end\
\
function vio:close()\
	self.pos, self.data = nil, nil;\
end\
\
"e["gunzip.lua"]="local i,h,b,m,l,d,e,y,r,w,u,v,l,l=assert,error,ipairs,pairs,tostring,type,setmetatable,io,math,table.sort,math.max,string.char,io.open,_G;local function p(n)local l={};local e=e({},l)function l:__index(l)local n=n(l);e[l]=n\
return n\
end\
return e\
end\
local function l(n,l)l=l or 1\
h({n},l+1)end\
local function _(n)local l={}l.outbs=n\
l.wnd={}l.wnd_pos=1\
return l\
end\
local function t(l,e)local n=l.wnd_pos\
l.outbs(e)l.wnd[n]=e\
l.wnd_pos=n%32768+1\
end\
local function n(l)return i(l,'unexpected end of file')end\
local function o(n,l)return n%(l+l)>=l\
end\
local a=p(function(l)return 2^l end)local c=e({},{__mode='k'})local function g(o)local l=1\
local e={}function e:read()local n\
if l<=#o then\
n=o:byte(l)l=l+1\
end\
return n\
end\
return e\
end\
local l\
local function s(d)local n,l,o=0,0,{};function o:nbits_left_in_byte()return l\
end\
function o:read(e)e=e or 1\
while l<e do\
local e=d:read()if not e then return end\
n=n+a[l]*e\
l=l+8\
end\
local o=a[e]local a=n%o\
n=(n-a)/o\
l=l-e\
return a\
end\
c[o]=true\
return o\
end\
local function f(l)return c[l]and l or s(g(l))end\
local function s(l)local n\
if y.type(l)=='file'then\
n=function(n)l:write(v(n))end\
elseif d(l)=='function'then\
n=l\
end\
return n\
end\
local function d(e,o)local l={}if o then\
for e,n in m(e)do\
if n~=0 then\
l[#l+1]={val=e,nbits=n}end\
end\
else\
for n=1,#e-2,2 do\
local o,n,e=e[n],e[n+1],e[n+2]if n~=0 then\
for e=o,e-1 do\
l[#l+1]={val=e,nbits=n}end\
end\
end\
end\
w(l,function(n,l)return n.nbits==l.nbits and n.val<l.val or n.nbits<l.nbits\
end)local e=1\
local o=0\
for n,l in b(l)do\
if l.nbits~=o then\
e=e*a[l.nbits-o]o=l.nbits\
end\
l.code=e\
e=e+1\
end\
local e=r.huge\
local c={}for n,l in b(l)do\
e=r.min(e,l.nbits)c[l.code]=l.val\
end\
local function o(n,e)local l=0\
for e=1,e do\
local e=n%2\
n=(n-e)/2\
l=l*2+e\
end\
return l\
end\
local d=p(function(l)return a[e]+o(l,e)end)function l:read(a)local o,l=1,0\
while 1 do\
if l==0 then\
o=d[n(a:read(e))]l=l+e\
else\
local n=n(a:read())l=l+1\
o=o*2+n\
end\
local l=c[o]if l then\
return l\
end\
end\
end\
return l\
end\
local function b(l)local a=2^1\
local e=2^2\
local c=2^3\
local d=2^4\
local n=l:read(8)local n=l:read(8)local n=l:read(8)local n=l:read(8)local t=l:read(32)local t=l:read(8)local t=l:read(8)if o(n,e)then\
local n=l:read(16)local e=0\
for n=1,n do\
e=l:read(8)end\
end\
if o(n,c)then\
while l:read(8)~=0 do end\
end\
if o(n,d)then\
while l:read(8)~=0 do end\
end\
if o(n,a)then\
l:read(16)end\
end\
local function p(l)local f=l:read(5)local i=l:read(5)local e=n(l:read(4))local a=e+4\
local e={}local o={16,17,18,0,8,7,9,6,10,5,11,4,12,3,13,2,14,1,15}for n=1,a do\
local l=l:read(3)local n=o[n]e[n]=l\
end\
local e=d(e,true)local function r(o)local t={}local a\
local c=0\
while c<o do\
local o=e:read(l)local e\
if o<=15 then\
e=1\
a=o\
elseif o==16 then\
e=3+n(l:read(2))elseif o==17 then\
e=3+n(l:read(3))a=0\
elseif o==18 then\
e=11+n(l:read(7))a=0\
else\
h'ASSERT'end\
for l=1,e do\
t[c]=a\
c=c+1\
end\
end\
local l=d(t,true)return l\
end\
local n=f+257\
local l=i+1\
local n=r(n)local l=r(l)return n,l\
end\
local a\
local o\
local c\
local r\
local function h(e,n,l,d)local l=l:read(e)if l<256 then\
t(n,l)elseif l==256 then\
return true\
else\
if not a then\
local l={[257]=3}local e=1\
for n=258,285,4 do\
for n=n,n+3 do l[n]=l[n-1]+e end\
if n~=258 then e=e*2 end\
end\
l[285]=258\
a=l\
end\
if not o then\
local l={}for e=257,285 do\
local n=u(e-261,0)l[e]=(n-(n%4))/4\
end\
l[285]=0\
o=l\
end\
local a=a[l]local l=o[l]local l=e:read(l)local o=a+l\
if not c then\
local e={[0]=1}local l=1\
for n=1,29,2 do\
for n=n,n+1 do e[n]=e[n-1]+l end\
if n~=1 then l=l*2 end\
end\
c=e\
end\
if not r then\
local n={}for e=0,29 do\
local l=u(e-2,0)n[e]=(l-(l%2))/2\
end\
r=n\
end\
local l=d:read(e)local a=c[l]local l=r[l]local l=e:read(l)local l=a+l\
for e=1,o do\
local l=(n.wnd_pos-1-l)%32768+1\
t(n,i(n.wnd[l],'invalid distance'))end\
end\
return false\
end\
local function u(l,a)local i=l:read(1)local e=l:read(2)local r=0\
local o=1\
local c=2\
local f=3\
if e==r then\
l:read(l:nbits_left_in_byte())local e=l:read(16)local o=n(l:read(16))for e=1,e do\
local l=n(l:read(8))t(a,l)end\
elseif e==o or e==c then\
local n,o\
if e==c then\
n,o=p(l)else\
n=d{0,8,144,9,256,7,280,8,288,nil}o=d{0,5,32,nil}end\
repeat until h(l,a,n,o);end\
return i~=0\
end\
local function e(l)local n,l=f(l.input),_(s(l.output))repeat until u(n,l)end\
return function(n)local l=f(n.input)local n=s(n.output)b(l)e{input=l,output=n}l:read(l:nbits_left_in_byte())l:read()end\
"e["squish.debug"]="package.preload['minichunkspy']=(function(...)local string,table,math=string,table,math\
local ipairs,setmetatable,type,assert=ipairs,setmetatable,type,assert\
local _=__END_OF_GLOBALS__\
local string_char,string_byte,string_sub=string.char,string.byte,string.sub\
local table_concat=table.concat\
local math_abs,math_ldexp,math_frexp=math.abs,math.ldexp,math.frexp\
local Inf=math.huge\
local Nan=Inf-Inf\
local BIG_ENDIAN=false\
local function construct(class,...)return class.new(class,...)end\
local mt_memo={}local Field=construct{new=function(class,self)local self=self or{}local mt=mt_memo[class]or{__index=class,__call=construct}mt_memo[class]=mt\
return setmetatable(self,mt)end,}local None=Field{unpack=function(self,bytes,ix)return nil,ix end,pack=function(self,val)return\"\"end}local char_memo={}local function char(n)local field=char_memo[n]or Field{unpack=function(self,bytes,ix)return string_sub(bytes,ix,ix+n-1),ix+n\
end,pack=function(self,val)return string_sub(val,1,n)end}char_memo[n]=field\
return field\
end\
local uint8=Field{unpack=function(self,bytes,ix)return string_byte(bytes,ix,ix),ix+1\
end,pack=function(self,val)return string_char(val)end}local uint32=Field{unpack=function(self,bytes,ix)local a,b,c,d=string_byte(bytes,ix,ix+3)if BIG_ENDIAN then a,b,c,d=d,c,b,a end\
return a+b*256+c*256^2+d*256^3,ix+4\
end,pack=function(self,val)assert(type(val)==\"number\",\"unexpected value type to pack as an uint32\")local a,b,c,d\
d=val%2^32\
a=d%256;d=(d-a)/256\
b=d%256;d=(d-b)/256\
c=d%256;d=(d-c)/256\
if BIG_ENDIAN then a,b,c,d=d,c,b,a end\
return string_char(a,b,c,d)end}local int32=uint32{unpack=function(self,bytes,ix)local val,ix=uint32:unpack(bytes,ix)return val<2^32 and val or(val-2^31),ix\
end}local Byte=uint8\
local Size_t=uint32\
local Integer=int32\
local Number=char(8)local Insn=char(4)local Struct=Field{unpack=function(self,bytes,ix)local val={}local i,j=1,1\
while self[i]do\
local field=self[i]local key=field.name\
if not key then key,j=j,j+1 end\
val[key],ix=field:unpack(bytes,ix)i=i+1\
end\
return val,ix\
end,pack=function(self,val)local data={}local i,j=1,1\
while self[i]do\
local field=self[i]local key=field.name\
if not key then key,j=j,j+1 end\
data[i]=field:pack(val[key])i=i+1\
end\
return table_concat(data)end}local List=Field{unpack=function(self,bytes,ix)local len,ix=Integer:unpack(bytes,ix)local vals={}local field=self.type\
for i=1,len do\
vals[i],ix=field:unpack(bytes,ix)end\
return vals,ix\
end,pack=function(self,vals)local len=#vals\
local data={Integer:pack(len)}local field=self.type\
for i=1,len do\
data[#data+1]=field:pack(vals[i])end\
return table_concat(data)end}local Boolean=Field{unpack=function(self,bytes,ix)local val,ix=Integer:unpack(bytes,ix)assert(val==0 or val==1,\"unpacked an unexpected value \"..val..\" for a Boolean\")return val==1,ix\
end,pack=function(self,val)assert(type(val)==\"boolean\",\"unexpected value type to pack as a Boolean\")return Integer:pack(val and 1 or 0)end}local String=Field{unpack=function(self,bytes,ix)local len,ix=Integer:unpack(bytes,ix)local val=nil\
if len>0 then\
local string_len=len-1\
val=bytes:sub(ix,ix+string_len-1)end\
return val,ix+len\
end,pack=function(self,val)assert(type(val)==\"nil\"or type(val)==\"string\",\"unexpected value type to pack as a String\")if val==nil then\
return Integer:pack(0)end\
return Integer:pack(#val+1)..val..\"\\0\"end}local ChunkHeader=Struct{char(4){name=\"signature\"},Byte{name=\"version\"},Byte{name=\"format\"},Byte{name=\"endianness\"},Byte{name=\"sizeof_int\"},Byte{name=\"sizeof_size_t\"},Byte{name=\"sizeof_insn\"},Byte{name=\"sizeof_Number\"},Byte{name=\"integral_flag\"},}local ConstantTypes={[0]=None,[1]=Boolean,[3]=Number,[4]=String,}local Constant=Field{unpack=function(self,bytes,ix)local t,ix=Byte:unpack(bytes,ix)local field=ConstantTypes[t]assert(field,\"unknown constant type \"..t..\" to unpack\")local v,ix=field:unpack(bytes,ix)return{type=t,value=v},ix\
end,pack=function(self,val)local t,v=val.type,val.value\
return Byte:pack(t)..ConstantTypes[t]:pack(v)end}local Local=Struct{String{name=\"name\"},Integer{name=\"startpc\"},Integer{name=\"endpc\"}}local Function=Struct{String{name=\"name\"},Integer{name=\"line\"},Integer{name=\"last_line\"},Byte{name=\"num_upvalues\"},Byte{name=\"num_parameters\"},Byte{name=\"is_vararg\"},Byte{name=\"max_stack_size\"},List{name=\"insns\",type=Insn},List{name=\"constants\",type=Constant},List{name=\"prototypes\",type=nil},List{name=\"source_lines\",type=Integer},List{name=\"locals\",type=Local},List{name=\"upvalues\",type=String},}assert(Function[10].name==\"prototypes\",\"missed the function prototype list\")Function[10].type=Function\
local Chunk=Struct{ChunkHeader{name=\"header\"},Function{name=\"body\"}}local function validate(chunk)if type(chunk)==\"function\"then\
return validate(string.dump(chunk))end\
local f=Chunk:unpack(chunk,1)local chunk2=Chunk:pack(f)if chunk==chunk2 then return true end\
local i\
local len=math.min(#chunk,#chunk2)for i=1,len do\
local a=chunk:sub(i,i)local b=chunk:sub(i,i)if a~=b then\
return false,(\"chunk roundtripping failed: \"..\"first byte difference at index %d\"):format(i)end\
end\
return false,(\"chunk round tripping failed: \"..\"original length %d vs. %d\"):format(#chunk,#chunk2)end\
return{disassemble=function(chunk)return Chunk:unpack(chunk,1)end,assemble=function(disassembled)return Chunk:pack(disassembled)end,validate=validate}end)local cs=require\"minichunkspy\"local function ___adjust_chunk(chunk,newname,lineshift)local c=cs.disassemble(string.dump(chunk));c.body.name=newname;lineshift=-c.body.line;local function shiftlines(c)c.line=c.line+lineshift;c.last_line=c.last_line+lineshift;for i,line in ipairs(c.source_lines)do\
c.source_lines[i]=line+lineshift;end\
for i,f in ipairs(c.prototypes)do\
shiftlines(f);end\
end\
shiftlines(c.body);return assert(loadstring(cs.assemble(c),newname))();end\
"function require_resource(t)return e[t]or error("resource '"..tostring(t).."' not found");end end
local o={v="verbose",vv="very_verbose",o="output",q="quiet",qq="very_quiet",g="debug"}
local e={use_http=false};
for t,a in ipairs(arg)do
if a:match("^%-")then
local t=a:match("^%-%-?([^%s=]+)()")
t=(o[t]or t):gsub("%-+","_");
if t:match("^no_")then
t=t:sub(4,-1);
e[t]=false;
else
e[t]=a:match("=(.*)$")or true;
end
else
base_path=a;
end
end
if e.very_verbose then e.verbose=true;end
if e.very_quiet then e.quiet=true;end
local t=function()end
local t,o,s,n=t,t,t,t;
if not e.very_quiet then t=print;end
if not e.quiet then o=print;end
if e.verbose or e.very_verbose then s=print;end
if e.very_verbose then n=print;end
print=s;
local i,d,h={},{},{};
function Module(e)
if i[e]then
s("Ignoring duplicate module definition for "..e);
return function()end
end
local t=#i+1;
i[t]={name=e,url=___fetch_url};
i[e]=i[t];
return function(e)
i[t].path=e;
end
end
function Resource(e,a)
local t=#h+1;
h[t]={name=e,path=a or e};
return function(e)
h[t].path=e;
end
end
function AutoFetchURL(e)
___fetch_url=e;
end
function Main(e)
table.insert(d,e);
end
function Output(t)
if e.output==nil then
out_fn=t;
end
end
function Option(t)
t=t:gsub("%-","_");
if e[t]==nil then
e[t]=true;
return function(a)
e[t]=a;
end
else
return function()end;
end
end
function GetOption(t)
return e[t:gsub('%-','_')];
end
function Message(t)
if not e.quiet then
o(t);
end
end
function Error(a)
if not e.very_quiet then
t(a);
end
end
function Exit()
os.exit(1);
end
base_path=(base_path or"."):gsub("/$","").."/"
squishy_file=base_path.."squishy";
out_fn=e.output;
local r,a=pcall(dofile,squishy_file);
if not r then
t("Couldn't read squishy file: "..a);
os.exit(1);
end
if not out_fn then
t("No output file specified by user or squishy file");
os.exit(1);
elseif#d==0 and#i==0 and#h==0 then
t("No files, modules or resources. Not going to generate an empty file.");
os.exit(1);
end
local r={};
function r.filesystem(e)
local e,t=io.open(e);
if not e then return false,t;end
local t=e:read("*a");
e:close();
return t;
end
if e.use_http then
function r.http(t)
local e=require"socket.http";
local t,e=e.request(t);
if e==200 then
return t;
end
return false,"HTTP status code: "..tostring(e);
end
else
function r.http(e)
return false,"Module not found. Re-squish with --use-http option to fetch it from "..e;
end
end
o("Writing "..out_fn.."...");
local a,l=io.open(out_fn,"w+");
if not a then
t("Couldn't open output file: "..tostring(l));
os.exit(1);
end
if e.executable then
if e.executable==true then
a:write("#!/usr/bin/env lua\n");
else
a:write(e.executable,"\n");
end
end
if e.debug then
a:write(require_resource("squish.debug"));
end
s("Resolving modules...");
do
local e=package.config:sub(1,1);
local o=package.config:sub(5,5);
local s=package.path:gsub("[^;]+",function(t)
if not t:match("^%"..e)then
return base_path..t;
end
end):gsub("/%./","/");
local a=package.cpath:gsub("[^;]+",function(t)
if not t:match("^%"..e)then
return base_path..t;
end
end):gsub("/%./","/");
function resolve_module(t,a)
t=t:gsub("%.",e);
for e in a:gmatch("[^;]+")do
e=e:gsub("%"..o,t);
n("Looking for "..e)
local t=io.open(e);
if t then
n("Found!");
t:close();
return e;
end
end
return nil;
end
for a,e in ipairs(i)do
if not e.path then
e.path=resolve_module(e.name,s);
if not e.path then
t("Couldn't resolve module: "..e.name);
else
e.path=e.path:gsub("^"..base_path:gsub("%p","%%%1"),"");
end
end
end
end
s("Packing modules...");
for i,o in ipairs(i)do
local i,h=o.name,o.path;
if o.path:sub(1,1)~="/"then
h=base_path..o.path;
end
n("Packing "..i.." ("..h..")...");
local s,d=r.filesystem(h);
if(not s)and o.url then
n("Fetching: "..o.url:gsub("%?",o.path))
s,d=r.http(o.url:gsub("%?",o.path));
end
if s then
a:write("package.preload['",i,"'] = (function (...)\n");
a:write(s);
a:write(" end)\n");
if e.debug then
a:write(string.format("package.preload[%q] = ___adjust_chunk(package.preload[%q], %q);\n\n",
i,i,"@"..h));
end
else
t("Couldn't pack module '"..i.."': "..(d or"unknown error... path to module file correct?"));
os.exit(1);
end
end
if#h>0 then
s("Packing resources...")
a:write("do local resources = {};\n");
for o,e in ipairs(h)do
local i,e=e.name,e.path;
local e,o=io.open(base_path..e,"rb");
if not e then
t("Couldn't load resource: "..tostring(o));
os.exit(1);
end
local e=e:read("*a");
local t=0;
e:gsub("(=+)",function(e)t=math.max(t,#e);end);
a:write(("resources[%q] = %q"):format(i,e));
end
if e.virtual_io then
local e=require_resource("vio");
if not e then
t("Virtual IO requested but is not enabled in this build of squish");
else
a:write(e,"\n")
a:write[[local io_open, io_lines = io.open, io.lines; function io.open(fn, mode)
					if not resources[fn] then
						return io_open(fn, mode);
					else
						return vio.open(resources[fn]);
				end end
				function io.lines(fn)
					if not resources[fn] then
						return io_lines(fn);
					else
						return vio.open(resources[fn]):lines()
				end end
				local _dofile = dofile;
				function dofile(fn)
					if not resources[fn] then
						return _dofile(fn);
					else
						return assert(loadstring(resources[fn]))();
				end end
				local _loadfile = loadfile;
				function loadfile(fn)
					if not resources[fn] then
						return _loadfile(fn);
					else
						return loadstring(resources[fn], "@"..fn);
				end end ]]
end
end
a:write[[function require_resource(name) return resources[name] or error("resource '"..tostring(name).."' not found"); end end ]]
end
n("Finalising...")
for e,o in pairs(d)do
local e,i=io.open(base_path..o);
if not e then
t("Failed to open "..o..": "..i);
os.exit(1);
else
a:write((e:read("*a"):gsub("^#.-\n","")));
e:close();
end
end
a:close();
o("OK!");
local n=require"optlex"
local d=require"optparser"
local a=require"llex"
local r=require"lparser"
local i={
none={};
debug={"whitespace","locals","entropy","comments","numbers"};
default={"comments","whitespace","emptylines","numbers","locals"};
basic={"comments","whitespace","emptylines"};
full={"comments","whitespace","emptylines","eols","strings","numbers","locals","entropy"};
}
if e.minify_level and not i[e.minify_level]then
t("Unknown minify level: "..e.minify_level);
t("Available minify levels: none, basic, default, full, debug");
end
for a,t in ipairs(i[e.minify_level or"default"]or{})do
if e["minify_"..t]==nil then
e["minify_"..t]=true;
end
end
local h={
["opt-locals"]=e.minify_locals;
["opt-comments"]=e.minify_comments;
["opt-entropy"]=e.minify_entropy;
["opt-whitespace"]=e.minify_whitespace;
["opt-emptylines"]=e.minify_emptylines;
["opt-eols"]=e.minify_eols;
["opt-strings"]=e.minify_strings;
["opt-numbers"]=e.minify_numbers;
}
local function i(e)
t("minify: "..e);os.exit(1);
end
local function l(e)
local t=io.open(e,"rb")
if not t then i("cannot open \""..e.."\" for reading")end
local a=t:read("*a")
if not a then i("cannot read from \""..e.."\"")end
t:close()
return a
end
local function u(t,a)
local e=io.open(t,"wb")
if not e then i("cannot open \""..t.."\" for writing")end
local a=e:write(a)
if not a then i("cannot write to \""..t.."\"")end
e:close()
end
function minify_string(e)
a.init(e)
a.llex()
local t,e,a
=a.tok,a.seminfo,a.tokln
if h["opt-locals"]then
d.print=print
r.init(t,e,a)
local o,a=r.parser()
d.optimize(h,t,e,o,a)
end
n.print=print
t,e,a
=n.optimize(h,t,e,a)
local e=table.concat(e)
if string.find(e,"\r\n",1,1)or
string.find(e,"\n\r",1,1)then
n.warn.mixedeol=true
end
return e;
end
function minify_file(e,t)
local e=l(e);
e=minify_string(e);
u(t,e);
end
if e.minify~=false then
o("Minifying "..out_fn.."...");
minify_file(out_fn,out_fn);
o("OK!");
end
local h=require"llex"
local i=128;
local n={"and","break","do","else","elseif",
"end","false","for","function","if",
"in","local","nil","not","or","repeat",
"return","then","true","until","while"}
function uglify_file(u,o)
local s,a=io.open(u);
if not s then
t("Can't open input file for reading: "..tostring(a));
return;
end
local a,r=io.open(o..".uglified","wb+");
if not a then
t("Can't open output file for writing: "..tostring(r));
return;
end
local l=s:read("*a");
s:close();
local s,t=l:match("^(#.-\n)(.+)$");
local t=t or l;
if s then
a:write(s)
end
while i+#n<=255 and t:find("["..string.char(i).."-"..string.char(i+#n-1).."]")do
i=i+1;
end
if i+#n>255 then
a:write(t);
a:close();
os.rename(o..".uglified",o);
return;
end
local d={}
for e,t in ipairs(n)do
d[t]=string.char(i+e);
end
local r=0;
l:gsub("(=+)",function(e)r=math.max(r,#e);end);
h.init(t,"@"..u);
h.llex()
local s=h.seminfo;
if e.uglify_level=="full"and i+#n<255 then
local e={};
for o,a in ipairs(h.tok)do
if a=="TK_NAME"or a=="TK_STRING"then
local t=string.format("%q,%q",a,s[o]);
if not e[t]then
e[t]={type=a,value=s[o],count=0};
e[#e+1]=e[t];
end
e[t].count=e[t].count+1;
end
end
for t=1,#e do
local e=e[t];
e.score=(e.count)*(#e.value-1)-#string.format("%q",e.value)-1;
end
table.sort(e,function(e,t)return e.score>t.score;end);
local t=255-(i+#n);
for t=t+1,#e do
e[t]=nil;
end
local a=#n;
for t,e in ipairs(e)do
if e.score>0 then
table.insert(n,e.value);
d[e.value]=string.char(i+a+t);
end
end
end
a:write("local base_char,keywords=",tostring(i),",{");
for t,e in ipairs(n)do
a:write(string.format("%q",e),',');
end
a:write[[}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
	function (c) return keywords[c:byte()-base_char]; end) end ]]
a:write[[return assert(loadstring(prettify]]
a:write("[",string.rep("=",r+1),"[");
for e,t in ipairs(h.tok)do
if t=="TK_KEYWORD"or t=="TK_NAME"or t=="TK_STRING"then
local t=d[s[e]];
if t then
a:write(t);
else
a:write(s[e]);
end
else
a:write(s[e]);
end
end
a:write("]",string.rep("=",r+1),"]");
a:write(", '@",o,"'))()");
a:close();
os.rename(o..".uglified",o);
end
if e.uglify then
o("Uglifying "..out_fn.."...");
uglify_file(out_fn,out_fn);
o("OK!");
end
local i=require"minichunkspy"
function compile_string(t,a)
local t=string.dump(loadstring(t,a));
if((not e.debug)or e.compile_strip)and e.compile_strip~=false then
local t=i.disassemble(t);
local function a(e)
e.source_lines,e.locals,e.upvalues={},{},{};
for t,e in ipairs(e.prototypes)do
a(e);
end
end
s("Stripping debug info...");
a(t.body);
return i.assemble(t);
end
return t;
end
function compile_file(a,e)
local o,a=io.open(a);
if not o then
t("Can't open input file for reading: "..tostring(a));
return;
end
local a,i=io.open(e..".compiled","w+");
if not a then
t("Can't open output file for writing: "..tostring(i));
return;
end
local i=o:read("*a");
o:close();
local t,o=i:match("^(#.-\n)(.+)$");
local o=o or i;
if t then
a:write(t)
end
a:write(compile_string(o,e));
os.rename(e..".compiled",e);
end
if e.compile then
o("Compiling "..out_fn.."...");
compile_file(out_fn,out_fn);
o("OK!");
end
function gzip_file(a,e)
local o,a=io.open(a);
if not o then
t("Can't open input file for reading: "..tostring(a));
return;
end
local a,i=io.open(e..".gzipped","wb+");
if not a then
t("Can't open output file for writing: "..tostring(i));
return;
end
local i=o:read("*a");
o:close();
local n,o=i:match("^(#.-\n)(.+)$");
local o=o or i;
if n then
a:write(n)
end
local i,n=io.open(e..".pregzip","wb+");
if not i then
t("Can't open temp file for writing: "..tostring(n));
return;
end
i:write(o);
i:close();
local t=io.popen("gzip -c '"..e..".pregzip'");
o=t:read("*a");
t:close();
os.remove(e..".pregzip");
local t=0;
o:gsub("(=+)",function(e)t=math.max(t,#e);end);
a:write("local ungz = (function ()",require_resource"gunzip.lua"," end)()\n");
a:write[[return assert(loadstring((function (i)local o={} ungz{input=i,output=function(b)table.insert(o,string.char(b))end}return table.concat(o)end) ]];
a:write((string.format("%q",o):gsub("\026","\\026")));
a:write(", '@",e,"'))()");
a:close();
os.rename(e..".gzipped",e);
end
if e.gzip then
o("Gzipping "..out_fn.."...");
gzip_file(out_fn,out_fn);
o("OK!");
end
