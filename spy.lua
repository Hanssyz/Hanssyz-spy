local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Mouse = LocalPlayer:GetMouse()

local SpyCore = {}
SpyCore.IsActive = true
SpyCore.IsMinimized = false
SpyCore.LogText = ""
SpyCore.Step = 1
SpyCore.EggCount = 0
SpyCore.RemoteCount = 0
SpyCore.PromptCount = 0

if PlayerGui:FindFirstChild("SpyV6") then
    PlayerGui.SpyV6:Destroy()
end

local Screen = Instance.new("ScreenGui")
Screen.Name = "SpyV6"
Screen.ResetOnSpawn = false
Screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Screen.IgnoreGuiInset = true
Screen.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 380, 0, 540)
Main.Position = UDim2.new(0, 15, 0, 80)
Main.BackgroundColor3 = Color3.fromRGB(15, 18, 42)
Main.BorderSizePixel = 0
Main.Active = true
Main.ClipsDescendants = true
Main.Parent = Screen

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(88, 166, 255)
MainStroke.Thickness = 2
MainStroke.Transparency = 0.2
MainStroke.Parent = Main

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 25, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 18, 42))
})
MainGradient.Rotation = 45
MainGradient.Parent = Main

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundColor3 = Color3.fromRGB(28, 32, 58)
Header.BorderSizePixel = 0
Header.Active = true
Header.Parent = Main

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Name = "Title"
HeaderTitle.Size = UDim2.new(1, -50, 1, 0)
HeaderTitle.Position = UDim2.new(0, 15, 0, 0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "Hanssyz Spy v6.0"
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.TextColor3 = Color3.fromRGB(245, 248, 255)
HeaderTitle.TextSize = 16
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.Parent = Header

local MinBtn = Instance.new("TextButton")
MinBtn.Name = "MinBtn"
MinBtn.Size = UDim2.new(0, 28, 0, 28)
MinBtn.Position = UDim2.new(1, -36, 0.5, -14)
MinBtn.BackgroundColor3 = Color3.fromRGB(255, 120, 120)
MinBtn.Text = "-"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 20
MinBtn.Parent = Header

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinBtn

local StatsFrame = Instance.new("Frame")
StatsFrame.Name = "Stats"
StatsFrame.Size = UDim2.new(1, -20, 0, 35)
StatsFrame.Position = UDim2.new(0, 10, 0, 55)
StatsFrame.BackgroundColor3 = Color3.fromRGB(28, 32, 58)
StatsFrame.BackgroundTransparency = 0.5
StatsFrame.BorderSizePixel = 0
StatsFrame.Parent = Main

local StatsCorner = Instance.new("UICorner")
StatsCorner.CornerRadius = UDim.new(0, 8)
StatsCorner.Parent = StatsFrame

local StatsLayout = Instance.new("UIListLayout")
StatsLayout.FillDirection = Enum.FillDirection.Horizontal
StatsLayout.SortOrder = Enum.SortOrder.LayoutOrder
StatsLayout.Padding = UDim.new(0, 5)
StatsLayout.Parent = StatsFrame

local EggCountLabel = Instance.new("TextLabel")
EggCountLabel.Name = "EggCount"
EggCountLabel.Size = UDim2.new(0.33, -5, 1, 0)
EggCountLabel.BackgroundTransparency = 1
EggCountLabel.Text = "Eggs: 0"
EggCountLabel.Font = Enum.Font.Code
EggCountLabel.TextColor3 = Color3.fromRGB(100, 255, 160)
EggCountLabel.TextSize = 11
EggCountLabel.Parent = StatsFrame

local RemoteCountLabel = Instance.new("TextLabel")
RemoteCountLabel.Name = "RemoteCount"
RemoteCountLabel.Size = UDim2.new(0.33, -5, 1, 0)
RemoteCountLabel.BackgroundTransparency = 1
RemoteCountLabel.Text = "Remotes: 0"
RemoteCountLabel.Font = Enum.Font.Code
RemoteCountLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
RemoteCountLabel.TextSize = 11
RemoteCountLabel.Parent = StatsFrame

local PromptCountLabel = Instance.new("TextLabel")
PromptCountLabel.Name = "PromptCount"
PromptCountLabel.Size = UDim2.new(0.33, -5, 1, 0)
PromptCountLabel.BackgroundTransparency = 1
PromptCountLabel.Text = "Prompts: 0"
PromptCountLabel.Font = Enum.Font.Code
PromptCountLabel.TextColor3 = Color3.fromRGB(88, 166, 255)
PromptCountLabel.TextSize = 11
PromptCountLabel.Parent = StatsFrame

local StepFrame = Instance.new("Frame")
StepFrame.Name = "Step"
StepFrame.Size = UDim2.new(1, -20, 0, 60)
StepFrame.Position = UDim2.new(0, 10, 0, 100)
StepFrame.BackgroundColor3 = Color3.fromRGB(40, 45, 80)
StepFrame.BorderSizePixel = 0
StepFrame.Parent = Main

local StepCorner = Instance.new("UICorner")
StepCorner.CornerRadius = UDim.new(0, 8)
StepCorner.Parent = StepFrame

local StepTitle = Instance.new("TextLabel")
StepTitle.Size = UDim2.new(1, -20, 0, 20)
StepTitle.Position = UDim2.new(0, 10, 0, 5)
StepTitle.BackgroundTransparency = 1
StepTitle.Text = "PANDUAN SAAT INI:"
StepTitle.Font = Enum.Font.GothamBold
StepTitle.TextColor3 = Color3.fromRGB(255, 255, 100)
StepTitle.TextSize = 11
StepTitle.TextXAlignment = Enum.TextXAlignment.Left
StepTitle.Parent = StepFrame

local StepDesc = Instance.new("TextLabel")
StepDesc.Name = "Desc"
StepDesc.Size = UDim2.new(1, -20, 0, 30)
StepDesc.Position = UDim2.new(0, 10, 0, 25)
StepDesc.BackgroundTransparency = 1
StepDesc.Text = "1. Tunggu spawn."
StepDesc.Font = Enum.Font.Gotham
StepDesc.TextColor3 = Color3.fromRGB(200, 220, 255)
StepDesc.TextSize = 12
StepDesc.TextWrapped = true
StepDesc.TextXAlignment = Enum.TextXAlignment.Left
StepDesc.TextYAlignment = Enum.TextYAlignment.Top
StepDesc.Parent = StepFrame

local LogContainer = Instance.new("Frame")
LogContainer.Name = "Logs"
LogContainer.Size = UDim2.new(1, -20, 1, -230)
LogContainer.Position = UDim2.new(0, 10, 0, 170)
LogContainer.BackgroundColor3 = Color3.fromRGB(15, 18, 42)
LogContainer.BorderSizePixel = 0
LogContainer.Parent = Main

local LogCorner = Instance.new("UICorner")
LogCorner.CornerRadius = UDim.new(0, 8)
LogCorner.Parent = LogContainer

local LogStroke = Instance.new("UIStroke")
LogStroke.Color = Color3.fromRGB(50, 55, 80)
LogStroke.Thickness = 1
LogStroke.Parent = LogContainer

local Scrolling = Instance.new("ScrollingFrame")
Scrolling.Name = "Scrolling"
Scrolling.Size = UDim2.new(1, -10, 1, -10)
Scrolling.Position = UDim2.new(0, 5, 0, 5)
Scrolling.BackgroundTransparency = 1
Scrolling.BorderSizePixel = 0
Scrolling.ScrollBarThickness = 4
Scrolling.ScrollBarImageColor3 = Color3.fromRGB(88, 166, 255)
Scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
Scrolling.Parent = LogContainer

local UILayout = Instance.new("UIListLayout")
UILayout.Padding = UDim.new(0, 4)
UILayout.Parent = Scrolling

local BtnFrame = Instance.new("Frame")
BtnFrame.Name = "Buttons"
BtnFrame.Size = UDim2.new(1, -20, 0, 40)
BtnFrame.Position = UDim2.new(0, 10, 1, -55)
BtnFrame.BackgroundTransparency = 1
BtnFrame.Parent = Main

local ScanBtn = Instance.new("TextButton")
ScanBtn.Name = "ScanBtn"
ScanBtn.Size = UDim2.new(0.48, 0, 1, 0)
ScanBtn.Position = UDim2.new(0, 0, 0, 0)
ScanBtn.BackgroundColor3 = Color3.fromRGB(100, 255, 160)
ScanBtn.Text = "SCAN EGGS"
ScanBtn.Font = Enum.Font.GothamBold
ScanBtn.TextColor3 = Color3.fromRGB(15, 18, 42)
ScanBtn.TextSize = 12
ScanBtn.Parent = BtnFrame

local ScanCorner = Instance.new("UICorner")
ScanCorner.CornerRadius = UDim.new(0, 6)
ScanCorner.Parent = ScanBtn

local CopyBtn = Instance.new("TextButton")
CopyBtn.Name = "CopyBtn"
CopyBtn.Size = UDim2.new(0.48, 0, 1, 0)
CopyBtn.Position = UDim2.new(0.52, 0, 0, 0)
CopyBtn.BackgroundColor3 = Color3.fromRGB(88, 166, 255)
CopyBtn.Text = "COPY LOG"
CopyBtn.Font = Enum.Font.GothamBold
CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyBtn.TextSize = 12
CopyBtn.Parent = BtnFrame

local CopyCorner = Instance.new("UICorner")
CopyCorner.CornerRadius = UDim.new(0, 6)
CopyCorner.Parent = CopyBtn

local ClearBtn = Instance.new("TextButton")
ClearBtn.Name = "ClearBtn"
ClearBtn.Size = UDim2.new(1, 0, 0, 25)
ClearBtn.Position = UDim2.new(0, 0, 1, -25)
ClearBtn.BackgroundColor3 = Color3.fromRGB(255, 120, 120)
ClearBtn.Text = "CLEAR LOG"
ClearBtn.Font = Enum.Font.GothamBold
ClearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearBtn.TextSize = 11
ClearBtn.Parent = Main

local ClearCorner = Instance.new("UICorner")
ClearCorner.CornerRadius = UDim.new(0, 6)
ClearCorner.Parent = ClearBtn

local function AddLog(text, color)
    SpyCore.LogText = SpyCore.LogText .. text .. "\n"
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 24)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.Font = Enum.Font.Code
    lbl.TextColor3 = color or Color3.fromRGB(200, 200, 200)
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextWrapped = true
    lbl.Parent = Scrolling
    Scrolling.CanvasSize = UDim2.new(0, 0, 0, UILayout.AbsoluteContentSize.Y + 10)
