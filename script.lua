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

-- COLUNA ESQUERDA (ESP PRINCIPAIS)
local ESPMain = ESPTab:NewSection("ESP Principais")

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

ESPMain:NewToggle("Enable Health Bar", "Barra de vida", function(v)
    espHealthBar = v
end)


-- COLUNA DIREITA (SETTINGS SEM ROLAR)
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
