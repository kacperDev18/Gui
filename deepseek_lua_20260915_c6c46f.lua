-- EZVC Hub v1.2
local TS=game:GetService("TweenService")
local UIS=game:GetService("UserInputService")
local RS=game:GetService("ReplicatedStorage")
local HS=game:GetService("HttpService")
local VU=game:GetService("VirtualUser")
local PLR=game:GetService("Players").LocalPlayer
local PG=PLR:FindFirstChild("PlayerGui") or PLR:WaitForChild("PlayerGui")

-- ConnTrack: system for auto-cleanup of connections
local Conns={}
local function addConn(c) table.insert(Conns,c) return c end
local function cleanConns()
    for _,c in ipairs(Conns) do pcall(function() c:Disconnect() end) end
    Conns={}
end