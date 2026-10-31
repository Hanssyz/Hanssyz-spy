--[[
    =========================================
    KYRIEL'S RECON SUITE V2
    =========================================
    Fitur:
    - Remote Spy (Log komunikasi client-server)
    - Passive Memory Scanner (Baca daftar Egg & Rarity di game)
    - Copy Log
    - TIDAK mengambil/mencuri egg secara otomatis.
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("Kyriel_ReconSuite") then
    CoreGui.Kyriel_ReconSuite:Destroy()
end

-- =========================================
-- UI SETUP
-- =========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Kyriel_ReconSuite"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -10, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Kyriel's Recon Suite v2 | Passive Mode"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Tombol Copy & Clear
local CopyBtn = Instance.new("TextButton")
CopyBtn.Size = UDim2.new(0, 70, 0, 25)
CopyBtn.Position = UDim2.new(1, -150, 0, 5)
CopyBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 150)
CopyBtn.Text = "Copy Log"
CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyBtn.Font = Enum.Font.GothamBold
CopyBtn.TextSize = 11
CopyBtn.Parent = TopBar
Instance.new("UICorner", CopyBtn).CornerRadius = UDim.new(0, 4)

local ClearBtn = Instance.new("TextButton")
ClearBtn.Size = UDim2.new(0, 70, 0, 25)
ClearBtn.Position = UDim2.new(1, -75, 0, 5)
ClearBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
ClearBtn.Text = "Clear"
ClearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearBtn.Font = Enum.Font.GothamBold
ClearBtn.TextSize = 11
ClearBtn.Parent = TopBar
Instance.new("UICorner", ClearBtn).CornerRadius = UDim.new(0, 4)

-- Tab System (Spy & Scanner)
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1, -20, 0, 30)
TabFrame.Position = UDim2.new(0, 10, 0, 40)
TabFrame.BackgroundTransparency = 1
TabFrame.Parent = MainFrame

local SpyTab = Instance.new("TextButton")
SpyTab.Size = UDim2.new(0, 100, 1, 0)
SpyTab.Position = UDim2.new(0, 0, 0, 0)
SpyTab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SpyTab.Text = "Remote Spy"
SpyTab.TextColor3 = Color3.fromRGB(255, 255, 255)
SpyTab.Font = Enum.Font.GothamBold
SpyTab.TextSize = 12
SpyTab.Parent = TabFrame

local ScanTab = Instance.new("TextButton")
ScanTab.Size = UDim2.new(0, 100, 1, 0)
ScanTab.Position = UDim2.new(0, 105, 0, 0)
ScanTab.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ScanTab.Text = "Egg & Rarity"
ScanTab.TextColor3 = Color3.fromRGB(150, 150, 150)
ScanTab.Font = Enum.Font.GothamBold
ScanTab.TextSize = 12
ScanTab.Parent = TabFrame

-- Container Log
local SpyContainer = Instance.new("ScrollingFrame")
SpyContainer.Size = UDim2.new(1, -20, 1, -85)
SpyContainer.Position = UDim2.new(0, 10, 0, 75)
SpyContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SpyContainer.BorderSizePixel = 0
SpyContainer.ScrollBarThickness = 6
SpyContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
SpyContainer.Parent = MainFrame
local SpyLayout = Instance.new("UIListLayout", SpyContainer)
SpyLayout.Padding = UDim.new(0, 4)

local ScanContainer = Instance.new("ScrollingFrame")
ScanContainer.Size = UDim2.new(1, -20, 1, -85)
ScanContainer.Position = UDim2.new(0, 10, 0, 75)
ScanContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ScanContainer.BorderSizePixel = 0
ScanContainer.ScrollBarThickness = 6
ScanContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
ScanContainer.Visible = false
ScanContainer.Parent = MainFrame
local ScanLayout = Instance.new("UIListLayout", ScanContainer)
ScanLayout.Padding = UDim.new(0, 4)

-- Tab Logic
SpyTab.MouseButton1Click:Connect(function()
    SpyContainer.Visible = true
    ScanContainer.Visible = false
    SpyTab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ScanTab.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    SpyTab.TextColor3 = Color3.fromRGB(255, 255, 255)
    ScanTab.TextColor3 = Color3.fromRGB(150, 150, 150)
end)

ScanTab.MouseButton1Click:Connect(function()
    SpyContainer.Visible = false
    ScanContainer.Visible = true
    ScanTab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    SpyTab.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ScanTab.TextColor3 = Color3.fromRGB(255, 255, 255)
    SpyTab.TextColor3 = Color3.fromRGB(150, 150, 150)
end)

-- Logging Function
local FullLog = ""
local function AddLog(text, color, container)
    FullLog = FullLog .. text .. "\n"
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -5, 0, 18)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color or Color3.fromRGB(200, 200, 200)
    label.Font = Enum.Font.Code
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container
    
    local layout = container:FindFirstChildOfClass("UIListLayout")
    container.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    container.CanvasPosition = Vector2.new(0, layout.AbsoluteContentSize.Y)