end

local function UpdateStep(stepNum, text)
    SpyCore.Step = stepNum
    StepDesc.Text = text
end

local function UpdateStats()
    EggCountLabel.Text = "Eggs: " .. SpyCore.EggCount
    RemoteCountLabel.Text = "Remotes: " .. SpyCore.RemoteCount
    PromptCountLabel.Text = "Prompts: " .. SpyCore.PromptCount
end

AddLog("[SISTEM] Spy v6.0 Loaded.", Color3.fromRGB(100, 255, 160))
AddLog("[INFO] Silakan ikuti panduan.", Color3.fromRGB(255, 255, 100))
UpdateStep(1, "1. Pencet 'SCAN EGGS' buat liat target.")

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    if method == "FireServer" or method == "InvokeServer" then
        SpyCore.RemoteCount = SpyCore.RemoteCount + 1
        UpdateStats()
        local args = {...}
        local argStr = ""
        for _, v in pairs(args) do
            if typeof(v) == "Instance" then
                argStr = argStr .. v.Name .. ", "
            else
                argStr = argStr .. tostring(v) .. ", "
            end
        end
        AddLog("REMOTE: " .. self.Name .. " | " .. argStr, Color3.fromRGB(255, 200, 100))
        
        if SpyCore.Step == 3 then
            UpdateStep(4, "4. Data didapat! Pencet 'COPY LOG'.")
        end
    end
    return oldNamecall(self, ...)
