-- ============================================
-- MAD OURO v2 - STEAL AN EGG
-- Lengkap, rapi, keyless
-- ============================================

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local P = Players.LocalPlayer
local PG = P:WaitForChild("PlayerGui")

-- ============================================
-- CEK GAME
-- ============================================
local STEAL_EGG_PLACE = 107778070777162
local STEAL_EGG_UNIVERSE = 10563114921
local isStealEgg = (game.PlaceId == STEAL_EGG_PLACE) or (game.GameId == STEAL_EGG_UNIVERSE)

-- ============================================
-- CONFIG
-- ============================================
local CONFIG = {
    basePosition = Vector3.new(0, 10, 0),
    autoSteal = false,
    antiRagdoll = false,
    speedBoost = false,
    speedValue = 100,
    loopDelay = 0.5,
}

-- ============================================
-- HAPUS GUI LAMA
-- ============================================
local old = PG:FindFirstChild("MadOuro")
if old then old:Destroy() end

-- ============================================
-- GUI
-- ============================================
local GUI = Instance.new("ScreenGui")
GUI.Name = "MadOuro"
GUI.ResetOnSpawn = false
GUI.Parent = PG

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(320, 460)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = GUI
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", Main)
stroke.Color = Color3.fromRGB(220, 38, 44)
stroke.Thickness = 2

-- Header
local Header = Instance.new("TextLabel", Main)
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
Header.Text = "⚡ MAD OURO v2"
Header.TextColor3 = Color3.fromRGB(255, 255, 255)
Header.Font = Enum.Font.GothamBlack
Header.TextSize = 16
Header.BorderSizePixel = 0
Header.Parent = Main
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)

-- Subtitle
local Sub = Instance.new("TextLabel", Main)
Sub.Size = UDim2.new(1, -20, 0, 18)
Sub.Position = UDim2.fromOffset(10, 50)
Sub.BackgroundTransparency = 1
Sub.Text = isStealEgg and "✅ Steal An Egg terdeteksi" or "⚠️ Bukan Steal An Egg"
Sub.TextColor3 = isStealEgg and Color3.fromRGB(25, 145, 105) or Color3.fromRGB(255, 200, 0)
Sub.Font = Enum.Font.Gotham
Sub.TextSize = 10
Sub.Parent = Main

-- ============================================
-- SET BASE
-- ============================================
local SetBase = Instance.new("TextButton", Main)
SetBase.Size = UDim2.new(1, -20, 0, 32)
SetBase.Position = UDim2.fromOffset(10, 75)
SetBase.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
SetBase.BorderSizePixel = 0
SetBase.Text = "📍 Set Base Position"
SetBase.TextColor3 = Color3.fromRGB(255, 255, 255)
SetBase.Font = Enum.Font.GothamBold
SetBase.TextSize = 11
SetBase.AutoButtonColor = false
Instance.new("UICorner", SetBase).CornerRadius = UDim.new(0, 8)

SetBase.MouseButton1Click:Connect(function()
    if P.Character and P.Character:FindFirstChild("HumanoidRootPart") then
        CONFIG.basePosition = P.Character.HumanoidRootPart.Position
        SetBase.Text = "📍 Base Tersimpan!"
        task.wait(1)
        SetBase.Text = "📍 Set Base Position"
    end
end)

-- ============================================
-- AUTO STEAL TOGGLE
-- ============================================
local AutoBtn = Instance.new("TextButton", Main)
AutoBtn.Size = UDim2.new(1, -20, 0, 38)
AutoBtn.Position = UDim2.fromOffset(10, 115)
AutoBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
AutoBtn.BorderSizePixel = 0
AutoBtn.Text = "🎯 AUTO STEAL : OFF"
AutoBtn.TextColor3 = Color3.fromRGB(220, 220, 225)
AutoBtn.Font = Enum.Font.GothamBlack
AutoBtn.TextSize = 12
AutoBtn.AutoButtonColor = false
Instance.new("UICorner", AutoBtn).CornerRadius = UDim.new(0, 8)

