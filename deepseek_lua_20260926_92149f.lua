local TS=game:GetService("TweenService")
local UIS=game:GetService("UserInputService")
local RS=game:GetService("ReplicatedStorage")
local HS=game:GetService("HttpService")
local PLR=game:GetService("Players").LocalPlayer
local FO="macro_ng/"
local CF=FO.."cfg.json"
pcall(function() if type(isfolder)=="function" and type(makefolder)=="function" and not isfolder(FO) then makefolder(FO) end end)
local function wj(p,d) if type(writefile)~="function" then return false end local ok,s=pcall(function() return HS:JSONEncode(d) end) if not ok then return false end return pcall(writefile,p,s) end
local function rj(p) if type(isfile)~="function" or type(readfile)~="function" or not isfile(p) then return nil end local ok,d=pcall(readfile,p) if not ok then return nil end local ok2,a=pcall(function() return HS:JSONDecode(d) end) if not ok2 or type(a)~="table" then return nil end return a end
local function lf() if type(listfiles)~="function" then return {} end local s,n={},{} for _,p in ipairs({FO,"macro_ng","./macro_ng/"}) do local ok,l=pcall(listfiles,p) if ok and type(l)=="table" then for _,f in ipairs(l) do local x=tostring(f):match("([^/\\]+)%.json$") if x and x~="cfg" and not s[x] then s[x]=true n[#n+1]=x end end end end return n end
local Cfg={} do local c=rj(CF) if type(c)=="table" then Cfg=c end end
for k,v in pairs({mn="",sel="",vm="Normal",acr=155,acg=120,acb=255}) do if Cfg[k]==nil then Cfg[k]=v end end
local sel=Cfg.sel or ""
local function sv() pcall(function() wj(CF,Cfg) end) end
local function set(k,v) Cfg[k]=v sv() end
local BG=Color3.fromRGB(16,16,20) local SF=Color3.fromRGB(22,22,27) local HD=Color3.fromRGB(26,26,32) local PN=Color3.fromRGB(30,30,36) local EL=Color3.fromRGB(38,38,45) local BR=Color3.fromRGB(52,52,60) local TX=Color3.fromRGB(238,238,244) local SB=Color3.fromRGB(150,150,162) local MT=Color3.fromRGB(98,98,110) local OFF=Color3.fromRGB(52,52,60)
local AC=Color3.fromRGB(tonumber(Cfg.acr) or 155,tonumber(Cfg.acg) or 120,tonumber(Cfg.acb) or 255)
local par pcall(function() if gethui then local ok,h=pcall(gethui) if ok and h then par=h end end end) par=par or game:GetService("CoreGui")
for _,v in ipairs(par:GetChildren()) do if v.Name=="EZVCMacroATD" then pcall(function() v:Destroy() end) end end
local sg=Instance.new("ScreenGui") sg.Name="EZVCMacroATD" sg.IgnoreGuiInset=true sg.ResetOnSpawn=false sg.DisplayOrder=999 sg.ZIndexBehavior=Enum.ZIndexBehavior.Sibling sg.Parent=par
local function mk(c,p,r) local o=Instance.new(c) for k,v in next,p do o[k]=v end if r then o.Parent=r end return o end
local function cr(o,r) mk("UICorner",{CornerRadius=UDim.new(0,r)},o) end
local function sk(o,c,t) return mk("UIStroke",{Color=c,Thickness=1,Transparency=t},o) end
local function lb(p,t,x,y,w,h,c,s,b) return mk("TextLabel",{Size=UDim2.new(0,w,0,h),Position=UDim2.new(0,x,0,y),BackgroundTransparency=1,Font=b and Enum.Font.GothamBold or Enum.Font.Gotham,TextSize=s or 11,TextColor3=c,TextXAlignment=Enum.TextXAlignment.Left,Text=t},p) end
local tR={}
local function rT(p,f,prop) tR[#tR+1]={p=p,f=f,prop=prop or "BackgroundColor3"} return p end
local function setAC(c) AC=c for i=#tR,1,-1 do local e=tR[i] if not e.p or not e.p.Parent then table.remove(tR,i) else local v=e.f and e.f() or c pcall(function() TS:Create(e.p,TweenInfo.new(0.28,Enum.EasingStyle.Quart),{[e.prop]=v}):Play() end) end end end
local function iA() for _,e in ipairs(tR) do if e.p and e.p.Parent then local v=e.f and e.f() or AC pcall(function() e.p[e.prop]=v end) end end end
local win=mk("Frame",{Size=UDim2.fromOffset(420,300),AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,0.5,0),BackgroundColor3=BG,BorderSizePixel=0},sg) cr(win,12)
local wS=sk(win,BR,0.35)
local function fit() pcall(function() local cam=workspace.CurrentCamera if not cam then return end local vp=cam.ViewportSize if vp.X<=0 or vp.Y<=0 then return end win.Size=UDim2.fromOffset(math.clamp(math.floor(vp.X*0.92),300,460),math.clamp(math.floor(vp.Y*0.78),260,340)) win.Position=UDim2.new(0.5,0,0.5,0) end) end
fit() pcall(function() workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fit) end)
local hdr=mk("Frame",{Size=UDim2.new(1,0,0,38),BackgroundColor3=HD,BorderSizePixel=0},win) cr(hdr,12)
mk("Frame",{Size=UDim2.new(1,0,0,12),Position=UDim2.new(0,0,1,-12),BackgroundColor3=HD,BorderSizePixel=0},hdr)
local aD=mk("Frame",{Size=UDim2.fromOffset(10,10),Position=UDim2.new(0,14,0.5,-5),BackgroundColor3=AC,BorderSizePixel=0},hdr) cr(aD,3) rT(aD)
lb(hdr,"Macro System",30,0,140,38,TX,13,true) lb(hdr,"v2.11",115,0,90,38,MT,9,false)
local xb=mk("TextButton",{Size=UDim2.fromOffset(24,24),Position=UDim2.new(1,-30,0.5,-12),BackgroundColor3=EL,BorderSizePixel=0,Font=Enum.Font.Gotham,TextSize=11,TextColor3=SB,Text="X",AutoButtonColor=false},hdr) cr(xb,6)
xb.MouseEnter:Connect(function() TS:Create(xb,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(200,90,90),TextColor3=Color3.new(1,1,1)}):Play() end)
xb.MouseLeave:Connect(function() TS:Create(xb,TweenInfo.new(0.15),{BackgroundColor3=EL,TextColor3=SB}):Play() end)
local dg,d0,d1=false,nil,nil
hdr.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dg=true d0=i.Position d1=win.Position end end)
UIS.InputChanged:Connect(function(i) if dg and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local d=i.Position-d0 win.Position=UDim2.new(d1.X.Scale,d1.X.Offset+d.X,d1.Y.Scale,d1.Y.Offset+d.Y) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dg=false end end)
local body=mk("Frame",{Size=UDim2.new(1,0,1,-38),Position=UDim2.new(0,0,0,38),BackgroundTransparency=1},win)
local sB=mk("Frame",{Size=UDim2.new(0,118,1,0),BackgroundColor3=SF,BorderSizePixel=0},body)
mk("Frame",{Size=UDim2.new(0,1,1,0),Position=UDim2.new(1,-1,0,0),BackgroundColor3=BR,BackgroundTransparency=0.4,BorderSizePixel=0},sB)
local ct=mk("Frame",{Size=UDim2.new(1,-118,1,0),Position=UDim2.new(0,118,0,0),BackgroundTransparency=1},body)
local aL=mk("Frame",{Size=UDim2.new(1,0,0,2),Position=UDim2.new(0,0,0,0),BackgroundColor3=AC,BorderSizePixel=0,ZIndex=10},body) rT(aL)
local pages,tabs,tInd,cur={},{},{},nil
local function go(n) if cur==n then return end for k,p in pairs(pages) do if k==n then p.Visible=true p.Position=UDim2.new(0,5,0,0) TS:Create(p,TweenInfo.new(0.22,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(0,0,0,0)}):Play() else p.Visible=false end end for k,b in pairs(tabs) do if k==n then TS:Create(b,TweenInfo.new(0.22),{BackgroundColor3=EL,TextColor3=AC}):Play() if tInd[k] then TS:Create(tInd[k],TweenInfo.new(0.22),{BackgroundTransparency=0}):Play() end else TS:Create(b,TweenInfo.new(0.22),{BackgroundColor3=SF,TextColor3=MT}):Play() if tInd[k] then TS:Create(tInd[k],TweenInfo.new(0.22),{BackgroundTransparency=1}):Play() end end end cur=n end
for i,n in ipairs({"Main","Play","Macro","Debug","GUI"}) do
local b=mk("TextButton",{Size=UDim2.new(1,-16,0,28),Position=UDim2.new(0,8,0,10+(i-1)*32),BackgroundColor3=SF,BorderSizePixel=0,Font=Enum.Font.Gotham,TextSize=11,TextColor3=MT,Text="  "..n,AutoButtonColor=false,TextXAlignment=Enum.TextXAlignment.Left},sB) cr(b,6)
local ind=mk("Frame",{Size=UDim2.new(0,3,1,-16),Position=UDim2.new(0,3,0,8),BackgroundColor3=AC,BorderSizePixel=0,BackgroundTransparency=1},b) cr(ind,2) rT(ind) tInd[n]=ind
b.MouseButton1Click:Connect(function() go(n) end) tabs[n]=b rT(b,function() return (cur==n) and AC or MT end,"TextColor3")
end
for i,c in ipairs({Color3.fromRGB(155,120,255),Color3.fromRGB(220,96,96),Color3.fromRGB(108,142,255),Color3.fromRGB(90,196,140),Color3.fromRGB(240,150,60),Color3.fromRGB(230,120,180),Color3.fromRGB(0,200,220),Color3.fromRGB(230,200,90)}) do
local s=mk("TextButton",{Size=UDim2.fromOffset(12,12),Position=UDim2.new(0,8+(i-1)*13,1,-20),BackgroundColor3=c,BorderSizePixel=0,Text="",AutoButtonColor=false},sB) cr(s,6)
s.MouseButton1Click:Connect(function() setAC(c) set("acr",math.floor(c.R*255+0.5)) set("acg",math.floor(c.G*255+0.5)) set("acb",math.floor(c.B*255+0.5)) if _sT then _sT() end end)
end
local function pg(n) local s=mk("ScrollingFrame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=EL,CanvasSize=UDim2.new(0,0,0,900),Visible=false},ct) pages[n]=s return s end
local function cd(p,t,y) local f=mk("Frame",{Size=UDim2.new(1,-24,0,0),Position=UDim2.new(0,12,0,y),BackgroundColor3=PN,BorderSizePixel=0},p) cr(f,8) sk(f,BR,0.4) if t then local d=mk("Frame",{Size=UDim2.fromOffset(5,5),Position=UDim2.new(0,10,0,14),BackgroundColor3=AC,BorderSizePixel=0},f) cr(d,2) rT(d) local tL=lb(f,string.upper(t),20,10,200,12,AC,10,true) rT(tL,nil,"TextColor3") end return f end
local function bt(p,t,x,y,w,h,k,cb) local o=mk("TextButton",{Size=UDim2.new(0,w,0,h),Position=UDim2.new(0,x,0,y),BorderSizePixel=0,Font=Enum.Font.Gotham,TextSize=11,Text=t,AutoButtonColor=false},p) if k=="p" then o.BackgroundColor3=AC o.TextColor3=Color3.new(1,1,1) elseif k=="d" then o.BackgroundColor3=Color3.fromRGB(56,34,34) o.TextColor3=Color3.fromRGB(230,150,150) else o.BackgroundColor3=EL o.TextColor3=TX end cr(o,6) if k=="p" then rT(o) end o.MouseEnter:Connect(function() TS:Create(o,TweenInfo.new(0.14),{BackgroundColor3=o.BackgroundColor3:Lerp(Color3.new(1,1,1),0.15)}):Play() end) o.MouseLeave:Connect(function() local tg2=EL if k=="p" then tg2=AC end if k=="d" then tg2=Color3.fromRGB(56,34,34) end TS:Create(o,TweenInfo.new(0.14),{BackgroundColor3=tg2}):Play() end) if cb then o.MouseButton1Click:Connect(cb) end return o end
local function tg(p,nm,ds,x,y,w,h,on,cb) local bx=mk("Frame",{Size=UDim2.new(0,w,0,h),Position=UDim2.new(0,x,0,y),BackgroundColor3=EL,BorderSizePixel=0},p) cr(bx,6) if ds then lb(bx,nm,10,5,w-50,14,TX,11,false) lb(bx,ds,10,20,w-50,11,SB,9,false) else lb(bx,nm,10,0,w-50,h,TX,11,false) end local st=on local sw=mk("Frame",{Size=UDim2.fromOffset(32,18),Position=UDim2.new(1,-44,0.5,-9),BackgroundColor3=on and AC or OFF,BorderSizePixel=0},bx) cr(sw,9) local kn=mk("Frame",{Size=UDim2.fromOffset(12,12),Position=on and UDim2.new(1,-15,0.5,-6) or UDim2.new(0,3,0.5,-6),BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0},sw) cr(kn,6) rT(sw,function() return st and AC or OFF end) local function ap(v) st=v pcall(function() TS:Create(sw,TweenInfo.new(0.22,Enum.EasingStyle.Quart),{BackgroundColor3=v and AC or OFF}):Play() TS:Create(kn,TweenInfo.new(0.22,Enum.EasingStyle.Quart),{Position=v and UDim2.new(1,-15,0.5,-6) or UDim2.new(0,3,0.5,-6)}):Play() end) end local z=mk("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",AutoButtonColor=false},bx) z.MouseButton1Click:Connect(function() ap(not st) if cb then cb(st) end end) return {GetValue=function() return st end,SetValue=function(v) ap(v) end} end
local function N(t,c) local nf=mk("Frame",{Size=UDim2.fromOffset(220,50),Position=UDim2.new(1,-230,1,-70),BackgroundColor3=PN,BorderSizePixel=0,ZIndex=50},sg) cr(nf,8) local ns=sk(nf,AC,0.3) local t1=lb(nf,t,12,8,180,16,AC,11,true) t1.ZIndex=51 local t2=lb(nf,c,12,26,196,18,SB,10,false) t2.ZIndex=51 nf.BackgroundTransparency=1 ns.Transparency=1 TS:Create(nf,TweenInfo.new(0.2),{BackgroundTransparency=0}):Play() TS:Create(ns,TweenInfo.new(0.2),{Transparency=0.3}):Play() task.delay(3,function() if not nf or not nf.Parent then return end TS:Create(nf,TweenInfo.new(0.3),{BackgroundTransparency=1}):Play() TS:Create(ns,TweenInfo.new(0.3),{Transparency=1}):Play() TS:Create(t1,TweenInfo.new(0.3),{TextTransparency=1}):Play() TS:Create(t2,TweenInfo.new(0.3),{TextTransparency=1}):Play() task.delay(0.35,function() pcall(function() nf:Destroy() end) end) end) end
local stB=mk("Frame",{Size=UDim2.new(1,0,0,18),Position=UDim2.new(0,0,1,-18),BackgroundColor3=SF,BorderSizePixel=0},win)
local stD=mk("Frame",{Size=UDim2.fromOffset(5,5),Position=UDim2.new(0,11,0.5,-2),BackgroundColor3=AC,BorderSizePixel=0},stB) cr(stD,3) rT(stD)
local stL=lb(stB,"Place 0 | Upgrade 0 | Sell 0",22,0,300,18,MT,9,false)
local vis=true
local fl=mk("TextButton",{Size=UDim2.fromOffset(78,34),Position=UDim2.new(0,16,0,16),BackgroundColor3=HD,BorderSizePixel=0,Font=Enum.Font.GothamBold,TextSize=12,TextColor3=TX,Text="Toggle",AutoButtonColor=false,ZIndex=30},sg) cr(fl,17)
local fS=sk(fl,AC,0.4) rT(fS,nil,"Color")
local fd=mk("Frame",{Size=UDim2.fromOffset(8,8),Position=UDim2.new(0,10,0.5,-4),BackgroundColor3=AC,BorderSizePixel=0},fl) cr(fd,4) rT(fd)
local fDg,fM,f0,f1=false,false,nil,nil
fl.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then fDg=true fM=false f0=i.Position f1=fl.Position end end)
UIS.InputChanged:Connect(function(i) if fDg and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local d=i.Position-f0 if math.abs(d.X)>4 or math.abs(d.Y)>4 then fM=true end fl.Position=UDim2.new(f1.X.Scale,f1.X.Offset+d.X,f1.Y.Scale,f1.Y.Offset+d.Y) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then fDg=false end end)
local function shW(v) vis=v if v then win.Visible=true win.BackgroundTransparency=1 wS.Transparency=1 TS:Create(win,TweenInfo.new(0.28,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=0}):Play() TS:Create(wS,TweenInfo.new(0.28,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Transparency=0.35}):Play() TS:Create(fd,TweenInfo.new(0.24),{BackgroundColor3=AC}):Play() else TS:Create(win,TweenInfo.new(0.22,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{BackgroundTransparency=1}):Play() TS:Create(wS,TweenInfo.new(0.22,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{Transparency=1}):Play() task.delay(0.3,function() if not vis then win.Visible=false end end) TS:Create(fd,TweenInfo.new(0.24),{BackgroundColor3=Color3.fromRGB(90,196,140)}):Play() end end
fl.MouseButton1Click:Connect(function() if not fM then shW(not vis) end end)
local _sD,_dlg
local function killD(inst) if not _dlg then return end if inst then pcall(function() _dlg:Destroy() end) pcall(function() _sD:Destroy() end) _dlg=nil _sD=nil return end local ti=TweenInfo.new(0.22,Enum.EasingStyle.Quart,Enum.EasingDirection.In) local items={_dlg,_sD} for _,c in ipairs(_dlg:GetDescendants()) do items[#items+1]=c end for _,el in ipairs(items) do if el and el:IsA("TextLabel") then TS:Create(el,ti,{TextTransparency=1}):Play() elseif el and el:IsA("TextButton") then TS:Create(el,ti,{BackgroundTransparency=1,TextTransparency=1}):Play() elseif el and el:IsA("UIStroke") then TS:Create(el,ti,{Transparency=1}):Play() elseif el and el:IsA("Frame") then TS:Create(el,ti,{BackgroundTransparency=1}):Play() end end task.delay(0.28,function() pcall(function() _dlg:Destroy() end) pcall(function() _sD:Destroy() end) _dlg=nil _sD=nil end) end
local function ask() killD(true) _sD=mk("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=1,BorderSizePixel=0,Text="",AutoButtonColor=false,ZIndex=40},sg) _dlg=mk("Frame",{Size=UDim2.fromOffset(280,130),AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,0.5,0),BackgroundColor3=PN,BackgroundTransparency=1,BorderSizePixel=0,ZIndex=41},sg) cr(_dlg,10) local ds=sk(_dlg,BR,1) local dt=lb(_dlg,"Close GUI",14,14,250,20,TX,14,true) dt.TextTransparency=1 dt.ZIndex=42 local dm=mk("TextLabel",{Size=UDim2.new(1,-28,0,40),Position=UDim2.new(0,14,0,40),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=12,TextColor3=SB,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top,TextWrapped=true,Text="Are you sure you want to close this GUI?",TextTransparency=1,ZIndex=42},_dlg) local nb=mk("TextButton",{Size=UDim2.new(0.5,-20,0,32),Position=UDim2.new(0,14,1,-46),BackgroundColor3=EL,BackgroundTransparency=1,BorderSizePixel=0,Font=Enum.Font.Gotham,TextSize=12,TextColor3=TX,TextTransparency=1,Text="No",AutoButtonColor=false,ZIndex=42},_dlg) cr(nb,6) local yb=mk("TextButton",{Size=UDim2.new(0.5,-20,0,32),Position=UDim2.new(0.5,6,1,-46),BackgroundColor3=Color3.fromRGB(180,70,70),BackgroundTransparency=1,BorderSizePixel=0,Font=Enum.Font.Gotham,TextSize=12,TextColor3=Color3.new(1,1,1),TextTransparency=1,Text="Yes",AutoButtonColor=false,ZIndex=42},_dlg) cr(yb,6) local ti=TweenInfo.new(0.22,Enum.EasingStyle.Quart,Enum.EasingDirection.Out) TS:Create(_sD,ti,{BackgroundTransparency=0.5}):Play() TS:Create(_dlg,ti,{BackgroundTransparency=0}):Play() TS:Create(ds,ti,{Transparency=0.3}):Play() TS:Create(dt,ti,{TextTransparency=0}):Play() TS:Create(dm,ti,{TextTransparency=0}):Play() TS:Create(nb,ti,{BackgroundTransparency=0,TextTransparency=0}):Play() TS:Create(yb,ti,{BackgroundTransparency=0,TextTransparency=0}):Play() nb.MouseButton1Click:Connect(function() killD(false) end) yb.MouseButton1Click:Connect(function() if rec.on then rec.on=false pcall(unHook) end pb.on=false stopAutoSkip() pcall(function() sg:Destroy() end) end) end
xb.MouseButton1Click:Connect(ask)
local function getRF() local ml=RS:FindFirstChild("ModuleLoader") if not ml then return nil end local sh=ml:FindFirstChild("Shared") if not sh then return nil end local nw=sh:FindFirstChild("Network") if not nw then return nil end return nw:FindFirstChild("RemoteEvent") end
local REM={}
local function rRem() local f=getRF() if not f then REM.Add=nil REM.Up=nil REM.Sell=nil REM.Skip=nil REM.Vote=nil return false end REM.Add=f:FindFirstChild("TowerAdd") REM.Up=f:FindFirstChild("TowerUpgrade") REM.Sell=f:FindFirstChild("TowerSell") REM.Skip=f:FindFirstChild("WaveSkip") REM.Vote=f:FindFirstChild("ModeVote") return REM.Add and REM.Up and REM.Sell end
rRem()
local IDA={"Id","ID","UnitId","UUID","uid","InstanceId","GUID"}
local function extId(o) if not o then return nil end for _,a in ipairs(IDA) do local ok,v=pcall(function() return o:GetAttribute(a) end) if ok and v~=nil then return v end end for _,a in ipairs(IDA) do local c=o:FindFirstChild(a) if c and (c:IsA("StringValue") or c:IsA("IntValue") or c:IsA("NumberValue")) then return c.Value end end return nil end
local function capUnit(pos,to) local found,fid,done=nil,nil,false local conn=workspace.DescendantAdded:Connect(function(o) if done then return end if not o:IsA("Model") then return end local ok,pv=pcall(function() return o:GetPivot().Position end) if ok and (pv-pos).Magnitude<15 then local id=extId(o) if id~=nil then found=o fid=id done=true end end end) local dl=tick()+to while tick()<dl and not done do task.wait(0.05) end done=true pcall(function() conn:Disconnect() end) return found,fid end
local rec={a={},n=0,t={},k={},l=0,on=false,last=nil}
local pb={on=false,sess=0}
local hInst=false
local hOld=nil
local hits=0
local function recCall(self,m,args)
    if self==REM.Add then
        local d=args[1]
        if type(d)=="table" and d.CFrame and d.Pos then
            rec.n=rec.n+1
            local sid=rec.n
            local cf=d.CFrame
            local ps=d.Pos
            local tk=tick()
            rec.a[#rec.a+1]={t="P",sid=sid,unitId=d.UnitId,name=d.Name,cf={cf:GetComponents()},pos={ps.X,ps.Y,ps.Z},d=tk-(rec.l~=0 and rec.l or tk)}
            rec.l=tk
            hits=hits+1
            task.spawn(function()
                local u,gid=capUnit(ps,2.5)
                if u then rec.t[sid]=u rec.k[u]=sid rec.last=u end
                if gid~=nil then rec.k["id:"..tostring(gid)]=sid end
                if _cL then _cL() end
            end)
        end
    elseif self==REM.Up then
        local d=args[1]
        if type(d)=="table" and d.Id~=nil then
            local sid=rec.k["id:"..tostring(d.Id)]
            if sid then
                local tk=tick()
                rec.a[#rec.a+1]={t="U",sid=sid,d=tk-(rec.l~=0 and rec.l or tk)}
                rec.l=tk
                hits=hits+1
                if _cL then _cL() end
            end
        end
    elseif self==REM.Sell then
        local d=args[1]
        if type(d)=="table" and d.Id~=nil then
            local sid=rec.k["id:"..tostring(d.Id)]
            if sid then
                local tk=tick()
                rec.a[#rec.a+1]={t="S",sid=sid,d=tk-(rec.l~=0 and rec.l or tk)}
                rec.l=tk
                hits=hits+1
                if _cL then _cL() end
            end
        end
    end
end
local function hBd(self,...)
    if not rec.on then return hOld(self,...) end
    if self~=REM.Add and self~=REM.Up and self~=REM.Sell then return hOld(self,...) end
    local m=getnamecallmethod and getnamecallmethod() or ""
    if m~="FireServer" and m~="InvokeServer" then return hOld(self,...) end
    local a={...}
    local r=hOld(self,...)
    pcall(recCall,self,m,a)
    return r
end
local function inHook()
    if hInst then return true end
    if type(hookmetamethod)=="function" and type(newcclosure)=="function" then
        local ok=pcall(function() hOld=hookmetamethod(game,"__namecall",newcclosure(hBd)) end)
        if ok and hOld then hInst=true return true end
    end
    if type(getrawmetatable)=="function" and type(setreadonly)=="function" and type(newcclosure)=="function" then
        local ok=pcall(function() local mt=getrawmetatable(game) hOld=mt.__namecall setreadonly(mt,false) mt.__namecall=newcclosure(hBd) setreadonly(mt,true) end)
        if ok and hOld then hInst=true return true end
    end
    return false
end
local function unHook() if not hInst then return end hInst=false pcall(function() local mt=getrawmetatable(game) setreadonly(mt,false) mt.__namecall=hOld setreadonly(mt,true) end) hOld=nil end
local C={P=0,U=0,S=0}
local function callR(fn,args) if not fn then return end if fn:IsA("RemoteFunction") then pcall(function() fn:InvokeServer(args) end) else pcall(function() fn:FireServer(args) end) end end
local function play()
    if pb.on then return end
    pb.on=true
    pb.sess=pb.sess+1
    local ms=pb.sess
    local data=rj(FO..sel..".json")
    if type(data)~="table" or #data==0 then pb.on=false return end
    C.P=0 C.U=0 C.S=0
    if not rRem() then N("Macro","Remotes not found") pb.on=false return end
    local m={}
    task.spawn(function()
        for _,a in ipairs(data) do
            if not pb.on or pb.sess~=ms then break end
            local d=a.d or 0
            if d>0 then local t0=tick() while tick()-t0<d and pb.on and pb.sess==ms do task.wait(0.05) end end
            if not pb.on or pb.sess~=ms then break end
            if a.t=="P" then
                local ps=Vector3.new(unpack(a.pos))
                local found,fid,done=nil,nil,false
                local conn=workspace.DescendantAdded:Connect(function(o)
                    if done then return end
                    if not o:IsA("Model") then return end
                    local ok,pv=pcall(function() return o:GetPivot().Position end)
                    if ok and (pv-ps).Magnitude<15 then
                        local id=extId(o)
                        if id~=nil then found=o fid=id done=true end
                    end
                end)
                callR(REM.Add,{UnitId=a.unitId,CFrame=CFrame.new(unpack(a.cf)),Name=a.name,Pos=ps})
                C.P=C.P+1
                local dl=tick()+3
                while tick()<dl and not done and pb.on and pb.sess==ms do task.wait(0.05) end
                done=true
                pcall(function() conn:Disconnect() end)
                if fid~=nil then m[a.sid]=fid end
            elseif a.t=="U" then
                local g=m[a.sid]
                if g~=nil then callR(REM.Up,{Id=g}) C.U=C.U+1 end
            elseif a.t=="S" then
                local g=m[a.sid]
                if g~=nil then callR(REM.Sell,{Id=g}) C.S=C.S+1 end
            end
        end
        if pb.sess==ms then pb.on=false if _pT and _pT.GetValue() then _pT.SetValue(false) end end
    end)
end
local function stopP() pb.on=false pb.sess=pb.sess+1 end
local autoSkipOn=false
local autoSkipSess=0
local function startAutoSkip()
    if autoSkipOn then return end
    autoSkipOn=true
    autoSkipSess=autoSkipSess+1
    local ms=autoSkipSess
    task.spawn(function()
        while autoSkipOn and autoSkipSess==ms and sg and sg.Parent do
            if not REM.Skip or not REM.Skip.Parent then rRem() end
            if REM.Skip then pcall(function() REM.Skip:FireServer() end) end
            task.wait(1)
        end
    end)
end
local function stopAutoSkip() autoSkipOn=false autoSkipSess=autoSkipSess+1 end
local voteModes={"Easy","Normal","Hard","Insane"}
local voteIdx=1
for i,v in ipairs(voteModes) do if v==Cfg.vm then voteIdx=i end end
local function fireVote()
    if not REM.Vote or not REM.Vote.Parent then rRem() end
    if REM.Vote then pcall(function() REM.Vote:FireServer(voteModes[voteIdx]) end) end
end
local mP=pg("Main")
local c1=cd(mP,"Statistics",12) c1.Size=UDim2.new(1,-24,0,84)
lb(c1,"Place",12,30,80,12,SB,9,false) lb(c1,"Upgrade",112,30,80,12,SB,9,false) lb(c1,"Sell",212,30,80,12,SB,9,false)
local _pL=lb(c1,"0",12,44,80,20,TX,16,true) local _uL=lb(c1,"0",112,44,80,20,TX,16,true) local _sL=lb(c1,"0",212,44,80,20,TX,16,true)
local function rC() pcall(function() stL.Text=string.format("Place %d | Upgrade %d | Sell %d",C.P,C.U,C.S) end) pcall(function() _pL.Text=tostring(C.P) _uL.Text=tostring(C.U) _sL.Text=tostring(C.S) end) end
local c2=cd(mP,"Remote Status",104) c2.Size=UDim2.new(1,-24,0,130)
local aLb=lb(c2,"TowerAdd: checking...",12,28,240,14,SB,10,false)
local uLb=lb(c2,"TowerUpgrade: checking...",12,46,240,14,SB,10,false)
local sLb=lb(c2,"TowerSell: checking...",12,64,240,14,SB,10,false)
local skLb=lb(c2,"WaveSkip: checking...",12,82,240,14,SB,10,false)
local voLb=lb(c2,"ModeVote: checking...",12,100,240,14,SB,10,false)
local function rRU()
    rRem()
    local function ck(v) return v and "OK" or "MISSING" end
    aLb.Text="TowerAdd: "..ck(REM.Add) aLb.TextColor3=REM.Add and Color3.fromRGB(90,196,140) or Color3.fromRGB(220,96,96)
    uLb.Text="TowerUpgrade: "..ck(REM.Up) uLb.TextColor3=REM.Up and Color3.fromRGB(90,196,140) or Color3.fromRGB(220,96,96)
    sLb.Text="TowerSell: "..ck(REM.Sell) sLb.TextColor3=REM.Sell and Color3.fromRGB(90,196,140) or Color3.fromRGB(220,96,96)
    skLb.Text="WaveSkip: "..ck(REM.Skip) skLb.TextColor3=REM.Skip and Color3.fromRGB(90,196,140) or Color3.fromRGB(220,96,96)
    voLb.Text="ModeVote: "..ck(REM.Vote) voLb.TextColor3=REM.Vote and Color3.fromRGB(90,196,140) or Color3.fromRGB(220,96,96)
end
task.spawn(function() while sg and sg.Parent do rRU() task.wait(2) end end)
-- PLAY PAGE
local pP=pg("Play")
local cp=cd(pP,"Automation",12) cp.Size=UDim2.new(1,-24,0,180)
local aSkTg
aSkTg=tg(cp,"Auto Skip","Fire WaveSkip every 1s",12,26,240,38,false,function(on)
    if on then startAutoSkip() else stopAutoSkip() end
end)
lb(cp,"VOTE MODE",12,74,120,12,SB,9,true)
local vmOpts={"Easy","Normal","Hard","Insane"}
local vmLbl=mk("TextButton",{Size=UDim2.new(1,-24,0,28),Position=UDim2.new(0,12,0,90),BackgroundColor3=BG,BorderSizePixel=0,Font=Enum.Font.Gotham,TextSize=11,TextColor3=TX,Text="Mode: "..voteModes[voteIdx],AutoButtonColor=false,TextXAlignment=Enum.TextXAlignment.Left},cp)
cr(vmLbl,5)
local vmPad=lb(vmLbl,"  ",0,0,10,28,MT,11,false)
vmLbl.MouseButton1Click:Connect(function()
    voteIdx=voteIdx%#voteModes+1
    vmLbl.Text="Mode: "..voteModes[voteIdx]
    set("vm",voteModes[voteIdx])
    fireVote()
    N("Macro","Vote: "..voteModes[voteIdx])
end)
bt(cp,"Send Vote Now",12,126,240,28,"p",function()
    fireVote()
    N("Macro","Voted: "..voteModes[voteIdx])
end)
local mP2=pg("Macro")
local rc=cd(mP2,"Macro Name",12) rc.Size=UDim2.new(1,-24,0,56)
lb(rc,"Name",12,26,50,24,SB,11,false)
local mnBox=mk("TextBox",{Size=UDim2.new(1,-80,0,26),Position=UDim2.new(0,64,0,20),BackgroundColor3=BG,BorderSizePixel=0,Font=Enum.Font.Gotham,TextSize=11,TextColor3=TX,PlaceholderText="e.g. Farm",PlaceholderColor3=MT,Text=Cfg.mn or "",ClearTextOnFocus=false},rc) cr(mnBox,5)
mnBox.FocusLost:Connect(function() set("mn",mnBox.Text or "") end)
local rc2=cd(mP2,"Macro Actions",76) rc2.Size=UDim2.new(1,-24,0,300)
local mStat=lb(rc2,"Status: Idle",12,26,110,14,SB,10,true)
local mCnt=lb(rc2,"Actions: 0",124,26,100,14,MT,10,false)
lb(rc2,"STATISTICS",12,48,120,12,SB,9,true)
local sPl=lb(rc2,"Place: 0",12,64,90,16,TX,11,true)
local sUp=lb(rc2,"Upgrade: 0",102,64,90,16,TX,11,true)
local sSl=lb(rc2,"Sell: 0",192,64,90,16,TX,11,true)
local function sSt(s) if not mStat or not mStat.Parent then return end local col=MT if s=="Recording" then col=Color3.fromRGB(220,96,96) elseif s=="Playing" then col=Color3.fromRGB(90,196,140) elseif s=="Idle" then col=SB end mStat.Text="Status: "..s pcall(function() TS:Create(mStat,TweenInfo.new(0.2),{TextColor3=col}):Play() end) end
local function sCn(n) if mCnt and mCnt.Parent then mCnt.Text="Actions: "..tostring(n) end end
local mList=lf()
local mIdx=0
for i,v in ipairs(mList) do if v==sel then mIdx=i end end
local mSel=mk("TextButton",{Size=UDim2.new(1,-24,0,28),Position=UDim2.new(0,12,0,90),BackgroundColor3=EL,BorderSizePixel=0,Font=Enum.Font.Gotham,TextSize=11,TextColor3=TX,Text=sel~="" and sel or "-- select macro --",AutoButtonColor=false},rc2) cr(mSel,5)
local function rML() mList=lf() mIdx=0 for i,v in ipairs(mList) do if v==sel then mIdx=i end end mSel.Text=sel~="" and sel or "-- select macro --" end
mSel.MouseButton1Click:Connect(function() mList=lf() if #mList==0 then N("Macro","No saved macros") return end mIdx=mIdx%#mList+1 local ch=mList[mIdx] mSel.Text=ch sel=ch set("sel",ch) end)
bt(rc2,"Create / Save Macro",12,126,240,28,"p",function() local n=mnBox.Text or "" if n=="" then N("Macro","Enter a name") return end pcall(function() if type(isfile)~="function" or not isfile(FO..n..".json") then wj(FO..n..".json",{}) end end) sel=n set("sel",n) rML() N("Macro","Ready: "..n) end)
local rToggle
rToggle=tg(rc2,"Record Macro","Start/stop recording",12,162,240,38,false,function(on)
    if on then
        if rec.on then N("Macro","Already recording") rToggle.SetValue(true) return end
        if pb.on then N("Macro","Stop playback first") rToggle.SetValue(false) return end
        if sel=="" then N("Macro","Select a macro first") rToggle.SetValue(false) return end
        rec.a={} rec.n=0 rec.t={} rec.k={} rec.l=0 rec.last=nil
        C.P=0 C.U=0 C.S=0 rC() sCn(0) hits=0
        rRem()
        local ok=inHook()
        if not ok then N("Macro","Hook unavailable") rToggle.SetValue(false) return end
        rec.on=true
        sSt("Recording")
        N("Macro","Recording -> "..sel)
    else
        if not rec.on then sSt("Idle") return end
        rec.on=false
        unHook()
        if #rec.a>0 and sel~="" then
            if wj(FO..sel..".json",rec.a) then N("Macro","Saved "..#rec.a.." steps") else N("Macro","Save failed") end
        else
            N("Macro","Nothing saved (hits="..hits..")")
        end
        rec.a={} rec.n=0 rec.t={} rec.k={} rec.l=0 rec.last=nil
        C.P=0 C.U=0 C.S=0 rC() sCn(0)
        sSt("Idle")
    end
end)
local _pT
_pT=tg(rc2,"Play Macro","Playback recorded macro",12,206,240,38,false,function(on)
    if on then
        if rec.on then N("Macro","Stop recording first") _pT.SetValue(false) return end
        if sel=="" then N("Macro","Select a macro first") _pT.SetValue(false) return end
        local d=rj(FO..sel..".json")
        if type(d)~="table" or #d==0 then N("Macro","Macro empty") _pT.SetValue(false) return end
        sSt("Playing")
        play()
    else
        stopP()
        sSt("Idle")
    end
end)
bt(rc2,"Delete Macro",12,252,240,28,"d",function() if sel=="" then N("Macro","Select a macro") return end pcall(function() if type(delfile)=="function" then delfile(FO..sel..".json") end end) sel="" set("sel","") rML() N("Macro","Deleted") end)
local dP=pg("Debug")
local dc=cd(dP,"Recorded Actions",12) dc.Size=UDim2.new(1,-24,0,340)
local dbSt=lb(dc,"No macro selected",12,26,240,14,SB,10,false)
local dbLs=mk("TextLabel",{Size=UDim2.new(1,-24,0,240),Position=UDim2.new(0,12,0,46),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=10,TextColor3=MT,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top,TextWrapped=true,Text=""},dc)
local function rDb() if sel=="" then dbSt.Text="No macro selected" dbLs.Text="" return end local d=rj(FO..sel..".json") if type(d)~="table" or #d==0 then dbSt.Text="Macro empty: "..sel dbLs.Text="" return end dbSt.Text="Macro: "..sel.." ("..#d.." actions)" local L={} for i,a in ipairs(d) do if i>25 then L[#L+1]="... +"..(#d-25).." more" break end local dl=string.format("%.2f",a.d or 0) if a.t=="P" then L[#L+1]=string.format("%d.[%ss] PLACE %s sid=%s",i,dl,tostring(a.name),tostring(a.sid)) elseif a.t=="U" then L[#L+1]=string.format("%d.[%ss] UPGRADE sid=%s",i,dl,tostring(a.sid)) elseif a.t=="S" then L[#L+1]=string.format("%d.[%ss] SELL sid=%s",i,dl,tostring(a.sid)) end end dbLs.Text=table.concat(L,"\n") end
bt(dc,"Refresh",12,300,116,28,function() rDb() end)
bt(dc,"Copy JSON",128,300,116,28,function() if sel=="" then N("Macro","No macro selected") return end local d=rj(FO..sel..".json") if not d then N("Macro","Empty") return end local ok,j=pcall(function() return HS:JSONEncode(d) end) if not ok then N("Macro","Encode failed") return end local fn=setclipboard or toclipboard or writeclipboard if type(fn)~="function" then N("Macro","Clipboard not available") return end pcall(fn,j) N("Macro","Copied JSON") end)
local gP=pg("GUI")
local th=cd(gP,"Theme",12) th.Size=UDim2.new(1,-24,0,180)
local themes={{n="Purple",c=Color3.fromRGB(155,120,255)},{n="Red",c=Color3.fromRGB(220,96,96)},{n="Blue",c=Color3.fromRGB(108,142,255)},{n="Green",c=Color3.fromRGB(90,196,140)},{n="Orange",c=Color3.fromRGB(240,150,60)},{n="Pink",c=Color3.fromRGB(230,120,180)},{n="Cyan",c=Color3.fromRGB(0,200,220)},{n="Yellow",c=Color3.fromRGB(230,200,90)}}
local tEnt={}
local function isSm(a,b) return math.abs(a.R-b.R)<0.01 and math.abs(a.G-b.G)<0.01 and math.abs(a.B-b.B)<0.01 end
local function sTS() for _,e in ipairs(tEnt) do if not e.str or not e.str.Parent then break end local isS=isSm(e.c,AC) TS:Create(e.str,TweenInfo.new(0.25,Enum.EasingStyle.Quart),{Transparency=isS and 0 or 0.85,Color=e.c}):Play() end end
_sT=sTS
for i,t in ipairs(themes) do local col=(i-1)%2 local row=math.floor((i-1)/2) local px=(col==0) and UDim2.new(0,12,0,30+row*34) or UDim2.new(0.5,6,0,30+row*34) local b=mk("TextButton",{Size=UDim2.new(0.5,-18,0,28),Position=px,BackgroundColor3=EL,BorderSizePixel=0,Font=Enum.Font.Gotham,TextSize=11,TextColor3=TX,Text="  "..t.n,AutoButtonColor=false,TextXAlignment=Enum.TextXAlignment.Left},th) cr(b,6) local str=sk(b,t.c,0.85) local dot=mk("Frame",{Size=UDim2.fromOffset(14,14),Position=UDim2.new(1,-22,0.5,-7),BackgroundColor3=t.c,BorderSizePixel=0},b) cr(dot,7) tEnt[#tEnt+1]={btn=b,str=str,c=t.c} end
for _,e in ipairs(tEnt) do e.btn.MouseButton1Click:Connect(function() setAC(e.c) set("acr",math.floor(e.c.R*255+0.5)) set("acg",math.floor(e.c.G*255+0.5)) set("acb",math.floor(e.c.B*255+0.5)) sTS() end) end
sTS()
local function updateCnt() local p,u,s=0,0,0 for _,a in ipairs(rec.a) do if a.t=="P" then p=p+1 elseif a.t=="U" then u=u+1 elseif a.t=="S" then s=s+1 end end C.P=p C.U=u C.S=s rC() sCn(#rec.a) pcall(function() sPl.Text="Place: "..tostring(p) sUp.Text="Upgrade: "..tostring(u) sSl.Text="Sell: "..tostring(s) end) end
_cL=updateCnt
task.spawn(function() while sg and sg.Parent do rC() task.wait(0.5) end end)
task.spawn(function() task.wait(0.3) iA() sTS() rDb() end)
go("Main") rC() N("Macro","Ready v2.11")
print("[MacroATD] v2.11 loaded")