end)

local oldPrompt = fireproximityprompt
fireproximityprompt = function(prompt)
    SpyCore.PromptCount = SpyCore.PromptCount + 1
    UpdateStats()
    AddLog("PROMPT: " .. prompt.Name .. " di " .. prompt.Parent.Name, Color3.fromRGB(88, 166, 255))
    
    if SpyCore.Step == 3 then
        UpdateStep(4, "4. Data didapat! Pencet 'COPY LOG'.")
    end
    return oldPrompt(prompt)
end

ScanBtn.MouseButton1Click:Connect(function()
    AddLog("--- SCAN DIMULAI ---", Color3.fromRGB(255, 255, 100))
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then 
        AddLog("Karakter belum spawn.", Color3.fromRGB(255, 120, 120))
        return 
    end
    
    local hrp = char.HumanoidRootPart
    local found = 0
    
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") or v:IsA("BasePart") then
            if v.Name:lower():find("egg") then
                local pos = v:IsA("Model") and v:GetPivot().Position or v.Position
                local dist = (hrp.Position - pos).Magnitude
                
                if dist < 200 then
                    found = found + 1
                    SpyCore.EggCount = SpyCore.EggCount + 1
                    UpdateStats()
                    
                    local hasPrompt = v:FindFirstChildWhichIsA("ProximityPrompt", true) ~= nil
                    local status = hasPrompt and "BISA DICURI" or "PAJANGAN"
                    local color = hasPrompt and Color3.fromRGB(100, 255, 160) or Color3.fromRGB(255, 120, 120)
                    
                    AddLog("EGG: " .. v.Name .. " | " .. status, color)
                end
            end
        end
    end
    
    if found == 0 then
        AddLog("Ga ada egg di sekitar.", Color3.fromRGB(255, 120, 120))
        UpdateStep(2, "2. Jalan mendekati Egg.")
    else
        UpdateStep(2, "2. Dekati Egg, lalu pencet E manual.")
    end
end)

CopyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(SpyCore.LogText)
        CopyBtn.Text = "COPIED!"
        task.wait(2)
        CopyBtn.Text = "COPY LOG"
        AddLog("[SISTEM] Log berhasil di-copy.", Color3.fromRGB(100, 255, 160))
    else
        AddLog("[ERROR] Executor ga support clipboard.", Color3.fromRGB(255, 120, 120))
    end
end)

ClearBtn.MouseButton1Click:Connect(function()
    for _, child in pairs(Scrolling:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end
    SpyCore.LogText = ""
    AddLog("[SISTEM] Log dibersihkan.", Color3.fromRGB(255, 255, 100))
end)

MinBtn.MouseButton1Click:Connect(function()
    if SpyCore.IsMinimized then return end
    SpyCore.IsMinimized = true
    Main.Visible = false
    
    local Icon = Instance.new("TextButton")
    Icon.Name = "MinIcon"
    Icon.Size = UDim2.new(0, 45, 0, 45)
    Icon.Position = UDim2.new(0, 20, 0, 100)
    Icon.BackgroundColor3 = Color3.fromRGB(28, 32, 58)
    Icon.Text = "S"
    Icon.Font = Enum.Font.GothamBold
    Icon.TextColor3 = Color3.fromRGB(88, 166, 255)
    Icon.TextSize = 20
    Icon.ZIndex = 50
    Icon.Parent = Screen
    
    local ICorner = Instance.new("UICorner")
    ICorner.CornerRadius = UDim.new(0, 10)
    ICorner.Parent = Icon
    
    local IStroke = Instance.new("UIStroke")
    IStroke.Color = Color3.fromRGB(88, 166, 255)
    IStroke.Thickness = 2
    IStroke.Parent = Icon
    
    Icon.MouseButton1Click:Connect(function()
        SpyCore.IsMinimized = false
        Main.Visible = true
        Icon:Destroy()
    end)
end)

local drag, dStart, sPos
Header.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        drag = true
        dStart = i.Position
        sPos = Main.Position
    end
end)

Header.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        drag = false
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - dStart
        Main.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + d.X, sPos.Y.Scale, sPos.Y.Offset + d.Y)
    end
end)

RunService.RenderStepped:Connect(function()
    if Main.Visible then
        local pulse = math.abs(math.sin(tick() * 2))
        MainStroke.Transparency = 0.2 + (pulse * 0.3)
    end
end)
