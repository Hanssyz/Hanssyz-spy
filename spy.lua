--[[
    Hanssyz Sc | Deep Spy & Inspector v3.0
    Fitur: Logging interaksi, Scan Egg (Bisa dicuri vs Pajangan), Copy to Clipboard.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Setup UI
if PlayerGui:FindFirstChild("SpyUI") then PlayerGui.SpyUI:Destroy() end
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SpyUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 400)
MainFrame.Position = UDim2.new(0, 10, 0, 100)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 18, 42)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui
local UICorner = Instance.new("UICorner"); UICorner.CornerRadius = UDim.new(0, 10); UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(28, 32, 58)
Title.Text = "Hanssyz Deep Spy"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Parent = MainFrame

local ScrollingLog = Instance.new("ScrollingFrame")
ScrollingLog.Size = UDim2.new(1, -20, 1, -120)
ScrollingLog.Position = UDim2.new(0, 10, 0, 45)
ScrollingLog.BackgroundTransparency = 1
ScrollingLog.BorderSizePixel = 0
ScrollingLog.ScrollBarThickness = 4
ScrollingLog.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingLog.Parent = MainFrame
local UIListLayout = Instance.new("UIListLayout"); UIListLayout.Parent = ScrollingLog

local BtnLayout = Instance.new("Frame")
BtnLayout.Size = UDim2.new(1, -20, 0, 35)
BtnLayout.Position = UDim2.new(0, 10, 1, -45)
BtnLayout.BackgroundTransparency = 1
BtnLayout.Parent = MainFrame

local CopyBtn = Instance.new("TextButton")
CopyBtn.Size = UDim2.new(0.48, 0, 1, 0)
CopyBtn.Position = UDim2.new(0, 0, 0, 0)
CopyBtn.BackgroundColor3 = Color3.fromRGB(88, 166, 255)
CopyBtn.Text = "COPY LOG"
CopyBtn.Font = Enum.Font.GothamBold
CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyBtn.Parent = BtnLayout
local CC = Instance.new("UICorner"); CC.CornerRadius = UDim.new(0, 6); CC.Parent = CopyBtn

local ScanBtn = Instance.new("TextButton")
ScanBtn.Size = UDim2.new(0.48, 0, 1, 0)
ScanBtn.Position = UDim2.new(0.52, 0, 0, 0)
ScanBtn.BackgroundColor3 = Color3.fromRGB(100, 255, 160)
ScanBtn.Text = "SCAN EGGS"
ScanBtn.Font = Enum.Font.GothamBold
ScanBtn.TextColor3 = Color3.fromRGB(15, 18, 42)
ScanBtn.Parent = BtnLayout
local SC = Instance.new("UICorner"); SC.CornerRadius = UDim.new(0, 6); SC.Parent = ScanBtn

-- Logging System
local FullLogText = ""
local function Log(text, color)
    FullLogText = FullLogText .. text .. "\n"
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 25)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.Code
    label.TextColor3 = color or Color3.fromRGB(200, 200, 200)
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextWrapped = true
    label.Parent = ScrollingLog
    ScrollingLog.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end

Log("[SISTEM] Spy v3.0 Aktif. Silakan main manual.", Color3.fromRGB(100, 255, 160))

-- 1. HOOK REMOTE & PROMPT
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
        Log("REMOTE: " .. self:GetFullName() .. " | Args: " .. argStr, Color3.fromRGB(255, 200, 100))
    end
    return oldNamecall(self, ...)
end)

local oldPrompt = fireproximityprompt
fireproximityprompt = function(prompt)
    Log("PROMPT: " .. prompt.Name .. " | Parent: " .. prompt.Parent.Name, Color3.fromRGB(100, 200, 255))
    return oldPrompt(prompt)
end

-- 2. SCAN EGGS (Bisa Dicuri vs Pajangan)
ScanBtn.MouseButton1Click:Connect(function()
    Log("--- MEMULAI SCAN EGG ---", Color3.fromRGB(255, 255, 100))
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    
    local foundCount = 0
    for _, v in pairs(workspace:GetDescendants()) do
        if (v:IsA("Model") or v:IsA("BasePart")) and v.Name:lower():find("egg") then
            local pos = v:IsA("Model") and v:GetPivot().Position or v.Position
            local dist = (hrp.Position - pos).Magnitude
            
            if dist < 150 then -- Radius 150 stud
                local hasPrompt = v:FindFirstChildWhichIsA("ProximityPrompt", true) ~= nil
                local hasClick = v:FindFirstChildWhichIsA("ClickDetector", true) ~= nil
                
                local status = "PAJANGAN (Ga bisa dicuri)"
                local color = Color3.fromRGB(255, 100, 100)
                
                if hasPrompt then
                    status = "BISA DICURI (Ada Prompt)"
                    color = Color3.fromRGB(100, 255, 160)
                elseif hasClick then
                    status = "BISA DICURI (Ada Click)"
                    color = Color3.fromRGB(100, 255, 160)
                elseif v:IsA("Model") and v.PrimaryPart then
                    -- Cek apakah model punya script di dalemnya
                    local hasScript = false
                    for _, child in pairs(v:GetDescendants()) do
                        if child:IsA("Script") or child:IsA("LocalScript") then hasScript = true break end
                    end
                    if hasScript then
                        status = "MUNGKIN BISA (Ada Script)"
                        color = Color3.fromRGB(255, 255, 100)
                    end
                end
                
                Log("EGG: " .. v.Name .. " | Dist: " .. math.floor(dist) .. " | " .. status, color)
                foundCount += 1
            end
        end
    end
    
    if foundCount == 0 then
        Log("Ga ada object bernama 'egg' di radius 150 stud.", Color3.fromRGB(255, 100, 100))
    else
        Log("Scan selesai. " .. foundCount .. " object ditemukan.", Color3.fromRGB(255, 255, 100))
    end
end)

-- 3. COPY TO CLIPBOARD
CopyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(FullLogText)
        CopyBtn.Text = "COPIED!"
        task.wait(2)
        CopyBtn.Text = "COPY LOG"
    else
        CopyBtn.Text = "GAGAL COPY"
        task.wait(2)
        CopyBtn.Text = "COPY LOG"
    end
end)

-- Draggable
local dragging, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = MainFrame.Position
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
