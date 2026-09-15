-- EZVC Hub v1.1 - Full GUI + Logic + GUI Tab + Anti AFK
local TS=game:GetService("TweenService")
local UIS=game:GetService("UserInputService")
local RS=game:GetService("ReplicatedStorage")
local HS=game:GetService("HttpService")
local VU=game:GetService("VirtualUser")
local PLR=game:GetService("Players").LocalPlayer
local PG=PLR:FindFirstChild("PlayerGui") or PLR:WaitForChild("PlayerGui")

-- GUI parent
local par
pcall(function() if gethui then local ok,h=pcall(gethui) if ok and h then par=h end end end)
par=par or game:GetService("CoreGui")
for _,v in ipairs(par:GetChildren()) do
    if v.Name=="EZVCProto" then pcall(function() v:Destroy() end) end
end
local sg=Instance.new("ScreenGui")
sg.Name="EZVCProto"
sg.IgnoreGuiInset=true
sg.ResetOnSpawn=false
sg.DisplayOrder=999
sg.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
sg.Parent=par

-- Helpers
local function mk(c,p,r)
    local o=Instance.new(c)
    for k,v in next,p do o[k]=v end
    if r then o.Parent=r end
    return o
end
local function cr(o,r) mk("UICorner",{CornerRadius=UDim.new(0,r)},o) end
local function sk(o,c,t) return mk("UIStroke",{Color=c,Thickness=1,Transparency=t},o) end
local function lb(p,t,x,y,w,h,c,s,b)
    return mk("TextLabel",{Size=UDim2.new(0,w,0,h),Position=UDim2.new(0,x,0,y),BackgroundTransparency=1,Font=b and Enum.Font.GothamBold or Enum.Font.Gotham,TextSize=s or 11,TextColor3=c,TextXAlignment=Enum.TextXAlignment.Left,Text=t},p)
end

-- Colors
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
local OFF=Color3.fromRGB(52,52,60)

-- Accent refs
local tRefs={}
local function rT(p,f) tRefs[#tRefs+1]={p=p,f=f} end
local function setAC(c)
    AC=c
    for _,e in ipairs(tRefs) do
        local v=e.f and e.f() or c
        TS:Create(e.p,TweenInfo.new(0.28,Enum.EasingStyle.Quart),{BackgroundColor3=v}):Play()
    end
end

-- Main window
local win=mk("Frame",{Size=UDim2.fromOffset(420,300),AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,0.5,0),BackgroundColor3=BG,BorderSizePixel=0},sg)
cr(win,12)
local wS=sk(win,BR,0.35)

local function fit()
    pcall(function()
        local cam=workspace.CurrentCamera
        if not cam then return end
        local vp=cam.ViewportSize
        if vp.X<=0 or vp.Y<=0 then return end
        win.Size=UDim2.fromOffset(math.clamp(math.floor(vp.X*0.92),300,460),math.clamp(math.floor(vp.Y*0.78),260,340))
        win.Position=UDim2.new(0.5,0,0.5,0)
    end)
end
fit()
pcall(function() workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fit) end)

-- Header
local hdr=mk("Frame",{Size=UDim2.new(1,0,0,38),BackgroundColor3=HD,BorderSizePixel=0},win)
cr(hdr,12)
mk("Frame",{Size=UDim2.new(1,0,0,12),Position=UDim2.new(0,0,1,-12),BackgroundColor3=HD,BorderSizePixel=0},hdr)
local aDot=mk("Frame",{Size=UDim2.fromOffset(10,10),Position=UDim2.new(0,14,0.5,-5),BackgroundColor3=AC,BorderSizePixel=0},hdr)
cr(aDot,3)
rT(aDot)
lb(hdr,"EZVC Hub",30,0,120,38,TX,13,true)
lb(hdr,"v1.1",92,0,90,38,MT,9,false)

local xb=mk("TextButton",{Size=UDim2.fromOffset(24,24),Position=UDim2.new(1,-30,0.5,-12),BackgroundColor3=EL,BorderSizePixel=0,Font=Enum.Font.Gotham,TextSize=11,TextColor3=SB,Text="X",AutoButtonColor=false},hdr)
cr(xb,6)
xb.MouseEnter:Connect(function() TS:Create(xb,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(200,90,90),TextColor3=Color3.new(1,1,1)}):Play() end)
xb.MouseLeave:Connect(function() TS:Create(xb,TweenInfo.new(0.15),{BackgroundColor3=EL,TextColor3=SB}):Play() end)

