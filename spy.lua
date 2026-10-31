--[[
    Hanssyz Sc | Advanced Recon & Spy Tool (Extended Edition)
    Version: 2.0
    Fitur: Remote Spy, Prompt Spy, ClickDetector Spy, Deep Object Scanner, Ping Monitor.
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ================= KONFIGURASI UI =================
if PlayerGui:FindFirstChild("HanssyzSpyUI") then PlayerGui.HanssyzSpyUI:Destroy() end
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HanssyzSpyUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 380, 0, 280)
MainFrame.Position = UDim2.new(0, 20, 0, 100)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 18, 42)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(88, 166, 255)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(25, 30, 55)
Header.Parent = MainFrame
local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 10)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Hanssyz Advanced Spy | v2.0"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Ping Display
local PingLabel = Instance.new("TextLabel")
PingLabel.Size = UDim2.new(0, 80, 1, 0)
PingLabel.Position = UDim2.new(1, -85, 0, 0)
PingLabel.BackgroundTransparency = 1
PingLabel.Text = "Ping: --"
PingLabel.Font = Enum.Font.Code
PingLabel.TextColor3 = Color3.fromRGB(100, 255, 160)
PingLabel.TextSize = 12
PingLabel.TextXAlignment = Enum.TextXAlignment.Right
PingLabel.Parent = Header

-- Scroll Area
local Scrolling = Instance.new("ScrollingFrame")
Scrolling.Size = UDim2.new(1, -10, 1, -90)
Scrolling.Position = UDim2.new(0, 5, 0, 45)
Scrolling.BackgroundTransparency = 1
Scrolling.BorderSizePixel = 0
Scrolling.ScrollBarThickness = 4
Scrolling.ScrollBarImageColor3 = Color3.fromRGB(88, 166, 255)
Scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
Scrolling.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = Scrolling

-- Footer Buttons
local ClearBtn = Instance.new("TextButton")
ClearBtn.Size = UDim2.new(0.45, 0, 0, 30)
ClearBtn.Position = UDim2.new(0.03, 0, 1, -35)
ClearBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
ClearBtn.Text = "CLEAR LOG"
ClearBtn.Font = Enum.Font.GothamBold
ClearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearBtn.TextSize = 12
ClearBtn.Parent = MainFrame
local CCorner = Instance.new("UICorner"); CCorner.CornerRadius = UDim.new(0, 6); CCorner.Parent = ClearBtn

local ScanBtn = Instance.new("TextButton")
ScanBtn.Size = UDim2.new(0.45, 0, 0, 30)
ScanBtn.Position = UDim2.new(0.52, 0, 1, -35)
ScanBtn.BackgroundColor3 = Color3.fromRGB(88, 166, 255)
ScanBtn.Text = "FORCE SCAN"
ScanBtn.Font = Enum.Font.GothamBold
ScanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ScanBtn.TextSize = 12
ScanBtn.Parent = MainFrame
local SCorner = Instance.new("UICorner"); SCorner.CornerRadius = UDim.new(0, 6); SCorner.Parent = ScanBtn

-- ================= LOGIC =================
local function Log(text, color)
    print(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 22)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.Code
    label.TextColor3 = color or Color3.fromRGB(200, 200, 200)
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextWrapped = true
    label.Parent = Scrolling
    Scrolling.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end

ClearBtn.MouseButton1Click:Connect(function()
    for _, v in pairs(Scrolling:GetChildren()) do
        if v:IsA("TextLabel") then v:Destroy() end
    end
end)

Log("[SISTEM] Advanced Spy Aktif.", Color3.fromRGB(100, 255, 160))
Log("[INFO] Silakan lakukan steal manual (tekan E).", Color3.fromRGB(255, 255, 100))

-- 1. Spy Remote
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    if method == "FireServer" or method == "InvokeServer" then
        local args = {...}
        local argStr = ""
        for i, v in pairs(args) do
            if typeof(v) == "Instance" then
                argStr = argStr .. v.Name .. " ("..v.ClassName.."), "
            else
                argStr = argStr .. tostring(v) .. ", "
            end
        end
        Log("REMOTE: " .. self.Name .. " | Args: " .. argStr, Color3.fromRGB(255, 200, 100))
    end
    return oldNamecall(self, ...)
end)

-- 2. Spy Prompt
local oldPrompt = fireproximityprompt
fireproximityprompt = function(prompt)
    Log("PROMPT: " .. prompt.Name .. " | Parent: " .. prompt.Parent.Name, Color3.fromRGB(100, 200, 255))
    return oldPrompt(prompt)
end

-- 3. Spy ClickDetector
local oldClick = fireclickdetector
fireclickdetector = function(detector, distance)
    Log("CLICK: " .. detector.Name .. " | Parent: " .. detector.Parent.Name, Color3.fromRGB(190, 130, 255))
    return oldClick(detector, distance)
end

-- 4. Deep Scanner Function
local function ScanEnvironment()
    Log("[SCAN] Memulai Deep Scan...", Color3.fromRGB(255, 255, 100))
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    
    local keywords = {"egg", "spawn", "pet", "steal", "item", "drop", "collect"}
    local foundCount = 0
    
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") or v:IsA("BasePart") then
            local dist = 999
            if v:IsA("Model") and v.PrimaryPart then
                dist = (hrp.Position - v.PrimaryPart.Position).Magnitude
            elseif v:IsA("BasePart") then
                dist = (hrp.Position - v.Position).Magnitude
            end
            
            if dist < 100 then
                local nameLower = v.Name:lower()
                for _, kw in pairs(keywords) do
                    if nameLower:find(kw) then
                        Log("OBJ: " .. v.Name .. " [" .. v.ClassName .. "] | Dist: " .. math.floor(dist), Color3.fromRGB(150, 255, 150))
                        foundCount = foundCount + 1
                        
                        -- Cek apakah punya prompt di dalemnya
                        local prompt = v:FindFirstChildWhichIsA("ProximityPrompt", true)
                        if prompt then
                            Log("  -> Punya Prompt: " .. prompt.Name, Color3.fromRGB(100, 200, 255))
                        end
                        break
                    end
                end
            end
        end
    end
    
    if foundCount == 0 then
        Log("[SCAN] Tidak ada object menarik dalam radius 100 stud.", Color3.fromRGB(255, 100, 100))
    else
        Log("[SCAN] Selesai. Ditemukan " .. foundCount .. " object.", Color3.fromRGB(100, 255, 160))
    end
end

ScanBtn.MouseButton1Click:Connect(ScanEnvironment)

-- Auto scan awal setelah 2 detik
task.spawn(function()
    task.wait(2)
    ScanEnvironment()
end)

-- 5. Ping Monitor (Update tiap 1 detik)
task.spawn(function()
    while ScreenGui.Parent do
        local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        PingLabel.Text = "Ping: " .. ping .. "ms"
        task.wait(1)
    end
end)

-- Draggable
local dragging, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
