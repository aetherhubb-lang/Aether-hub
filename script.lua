-- =========================================================
-- AETHER HUB - RED & DARK THEME (INSPIRADO NO PRINT)
-- =========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Prevenir duplicidade da interface
if game:GetService("CoreGui"):FindFirstChild("AetherHubUI") then
    game:GetService("CoreGui").AetherHubUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AetherHubUI"
ScreenGui.ResetOnSpawn = false

pcall(function()
    ScreenGui.Parent = game:GetService("CoreGui")
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- =========================================================
-- JANELA PRINCIPAL (MAIN HUB)
-- =========================================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 480, 0, 290)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -145)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainUICorner = Instance.new("UICorner")
MainUICorner.CornerRadius = UDim2.new(0, 12)
MainUICorner.Parent = MainFrame

local MainUIStroke = Instance.new("UIStroke")
MainUIStroke.Color = Color3.fromRGB(220, 35, 35) -- Vermelho Aether
MainUIStroke.Thickness = 1.8
MainUIStroke.Parent = MainFrame

-- BARRA SUPERIOR (TOP BAR)
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 38)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim2.new(0, 12)
TopBarCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -90, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Aether Hub"
Title.TextColor3 = Color3.fromRGB(230, 40, 40)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Cadeado de Arraste (Lock/Unlock)
local LockBtn = Instance.new("TextButton")
LockBtn.Size = UDim2.new(0, 28, 0, 28)
LockBtn.Position = UDim2.new(1, -65, 0, 5)
LockBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
LockBtn.Text = "🔓"
LockBtn.TextSize = 13
LockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LockBtn.Parent = TopBar

local LockCorner = Instance.new("UICorner")
LockCorner.CornerRadius = UDim2.new(0, 6)
LockCorner.Parent = LockBtn

-- Botão Minimizar (-)
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 28, 0, 28)
MinimizeBtn.Position = UDim2.new(1, -32, 0, 5)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
MinimizeBtn.Text = "-"
MinimizeBtn.TextSize = 18
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.Parent = TopBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim2.new(0, 6)
MinCorner.Parent = MinimizeBtn

-- Botão de Reabrir (+)
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 80, 0, 32)
OpenBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
OpenBtn.Text = "Aether Hub"
OpenBtn.TextSize = 12
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.Visible = false
OpenBtn.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim2.new(0, 8)
OpenCorner.Parent = OpenBtn

-- =========================================================
-- PAINEL LATERAL (SIDEBAR DE ABAS)
-- =========================================================
local SideBar = Instance.new("Frame")
SideBar.Size = UDim2.new(0, 130, 1, -45)
SideBar.Position = UDim2.new(0, 8, 0, 42)
SideBar.BackgroundTransparency = 1
SideBar.Parent = MainFrame

local SideLayout = Instance.new("UIListLayout")
SideLayout.Parent = SideBar
SideLayout.SortOrder = Enum.SortOrder.LayoutOrder
SideLayout.Padding = UDim.new(0, 5)

-- PAINEL DE CONTEÚDO (DIREITA)
local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -150, 1, -45)
ContentContainer.Position = UDim2.new(0, 142, 0, 42)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Parent = ContentContainer
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Padding = UDim.new(0, 8)

-- Função para criar botões de aba na lateral
local tabs = {}
local function createTab(name, active)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, 0, 0, 32)
    tabBtn.BackgroundColor3 = active and Color3.fromRGB(200, 30, 30) or Color3.fromRGB(25, 25, 32)
    tabBtn.Text = name
    tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabBtn.TextSize = 12
    tabBtn.Font = Enum.Font.GothamSemibold
    tabBtn.Parent = SideBar

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim2.new(0, 6)
    corner.Parent = tabBtn

    table.insert(tabs, tabBtn)

    tabBtn.MouseButton1Click:Connect(function()
        for _, btn in ipairs(tabs) do
            btn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
        end
        tabBtn.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
    end)
end

-- Criando as abas iguaizinhas ao print
createTab("Principal", true)
createTab("AC Bypass", false)
createTab("Extras", false)
createTab("Teleporte", false)
createTab("Visual", false)
createTab("Créditos", false)

-- =========================================================
-- SISTEMA DE DRAG & MINIMIZAR
-- =========================================================
local dragging = false
local dragInput, dragStart, startPos
local isLocked = false

LockBtn.MouseButton1Click:Connect(function()
    isLocked = not isLocked
    if isLocked then
        LockBtn.Text = "🔒"
        LockBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
    else
        LockBtn.Text = "🔓"
        LockBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    end
end)

TopBar.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not isLocked then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging and not isLocked then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenBtn.Visible = false
end)

-- =========================================================
-- CRIADOR DE CRIAÇÃO DE TOGGLES (CHAVES LIGA/DESLIGA)
-- =========================================================
local function createToggle(text, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -5, 0, 36)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    toggleFrame.Parent = ContentContainer

    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim2.new(0, 6)
    tCorner.Parent = toggleFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -50, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggleFrame

    local switchBg = Instance.new("TextButton")
    switchBg.Size = UDim2.new(0, 36, 0, 20)
    switchBg.Position = UDim2.new(1, -42, 0.5, -10)
    switchBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    switchBg.Text = ""
    switchBg.Parent = toggleFrame

    local swCorner = Instance.new("UICorner")
    swCorner.CornerRadius = UDim2.new(1, 0)
    swCorner.Parent = switchBg

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = UDim2.new(0, 2, 0.5, -8)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.Parent = switchBg

    local knCorner = Instance.new("UICorner")
    knCorner.CornerRadius = UDim2.new(1, 0)
    knCorner.Parent = knob

    local enabled = false
    switchBg.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            switchBg.BackgroundColor3 = Color3.fromRGB(220, 35, 35)
            knob.Position = UDim2.new(1, -18, 0.5, -8)
        else
            switchBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            knob.Position = UDim2.new(0, 2, 0.5, -8)
        end
        callback(enabled)
    end)