-- Drag
local dg,d0,d1=false,nil,nil
hdr.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
        dg=true d0=i.Position d1=win.Position
    end
end)
UIS.InputChanged:Connect(function(i)
    if dg and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
        local d=i.Position-d0
        win.Position=UDim2.new(d1.X.Scale,d1.X.Offset+d.X,d1.Y.Scale,d1.Y.Offset+d.Y)
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dg=false end
end)

-- Body
local body=mk("Frame",{Size=UDim2.new(1,0,1,-38),Position=UDim2.new(0,0,0,38),BackgroundTransparency=1},win)
local sideBar=mk("Frame",{Size=UDim2.new(0,118,1,0),BackgroundColor3=SF,BorderSizePixel=0},body)
mk("Frame",{Size=UDim2.new(0,1,1,0),Position=UDim2.new(1,-1,0,0),BackgroundColor3=BR,BackgroundTransparency=0.4,BorderSizePixel=0},sideBar)
local ct=mk("Frame",{Size=UDim2.new(1,-118,1,0),Position=UDim2.new(0,118,0,0),BackgroundTransparency=1},body)

-- Tabs
local pages,tabs,cur={},{},nil
local function go(n)
    if cur==n then return end
    for k,p in pairs(pages) do
        if k==n then
            p.Visible=true
            p.Position=UDim2.new(0,5,0,0)
            TS:Create(p,TweenInfo.new(0.22,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(0,0,0,0)}):Play()
        else
            p.Visible=false
        end
    end
    for k,b in pairs(tabs) do
        if k==n then TS:Create(b,TweenInfo.new(0.18),{BackgroundColor3=EL,TextColor3=TX}):Play()
        else TS:Create(b,TweenInfo.new(0.18),{BackgroundColor3=SF,TextColor3=MT}):Play() end
    end
    cur=n
end

for i,n in ipairs({"Main","Play","Macro","GUI"}) do
    local b=mk("TextButton",{Size=UDim2.new(1,-16,0,28),Position=UDim2.new(0,8,0,10+(i-1)*32),BackgroundColor3=SF,BorderSizePixel=0,Font=Enum.Font.Gotham,TextSize=11,TextColor3=MT,Text="  "..n,AutoButtonColor=false,TextXAlignment=Enum.TextXAlignment.Left},sideBar)
    cr(b,6)
    b.MouseButton1Click:Connect(function() go(n) end)
    tabs[n]=b
end

for i,c in ipairs({Color3.fromRGB(155,120,255),Color3.fromRGB(108,142,255),Color3.fromRGB(0,200,220),Color3.fromRGB(90,196,140),Color3.fromRGB(220,96,96),Color3.fromRGB(240,150,60),Color3.fromRGB(230,120,180)}) do
    local s=mk("TextButton",{Size=UDim2.fromOffset(12,12),Position=UDim2.new(0,8+(i-1)*15,1,-20),BackgroundColor3=c,BorderSizePixel=0,Text="",AutoButtonColor=false},sideBar)
    cr(s,6)
    s.MouseButton1Click:Connect(function() setAC(c) end)
end

