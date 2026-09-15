local TS=game:GetService("TweenService")
local UIS=game:GetService("UserInputService")
local PLR=game:GetService("Players").LocalPlayer
local par
if gethui then local o,h=pcall(gethui)if o and h then par=h end end
par=par or game:GetService("CoreGui")
for _,v in ipairs(par:GetChildren())do if v.Name=="EZVCProto"then pcall(v.Destroy,v)end end
local sg=Instance.new("ScreenGui")
sg.Name="EZVCProto"
sg.IgnoreGuiInset=true
sg.ResetOnSpawn=false
sg.DisplayOrder=999
sg.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
sg.Parent=par

local function mk(c,p,r)local o=Instance.new(c)for k,v in next,p do o[k]=v end if r then o.Parent=r end return o end
local function cr(o,r)mk("UICorner",{CornerRadius=UDim.new(0,r)},o)end
local function sk(o,c,t)return mk("UIStroke",{Color=c,Thickness=1,Transparency=t},o)end
local function lb(p,t,x,y,w,h,c,s,b)return mk("TextLabel",{Size=UDim2.new(0,w,0,h),Position=UDim2.new(0,x,0,y),BackgroundTransparency=1,Font=b and Enum.Font.GothamBold or Enum.Font.Gotham,TextSize=s or 11,TextColor3=c,TextXAlignment=Enum.TextXAlignment.Left,Text=t},p)end

local BG=Color3.fromRGB(16,16,20)
local SF=Color3.fromRGB(22,22,27)
local HD=Color3.fromRGB(26,26,32)
local PN=Color3.fromRGB(30,30,36)
local EL=Color3.fromRGB(38,38,45)
local BR=Color3.fromRGB(52,52,60)
local TX=Color3.fromRGB(238,238,244)
local SB=Color3.fromRGB(150,150,162)
local MT=Color3.fromRGB(98,98,110)
local AC=Color3.fromRGB(155,120,255)

local tRefs={}
local function rT(p,f)tRefs[#tRefs+1]={p=p,f=f}end
local function setAC(c)
AC=c
for _,e in ipairs(tRefs)do
local v=c
if e.f then v=e.f()end
TS:Create(e.p,TweenInfo.new(0.28,Enum.EasingStyle.Quart),{BackgroundColor3=v}):Play()
end
end

local win=mk("Frame",{Size=UDim2.fromOffset(420,300),AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,0.5,0),BackgroundColor3=BG,BorderSizePixel=0},sg)
cr(win,12)
local wS=sk(win,BR,0.35)

local function fit()
local cam=workspace.CurrentCamera
if not cam then return end
local vp=cam.ViewportSize
if vp.X<=0 or vp.Y<=0 then return end
win.Size=UDim2.fromOffset(math.clamp(math.floor(vp.X*0.92),300,460),math.clamp(math.floor(vp.Y*0.78),260,340))
end
fit()
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fit)

local hdr=mk("Frame",{Size=UDim2.new(1,0,0,38),BackgroundColor3=HD,BorderSizePixel=0},win)
cr(hdr,12)
mk("Frame",{Size=UDim2.new(1,0,0,12),Position=UDim2.new(0,0,1,-12),BackgroundColor3=HD,BorderSizePixel=0},hdr)
local aDot=mk("Frame",{Size=UDim2.fromOffset(10,10),Position=UDim2.new(0,14,0.5,-5),BackgroundColor3=AC,BorderSizePixel=0},hdr)
cr(aDot,3)
rT(aDot)
lb(hdr,"EZVC Hub",30,0,120,38,TX,13,true)
lb(hdr,"v1.0 Preview",92,0,90,38,MT,9,false)
local xb=mk("TextButton",{Size=UDim2.fromOffset(24,24),Position=UDim2.new(1,-30,0.5,-12),BackgroundColor3=EL,BorderSizePixel=0,Font=Enum.Font.Gotham,TextSize=11,TextColor3=SB,Text="X",AutoButtonColor=false},hdr)
cr(xb,6)
xb.MouseEnter:Connect(function()TS:Create(xb,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(200,90,90),TextColor3=Color3.new(1,1,1)}):Play()end)
xb.MouseLeave:Connect(function()TS:Create(xb,TweenInfo.new(0.15),{BackgroundColor3=EL,TextColor3=SB}):Play()end)