AutoBtn.MouseButton1Click:Connect(function()
    CONFIG.autoSteal = not CONFIG.autoSteal
    if CONFIG.autoSteal then
        AutoBtn.BackgroundColor3 = Color3.fromRGB(25, 145, 105)
        AutoBtn.Text = "🎯 AUTO STEAL : ON"
    else
        AutoBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
        AutoBtn.Text = "🎯 AUTO STEAL : OFF"
    end
end)

-- ============================================
-- ANTI RAGDOLL TOGGLE
-- ============================================
local RagdollBtn = Instance.new("TextButton", Main)
RagdollBtn.Size = UDim2.new(1, -20, 0, 38)
RagdollBtn.Position = UDim2.fromOffset(10, 158)
RagdollBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
RagdollBtn.BorderSizePixel = 0
RagdollBtn.Text = "🛡️ ANTI RAGDOLL : OFF"
RagdollBtn.TextColor3 = Color3.fromRGB(220, 220, 225)
RagdollBtn.Font = Enum.Font.GothamBlack
RagdollBtn.TextSize = 12
RagdollBtn.AutoButtonColor = false
Instance.new("UICorner", RagdollBtn).CornerRadius = UDim.new(0, 8)

RagdollBtn.MouseButton1Click:Connect(function()
    CONFIG.antiRagdoll = not CONFIG.antiRagdoll
    if CONFIG.antiRagdoll then
        RagdollBtn.BackgroundColor3 = Color3.fromRGB(25, 145, 105)
        RagdollBtn.Text = "🛡️ ANTI RAGDOLL : ON"
    else
        RagdollBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
        RagdollBtn.Text = "🛡️ ANTI RAGDOLL : OFF"
    end
end)

-- ============================================
-- SPEED BOOST TOGGLE
-- ============================================
local SpeedBtn = Instance.new("TextButton", Main)
SpeedBtn.Size = UDim2.new(1, -20, 0, 38)
SpeedBtn.Position = UDim2.fromOffset(10, 201)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
SpeedBtn.BorderSizePixel = 0
SpeedBtn.Text = "💨 SPEED BOOST : OFF"
SpeedBtn.TextColor3 = Color3.fromRGB(220, 220, 225)
SpeedBtn.Font = Enum.Font.GothamBlack
SpeedBtn.TextSize = 12
SpeedBtn.AutoButtonColor = false
Instance.new("UICorner", SpeedBtn).CornerRadius = UDim.new(0, 8)

