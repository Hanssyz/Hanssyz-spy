local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local SpyData = {
    LogText = "",
    IsMinimized = false,
    IsDragging = false,
    StartPos = nil,
    StartFramePos = nil,
    RemoteCount = 0,
    PromptCount = 0,
    EggCount = 0,
    FilterKeywords = {"egg", "steal", "trigger", "grab", "collect", "spawn", "interact", "tool"}
}

if PlayerGui:FindFirstChild("HanssyzSpy") then
    PlayerGui.HanssyzSpy:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HanssyzSpy"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 420)
MainFrame.Position = UDim2.new(0, 15, 0, 80)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 18, 42)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(88, 166, 255)
MainStroke.Thickness = 2
MainStroke.Transparency = 0.3
MainStroke.Parent = MainFrame

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundColor3 = Color3.fromRGB(28, 32, 58)
Header.BorderSizePixel = 0
Header.Active = true
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Name = "Title"
HeaderTitle.Size = UDim2.new(1, -50, 1, 0)
HeaderTitle.Position = UDim2.new(0, 15, 0, 0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "Spy Tool v6.1"
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.TextColor3 = Color3.fromRGB(245, 248, 255)
HeaderTitle.TextSize = 15
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
StatsFrame.Parent = MainFrame

local StatsCorner = Instance.new("UICorner")
StatsCorner.CornerRadius = UDim.new(0, 8)
StatsCorner.Parent = StatsFrame

local StatsLayout = Instance.new("UIListLayout")
StatsLayout.FillDirection = Enum.FillDirection.Horizontal
StatsLayout.SortOrder = Enum.SortOrder.LayoutOrder
StatsLayout.Padding = UDim.new(0, 5)
StatsLayout.Parent = StatsFrame

local EggLabel = Instance.new("TextLabel")
EggLabel.Size = UDim2.new(0.33, -5, 1, 0)
EggLabel.BackgroundTransparency = 1
EggLabel.Text = "Eggs: 0"
EggLabel.Font = Enum.Font.Code
EggLabel.TextColor3 = Color3.fromRGB(100, 255, 160)
EggLabel.TextSize = 11
EggLabel.Parent = StatsFrame

local RemoteLabel = Instance.new("TextLabel")
RemoteLabel.Size = UDim2.new(0.33, -5, 1, 0)
RemoteLabel.BackgroundTransparency = 1
RemoteLabel.Text = "Remotes: 0"
RemoteLabel.Font = Enum.Font.Code
RemoteLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
RemoteLabel.TextSize = 11
RemoteLabel.Parent = StatsFrame

local PromptLabel = Instance.new("TextLabel")
PromptLabel.Size = UDim2.new(0.33, -5, 1, 0)
PromptLabel.BackgroundTransparency = 1
PromptLabel.Text = "Prompts: 0"
PromptLabel.Font = Enum.Font.Code
PromptLabel.TextColor3 = Color3.fromRGB(88, 166, 255)
PromptLabel.TextSize = 11
PromptLabel.Parent = StatsFrame

local GuideFrame = Instance.new("Frame")
GuideFrame.Name = "Guide"
GuideFrame.Size = UDim2.new(1, -20, 0, 60)
GuideFrame.Position = UDim2.new(0, 10, 0, 100)
GuideFrame.BackgroundColor3 = Color3.fromRGB(40, 45, 80)
GuideFrame.BorderSizePixel = 0
GuideFrame.Parent = MainFrame

local GuideCorner = Instance.new("UICorner")
GuideCorner.CornerRadius = UDim.new(0, 8)
GuideCorner.Parent = GuideFrame

local GuideTitle = Instance.new("TextLabel")
GuideTitle.Size = UDim2.new(1, -20, 0, 20)
GuideTitle.Position = UDim2.new(0, 10, 0, 5)
GuideTitle.BackgroundTransparency = 1
GuideTitle.Text = "PANDUAN:"
GuideTitle.Font = Enum.Font.GothamBold
GuideTitle.TextColor3 = Color3.fromRGB(255, 255, 100)
GuideTitle.TextSize = 11
GuideTitle.TextXAlignment = Enum.TextXAlignment.Left
GuideTitle.Parent = GuideFrame

local GuideDesc = Instance.new("TextLabel")
GuideDesc.Name = "Desc"
GuideDesc.Size = UDim2.new(1, -20, 0, 30)
GuideDesc.Position = UDim2.new(0, 10, 0, 25)
GuideDesc.BackgroundTransparency = 1
GuideDesc.Text = "1. Pencet SCAN.\n2. Curi 1 Egg manual (pencet E)."
GuideDesc.Font = Enum.Font.Gotham
GuideDesc.TextColor3 = Color3.fromRGB(200, 220, 255)
GuideDesc.TextSize = 11
GuideDesc.TextXAlignment = Enum.TextXAlignment.Left
GuideDesc.TextYAlignment = Enum.TextYAlignment.Top
GuideDesc.TextWrapped = true
GuideDesc.Parent = GuideFrame

local LogContainer = Instance.new("Frame")
LogContainer.Name = "LogContainer"
LogContainer.Size = UDim2.new(1, -20, 1, -200)
LogContainer.Position = UDim2.new(0, 10, 0, 170)
LogContainer.BackgroundColor3 = Color3.fromRGB(10, 12, 25)
LogContainer.BorderSizePixel = 0
LogContainer.ClipsDescendants = true
LogContainer.Parent = MainFrame

local LogCorner = Instance.new("UICorner")
LogCorner.CornerRadius = UDim.new(0, 8)
LogCorner.Parent = LogContainer

local LogStroke = Instance.new("UIStroke")
LogStroke.Color = Color3.fromRGB(50, 55, 80)
LogStroke.Thickness = 1
LogStroke.Parent = LogContainer

local ScrollingLog = Instance.new("ScrollingFrame")
ScrollingLog.Name = "Scrolling"
ScrollingLog.Size = UDim2.new(1, -10, 1, -10)
ScrollingLog.Position = UDim2.new(0, 5, 0, 5)
ScrollingLog.BackgroundTransparency = 1
ScrollingLog.BorderSizePixel = 0
ScrollingLog.ScrollBarThickness = 3
ScrollingLog.ScrollBarImageColor3 = Color3.fromRGB(88, 166, 255)
ScrollingLog.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingLog.Parent = LogContainer

local LogLayout = Instance.new("UIListLayout")
LogLayout.Padding = UDim.new(0, 4)
LogLayout.Parent = ScrollingLog

local BtnFrame = Instance.new("Frame")
BtnFrame.Name = "Buttons"
BtnFrame.Size = UDim2.new(1, -20, 0, 35)
BtnFrame.Position = UDim2.new(0, 10, 1, -45)
BtnFrame.BackgroundTransparency = 1
BtnFrame.Parent = MainFrame

local ScanBtn = Instance.new("TextButton")
ScanBtn.Name = "ScanBtn"
ScanBtn.Size = UDim2.new(0.48, 0, 1, 0)
ScanBtn.Position = UDim2.new(0, 0, 0, 0)
ScanBtn.BackgroundColor3 = Color3.fromRGB(100, 255, 160)
ScanBtn.Text = "SCAN EGG"
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

local function Log(text, color)
    SpyData.LogText = SpyData.LogText .. text .. "\n"
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 22)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.Code
    label.TextColor3 = color or Color3.fromRGB(200, 200, 200)
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextWrapped = true
    label.Parent = ScrollingLog
    ScrollingLog.CanvasSize = UDim2.new(0, 0, 0, LogLayout.AbsoluteContentSize.Y + 10)