local dg=false
local d0,d1
hdr.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dg=true d0=i.Position d1=win.Position end end)
UIS.InputChanged:Connect(function(i)if dg and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then local d=i.Position-d0 win.Position=UDim2.new(d1.X.Scale,d1.X.Offset+d.X,d1.Y.Scale,d1.Y.Offset+d.Y)end end)
UIS.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dg=false end end)

local body=mk("Frame",{Size=UDim2.new(1,0,1,-38),Position=UDim2.new(0,0,0,38),BackgroundTransparency=1},win)
local sb=mk("Frame",{Size=UDim2.new(0,118,1,0),BackgroundColor3=SF,BorderSizePixel=0},body)
mk("Frame",{Size=UDim2.new(0,1,1,0),Position=UDim2.new(1,-1,0,0),BackgroundColor3=BR,BorderSizePixel=0,BackgroundTransparency=0.4},sb)
local ct=mk("Frame",{Size=UDim2.new(1,-118,1,0),Position=UDim2.new(0,118,0,0),BackgroundTransparency=1},body)

local pages,tabs,cur={},{},nil
local function go(n)
if cur==n then return end
for k,p in pairs(pages)do
if k==n then
p.Visible=true
p.Position=UDim2.new(0,5,0,0)
TS:Create(p,TweenInfo.new(0.22,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(0,0,0,0)}):Play()
else p.Visible=false end
end
for k,b in pairs(tabs)do
if k==n then TS:Create(b,TweenInfo.new(0.18),{BackgroundColor3=EL,TextColor3=TX}):Play()
else TS:Create(b,TweenInfo.new(0.18),{BackgroundColor3=SF,TextColor3=MT}):Play() end
end
cur=n
end

for i,n in ipairs({"Main","Play","Macro","Share"})do
local b=mk("TextButton",{Size=UDim2.new(1,-16,0,28),Position=UDim2.new(0,8,0,10+(i-1)*32),BackgroundColor3=SF,BorderSizePixel=0,Font=Enum.Font.Gotham,TextSize=11,TextColor3=MT,Text="  "..n,AutoButtonColor=false,TextXAlignment=Enum.TextXAlignment.Left},sb)
cr(b,6)
b.MouseButton1Click:Connect(function()go(n)end)
tabs[n]=b
end

for i,c in ipairs({Color3.fromRGB(155,120,255),Color3.fromRGB(108,142,255),Color3.fromRGB(0,200,220),Color3.fromRGB(90,196,140),Color3.fromRGB(220,96,96),Color3.fromRGB(240,150,60),Color3.fromRGB(230,120,180)})do
local s=mk("TextButton",{Size=UDim2.fromOffset(12,12),Position=UDim2.new(0,8+(i-1)*15,1,-20),BackgroundColor3=c,BorderSizePixel=0,Text="",AutoButtonColor=false},sb)
cr(s,6)
s.MouseButton1Click:Connect(function()setAC(c)end)
end

