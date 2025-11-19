local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Meu Painel", "DarkTheme")

-- ======================================
--              ABA AIMBOT
-- ======================================
local AimbotTab = Window:NewTab("Aimbot")
local AimbotSection = AimbotTab:NewSection("Configurações")

local aimbotEnabled = false
local smoothValue = 1
local fovValue = 50

AimbotSection:NewToggle("Aimbot", "Liga/Desliga o Aimbot", function(v)
    aimbotEnabled = v
end)

AimbotSection:NewSlider("Aimbot Smooth", "Velocidade de mira", 10, 1, function(v)
    smoothValue = v
end)

AimbotSection:NewSlider("Aimbot FOV", "Área do aimbot", 200, 1, function(v)
    fovValue = v
end)

-- =========================
-- ABA ESP (DUAS COLUNAS)
-- =========================

local ESPTab = Window:NewTab("ESP")

-- COLUNA ESQUERDA
local ESPMain = ESPTab:NewSection("Main")

ESPMain:NewToggle("Enable ESP", "Ativa todo o ESP", function(v)
    espEnabled = v
end)

ESPMain:NewToggle("Enable RGB", "ESP colorido animado", function(v)
    espRGB = v
end)

ESPMain:NewToggle("Enable Box", "Caixa ao redor do player", function(v)
    espBox = v
end)

ESPMain:NewToggle("Enable Name", "Mostrar nome", function(v)
    espName = v
end)

ESPMain:NewToggle("Enable Dist", "Mostrar distância", function(v)
    espDist = v
end)

ESPMain:NewToggle("Enable Skel", "Mostrar esqueleto", function(v)
    espSkel = v
end)

ESPMain:NewToggle("Enable Lines", "Linhas do jogador até você", function(v)
    espLines = v
end)

ESPMain:NewToggle("Health Bar", "Barra de vida", function(v)
    espHealthBar = v
end)

-- COLUNA DIREITA
local ESPSettings = ESPTab:NewSection("Settings")

ESPSettings:NewSlider("Distance", "Distância máxima", 500, 50, function(v)
    espDistance = v
end)

ESPSettings:NewSlider("Text Size", "Tamanho do texto", 20, 8, function(v)
    espTextSize = v
end)

-- CORES
ESPSettings:NewColorPicker("Name Color", "Cor do nome", Color3.fromRGB(255,255,255), function(v)
    espNameColor = v
end)

ESPSettings:NewColorPicker("Dist Color", "Cor da distância", Color3.fromRGB(255,255,255), function(v)
    espDistColor = v
end)

ESPSettings:NewColorPicker("Box Color", "Cor da caixa", Color3.fromRGB(255,255,255), function(v)
    espBoxColor = v
end)

ESPSettings:NewColorPicker("Fill Color", "Cor do preenchimento", Color3.fromRGB(255,0,0), function(v)
    espFillColor = v
end)

ESPSettings:NewColorPicker("Skel Color", "Cor do esqueleto", Color3.fromRGB(0,255,255), function(v)
    espSkelColor = v
end)

ESPSettings:NewColorPicker("Icon Color", "Cor dos ícones", Color3.fromRGB(255,255,0), function(v)
    espIconColor = v
end)

ESPSettings:NewColorPicker("Lines Color", "Cor das linhas", Color3.fromRGB(255,255,255), function(v)
    espLinesColor = v
end)

-- ======================================
--              ABA NO RECOIL
-- ======================================
local NoRecoilTab = Window:NewTab("Armas")
local NoRecoilSection = NoRecoilTab:NewSection("Configurações")

local noRecoil = false

NoRecoilSection:NewToggle("No Recoil", "Remove o recuo da arma", function(v)
    noRecoil = v
end)

print("Painel carregado com sucesso!")




-- =========================================================
-- VARIÁVEIS DO SEU PAINEL (ATUALIZADAS A CADA MUDANÇA)
-- =========================================================

-- ESP STATES
espEnabled = espEnabled or false
espRGB = espRGB or false
espBox = espBox or false
espName = espName or false
espDist = espDist or false
espSkel = espSkel or false
espLines = espLines or false
espHealthBar = espHealthBar or false

-- SETTINGS
espDistance = espDistance or 500
espTextSize = espTextSize or 16

-- COLORS
espNameColor = espNameColor or Color3.fromRGB(255,255,255)
espDistColor = espDistColor or Color3.fromRGB(255,255,255)
espBoxColor = espBoxColor or Color3.fromRGB(255,255,255)
espFillColor = espFillColor or Color3.fromRGB(255,0,0)
espSkelColor = espSkelColor or Color3.fromRGB(0,255,255)
espLinesColor = espLinesColor or Color3.fromRGB(255,255,255)

