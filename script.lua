--///////////////////////////////////////////////////////
--/////     S K I L L X I T   M E N U   1 . 0       /////
--/////   TUDO DENTRO DO PAINEL EM 1 LOCALSCRIPT   /////
--///////////////////////////////////////////////////////

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

---------------------------------------------------------
-- PAINEL SKILLXIT
---------------------------------------------------------

local gui = script.Parent
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 260, 0, 350)
frame.Position = UDim2.new(0.02, 0, 0.25, 0)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

-- fundo animado / partículas
local particle = Instance.new("ImageLabel", frame)
particle.Size = UDim2.new(1,0,1,0)
particle.Image = "rbxassetid://241837157"
particle.ImageTransparency = 0.85
particle.BackgroundTransparency = 1

RunService.RenderStepped:Connect(function(dt)
    particle.Rotation += dt * 10
end)

---------------------------------------------------------
-- BOTÕES DO PAINEL
---------------------------------------------------------

local function createButton(text, y)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(1, -20, 0, 35)
    b.Position = UDim2.new(0, 10, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(35,35,35)
    b.Text = text
    b.TextColor3 = Color3.new(1,1,1)
    b.BorderSizePixel = 0

    local c = Instance.new("UICorner", b)
    c.CornerRadius = UDim.new(0, 8)

    return b
end

local btnAimbot = createButton("Aimbot: OFF", 10)
local btnESP = createButton("ESP: OFF", 55)
local btnMode = createButton("Mode: LOOK", 100)
local btnBone = createButton("Bone: HEAD", 145)

---------------------------------------------------------
-- SISTEMA DE ESTADOS
---------------------------------------------------------

local aimbotEnabled = false
local espEnabled = false
local aimMode = "LOOK"    -- LOOK ou SHOOT
local aimBone = "Head"    -- Head ou HumanoidRootPart
local isShooting = false

btnAimbot.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    btnAimbot.Text = "Aimbot: " .. (aimbotEnabled and "ON" or "OFF")
end)

btnESP.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    btnESP.Text = "ESP: " .. (espEnabled and "ON" or "OFF")
end)

btnMode.MouseButton1Click:Connect(function()
    aimMode = (aimMode == "LOOK") and "SHOOT" or "LOOK"
    btnMode.Text = "Mode: " .. aimMode
end)

btnBone.MouseButton1Click:Connect(function()
    aimBone = (aimBone == "Head") and "HumanoidRootPart" or "Head"
    btnBone.Text = "Bone: " .. aimBone
end)

UIS.InputBegan:Connect(function(k)
    if k.UserInputType == Enum.UserInputType.MouseButton1 then
        isShooting = true
    end
end)

UIS.InputEnded:Connect(function(k)
    if k.UserInputType == Enum.UserInputType.MouseButton1 then
        isShooting = false
    end
end)

---------------------------------------------------------
-- ESP COMPLETO
---------------------------------------------------------

local function createESP(player)
    if player == LocalPlayer then return end

    local box = Drawing.new("Square")
    box.Filled = false
    box.Thickness = 2
    box.Color = Color3.fromRGB(0,255,255)
    box.Visible = false

    local text = Drawing.new("Text")
    text.Size = 14
    text.Center = true
    text.Color = Color3.new(1,1,1)
    text.Visible = false

    RunService.RenderStepped:Connect(function()
        if not espEnabled then
            box.Visible = false
            text.Visible = false
            return
        end

        local char = player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then
            box.Visible = false
            text.Visible = false
            return
        end

        local hrp = char.HumanoidRootPart
        local pos, onscreen = Camera:WorldToViewportPoint(hrp.Position)

        if onscreen then
            local distance = (Camera.CFrame.Position - hrp.Position).Magnitude
            local size = math.clamp(3000 / distance, 20, 120)

            box.Size = Vector2.new(size, size * 1.4)
            box.Position = Vector2.new(pos.X - size/2, pos.Y - size)
            box.Visible = true

            text.Text = math.floor(distance) .. "m"
            text.Position = Vector2.new(pos.X, pos.Y + size/1.4)
            text.Visible = true
        else
            box.Visible = false
            text.Visible = false
        end
    end)
end

for _, p in ipairs(Players:GetPlayers()) do
    createESP(p)
end

Players.PlayerAdded:Connect(createESP)

---------------------------------------------------------
-- AIMBOT
---------------------------------------------------------

RunService.RenderStepped:Connect(function()
    if not aimbotEnabled then return end
    if aimMode == "SHOOT" and not isShooting then return end

    local closest = nil
    local closestDist = 9999
    local mousePos = UIS:GetMouseLocation()

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild(aimBone) then
            local part = p.Character[aimBone]
            local pos, vis = Camera:WorldToViewportPoint(part.Position)

            if vis then
                local d = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                if d < closestDist then
                    closestDist = d
                    closest = part
                end
            end
        end
    end

    if closest then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, closest.Position)
    end
end)
