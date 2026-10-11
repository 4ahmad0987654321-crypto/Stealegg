-- ============================================
-- MAD STEAL PRO
-- Pilih Rarity + Area + Auto Steal
-- ============================================

local Players = game:GetService("Players")
local P = Players.LocalPlayer
local PG = P:WaitForChild("PlayerGui")
local char = P.Character or P.CharacterAdded:Wait()

-- ============================================
-- CONFIG
-- ============================================
local CONFIG = {
    basePosition = Vector3.new(0, 10, 0),
    autoSteal = false,
    loopDelay = 0.6,
    selectedRarity = "All",
    selectedArea = "All",
}

-- Daftar Rarity
local RARITIES = {
    "All", "Common", "Uncommon", "Rare", "Epic",
    "Legendary", "Mythical", "Divine"
}

-- Daftar Area
local AREAS = {
    "All", "Forest", "Desert", "Snow", "Volcano",
    "Enchanted Jungle", "Crystal Cave", "Sky Island"
}

-- ============================================
-- HAPUS GUI LAMA
-- ============================================
local old = PG:FindFirstChild("MadStealPro")
if old then old:Destroy() end

-- ============================================
-- GUI UTAMA
-- ============================================
local GUI = Instance.new("ScreenGui")
GUI.Name = "MadStealPro"
GUI.ResetOnSpawn = false
GUI.Parent = PG

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(320, 480)
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
Header.Text = "⚡ MAD STEAL PRO"
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

-- ============================================
-- SET BASE
-- ============================================
local SetBase = Instance.new("TextButton", Main)
SetBase.Size = UDim2.new(1, -20, 0, 32)
SetBase.Position = UDim2.fromOffset(10, 55)
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

-- ============================================
-- LABEL RARITY
-- ============================================
local RarityLabel = Instance.new("TextLabel", Main)
RarityLabel.Size = UDim2.new(1, -20, 0, 18)
RarityLabel.Position = UDim2.fromOffset(10, 92)
RarityLabel.BackgroundTransparency = 1
RarityLabel.Text = "🎯 Rarity: All"
RarityLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
RarityLabel.Font = Enum.Font.GothamBold
RarityLabel.TextSize = 11
RarityLabel.TextXAlignment = Enum.TextXAlignment.Left
RarityLabel.Parent = Main

-- Scroll Rarity
local RarityScroll = Instance.new("ScrollingFrame", Main)
RarityScroll.Size = UDim2.new(1, -20, 0, 40)
RarityScroll.Position = UDim2.fromOffset(10, 112)
RarityScroll.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
RarityScroll.BorderSizePixel = 0
RarityScroll.ScrollBarThickness = 3
RarityScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
RarityScroll.AutomaticCanvasSize = Enum.AutomaticSize.X
RarityScroll.ScrollingDirection = Enum.ScrollingDirection.X
Instance.new("UICorner", RarityScroll).CornerRadius = UDim.new(0, 6)

local RarityLayout = Instance.new("UIListLayout", RarityScroll)
RarityLayout.FillDirection = Enum.FillDirection.Horizontal
RarityLayout.Padding = UDim.new(0, 5)
RarityLayout.SortOrder = Enum.SortOrder.LayoutOrder
RarityLayout.VerticalAlignment = Enum.VerticalAlignment.Center

local RarityPadding = Instance.new("UIPadding", RarityScroll)
RarityPadding.PaddingLeft = UDim.new(0, 5)
RarityPadding.PaddingTop = UDim.new(0, 5)

-- ============================================
-- LABEL AREA
-- ============================================
local AreaLabel = Instance.new("TextLabel", Main)
AreaLabel.Size = UDim2.new(1, -20, 0, 18)
AreaLabel.Position = UDim2.fromOffset(10, 157)
AreaLabel.BackgroundTransparency = 1
AreaLabel.Text = "🗺️ Area: All"
AreaLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
AreaLabel.Font = Enum.Font.GothamBold
AreaLabel.TextSize = 11
AreaLabel.TextXAlignment = Enum.TextXAlignment.Left
AreaLabel.Parent = Main

-- Scroll Area
local AreaScroll = Instance.new("ScrollingFrame", Main)
AreaScroll.Size = UDim2.new(1, -20, 0, 40)
AreaScroll.Position = UDim2.fromOffset(10, 177)
AreaScroll.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
AreaScroll.BorderSizePixel = 0
AreaScroll.ScrollBarThickness = 3
AreaScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
AreaScroll.AutomaticCanvasSize = Enum.AutomaticSize.X
AreaScroll.ScrollingDirection = Enum.ScrollingDirection.X
Instance.new("UICorner", AreaScroll).CornerRadius = UDim.new(0, 6)

local AreaLayout = Instance.new("UIListLayout", AreaScroll)
AreaLayout.FillDirection = Enum.FillDirection.Horizontal
AreaLayout.Padding = UDim.new(0, 5)
AreaLayout.SortOrder = Enum.SortOrder.LayoutOrder
AreaLayout.VerticalAlignment = Enum.VerticalAlignment.Center

local AreaPadding = Instance.new("UIPadding", AreaScroll)
AreaPadding.PaddingLeft = UDim.new(0, 5)
AreaPadding.PaddingTop = UDim.new(0, 5)