local function pg(n)
local s=mk("ScrollingFrame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=EL,CanvasSize=UDim2.new(0,0,0,700),Visible=false},ct)
pages[n]=s
return s
end
local function cd(p,t,y)
local f=mk("Frame",{Size=UDim2.new(1,-24,0,0),Position=UDim2.new(0,12,0,y),BackgroundColor3=PN,BorderSizePixel=0},p)
cr(f,8)
sk(f,BR,0.4)
if t then lb(f,string.upper(t),12,10,200,12,SB,10,true)end
return f
end
local function btn(p,t,x,y,w,h,k)
local b=EL
local tc=TX
if k=="p"then b=AC tc=Color3.new(1,1,1)end
if k=="d"then b=Color3.fromRGB(56,34,34)tc=Color3.fromRGB(230,150,150)end
local o=mk("TextButton",{Size=UDim2.new(0,w,0,h),Position=UDim2.new(0,x,0,y),BackgroundColor3=b,BorderSizePixel=0,Font=Enum.Font.Gotham,TextSize=11,TextColor3=tc,Text=t,AutoButtonColor=false},p)
cr(o,6)
if k=="p"then rT(o)end
o.MouseEnter:Connect(function()TS:Create(o,TweenInfo.new(0.14),{BackgroundColor3=b:Lerp(Color3.new(1,1,1),0.15)}):Play()end)
o.MouseLeave:Connect(function()TS:Create(o,TweenInfo.new(0.14),{BackgroundColor3=b}):Play()end)
return o
end
local function tg(p,nm,ds,x,y,w,h,on)
local box=mk("Frame",{Size=UDim2.new(0,w,0,h),Position=UDim2.new(0,x,0,y),BackgroundColor3=EL,BorderSizePixel=0},p)
cr(box,6)
if ds then
lb(box,nm,10,5,w-50,14,TX,11,false)
lb(box,ds,10,20,w-50,11,SB,9,false)
else lb(box,nm,10,0,w-50,h,TX,11,false) end
local st=on
local sw=mk("Frame",{Size=UDim2.fromOffset(32,18),Position=UDim2.new(1,-44,0.5,-9),BackgroundColor3=on and AC or Color3.fromRGB(52,52,60),BorderSizePixel=0},box)
cr(sw,9)
local kn=mk("Frame",{Size=UDim2.fromOffset(12,12),Position=on and UDim2.new(1,-15,0.5,-6) or UDim2.new(0,3,0.5,-6),BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0},sw)
cr(kn,6)
rT(sw,function()return st and AC or Color3.fromRGB(52,52,60)end)
local z=mk("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",AutoButtonColor=false},box)
z.MouseButton1Click:Connect(function()
st=not st
TS:Create(sw,TweenInfo.new(0.22,Enum.EasingStyle.Quart),{BackgroundColor3=st and AC or Color3.fromRGB(52,52,60)}):Play()
TS:Create(kn,TweenInfo.new(0.22,Enum.EasingStyle.Quart),{Position=st and UDim2.new(1,-15,0.5,-6) or UDim2.new(0,3,0.5,-6)}):Play()
end)
end

local mP=pg("Main")
local c1=cd(mP,"Statistics",12)
c1.Size=UDim2.new(1,-24,0,84)
lb(c1,"Lobby",12,30,60,12,SB,9,false)lb(c1,"0",12,44,60,20,TX,16,true)
lb(c1,"Place",82,30,60,12,SB,9,false)lb(c1,"0",82,44,60,20,TX,16,true)
lb(c1,"Upgrade",152,30,60,12,SB,9,false)lb(c1,"0",152,44,60,20,TX,16,true)
lb(c1,"Sell",222,30,60,12,SB,9,false)lb(c1,"0",222,44,60,20,TX,16,true)
local c2=cd(mP,"Automation",104)
c2.Size=UDim2.new(1,-24,0,124)
tg(c2,"Auto Summon","Auto summon units",12,26,240,38,false)
tg(c2,"Auto Spin","Auto spin wheel",12,70,240,38,true)

local pP=pg("Play")
local pc=cd(pP,"Playback",12)
pc.Size=UDim2.new(1,-24,0,118)
lb(pc,"Select Macro",12,28,110,34,SB,11,false)
local dd=mk("TextButton",{Size=UDim2.new(0,120,0,32),Position=UDim2.new(1,-132,0,26),BackgroundColor3=BG,BorderSizePixel=0,Font=Enum.Font.Gotham,TextSize=11,TextColor3=TX,Text="EasyFarm",AutoButtonColor=false},pc)
cr(dd,5)
btn(pc,"Play Macro",12,66,240,30,"p")

