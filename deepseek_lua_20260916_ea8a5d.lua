mt.__namecall=newcclosure(function(self,...)
    if not rec.active then return old(self,...) end
    if self~=HR.PL and self~=HR.UP and self~=HR.SE and self~=HR.SK and self~=HR.SP then
        return old(self,...)
    end
    local m=getnamecallmethod()
    local x={...}
    local r=old(self,...)
    pcall(function()
        if m=="InvokeServer" and self==HR.PL then
            local n,cf=x[1],x[2]
            if typeof(cf)=="CFrame" then
                C.P=C.P+1
                placeQueue[#placeQueue+1]={cf=cf,n=n}
                processPlaceQueue()
            end
        ...