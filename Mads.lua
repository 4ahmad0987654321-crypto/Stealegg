-- ============================================
-- MAD FULL - INSTANT GRAB + INSTANT STEAL
-- Semua OFF default, aktifin manual
-- ============================================

local Players = game:GetService("Players")
local P = Players.LocalPlayer
local PG = P:WaitForChild("PlayerGui")
local char = P.Character or P.CharacterAdded:Wait()

-- ============================================
-- CONFIG
-- ============================================
local CONFIG = {
    instantGrab = false,
    instantSteal = false,
    antiRagdoll = false,
    speedBoost = false,
    grabRange = 20,
    stealRange = 50,
    speedValue = 100,
    basePosition = Vector3.new(0, 10, 0),
}

-- ============================================
-- GUI
-- ============================================
local old = PG:FindFirstChild("MadFull")
if old then old:Destroy() end

local GUI = Instance.new("ScreenGui")
GUI.Name = "MadFull"
GUI.ResetOnSpawn = false
GUI.Parent = PG

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(300, 380)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Visible = true
Main.Parent = GUI
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", Main)
stroke.Color = Color3.fromRGB(220, 38, 44)
stroke.Thickness = 2

-- Header
local Header = Instance.new("TextLabel", Main)
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
Header.Text = "⚡ MAD FULL"
Header.TextColor3 = Color3.fromRGB(255, 255, 255)
Header.Font = Enum.Font.GothamBlack
Header.TextSize = 16
Header.BorderSizePixel = 0
Header.Parent = Main
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)

-- Minimize
local MinBtn = Instance.new("TextButton", Main)
MinBtn.Size = UDim2.fromOffset(30, 30)
MinBtn.Position = UDim2.new(1, -40, 0, 8)
MinBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
MinBtn.BorderSizePixel = 0
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 14
MinBtn.AutoButtonColor = false
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

-- Container
local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, -20, 1, -130)
Container.Position = UDim2.fromOffset(10, 55)
Container.BackgroundTransparency = 1
Container.Parent = Main

local Layout = Instance.new("UIListLayout", Container)
Layout.Padding = UDim.new(0, 6)
Layout.SortOrder = Enum.SortOrder.LayoutOrder

-- ============================================
-- FUNGSI TOGGLE
-- ============================================
local function createToggle(name, callback)
    local btn = Instance.new("TextButton", Container)
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    btn.BorderSizePixel = 0
    btn.Text = name .. " : OFF"
    btn.TextColor3 = Color3.fromRGB(220, 220, 225)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            btn.BackgroundColor3 = Color3.fromRGB(25, 145, 105)
            btn.Text = name .. " : ON"
        else
            btn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
            btn.Text = name .. " : OFF"
        end
        callback(state)
    end)
end

-- ============================================
-- TOMBOL FITUR
-- ============================================
createToggle("⚡ Instant Grab", function(s) CONFIG.instantGrab = s end)
createToggle("🎯 Instant Steal", function(s) CONFIG.instantSteal = s end)
createToggle("🛡️ Anti Ragdoll", function(s) CONFIG.antiRagdoll = s end)
createToggle("💨 Speed Boost", function(s)
    CONFIG.speedBoost = s
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = s and CONFIG.speedValue or 16
    end
end)

-- Set Base
local SetBase = Instance.new("TextButton", Main)
SetBase.Size = UDim2.new(1, -20, 0, 32)
SetBase.Position = UDim2.new(0, 10, 1, -80)
SetBase.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
SetBase.BorderSizePixel = 0
SetBase.Text = "📍 Set Base Position"
SetBase.TextColor3 = Color3.fromRGB(255, 255, 255)
SetBase.Font = Enum.Font.GothamBold
SetBase.TextSize = 11
SetBase.AutoButtonColor = false
Instance.new("UICorner", SetBase).CornerRadius = UDim.new(0, 8)

SetBase.MouseButton1Click:Connect(function()
    if char and char:FindFirstChild("HumanoidRootPart") then
        CONFIG.basePosition = char.HumanoidRootPart.Position
        SetBase.Text = "📍 Base Tersimpan!"
        task.wait(1)
        SetBase.Text = "📍 Set Base Position"
    end
end)