local mP2=pg("Macro")
local rc=cd(mP2,"Recording",12)
rc.Size=UDim2.new(1,-24,0,152)
local ip=mk("Frame",{Size=UDim2.new(1,-24,0,34),Position=UDim2.new(0,12,0,26),BackgroundColor3=EL,BorderSizePixel=0},rc)
cr(ip,6)
lb(ip,"Name",10,0,60,34,SB,11,false)
mk("TextBox",{Size=UDim2.new(1,-80,1,-12),Position=UDim2.new(0,70,0,6),BackgroundColor3=BG,BorderSizePixel=0,Font=Enum.Font.Gotham,TextSize=11,TextColor3=TX,PlaceholderText="e.g. EasyFarm",PlaceholderColor3=MT,Text="",ClearTextOnFocus=false},ip)
btn(rc,"Record Macro",12,68,240,30,"p")
btn(rc,"Stop Recording",12,104,240,30,"d")

local sP=pg("Share")
local sc=cd(sP,"Share",12)
sc.Size=UDim2.new(1,-24,0,152)
lb(sc,"Generate shareable code below.",12,28,240,14,SB,11,false)
local cb=mk("Frame",{Size=UDim2.new(1,-24,0,60),Position=UDim2.new(0,12,0,48),BackgroundColor3=BG,BorderSizePixel=0},sc)
cr(cb,6)
lb(cb,"EZVC1:eyJ2IjoxLCJuYW1lIjoi...",8,8,240,44,MT,10,false)
btn(sc,"Copy to Clipboard",12,116,240,30,"p")

local st=mk("Frame",{Size=UDim2.new(1,0,0,18),Position=UDim2.new(0,0,1,-18),BackgroundColor3=SF,BorderSizePixel=0},win)
local sd=mk("Frame",{Size=UDim2.fromOffset(5,5),Position=UDim2.new(0,11,0.5,-2),BackgroundColor3=Color3.fromRGB(90,196,140),BorderSizePixel=0},st)
cr(sd,3)
lb(st,"EZVC Hub - Preview",22,0,200,18,MT,9,false)