end

-- =========================================================
-- LÓGICA DAS FUNÇÕES (GOJO 0.2 E FLY)
-- =========================================================

-- FUNÇÃO 1: Gojo 0.2
local gojoActive = false
local gojoThread = nil

createToggle("Gojo 0.2 (Teleport Loop)", function(state)
    gojoActive = state
    if gojoActive then
        gojoThread = task.spawn(function()
            while gojoActive do
                for _, player in ipairs(Players:GetPlayers()) do
                    if not gojoActive then break end
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local hum = player.Character:FindFirstChildOfClass("Humanoid")
                        if hum and hum.Health > 0 then
                            local myChar = LocalPlayer.Character
                            if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                                myChar.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                            end
                            task.wait(0.03)
                        end
                    end
                end
                task.wait()
            end
        end)
    else
        if gojoThread then task.cancel(gojoThread) end
    end
end)

-- FUNÇÃO 2: Fly Control
local FlyGui = Instance.new("Frame")
FlyGui.Name = "FlyControls"
FlyGui.Size = UDim2.new(1, 0, 1, 0)
FlyGui.BackgroundTransparency = 1
FlyGui.Visible = false
FlyGui.Parent = ScreenGui

-- D-Pad Esquerdo
local DPadFrame = Instance.new("Frame")
DPadFrame.Size = UDim2.new(0, 140, 0, 140)
DPadFrame.Position = UDim2.new(0, 25, 1, -165)
DPadFrame.BackgroundTransparency = 1
DPadFrame.Parent = FlyGui

local function makeFlyBtn(parent, text, size, pos)
    local b = Instance.new("TextButton")
    b.Size = size
    b.Position = pos
    b.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    b.BackgroundTransparency = 0.2
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize = 16
    b.Font = Enum.Font.GothamBold
    b.Parent = parent

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim2.new(0, 8)
    c.Parent = b

    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(220, 35, 35)
    s.Thickness = 1.2
    s.Parent = b

    return b
end

local BtnUp = makeFlyBtn(DPadFrame, "▲", UDim2.new(0, 42, 0, 42), UDim2.new(0.5, -21, 0, 0))
local BtnDown = makeFlyBtn(DPadFrame, "▼", UDim2.new(0, 42, 0, 42), UDim2.new(0.5, -21, 1, -42))
local BtnLeft = makeFlyBtn(DPadFrame, "◄", UDim2.new(0, 42, 0, 42), UDim2.new(0, 0, 0.5, -21))
local BtnRight = makeFlyBtn(DPadFrame, "►", UDim2.new(0, 42, 0, 42), UDim2.new(1, -42, 0.5, -21))

-- Subir e Descer Direito
local AltitudeFrame = Instance.new("Frame")
AltitudeFrame.Size = UDim2.new(0, 45, 0, 100)
AltitudeFrame.Position = UDim2.new(1, -65, 1, -145)
AltitudeFrame.BackgroundTransparency = 1
AltitudeFrame.Parent = FlyGui

local BtnAscend = makeFlyBtn(AltitudeFrame, "▲", UDim2.new(0, 42, 0, 42), UDim2.new(0, 0, 0, 0))
local BtnDescend = makeFlyBtn(AltitudeFrame, "▼", UDim2.new(0, 42, 0, 42), UDim2.new(0, 0, 1, -42))

local flyActive = false
local flySpeed = 60
local flyConnection = nil

local inputsHolding = { Forward = false, Backward = false, Left = false, Right = false, Up = false, Down = false }

local function bindHoldEvents(btn, key)
    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            inputsHolding[key] = true
        end
    end)
    btn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            inputsHolding[key] = false
        end
    end)
end

bindHoldEvents(BtnUp, "Forward")
bindHoldEvents(BtnDown, "Backward")
bindHoldEvents(BtnLeft, "Left")
bindHoldEvents(BtnRight, "Right")
bindHoldEvents(BtnAscend, "Up")
bindHoldEvents(BtnDescend, "Down")

createToggle("Fly (Com Setas Virtuais)", function(state)
    flyActive = state
    FlyGui.Visible = flyActive

    if flyActive then
        flyConnection = RunService.RenderStepped:Connect(function(dt)
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                local camera = workspace.CurrentCamera
                
                local dir = Vector3.zero
                if inputsHolding.Forward then dir = dir + camera.CFrame.LookVector end
                if inputsHolding.Backward then dir = dir - camera.CFrame.LookVector end
                if inputsHolding.Left then dir = dir - camera.CFrame.RightVector end
                if inputsHolding.Right then dir = dir + camera.CFrame.RightVector end
                if inputsHolding.Up then dir = dir + Vector3.new(0, 1, 0) end
                if inputsHolding.Down then dir = dir - Vector3.new(0, 1, 0) end

                if dir.Magnitude > 0 then
                    hrp.Velocity = Vector3.zero
                    hrp.CFrame = hrp.CFrame + (dir.Unit * flySpeed * dt)
                else
                    hrp.Velocity = Vector3.zero
                end
            end
        end)
    else
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        for k in pairs(inputsHolding) do inputsHolding[k] = false end
    end
end)