end

-- Copy & Clear Logic
CopyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(FullLog)
        AddLog("[SYSTEM] Log dicopy ke clipboard!", Color3.fromRGB(0, 255, 0), SpyContainer)
    end
end)

ClearBtn.MouseButton1Click:Connect(function()
    FullLog = ""
    for _, v in pairs(SpyContainer:GetChildren()) do
        if v:IsA("TextLabel") then v:Destroy() end
    end
    for _, v in pairs(ScanContainer:GetChildren()) do
        if v:IsA("TextLabel") then v:Destroy() end
    end
end)

-- =========================================
-- 1. REMOTE SPY HOOK
-- =========================================
AddLog("[SYSTEM] Remote Spy aktif.", Color3.fromRGB(0, 255, 0), SpyContainer)

local oldFireServer
oldFireServer = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    if not checkcaller() and method == "FireServer" and self:IsA("RemoteEvent") then
        local args = {...}
        local argStr = ""
        for i, v in ipairs(args) do
            argStr = argStr .. tostring(v) .. (i < #args and ", " or "")
        end
        AddLog("[OUT] " .. self:GetFullName() .. " (" .. argStr .. ")", Color3.fromRGB(100, 200, 255), SpyContainer)
    end
    return oldFireServer(self, ...)
end)

local oldInvokeServer
oldInvokeServer = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    if not checkcaller() and method == "InvokeServer" and self:IsA("RemoteFunction") then
        local args = {...}
        local argStr = ""
        for i, v in ipairs(args) do
            argStr = argStr .. tostring(v) .. (i < #args and ", " or "")
        end
        AddLog("[INVOKE] " .. self:GetFullName() .. " (" .. argStr .. ")", Color3.fromRGB(255, 150, 50), SpyContainer)
    end
    return oldInvokeServer(self, ...)
end)

-- =========================================
-- 2. PASSIVE MEMORY SCANNER (EGG & RARITY)
-- =========================================
local ScannedData = {}

local function ScanGameData()
    AddLog("[SCAN] Memulai pemindaian data game secara pasif...", Color3.fromRGB(255, 255, 0), ScanContainer)
    
    -- Cari di ReplicatedStorage, Workspace, dan module script
    for _, obj in pairs(game:GetDescendants()) do
        -- 1. Cari nama objek yang ada hubungannya sama Egg
        if obj.Name:lower():find("egg") or obj.Name:lower():find("rarity") then
            if not ScannedData[obj.Name] then
                ScannedData[obj.Name] = true
                local parentName = obj.Parent and obj.Parent.Name or "Unknown"
                AddLog("[DATA] " .. obj.Name .. " | Tipe: " .. obj.ClassName .. " | Parent: " .. parentName, Color3.fromRGB(200, 100, 255), ScanContainer)
            end
        end
        
        -- 2. Cari String/ModuleScript yang isinya tabel data (biasanya di ReplicatedStorage)
        if obj:IsA("ModuleScript") and (obj.Name:lower():find("egg") or obj.Name:lower():find("data") or obj.Name:lower():find("config")) then
            AddLog("[MODULE] Ketemu module potensial: " .. obj:GetFullName() .. " (Coba cek isinya pake executor)", Color3.fromRGB(255, 100, 100), ScanContainer)
        end
    end
    
    -- 3. Scan Workspace buat liat Egg apa aja yang lagi ada di map
    AddLog("[SCAN] Memindai egg yang ada di map (Workspace)...", Color3.fromRGB(255, 255, 0), ScanContainer)
    local activeEggs = {}
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name:lower():find("egg") then
            if not activeEggs[obj.Name] then
                activeEggs[obj.Name] = true
                AddLog("[MAP] Egg Aktif: " .. obj.Name .. " (Jarak: " .. math.floor((LocalPlayer.Character.HumanoidRootPart.Position - obj:GetPivot().Position).Magnitude) .. " studs)", Color3.fromRGB(100, 255, 100), ScanContainer)
            end
        end
    end
    
    AddLog("[SCAN] Pemindaian selesai. Data di atas adalah hasil observasi pasif.", Color3.fromRGB(0, 255, 0), ScanContainer)
end

-- Jalanin scan pas script di-load
task.spawn(ScanGameData)

-- =========================================
-- 3. INSTRUKSI
-- =========================================
print("=====================================================")
print("KYRIEL'S RECON SUITE V2 - INSTRUKSI")
print("=====================================================")
print("1. Cek tab 'Egg & Rarity' buat liat daftar egg & kemungkinan rarity.")
print("2. Lakuin mekanisme steal MANUAL 1x.")
print("3. Balik ke tab 'Remote Spy', liat remote apa yang dipanggil saat lo steal.")
print("4. Klik 'Copy Log' dan kirim ke gua.")
print("=====================================================")