-- Float toggle
local vis=true
local fl=mk("TextButton",{Size=UDim2.fromOffset(78,34),Position=UDim2.new(0,16,0,16),BackgroundColor3=HD,BorderSizePixel=0,Font=Enum.Font.GothamBold,TextSize=12,TextColor3=TX,Text="Toggle",AutoButtonColor=false,ZIndex=30},sg)
cr(fl,17)
local fS=sk(fl,BR,0.4)
local fd=mk("Frame",{Size=UDim2.fromOffset(8,8),Position=UDim2.new(0,10,0.5,-4),BackgroundColor3=AC,BorderSizePixel=0},fl)
cr(fd,4)
rT(fd)
local fDg,fM=false
local f0,f1
fl.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then fDg=true fM=false f0=i.Position f1=fl.Position end end)
UIS.InputChanged:Connect(function(i)if fDg and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then local d=i.Position-f0 if math.abs(d.X)>4 or math.abs(d.Y)>4 then fM=true end fl.Position=UDim2.new(f1.X.Scale,f1.X.Offset+d.X,f1.Y.Scale,f1.Y.Offset+d.Y)end end)
UIS.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then fDg=false end end)
local function show(v)
vis=v
if v then
win.Visible=true win.BackgroundTransparency=1 wS.Transparency=1
TS:Create(win,TweenInfo.new(0.28,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=0}):Play()
TS:Create(wS,TweenInfo.new(0.28,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Transparency=0.35}):Play()
TS:Create(fd,TweenInfo.new(0.24),{BackgroundColor3=AC}):Play()
else
TS:Create(win,TweenInfo.new(0.22,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{BackgroundTransparency=1}):Play()
TS:Create(wS,TweenInfo.new(0.22,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{Transparency=1}):Play()
task.delay(0.3,function()if not vis then win.Visible=false end end)
TS:Create(fd,TweenInfo.new(0.24),{BackgroundColor3=Color3.fromRGB(90,196,140)}):Play()
end
end
fl.MouseButton1Click:Connect(function()if not fM then show(not vis)end end)

-- Dialog
local scr,dlg
local function killD(inst)
if not dlg then return end
if inst then
if dlg then dlg:Destroy()end
if scr then scr:Destroy()end
dlg=nil scr=nil return
end
local ti=TweenInfo.new(0.22,Enum.EasingStyle.Quart,Enum.EasingDirection.In)
local items={dlg,scr}
for _,c in ipairs(dlg:GetDescendants())do table.insert(items,c)end
for _,el in ipairs(items)do
if el and el:IsA("TextLabel")then TS:Create(el,ti,{TextTransparency=1}):Play()
elseif el and el:IsA("TextButton")then TS:Create(el,ti,{BackgroundTransparency=1,TextTransparency=1}):Play()
elseif el and el:IsA("UIStroke")then TS:Create(el,ti,{Transparency=1}):Play()
elseif el and el:IsA("Frame")then TS:Create(el,ti,{BackgroundTransparency=1}):Play()end
end
task.delay(0.28,function()
if dlg then dlg:Destroy()end
if scr then scr:Destroy()end
dlg=nil scr=nil
end)
end
local function ask()
killD(true)
scr=mk("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=1,BorderSizePixel=0,Text="",AutoButtonColor=false,ZIndex=40},sg)
dlg=mk("Frame",{Size=UDim2.fromOffset(280,130),AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,0.5,0),BackgroundColor3=PN,BackgroundTransparency=1,BorderSizePixel=0,ZIndex=41},sg)
cr(dlg,10)
local ds=sk(dlg,BR,1)
local dt=lb(dlg,"Close GUI",14,14,250,20,TX,14,true)
dt.TextTransparency=1 dt.ZIndex=42
local dm=mk("TextLabel",{Size=UDim2.new(1,-28,0,40),Position=UDim2.new(0,14,0,40),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=12,TextColor3=SB,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top,TextWrapped=true,Text="Are you sure you want to close this GUI?",TextTransparency=1,ZIndex=42},dlg)
local nb=mk("TextButton",{Size=UDim2.new(0.5,-20,0,32),Position=UDim2.new(0,14,1,-46),BackgroundColor3=EL,BackgroundTransparency=1,BorderSizePixel=0,Font=Enum.Font.Gotham,TextSize=12,TextColor3=TX,TextTransparency=1,Text="No",AutoButtonColor=false,ZIndex=42},dlg)
cr(nb,6)
local yb=mk("TextButton",{Size=UDim2.new(0.5,-20,0,32),Position=UDim2.new(0.5,6,1,-46),BackgroundColor3=Color3.fromRGB(180,70,70),BackgroundTransparency=1,BorderSizePixel=0,Font=Enum.Font.Gotham,TextSize=12,TextColor3=Color3.new(1,1,1),TextTransparency=1,Text="Yes",AutoButtonColor=false,ZIndex=42},dlg)
cr(yb,6)
local ti=TweenInfo.new(0.22,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
TS:Create(scr,ti,{BackgroundTransparency=0.5}):Play()
TS:Create(dlg,ti,{BackgroundTransparency=0}):Play()
TS:Create(ds,ti,{Transparency=0.3}):Play()
TS:Create(dt,ti,{TextTransparency=0}):Play()
TS:Create(dm,ti,{TextTransparency=0}):Play()
TS:Create(nb,ti,{BackgroundTransparency=0,TextTransparency=0}):Play()
TS:Create(yb,ti,{BackgroundTransparency=0,TextTransparency=0}):Play()
nb.MouseButton1Click:Connect(function()killD(false)end)
yb.MouseButton1Click:Connect(function()
local to=TweenInfo.new(0.3,Enum.EasingStyle.Quart,Enum.EasingDirection.In)
local list={dlg,scr,win,fl,wS,fS}
for _,c in ipairs(dlg:GetDescendants())do table.insert(list,c)end
for _,el in ipairs(list)do
if el and el:IsA("TextLabel")then TS:Create(el,to,{TextTransparency=1}):Play()
elseif el and el:IsA("UIStroke")then TS:Create(el,to,{Transparency=1}):Play()
elseif el then TS:Create(el,to,{BackgroundTransparency=1,TextTransparency=1}):Play()end
end
task.delay(0.35,function()sg:Destroy()end)
end)
end
xb.MouseButton1Click:Connect(ask)

go("Main")
print("[EZVC] GUI loaded")
