--[[  
    PAINEL ESTILO EXECUTOR / URI3L XITER  
    Feito para uso SEGURO no seu próprio jogo dentro do Roblox Studio.
    Simula loadstring, getgenv, Drawing, etc. apenas para estudo.
]]--

-- FUNÇÕES SIMULADAS (SEGURAS)
local sandbox_env = {}
function getgenv()
    return sandbox_env
end

function loadstring_safe(code)
    local fn, err = loadstring(code)
    if not fn then return nil, err end
    setfenv(fn, sandbox_env)
    return fn
end

-- SIMULAÇÃO DE "Drawing"
local Drawing = {}
function Drawing.new(type)
    local obj = {}
    obj.Type = type
    obj.Visible = true
    obj.Color = Color3.new(1,1,1)
    obj.Thickness = 2
    obj.Position = Vector2.new(100,100)
    function obj:Remove() obj.Visible = false end
    return obj
end
sandbox_env.Drawing = Drawing

-- INTERFACE (PAINEL)
local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
ScreenGui.Name = "ExecutorPanel"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 550, 0, 350)
Frame.Position = UDim2.new(0.5, -275, 0.5, -175)
Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Frame.BorderSizePixel = 0

local UIStroke = Instance.new("UIStroke", Frame)
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(100,100,255)

Instance.new("UICorner", Frame)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,0,0,30)
Title.BackgroundTransparency = 1
Title.Text = "URI3L-XITER (SIMULATOR)"
Title.TextColor3 = Color3.fromRGB(150,150,255)
Title.Font = Enum.Font.Code
Title.TextSize = 20

local TextBox = Instance.new("TextBox", Frame)
TextBox.Size = UDim2.new(1, -20, 1, -90)
TextBox.Position = UDim2.new(0,10,0,40)
TextBox.BackgroundColor3 = Color3.fromRGB(10,10,10)
TextBox.TextColor3 = Color3.new(1,1,1)
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextYAlignment = Enum.TextYAlignment.Top
TextBox.Font = Enum.Font.Code
TextBox.TextSize = 18
TextBox.ClearTextOnFocus = false
TextBox.MultiLine = true
TextBox.Text = "-- DIGITE SEU SCRIPT AQUI --"

Instance.new("UICorner", TextBox)

-- BOTÕES
local function createButton(text, x)
    local b = Instance.new("TextButton", Frame)
    b.Size = UDim2.new(0,160,0,35)
    b.Position = UDim2.new(0, x, 1, -40)
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.Code
    b.TextSize = 18
    b.Text = text
    Instance.new("UICorner", b)
    return b
end

local Execute = createButton("EXECUTE", 10)
local Clear   = createButton("CLEAR", 190)
local Close   = createButton("CLOSE", 370)

-- LÓGICA DOS BOTÕES
Execute.MouseButton1Down:Connect(function()
    local code = TextBox.Text
    local fn, err = loadstring_safe(code)
    if not fn then
        warn("[EXECUTOR] ERRO:\n"..err)
        return
    end
    local ok, runerr = pcall(fn)
    if not ok then
        warn("[EXECUTOR] ERRO AO EXECUTAR:\n"..runerr)
    end
end)

Clear.MouseButton1Down:Connect(function()
    TextBox.Text = ""
end)

Close.MouseButton1Down:Connect(function()
    ScreenGui:Destroy()
end)