SpeedBtn.MouseButton1Click:Connect(function()
    CONFIG.speedBoost = not CONFIG.speedBoost
    if CONFIG.speedBoost then
        SpeedBtn.BackgroundColor3 = Color3.fromRGB(25, 145, 105)
        SpeedBtn.Text = "💨 SPEED BOOST : ON"
        if P.Character and P.Character:FindFirstChild("Humanoid") then
            P.Character.Humanoid.WalkSpeed = CONFIG.speedValue
        end
    else
        SpeedBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
        SpeedBtn.Text = "💨 SPEED BOOST : OFF"
        if P.Character and P.Character:FindFirstChild("Humanoid") then
            P.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

-- ============================================
-- INSTANT STEAL BUTTON
-- ============================================
local InstantBtn = Instance.new("TextButton", Main)
InstantBtn.Size = UDim2.new(1, -20, 0, 42)
InstantBtn.Position = UDim2.fromOffset(10, 245)
InstantBtn.BackgroundColor3 = Color3.fromRGB(190, 30, 45)
InstantBtn.BorderSizePixel = 0
InstantBtn.Text = "⚡ INSTANT STEAL"
InstantBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
InstantBtn.Font = Enum.Font.GothamBlack
InstantBtn.TextSize = 13
InstantBtn.AutoButtonColor = false
Instance.new("UICorner", InstantBtn).CornerRadius = UDim.new(0, 8)

-- ============================================
-- INFO LABEL
-- ============================================
local Info = Instance.new("TextLabel", Main)
Info.Size = UDim2.new(1, -20, 0, 18)
Info.Position = UDim2.fromOffset(10, 295)
Info.BackgroundTransparency = 1
Info.Text = "Status: Siap"
Info.TextColor3 = Color3.fromRGB(150, 150, 160)
Info.Font = Enum.Font.Gotham
Info.TextSize = 10
Info.TextXAlignment = Enum.TextXAlignment.Left
Info.Parent = Main

-- ============================================
-- FUNGSI CARI TELUR
-- ============================================
local function findEgg()
    local char = P.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local nearest, nearestDist = nil, math.huge
    local myPos = char.HumanoidRootPart.Position
    
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local name = obj.Name:lower()
            if not (name:find("telur") or name:find("egg")) then continue end
            
            local skipWords = {"treadmill", "base", "spawn", "zone", "portal", "shop", "index", "pet", "inventory", "display", "decor", "sign", "ui"}
            local shouldSkip = false
            for _, word in ipairs(skipWords) do
                if name:find(word) then shouldSkip = true; break end
            end
            if shouldSkip then continue end
            
            local hasPrompt = false
            for _, child in pairs(obj:GetChildren()) do
                if child:IsA("ProximityPrompt") or child:IsA("ClickDetector") then
                    hasPrompt = true; break
                end
            end
            if not hasPrompt and obj.Parent then
                for _, child in pairs(obj.Parent:GetChildren()) do
                    if child:IsA("ProximityPrompt") or child:IsA("ClickDetector") then
                        hasPrompt = true; break
                    end
                end
            end
            if not hasPrompt then continue end
            
            local dist = (obj.Position - myPos).Magnitude
            if dist < nearestDist then
                nearestDist = dist
                nearest = obj
            end
        end
    end
    return nearest, nearestDist
end

-- ============================================
-- FUNGSI STEAL (1x)
-- ============================================
local function doSteal()
    local char = P.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return false end
    
    local hrp = char.HumanoidRootPart
    local egg = findEgg()
    
    if not egg then return false end
    
    hrp.CFrame = CFrame.new(egg.Position)
    task.wait(0.05)
    
    pcall(function()
        if firetouchinterest then
            firetouchinterest(hrp, egg, 0)
            task.wait(0.03)
            firetouchinterest(hrp, egg, 1)
        end
    end)
    
    pcall(function()
        for _, child in pairs(egg:GetChildren()) do
            if child:IsA("ProximityPrompt") and fireproximityprompt then
                fireproximityprompt(child)
            end
        end
    end)
    
    task.wait(0.05)
    hrp.CFrame = CFrame.new(CONFIG.basePosition)
    return true
end

-- ============================================
-- INSTANT STEAL ACTION
-- ============================================
InstantBtn.MouseButton1Click:Connect(function()
    Info.Text = "Status: INSTANT STEAL..."
    Info.TextColor3 = Color3.fromRGB(255, 170, 60)
    InstantBtn.Text = "⚡ STEALING..."
    InstantBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
    
    task.spawn(function()
        local ok = doSteal()
        if ok then
            Info.Text = "Status: ✅ Berhasil!"
            Info.TextColor3 = Color3.fromRGB(25, 145, 105)
        else
            Info.Text = "Status: ❌ Gak ada telur!"
            Info.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
        task.wait(1)
        InstantBtn.Text = "⚡ INSTANT STEAL"
        InstantBtn.BackgroundColor3 = Color3.fromRGB(190, 30, 45)
    end)
end)

-- ============================================
-- LOOP AUTO STEAL
-- ============================================
task.spawn(function()
    while task.wait(CONFIG.loopDelay) do
        if CONFIG.autoSteal then
            pcall(doSteal)
        end
    end
end)

-- ============================================
-- LOOP ANTI RAGDOLL
-- ============================================
task.spawn(function()
    while task.wait(0.1) do
        if CONFIG.antiRagdoll then
            local char = P.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.PlatformStand = false
                char.Humanoid.Sit = false
            end
        end
    end
end)

-- ============================================
-- CLOSE BUTTON
-- ============================================
local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Size = UDim2.new(1, -20, 0, 30)
CloseBtn.Position = UDim2.new(0, 10, 1, -42)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "❌ Close"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 11
CloseBtn.AutoButtonColor = false
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

CloseBtn.MouseButton1Click:Connect(function()
    GUI:Destroy()
end)

-- ============================================
-- CHARACTER RESPAWN
-- ============================================
P.CharacterAdded:Connect(function()
    task.wait(1)
    if CONFIG.speedBoost then
        local char = P.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = CONFIG.speedValue
        end
    end
end)

print("[MAD OURO v2] Loaded! Keyless, rapi, lengkap.")