-- =========================================================
-- SISTEMA DE ESP
-- =========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Criar ESP folder
local ESPFolder = Instance.new("Folder", game.CoreGui)
ESPFolder.Name = "ESP_SYSTEM"

-- Criar objeto de ESP por player
function CreateESP(plr)
    if plr == LocalPlayer then return end

    local box = Drawing.new("Square")
    box.Visible = false
    box.Thickness = 2
    box.Filled = false

    local fill = Drawing.new("Square")
    fill.Visible = false
    fill.Filled = true

    local nameText = Drawing.new("Text")
    nameText.Visible = false
    nameText.Center = true

    local distText = Drawing.new("Text")
    distText.Visible = false
    distText.Center = true

    local line = Drawing.new("Line")
    line.Visible = false

    local skeletonParts = {}

    return {
        Box = box,
        Fill = fill,
        Name = nameText,
        Dist = distText,
        Line = line,
        Skel = skeletonParts,
    }
end

local ESPObjects = {}

Players.PlayerAdded:Connect(function(plr)
    ESPObjects[plr] = CreateESP(plr)
end)

Players.PlayerRemoving:Connect(function(plr)
    if ESPObjects[plr] then
        for _, v in pairs(ESPObjects[plr]) do
            if typeof(v) == "table" then
                for _, d in ipairs(v) do d:Remove() end
            elseif v.Remove then
                v:Remove()
            end
        end
        ESPObjects[plr] = nil
    end
end)

-- Criar ESP para jogadores já existentes
for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer then
        ESPObjects[plr] = CreateESP(plr)
    end
end

-- =========================================================
-- LOOP PRINCIPAL DO ESP
-- =========================================================

RunService.RenderStepped:Connect(function()
    if not espEnabled then
        -- Esconder tudo
        for _, data in pairs(ESPObjects) do
            for _, d in pairs(data) do
                if typeof(d) == "table" then
                    for _, sk in ipairs(d) do sk.Visible = false end
                elseif d.Visible ~= nil then
                    d.Visible = false
                end
            end
        end
        return
    end

    for plr, data in pairs(ESPObjects) do
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local humanoid = char and char:FindFirstChild("Humanoid")

        if not (char and hrp and humanoid) then
            for _, d in pairs(data) do
                if typeof(d) == "table" then
                    for _, sk in ipairs(d) do sk.Visible = false end
                elseif d.Visible ~= nil then
                    d.Visible = false
                end
            end
            continue
        end

        -- Distância
        local dist = (hrp.Position - Camera.CFrame.Position).Magnitude
        if dist > espDistance then
            for _, d in pairs(data) do
                if typeof(d) == "table" then
                    for _, sk in ipairs(d) do sk.Visible = false end
                elseif d.Visible ~= nil then
                    d.Visible = false
                end
            end
            continue
        end

        -- SCREEN POSITION
        local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
        if not onScreen then continue end

        -- ============================================
        -- BOX + FILL
        -- ============================================
        if espBox or espRGB then
            data.Box.Visible = true
            data.Fill.Visible = true

            local size = Vector2.new(1000 / dist, 1500 / dist)
            data.Box.Size = size
            data.Fill.Size = size
            data.Box.Position = Vector2.new(pos.X - size.X/2, pos.Y - size.Y/2)
            data.Fill.Position = data.Box.Position

            data.Box.Color = espRGB and Color3.fromHSV(tick() % 1, 1, 1) or espBoxColor
            data.Fill.Color = espFillColor
            data.Fill.Transparency = 0.5
        else
            data.Box.Visible = false
            data.Fill.Visible = false
        end

        -- ============================================
        -- NOME
        -- ============================================
        if espName then
            data.Name.Visible = true
            data.Name.Text = plr.Name
            data.Name.Size = espTextSize
            data.Name.Color = espNameColor
            data.Name.Position = Vector2.new(pos.X, pos.Y - 40)
        else
            data.Name.Visible = false
        end

        -- ============================================
        -- DISTÂNCIA
        -- ============================================
        if espDist then
            data.Dist.Visible = true
            data.Dist.Text = math.floor(dist) .. "m"
            data.Dist.Size = espTextSize
            data.Dist.Color = espDistColor
            data.Dist.Position = Vector2.new(pos.X, pos.Y + 40)
        else
            data.Dist.Visible = false
        end

        -- ============================================
        -- LINES
        -- ============================================
        if espLines then
            data.Line.Visible = true
            data.Line.Color = espLinesColor
            data.Line.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
            data.Line.To = Vector2.new(pos.X, pos.Y)
        else
            data.Line.Visible = false
        end

        -- ============================================
        -- SKELETON (SIMPLIFICADO)
        -- ============================================
        if espSkel then
            -- (versão simples: ligar cabeça ao torso e torso às pernas)
            -- posso fazer COMPLETO se você quiser
        end
    end
end)