-- ============================================
-- FUNGSI BIKIN TOMBOL PILIHAN
-- ============================================
local function createOption(parent, name, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.fromOffset(80, 30)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(220, 220, 225)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 10
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(function()
        -- Reset semua tombol
        for _, child in pairs(parent:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
            end
        end
        -- Highlight yang dipilih
        btn.BackgroundColor3 = Color3.fromRGB(220, 38, 44)
        callback(name)
    end)
    
    return btn
end

-- Bikin tombol Rarity
for _, rarity in ipairs(RARITIES) do
    createOption(RarityScroll, rarity, function(selected)
        CONFIG.selectedRarity = selected
        RarityLabel.Text = "🎯 Rarity: " .. selected
    end)
end

-- Bikin tombol Area
for _, area in ipairs(AREAS) do
    createOption(AreaScroll, area, function(selected)
        CONFIG.selectedArea = selected
        AreaLabel.Text = "🗺️ Area: " .. selected
    end)
end

-- ============================================
-- AUTO STEAL BUTTON
-- ============================================
local AutoBtn = Instance.new("TextButton", Main)
AutoBtn.Size = UDim2.new(1, -20, 0, 50)
AutoBtn.Position = UDim2.fromOffset(10, 225)
AutoBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
AutoBtn.BorderSizePixel = 0
AutoBtn.Text = "🔄 AUTO STEAL : OFF"
AutoBtn.TextColor3 = Color3.fromRGB(220, 220, 225)
AutoBtn.Font = Enum.Font.GothamBlack
AutoBtn.TextSize = 14
AutoBtn.AutoButtonColor = false
Instance.new("UICorner", AutoBtn).CornerRadius = UDim.new(0, 8)

AutoBtn.MouseButton1Click:Connect(function()
    CONFIG.autoSteal = not CONFIG.autoSteal
    if CONFIG.autoSteal then
        AutoBtn.BackgroundColor3 = Color3.fromRGB(25, 145, 105)
        AutoBtn.Text = "🔄 AUTO STEAL : ON"
    else
        AutoBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
        AutoBtn.Text = "🔄 AUTO STEAL : OFF"
    end
end)

-- ============================================
-- MANUAL STEAL BUTTON
-- ============================================
local ManualBtn = Instance.new("TextButton", Main)
ManualBtn.Size = UDim2.new(1, -20, 0, 38)
ManualBtn.Position = UDim2.fromOffset(10, 285)
ManualBtn.BackgroundColor3 = Color3.fromRGB(25, 145, 105)
ManualBtn.BorderSizePixel = 0
ManualBtn.Text = "🚀 STEAL (Manual)"
ManualBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ManualBtn.Font = Enum.Font.GothamBold
ManualBtn.TextSize = 12
ManualBtn.AutoButtonColor = false
Instance.new("UICorner", ManualBtn).CornerRadius = UDim.new(0, 8)

-- ============================================
-- FUNGSI CARI TELUR (FILTER RARITY + AREA)
-- ============================================
local function findEgg()
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local nearest, nearestDist = nil, math.huge
    local myPos = char.HumanoidRootPart.Position
    
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local name = obj.Name:lower()
            
            -- Cek apakah ini telur
            local isEgg = name:find("egg") or name:find("telur")
            if not isEgg then continue end
            
            -- Filter Rarity
            if CONFIG.selectedRarity ~= "All" then
                if not name:find(CONFIG.selectedRarity:lower()) then
                    -- Cek di parent atau attributes
                    local found = false
                    if obj.Parent then
                        if obj.Parent.Name:lower():find(CONFIG.selectedRarity:lower()) then
                            found = true
                        end
                    end
                    if not found then continue end
                end
            end
            
            -- Filter Area
            if CONFIG.selectedArea ~= "All" then
                local areaName = CONFIG.selectedArea:lower():gsub(" ", "")
                local inArea = false
                
                -- Cek di parent
                if obj.Parent and obj.Parent.Name:lower():gsub(" ", ""):find(areaName) then
                    inArea = true
                end
                
                -- Cek di ancestor
                local ancestor = obj.Parent
                while ancestor and ancestor ~= game.Workspace do
                    if ancestor.Name:lower():gsub(" ", ""):find(areaName) then
                        inArea = true
                        break
                    end
                    ancestor = ancestor.Parent
                end
                
                if not inArea then continue end
            end
            
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
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local hrp = char.HumanoidRootPart
    local egg, dist = findEgg()
    
    if not egg then
        print("[MAD STEAL] Gak ada telur sesuai filter!")
        return
    end
    
    local basePos = CONFIG.basePosition
    
    -- Teleport ke telur
    hrp.CFrame = CFrame.new(egg.Position)
    task.wait(0.08)
    
    -- Grab
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
    
    task.wait(0.08)
    
    -- Balik ke base
    hrp.CFrame = CFrame.new(basePos)
end

ManualBtn.MouseButton1Click:Connect(function()
    task.spawn(doSteal)
end)

-- ============================================
-- AUTO LOOP
-- ============================================
task.spawn(function()
    while task.wait(CONFIG.loopDelay) do
        if CONFIG.autoSteal then
            pcall(doSteal)
        end
    end
end)

-- ============================================
-- CLOSE
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

MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

-- ============================================
-- UPDATE CHARACTER
-- ============================================
P.CharacterAdded:Connect(function(newChar)
    task.wait(1)
    char = newChar
end)

print("[MAD STEAL PRO] Loaded! Pilih Rarity & Area, baru AUTO STEAL!")
