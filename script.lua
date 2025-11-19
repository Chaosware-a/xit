local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("SkillXIT", "DarkTheme")

----------------------------------------------------
--                 ABA AIMBOT
----------------------------------------------------

local AimbotTab = Window:NewTab("Aimbot")
local AimbotSection = AimbotTab:NewSection("Configurações")

local aimbotEnabled = false
local smoothValue = 1
local fovValue = 50

AimbotSection:NewToggle("Enable Aimbot", "Liga / Desliga", function(v)
    aimbotEnabled = v
end)

AimbotSection:NewSlider("Aimbot Smooth", "Velocidade de suavização", 10, 1, function(v)
    smoothValue = v
end)

AimbotSection:NewSlider("Aimbot FOV", "Área que o aimbot trava", 200, 1, function(v)
    fovValue = v
end)

AimbotSection:NewDropdown("Bone", "Onde mirar", {"Head","UpperTorso","HumanoidRootPart"}, function(v)
    aimbotBone = v
end)

AimbotSection:NewDropdown("Modo", "Quando mirar", {"Sempre","Ao Atirar","Ao Olhar"}, function(v)
    aimbotMode = v
end)


----------------------------------------------------
--                 ABA ESP
----------------------------------------------------

local ESPTab = Window:NewTab("ESP")

-- COLUNA 1: Principal
local ESPMain = ESPTab:NewSection("Main")

ESPMain:NewToggle("Enable ESP", "Liga o ESP", function(v)
    espEnabled = v
end)

ESPMain:NewToggle("Enable RGB", "RGB animado", function(v)
    espRGB = v
end)

ESPMain:NewToggle("Enable Box", "Caixa ao redor", function(v)
    espBox = v
end)

ESPMain:NewToggle("Enable Name", "Mostrar nome", function(v)
    espName = v
end)

ESPMain:NewToggle("Enable Distance", "Mostrar distância", function(v)
    espDist = v
end)

ESPMain:NewToggle("Enable Skeleton", "Mostrar esqueleto", function(v)
    espSkel = v
end)

ESPMain:NewToggle("Enable Lines", "Linhas até o player", function(v)
    espLines = v
end)

ESPMain:NewToggle("Enable Health Bar", "Barra de vida", function(v)
    espHealthBar = v
end)


-- COLUNA 2: Configurações
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

ESPSettings:NewColorPicker("Distance Color", "Cor da distância", Color3.fromRGB(255,255,255), function(v)
    espDistColor = v
end)

ESPSettings:NewColorPicker("Box Color", "Cor da caixa", Color3.fromRGB(255,255,255), function(v)
    espBoxColor = v
end)

ESPSettings:NewColorPicker("Fill Color", "Cor do preenchimento", Color3.fromRGB(255,0,0), function(v)
    espFillColor = v
end)

ESPSettings:NewColorPicker("Skeleton Color", "Cor do esqueleto", Color3.fromRGB(0,255,255), function(v)
    espSkelColor = v
end)

ESPSettings:NewColorPicker("Icon Color", "Cor do ícone", Color3.fromRGB(255,255,0), function(v)
    espIconColor = v
end)

ESPSettings:NewColorPicker("Lines Color", "Cor das linhas", Color3.fromRGB(255,255,255), function(v)
    espLinesColor = v
end)


print("Painel SkillXIT carregado com sucesso!")
