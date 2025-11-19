--== PAINEL VERMELHO - GUI COMPLETA SEM LÓGICA ==--

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "PainelVermelho"
gui.Parent = player:WaitForChild("PlayerGui")

-- JANELA PRINCIPAL
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 500, 0, 300)
main.Position = UDim2.new(0.5, -250, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
main.BorderSizePixel = 0
main.Parent = gui

local UICorner = Instance.new("UICorner", main)
UICorner.CornerRadius = UDim.new(0, 6)

-- ABA CONTAINER
local tabs = Instance.new("Frame")
tabs.Size = UDim2.new(1, 0, 0, 35)
tabs.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
tabs.BorderSizePixel = 0
tabs.Parent = main

local tabLayout = Instance.new("UIListLayout", tabs)
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 5)

-- FUNÇÃO PARA CRIAR BOTÕES DE ABA
local function createTabButton(name)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 160, 1, 0)
    b.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.Text = name
    b.Parent = tabs
    local c = Instance.new("UICorner", b)
    c.CornerRadius = UDim.new(0,4)
    return b
end

-- CRIAR ABAS
local tabAimbot = createTabButton("Aimbot")
local tabFOV = createTabButton("FOV")
local tabESP = createTabButton("ESP")

-- CONTEÚDO DAS ABAS
local function createPage()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 1, -55)
    frame.Position = UDim2.new(0, 10, 0, 45)
    frame.BackgroundColor3 = Color3.fromRGB(70, 0, 0)
    frame.Visible = false
    frame.Parent = main

    local c = Instance.new("UICorner", frame)
    c.CornerRadius = UDim.new(0, 5)

    return frame
end

local pageAimbot = createPage()
local pageFOV = createPage()
local pageESP = createPage()

-- Mostrar página certa
local function openPage(pg)
    pageAimbot.Visible = false
    pageFOV.Visible = false
    pageESP.Visible = false
    pg.Visible = true
end

tabAimbot.MouseButton1Click:Connect(function() openPage(pageAimbot) end)
tabFOV.MouseButton1Click:Connect(function() openPage(pageFOV) end)
tabESP.MouseButton1Click:Connect(function() openPage(pageESP) end)

pageAimbot.Visible = true -- A aba inicial será AIMBOT

-- FUNÇÃO PARA CRIAR TOGGLES
local function createToggle(parent, text)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 30)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(255,255,255)
    lbl.BackgroundTransparency = 1
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0.3, 0, 1, 0)
    btn.Position = UDim2.new(0.7, 0, 0, 0)
    btn.Text = "OFF"
    btn.BackgroundColor3 = Color3.fromRGB(120,0,0)
    btn.TextColor3 = Color3.fromRGB(255,255,255)

    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 4)

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = state and "ON" or "OFF"
        btn.BackgroundColor3 = state and Color3.fromRGB(200,0,0) or Color3.fromRGB(120,0,0)
    end)
end

-- ======================================================================
-- ABA AIMBOT
-- ======================================================================
local listAimbot = Instance.new("UIListLayout", pageAimbot)
listAimbot.Padding = UDim.new(0,5)

createToggle(pageAimbot, "Enable Aimbot")

-- Dropdown Aimpart
do
    local drop = Instance.new("TextButton", pageAimbot)
    drop.Size = UDim2.new(1, -20, 0, 30)
    drop.Text = "Aimpart: Head"
    drop.BackgroundColor3 = Color3.fromRGB(120,0,0)
    drop.TextColor3 = Color3.fromRGB(255,255,255)

    local c = Instance.new("UICorner", drop)
    c.CornerRadius = UDim.new(0,4)

    local open = false
    local list = Instance.new("Frame", pageAimbot)
    list.Size = UDim2.new(1, -20, 0, 60)
    list.BackgroundColor3 = Color3.fromRGB(90,0,0)
    list.Visible = false

    local ll = Instance.new("UIListLayout", list)

    local function opt(name)
        local b = Instance.new("TextButton", list)
        b.Size = UDim2.new(1,0,0,30)
        b.BackgroundColor3 = Color3.fromRGB(120,0,0)
        b.TextColor3 = Color3.fromRGB(255,255,255)
        b.Text = name

        b.MouseButton1Click:Connect(function()
            drop.Text = "Aimpart: "..name
            list.Visible = false
            open = false
        end)
    end

    opt("Head")
    opt("Chest")

    drop.MouseButton1Click:Connect(function()
        open = not open
        list.Visible = open
    end)
end

-- ======================================================================
-- ABA FOV
-- ======================================================================

local listFov = Instance.new("UIListLayout", pageFOV)
listFov.Padding = UDim.new(0,5)

createToggle(pageFOV, "Enable FOV")

-- Slider de FOV
do
    local frame = Instance.new("Frame", pageFOV)
    frame.Size = UDim2.new(1, -20, 0, 40)
    frame.BackgroundTransparency = 1

    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(1,0,0.5,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = "Tamanho do FOV"
    lbl.TextColor3 = Color3.fromRGB(255,255,255)

    local slider = Instance.new("Frame", frame)
    slider.Size = UDim2.new(1,0,0.5,0)
    slider.Position = UDim2.new(0,0,0.5,0)
    slider.BackgroundColor3 = Color3.fromRGB(90,0,0)

    local bar = Instance.new("Frame", slider)
    bar.Size = UDim2.new(0.3,0,1,0)
    bar.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
end

-- ======================================================================
-- ABA ESP
-- ======================================================================

local listESP = Instance.new("UIListLayout", pageESP)
listESP.Padding = UDim.new(0,5)

createToggle(pageESP, "Enable ESP")
createToggle(pageESP, "Enable Lines")
createToggle(pageESP, "Enable Health Bar")
createToggle(pageESP, "Enable Box")
createToggle(pageESP, "Enable Fill Color")
createToggle(pageESP, "Enable Name")
createToggle(pageESP, "Enable Distance")
createToggle(pageESP, "Enable Skeleton")