-- Builders
local function pg(n)
    local s=mk("ScrollingFrame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=EL,CanvasSize=UDim2.new(0,0,0,700),Visible=false},ct)
    pages[n]=s
    return s
end

local function cd(p,t,y)
    local f=mk("Frame",{Size=UDim2.new(1,-24,0,0),Position=UDim2.new(0,12,0,y),BackgroundColor3=PN,BorderSizePixel=0},p)
    cr(f,8)
    sk(f,BR,0.4)
    if t then lb(f,string.upper(t),12,10,200,12,SB,10,true) end
    return f
end

local function btn(p,t,x,y,w,h,k,cb)
    local bc,tc=EL,TX
    if k=="p" then bc=AC tc=Color3.new(1,1,1) end
    if k=="d" then bc=Color3.fromRGB(56,34,34) tc=Color3.fromRGB(230,150,150) end
    local o=mk("TextButton",{Size=UDim2.new(0,w,0,h),Position=UDim2.new(0,x,0,y),BackgroundColor3=bc,BorderSizePixel=0,Font=Enum.Font.Gotham,TextSize=11,TextColor3=tc,Text=t,AutoButtonColor=false},p)
    cr(o,6)
    if k=="p" then rT(o) end
    o.MouseEnter:Connect(function() TS:Create(o,TweenInfo.new(0.14),{BackgroundColor3=bc:Lerp(Color3.new(1,1,1),0.15)}):Play() end)
    o.MouseLeave:Connect(function() TS:Create(o,TweenInfo.new(0.14),{BackgroundColor3=bc}):Play() end)
    if cb then o.MouseButton1Click:Connect(cb) end
    return o
end

local function tg(p,nm,ds,x,y,w,h,on,cb)
    local box=mk("Frame",{Size=UDim2.new(0,w,0,h),Position=UDim2.new(0,x,0,y),BackgroundColor3=EL,BorderSizePixel=0},p)
    cr(box,6)
    if ds then
        lb(box,nm,10,5,w-50,14,TX,11,false)
        lb(box,ds,10,20,w-50,11,SB,9,false)
    else
        lb(box,nm,10,0,w-50,h,TX,11,false)
    end
    local st=on
    local sw=mk("Frame",{Size=UDim2.fromOffset(32,18),Position=UDim2.new(1,-44,0.5,-9),BackgroundColor3=on and AC or OFF,BorderSizePixel=0},box)
    cr(sw,9)
    local kn=mk("Frame",{Size=UDim2.fromOffset(12,12),Position=on and UDim2.new(1,-15,0.5,-6) or UDim2.new(0,3,0.5,-6),BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0},sw)
    cr(kn,6)
    rT(sw,function() return st and AC or OFF end)
    local function apply(v)
        st=v
        TS:Create(sw,TweenInfo.new(0.22,Enum.EasingStyle.Quart),{BackgroundColor3=v and AC or OFF}):Play()
        TS:Create(kn,TweenInfo.new(0.22,Enum.EasingStyle.Quart),{Position=v and UDim2.new(1,-15,0.5,-6) or UDim2.new(0,3,0.5,-6)}):Play()
    end
    local z=mk("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",AutoButtonColor=false},box)
    z.MouseButton1Click:Connect(function()
        apply(not st)
        if cb then cb(st) end
    end)
    return {GetValue=function() return st end,SetValue=apply}
end

-- Notification
local function N(title,content)
    pcall(function()
        local nf=mk("Frame",{Size=UDim2.fromOffset(220,50),Position=UDim2.new(1,-230,1,-70),BackgroundColor3=PN,BorderSizePixel=0,ZIndex=50},sg)
        cr(nf,8)
        sk(nf,BR,0.3)
        local t1=lb(nf,title,12,8,180,16,AC,11,true)
        t1.ZIndex=51
        local t2=lb(nf,content,12,26,196,18,SB,10,false)
        t2.ZIndex=51
        nf.BackgroundTransparency=1
        TS:Create(nf,TweenInfo.new(0.2),{BackgroundTransparency=0}):Play()
        task.delay(3,function()
            TS:Create(nf,TweenInfo.new(0.3),{BackgroundTransparency=1}):Play()
            task.delay(0.35,function() pcall(function() nf:Destroy() end) end)
        end)
    end)
end

-- Status bar
local stBar=mk("Frame",{Size=UDim2.new(1,0,0,18),Position=UDim2.new(0,0,1,-18),BackgroundColor3=SF,BorderSizePixel=0},win)
local stDot=mk("Frame",{Size=UDim2.fromOffset(5,5),Position=UDim2.new(0,11,0.5,-2),BackgroundColor3=Color3.fromRGB(90,196,140),BorderSizePixel=0},stBar)
cr(stDot,3)
local stLbl=lb(stBar,"Lobby 0 | Place 0 | Upgrade 0 | Sell 0",22,0,300,18,MT,9,false)

-- Float toggle
local visWin=true
local fl=mk("TextButton",{Size=UDim2.fromOffset(78,34),Position=UDim2.new(0,16,0,16),BackgroundColor3=HD,BorderSizePixel=0,Font=Enum.Font.GothamBold,TextSize=12,TextColor3=TX,Text="Toggle",AutoButtonColor=false,ZIndex=30},sg)
cr(fl,17)
local fS=sk(fl,BR,0.4)
local fd=mk("Frame",{Size=UDim2.fromOffset(8,8),Position=UDim2.new(0,10,0.5,-4),BackgroundColor3=AC,BorderSizePixel=0},fl)
cr(fd,4)
rT(fd)

