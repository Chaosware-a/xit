---------------------------------------------------------------------
--  SKILLXIT UI + AIMBOT + ESP (FUNCIONANDO DENTRO DO ROBLOX STUDIO)
---------------------------------------------------------------------

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInput = game:GetService("UserInputService")
local Cam = workspace.CurrentCamera

local LP = Players.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()
local Mouse = LP:GetMouse()

---------------------------------------------------------------------
--  VARIÁVEIS DO SISTEMA
---------------------------------------------------------------------
local aimbotEnabled = false
local aimPart = "Head"      -- "Head" ou "HumanoidRootPart"
local aimMode = "Hold"      -- "Hold" = só mirando | "Shoot" = atirando
local aimSmooth = 3
local aimFOV = 80

local espEnabled = false
local espBox = true
local espSkel = true
local espName = true
local espDist = true
local espHealth = true
local espTeamColorBehindWalls = true

local drawObjects = {}

---------------------------------------------------------------------
-- FUNÇÃO — ENCONTRAR MELHOR ALVO
---------------------------------------------------------------------
local function getClosestEnemy()
    local best = nil
    local bestDist = math.huge

    for _,plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP and plr.Team ~= LP.Team then
            local char = plr.Character
            if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                local part = char:FindFirstChild(aimPart)
                if part then
                    local screenPos, vis = Cam:WorldToViewportPoint(part.Position)
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                    if dist < aimFOV and dist < bestDist then
                        best = part
                        bestDist = dist
                    end
                end
            end
        end
    end
    return best
end

---------------------------------------------------------------------
-- FUNÇÃO — RENDERIZAR AIMBOT
---------------------------------------------------------------------
RunService.RenderStepped:Connect(function()
    if not aimbotEnabled then return end

    if aimMode == "Hold" and not UserInput:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        return
    end

    local target = getClosestEnemy()
    if target then
        local dir = (target.Position - Cam.CFrame.Position)
        Cam.CFrame = Cam.CFrame:Lerp(CFrame.lookAt(Cam.CFrame.Position, target.Position), aimSmooth/10)
    end
end)

---------------------------------------------------------------------
-- ESP — CRIAR OBJETO
---------------------------------------------------------------------
local function newDraw(type)
    local d = Drawing.new(type)
    d.Visible = false
    return d
end

---------------------------------------------------------------------
-- ESP — LOOP
---------------------------------------------------------------------
RunService.RenderStepped:Connect(function()
    for plr,objs in pairs(drawObjects) do
        local char = plr.Character
        local humanoid = char and char:FindFirstChild("Humanoid")
        local root = char and char:FindFirstChild("HumanoidRootPart")

        if espEnabled and humanoid and root then
            local pos, vis = Cam:WorldToViewportPoint(root.Position)
            
            -- VER COR DO TIME ATRÁS DA PAREDE
            if espTeamColorBehindWalls then
                if not vis then  
                    objs.Box.Color = plr.TeamColor.Color
                else
                    objs.Box.Color = Color3.new(1,1,1)
                end
            end
            
            -- BOX
            if espBox then
                objs.Box.Visible = true
                objs.Box.Size = Vector2.new(80,120)
                objs.Box.Position = Vector2.new(pos.X - 40, pos.Y - 110)
            else
                objs.Box.Visible = false
            end

            -- NOME
            if espName then
                objs.Name.Visible = true
                objs.Name.Text = plr.Name
                objs.Name.Position = Vector2.new(pos.X, pos.Y - 120)
            else
                objs.Name.Visible = false
            end

            -- DIST
            if espDist then
                objs.Dist.Visible = true
                objs.Dist.Text = math.floor((LP.Character.HumanoidRootPart.Position - root.Position).Magnitude).."m"
                objs.Dist.Position = Vector2.new(pos.X, pos.Y + 60)
            else
                objs.Dist.Visible = false
            end

        else
            for _,v in pairs(objs) do v.Visible = false end
        end
    end
end)

---------------------------------------------------------------------
-- CRIAR ESP PARA JOGADORES
---------------------------------------------------------------------
Players.PlayerAdded:Connect(function(plr)
    drawObjects[plr] = {
        Box = newDraw("Square"),
        Name = newDraw("Text"),
        Dist = newDraw("Text"),
    }
end)

for _,plr in ipairs(Players:GetPlayers()) do
    if plr ~= LP then
        drawObjects[plr] = {
            Box = newDraw("Square"),
            Name = newDraw("Text"),
            Dist = newDraw("Text"),
        }
    end
end

---------------------------------------------------------------------
--  PAINEL UI FEITO SEM GITHUB
---------------------------------------------------------------------

local Screen = Instance.new("ScreenGui", LP.PlayerGui)
Screen.Name = "SkillXit"

-- Partículas no fundo
local P = Instance.new("ParticleEmitter")
P.Texture = "rbxassetid://243660364"
P.Rate = 40
P.Speed = NumberRange.new(1,3)
P.Parent = Screen

local Frame = Instance.new("Frame", Screen)
Frame.Size = UDim2.new(0,420,0,380)
Frame.Position = UDim2.new(0.31,0,0.22,0)
Frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
Frame.BorderSizePixel = 0

local Title = Instance.new("TextLabel", Frame)
Title.Text = "SkillXit"
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.TextSize = 24
Title.TextColor3 = Color3.fromRGB(255,255,255)

-- Exemplo de botão
local btn = Instance.new("TextButton", Frame)
btn.Size = UDim2.new(0,200,0,40)
btn.Position = UDim2.new(0,10,0,60)
btn.Text = "Enable Aimbot"
btn.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
end)

---------------------------------------------------------------------
print("SkillXit carregado.")

