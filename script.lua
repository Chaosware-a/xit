--== PAINEL VERMELHO (SEM LÓGICA) ==--

-- Criar ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "RedMenu"
gui.ResetOnSpawn = false
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Criar Frame principal
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 380, 0, 300)
main.Position = UDim2.new(0.2, 0, 0.2, 0)
main.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
main.BorderSizePixel = 0
main.Parent = gui

-- Cantos arredondados
local uiCorner = Instance.new("UICorner", main)
uiCorner.CornerRadius = UDim.new(0, 12)

-- Barra superior
local top = Instance.new("Frame")
top.Name = "TopBar"
top.Size = UDim2.new(1, 0, 0, 30)
top.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
top.BorderSizePixel = 0
top.Parent = main

Instance.new("UICorner", top).CornerRadius = UDim.new(0, 10)

-- Título
local title = Instance.new("TextLabel")
title.Text = "PAINEL NECESSARY4CODE"
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.Parent = top

-- Aba lateral
local side = Instance.new("Frame")
side.Name = "SideBar"
side.Size = UDim2.new(0, 95, 1, -30)
side.Position = UDim2.new(0, 0, 0, 30)
side.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
side.BorderSizePixel = 0
side.Parent = main
Instance.new("UICorner", side).CornerRadius = UDim.new(0, 12)

-- Função para criar botões das abas
local function createTabButton(name, order)
    local btn = Instance.new("TextButton")
    btn.Text = name
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Position = UDim2.new(0, 0, 0, (order - 1) * 45)
    btn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.Parent = side
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    return btn
end

local btnAimbot = createTabButton("Aimbot", 1)
local btnFOV = createTabButton("FOV", 2)
local btnESP = createTabButton("ESP", 3)

-- Área de conteúdo
local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1, -95, 1, -30)
content.Position = UDim2.new(0, 95, 0, 30)
content.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
content.BorderSizePixel = 0
content.Parent = main
Instance.new("UICorner", content).CornerRadius = UDim.new(0, 12)

-- Função para criar páginas
local function createPage(name)
    local page = Instance.new("Frame")
    page.Name = name
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = content
    return page
end

local pageAimbot = createPage("Aimbot")
local pageFOV = createPage("FOV")
local pageESP = createPage("ESP")

-- Mostrar aba
local function showPage(page)
    pageAimbot.Visible = false
    pageFOV.Visible = false
    pageESP.Visible = false
    page.Visible = true
end

btnAimbot.MouseButton1Click:Connect(function() showPage(pageAimbot) end)
btnFOV.MouseButton1Click:Connect(function() showPage(pageFOV) end)
btnESP.MouseButton1Click:Connect(function() showPage(pageESP) end)

-- Mostrar Aimbot ao abrir
showPage(pageAimbot)

-- Criar textos dentro das seções
local function addLabel(parent, text, offset)
    local lbl = Instance.new("TextLabel")
    lbl.Text = text
    lbl.Size = UDim2.new(1, -20, 0, 30)
    lbl.Position = UDim2.new(0, 10, 0, offset)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.new(1, 1, 1)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextScaled = true
    lbl.Parent = parent
end

-- Aimbot
addLabel(pageAimbot, "AIMBOT (sem lógica ainda)", 20)
addLabel(pageAimbot, "- Ativar", 60)
addLabel(pageAimbot, "- Mira na cabeça", 100)
addLabel(pageAimbot, "- Mira no torso", 140)

-- FOV
addLabel(pageFOV, "FOV (sem lógica)", 20)
addLabel(pageFOV, "- Círculo FOV", 60)
addLabel(pageFOV, "- Tamanho FOV", 100)
addLabel(pageFOV, "- Cor do FOV", 140)

-- ESP
addLabel(pageESP, "ESP (sem lógica ainda)", 20)
addLabel(pageESP, "- Caixa no inimigo a 50m", 60)
addLabel(pageESP, "- Caixa colorida", 100)
addLabel(pageESP, "- Cor igual ao FOV", 140)
addLabel(pageESP, "- Nome do player", 180)
addLabel(pageESP, "- Distância", 220)