end

local function IsRelevant(text)
    local lower = text:lower()
    for _, kw in pairs(SpyData.FilterKeywords) do
        if lower:find(kw) then return true end
    end
    if lower:find("away") or lower:find("fps") or lower:find("ping") then return false end
    return false
end

Log("[SISTEM] Spy Tool Aktif.", Color3.fromRGB(100, 255, 160))

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    if method == "FireServer" or method == "InvokeServer" then
        local path = self:GetFullName()
        local name = self.Name
        if IsRelevant(name) or IsRelevant(path) then
            SpyData.RemoteCount = SpyData.RemoteCount + 1
            RemoteLabel.Text = "Remotes: " .. SpyData.RemoteCount
            local args = {...}
            local argStr = ""
            for _, v in pairs(args) do
                if typeof(v) == "Instance" then
                    argStr = argStr .. v.Name .. ", "
                else
                    argStr = argStr .. tostring(v) .. ", "
                end
            end
            Log("REMOTE: " .. name .. " | " .. argStr, Color3.fromRGB(255, 200, 100))
        end
    end
    return oldNamecall(self, ...)
end)

local oldPrompt = fireproximityprompt
fireproximityprompt = function(prompt)
    SpyData.PromptCount = SpyData.PromptCount + 1
    PromptLabel.Text = "Prompts: " .. SpyData.PromptCount
    Log("PROMPT: " .. prompt.Name .. " (" .. prompt.Parent.Name .. ")", Color3.fromRGB(88, 166, 255))
    return oldPrompt(prompt)