-- Close
local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Size = UDim2.new(1, -20, 0, 30)
CloseBtn.Position = UDim2.new(0, 10, 1, -42)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "❌ Close Menu"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 11
CloseBtn.AutoButtonColor = false
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

-- Open Button
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.fromOffset(50, 50)
OpenBtn.Position = UDim2.new(0, 20, 0.5, -25)
OpenBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
OpenBtn.BorderSizePixel = 0
OpenBtn.Text = "⚡"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.Font = Enum.Font.GothamBlack
OpenBtn.TextSize = 22
OpenBtn.AutoButtonColor = false
OpenBtn.Visible = false
OpenBtn.Parent = GUI
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(1, 0)

local OpenStroke = Instance.new("UIStroke", OpenBtn)
OpenStroke.Color = Color3.fromRGB(220, 38, 44)
OpenStroke.Thickness = 2

CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    OpenBtn.Visible = true
end)

MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    Main.Visible = true
    OpenBtn.Visible = false
end)

-- ============================================
-- FUNGSI CARI TELUR
-- ============================================
local function findEgg()
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local nearest, nearestDist = nil, math.huge
    local myPos = char.HumanoidRootPart.Position
    
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:lower():find("egg") then
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
-- FUNGSI CARI PROMPT
-- ============================================
local function findPrompts()
    local prompts = {}
    if not char or not char:FindFirstChild("HumanoidRootPart") then return prompts end
    local myPos = char.HumanoidRootPart.Position
    
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("ProximityPrompt") then
            local parent = obj.Parent
            if parent and parent:IsA("BasePart") then
                local dist = (parent.Position - myPos).Magnitude
                if dist <= CONFIG.grabRange then
                    table.insert(prompts, {type = "proximity", obj = obj, dist = dist})
                end
            end
        end
        if obj:IsA("ClickDetector") then
            local parent = obj.Parent
            if parent and parent:IsA("BasePart") then
                local dist = (parent.Position - myPos).Magnitude
                if dist <= CONFIG.grabRange then
                    table.insert(prompts, {type = "click", obj = obj, dist = dist})
                end
            end
        end
    end
    return prompts
end

local function triggerPrompt(data)
    if not data then return end
    if data.type == "proximity" then
        pcall(function()
            if fireproximityprompt then fireproximityprompt(data.obj) end
        end)
    elseif data.type == "click" then
        pcall(function()
            if fireclickdetector then fireclickdetector(data.obj) end
        end)
    end
end

-- ============================================
-- LOOP: INSTANT GRAB
-- ============================================
task.spawn(function()
    while task.wait(0.05) do
        if CONFIG.instantGrab then
            local prompts = findPrompts()
            if #prompts > 0 then
                table.sort(prompts, function(a, b) return a.dist < b.dist end)
                triggerPrompt(prompts[1])
            end
        end
    end
end)

-- ============================================
-- LOOP: INSTANT STEAL
-- ============================================
task.spawn(function()
    while task.wait(0.3) do
        if CONFIG.instantSteal and char and char:FindFirstChild("HumanoidRootPart") then
            local egg, dist = findEgg()
            if egg and dist <= CONFIG.stealRange then
                local basePos = CONFIG.basePosition
                pcall(function()
                    char.HumanoidRootPart.CFrame = egg.CFrame
                    task.wait(0.05)
                    if firetouchinterest then
                        firetouchinterest(char.HumanoidRootPart, egg, 0)
                        firetouchinterest(char.HumanoidRootPart, egg, 1)
                    end
                    task.wait(0.05)
                    char.HumanoidRootPart.CFrame = CFrame.new(basePos)
                end)
            end
        end
    end
end)

-- ============================================
-- LOOP: ANTI RAGDOLL
-- ============================================
task.spawn(function()
    while task.wait(0.1) do
        if CONFIG.antiRagdoll and char and char:FindFirstChild("Humanoid") then
            char.Humanoid.PlatformStand = false
            char.Humanoid.Sit = false
        end
    end
end)

P.CharacterAdded:Connect(function(newChar)
    task.wait(1)
    char = newChar
end)

print("[MAD FULL] Loaded! Aktifin fitur di menu.")