local fDg,fM,f0,f1=false,false,nil,nil
fl.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
        fDg=true fM=false f0=i.Position f1=fl.Position
    end
end)
UIS.InputChanged:Connect(function(i)
    if fDg and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
        local d=i.Position-f0
        if math.abs(d.X)>4 or math.abs(d.Y)>4 then fM=true end
        fl.Position=UDim2.new(f1.X.Scale,f1.X.Offset+d.X,f1.Y.Scale,f1.Y.Offset+d.Y)
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then fDg=false end
end)

local function showWin(v)
    visWin=v
    if v then
        win.Visible=true
        win.BackgroundTransparency=1
        wS.Transparency=1
        TS:Create(win,TweenInfo.new(0.28,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=0}):Play()
        TS:Create(wS,TweenInfo.new(0.28,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Transparency=0.35}):Play()
        TS:Create(fd,TweenInfo.new(0.24),{BackgroundColor3=AC}):Play()
    else
        TS:Create(win,TweenInfo.new(0.22,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{BackgroundTransparency=1}):Play()
        TS:Create(wS,TweenInfo.new(0.22,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{Transparency=1}):Play()
        task.delay(0.3,function() if not visWin then win.Visible=false end end)
        TS:Create(fd,TweenInfo.new(0.24),{BackgroundColor3=Color3.fromRGB(90,196,140)}):Play()
    end
end
fl.MouseButton1Click:Connect(function() if not fM then showWin(not visWin) end end)

-- Close dialog
local scrD,dlg
local function killD(instant)
    if not dlg then return end
    if instant then
        pcall(function() dlg:Destroy() end)
        pcall(function() scrD:Destroy() end)
        dlg=nil scrD=nil
        return
    end
    local ti=TweenInfo.new(0.22,Enum.EasingStyle.Quart,Enum.EasingDirection.In)
    local items={dlg,scrD}
    for _,c in ipairs(dlg:GetDescendants()) do items[#items+1]=c end
    for _,el in ipairs(items) do
        if el and el:IsA("TextLabel") then TS:Create(el,ti,{TextTransparency=1}):Play()
        elseif el and el:IsA("TextButton") then TS:Create(el,ti,{BackgroundTransparency=1,TextTransparency=1}):Play()
        elseif el and el:IsA("UIStroke") then TS:Create(el,ti,{Transparency=1}):Play()
        elseif el and el:IsA("Frame") then TS:Create(el,ti,{BackgroundTransparency=1}):Play() end
    end
    task.delay(0.28,function()
        pcall(function() dlg:Destroy() end)
        pcall(function() scrD:Destroy() end)
        dlg=nil scrD=nil
    end)
end

local function ask()
    killD(true)
    scrD=mk("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=1,BorderSizePixel=0,Text="",AutoButtonColor=false,ZIndex=40},sg)
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
    TS:Create(scrD,ti,{BackgroundTransparency=0.5}):Play()
    TS:Create(dlg,ti,{BackgroundTransparency=0}):Play()
    TS:Create(ds,ti,{Transparency=0.3}):Play()
    TS:Create(dt,ti,{TextTransparency=0}):Play()
    TS:Create(dm,ti,{TextTransparency=0}):Play()
    TS:Create(nb,ti,{BackgroundTransparency=0,TextTransparency=0}):Play()
    TS:Create(yb,ti,{BackgroundTransparency=0,TextTransparency=0}):Play()
    nb.MouseButton1Click:Connect(function() killD(false) end)
    yb.MouseButton1Click:Connect(function()
        local to=TweenInfo.new(0.3,Enum.EasingStyle.Quart,Enum.EasingDirection.In)
        local list={dlg,scrD,win,fl,wS,fS}
        for _,c in ipairs(dlg:GetDescendants()) do list[#list+1]=c end
        for _,el in ipairs(list) do
            if el and el:IsA("TextLabel") then TS:Create(el,to,{TextTransparency=1}):Play()
            elseif el and el:IsA("UIStroke") then TS:Create(el,to,{Transparency=1}):Play()
            elseif el then TS:Create(el,to,{BackgroundTransparency=1,TextTransparency=1}):Play() end
        end
        task.delay(0.35,function() pcall(function() sg:Destroy() end) end)
    end)
end
xb.MouseButton1Click:Connect(ask)

-- Config / IO
local FO="tdmacro/"
local CF=FO.."config.json"
pcall(function()
    if type(isfolder)=="function" and type(makefolder)=="function" and not isfolder(FO) then
        makefolder(FO)
    end
end)
local function wj(p,d)
    if type(writefile)~="function" then return false end
    local ok,s=pcall(function() return HS:JSONEncode(d) end)
    if not ok then return false end
    return pcall(writefile,p,s)
end
local function rj(p)
    if type(isfile)~="function" or type(readfile)~="function" or not isfile(p) then return nil end
    local ok,d=pcall(readfile,p)
    if not ok then return nil end
    local ok2,a=pcall(function() return HS:JSONDecode(d) end)
    if not ok2 or type(a)~="table" then return nil end
    return a
end
local function lf()
    if type(listfiles)~="function" then return {} end
    local seen,n={},{}
    for _,p in ipairs({FO,"tdmacro","./tdmacro/"}) do
        local ok,list=pcall(listfiles,p)
        if ok and type(list)=="table" then
            for _,f in ipairs(list) do
                local x=tostring(f):match("([^/\\]+)%.json$")
                if x and x~="state" and x~="config" and not seen[x] then
                    seen[x]=true
                    n[#n+1]=x
                end
            end
        end
    end
    return n
end

local Cfg={}
do
    local c=rj(CF)
    if c and type(c)=="table" then Cfg=c end
end
for k,v in pairs({gs="1",mn="",sel="",sk=false,rp=false,lb=false,rec=false,pl=false,s10=false,s1=false,spn=false,afk=false,acr=155,acg=120,acb=255}) do
    if Cfg[k]==nil then Cfg[k]=v end
end
local _init=true
local _pend=false
local function save()
    if _init or _pend then return end
    _pend=true
    task.spawn(function()
        task.wait(0.2)
        _pend=false
        pcall(function() wj(CF,Cfg) end)
    end)
end
local function set(k,v) Cfg[k]=v save() end

local sel=Cfg.sel or ""
local C={L=0,P=0,U=0,S=0}
local rec={a={},n=1,t={},k={},l=0,active=false}
local R={}

-- Remote cache
local function ens(k,f,n)
    local c=R[k]
    if c and c.Parent then return c end
    local fo=RS:FindFirstChild(f)
    if not fo then return nil end
    local r=fo:FindFirstChild(n)
    if r and (r:IsA("RemoteEvent") or r:IsA("RemoteFunction")) then
        R[k]=r
        return r
    end
end

local rfC=function()
    pcall(function() stLbl.Text=string.format("Lobby %d | Place %d | Upgrade %d | Sell %d",C.L,C.P,C.U,C.S) end)
end

-- GUI visibility check
local function visEl(d)
    if not d.Visible then return false end
    local p=d.Parent
    while p do
        if p:IsA("GuiObject") and not p.Visible then return false end
        p=p.Parent
    end
    return true
end

local function fB(tx)
    local nd=tx:lower()
    local rr={PG}
    pcall(function()
        if gethui then
            local ok,h=pcall(gethui)
            if ok and h then rr[#rr+1]=h end
        end
    end)
    for _,root in ipairs(rr) do
        if root then
            for _,d in ipairs(root:GetDescendants()) do
                if (d:IsA("TextButton") or d:IsA("ImageButton")) and visEl(d) then
                    local t=d.Text
                    if d:IsA("ImageButton") then
                        local lb2=d:FindFirstChildOfClass("TextLabel")
                        if lb2 then t=lb2.Text end
                    end
                    if tostring(t or ""):lower():find(nd,1,true) then return d end
                end
            end
        end
    end
end

-- Cached replay-button detection
local _loseCache=nil
local function lose()
    if _loseCache and _loseCache.Parent and visEl(_loseCache) then return true end
    _loseCache=fB("replay")
    return _loseCache~=nil
end

local function resetRec()
    rec.a={}
    rec.n=1
    rec.t={}
    rec.k={}
    rec.l=tick()
    C.P=0
    C.U=0
    C.S=0
    rfC()
end

-- Auto summon
local function invokeSummon(a)
    local ev
    pcall(function()
        local fo=RS:FindFirstChild("RemoteFunctions")
        if fo then ev=fo:FindFirstChild("SummonUnits") end
    end)
    if not ev or not ev:IsA("RemoteFunction") then return false end
    return pcall(function() ev:InvokeServer(a) end)
end
task.spawn(function()
    while true do
        if Cfg.s10 then
            if invokeSummon(10) then C.L=C.L+1 rfC() end
            task.wait(1)
        else
            task.wait(0.5)
        end
    end
end)
task.spawn(function()
    while true do
        if Cfg.s1 then
            if invokeSummon(1) then C.L=C.L+1 rfC() end
            task.wait(1)
        else
            task.wait(0.5)
        end
    end
end)

-- Auto spin
task.spawn(function()
    while true do
        if Cfg.spn then
            local ev
            pcall(function()
                local fo=RS:FindFirstChild("RemoteFunctions")
                if fo then ev=fo:FindFirstChild("SpinWheel") end
            end)
            if ev and ev:IsA("RemoteFunction") then
                pcall(function() ev:InvokeServer() end)
            end
            task.wait(0.5)
        else
            task.wait(0.2)
        end
    end
end)

-- Auto lobby
local lbLoop=false
local function startLB()
    if lbLoop then return end
    lbLoop=true
    task.spawn(function()
        while Cfg.lb do
            local tl=RS:FindFirstChild("ReturnToLobby")
            if tl and tl:IsA("RemoteEvent") then
                if pcall(function() tl:FireServer() end) then C.L=C.L+1 rfC() end
            end
            task.wait(1)
        end
        lbLoop=false
    end)
end

-- Round watcher
task.spawn(function()
    local was=false
    while true do
        local now=lose()
        if now and not was and rec.active then resetRec() end
        was=now
        task.wait(1)
    end
end)

-- Auto skip
local lastW=nil
local function getSkipBtn()
    local ok,b=pcall(function() return PG.MainGameUI.UpSide.InfoDop.AutoSkip end)
    return ok and b or nil
end
local function setVis(on)
    pcall(function()
        local b=getSkipBtn()
        if not b then return end
        for _,v in ipairs(b:GetDescendants()) do
            if v:IsA("UIGradient") then
                if v.Name=="AutoOff" then v.Enabled=not on
                elseif v.Name=="AutoOn" then v.Enabled=on end
            end
        end
    end)
end
task.spawn(function()
    while true do
        if Cfg.sk then
            local ws=RS:FindFirstChild("WaveState")
            if ws then
                pcall(function()
                    local w=ws:GetAttribute("CurrentWave")
                    local c=ws:GetAttribute("CanSkipWave")
                    local r=ws:GetAttribute("Result")
                    if c==true and r~="Win" and r~="Lose" and lastW~=w then
                        lastW=w
                        local skR=ens("w","RemoteEvents","SkipWaveVote")
                        if skR and pcall(function() skR:FireServer(w) end) then
                            C.L=C.L+1
                            rfC()
                        end
                    end
                end)
            end
        end
        task.wait(0.5)
    end
end)

-- Auto replay
local rpL=false
local function startRP()
    if rpL then return end
    rpL=true
    task.spawn(function()
        while Cfg.rp do
            local re=RS:FindFirstChild("RemoteEvents")
            local rv=re and re:FindFirstChild("ReplayVote")
            if rv and pcall(function() rv:FireServer() end) then
                C.L=C.L+1
                rfC()
            end
            task.wait(1)
        end
        rpL=false
    end)
end

-- ============================================================
-- RECORD HOOK (OPTIMIZED)
-- Fast-path filter BEFORE any allocation. Zero overhead
-- when not recording or when namecall isn't our remote.
-- ============================================================
local HR={PL=nil,UP=nil,SE=nil,SK=nil,SP=nil}
local function refreshHR()
    HR.PL=ens("p","RemoteFunctions","PlaceTower")
    HR.UP=ens("u","RemoteFunctions","UpgradeTower")
    HR.SE=ens("s","RemoteFunctions","SellTower")
    HR.SK=ens("w","RemoteEvents","SkipWaveVote")
    HR.SP=ens("g","RemoteEvents","SetGameSpeed")
end
refreshHR()
task.spawn(function()
    while true do
        if rec.active then refreshHR() end
        task.wait(5)
    end
end)

pcall(function()
    if not (getrawmetatable and setreadonly and newcclosure and getnamecallmethod) then return end
    local mt=getrawmetatable(game)
    local old=mt