end

ScanBtn.MouseButton1Click:Connect(function()
    Log("--- SCAN DIMULAI ---", Color3.fromRGB(255, 255, 100))
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    local found = 0
    for _, v in pairs(workspace:GetDescendants()) do
        if (v:IsA("Model") or v:IsA("BasePart")) and v.Name:lower():find("egg") then
            local pos = v:IsA("Model") and v:GetPivot().Position or v.Position
            local dist = (hrp.Position - pos).Magnitude
            if dist < 150 then
                found = found + 1
                SpyData.EggCount = SpyData.EggCount + 1
                EggLabel.Text = "Eggs: " .. SpyData.EggCount
                local prompt = v:FindFirstChildWhichIsA("ProximityPrompt", true)
                local status = prompt and "BISA DICURI" or "PAJANGAN"
                local color = prompt and Color3.fromRGB(100, 255, 160) or Color3.fromRGB(255, 120, 120)
                Log("EGG: " .. v.Name .. " | " .. status, color)
            end
        end
    end
    if found == 0 then
        Log("Egg tidak ditemukan.", Color3.fromRGB(255, 120, 120))
    end
end)

CopyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(SpyData.LogText)
        CopyBtn.Text = "COPIED!"
        task.wait(2)
        CopyBtn.Text = "COPY LOG"
    end
end)

MinBtn.MouseButton1Click:Connect(function()
    if SpyData.IsMinimized then return end
    SpyData.IsMinimized = true
    MainFrame.Visible = false
    local Icon = Instance.new("TextButton")
    Icon.Size = UDim2.new(0, 40, 0, 40)
    Icon.Position = UDim2.new(0, 20, 0, 100)
    Icon.BackgroundColor3 = Color3.fromRGB(28, 32, 58)
    Icon.Text = "S"
    Icon.Font = Enum.Font.GothamBold
    Icon.TextColor3 = Color3.fromRGB(88, 166, 255)
    Icon.TextSize = 18
    Icon.ZIndex = 50
    Icon.Parent = ScreenGui
    local ICorner = Instance.new("UICorner")
    ICorner.CornerRadius = UDim.new(0, 10)
    ICorner.Parent = Icon
    local IStroke = Instance.new("UIStroke")
    IStroke.Color = Color3.fromRGB(88, 166, 255)
    IStroke.Thickness = 2
    IStroke.Parent = Icon
    Icon.MouseButton1Click:Connect(function()
        SpyData.IsMinimized = false
        MainFrame.Visible = true
        Icon:Destroy()
    end)
end)

local drag, dStart, sPos
Header.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        drag = true
        dStart = i.Position
        sPos = MainFrame.Position
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
        MainFrame.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + d.X, sPos.Y.Scale, sPos.Y.Offset + d.Y)
    end
end)
