-- [[ PROYECTO NOVA: Edición Profesional ]] --
-- 1. Ocultar la interfaz del sistema de Roblox
local NovaUI = Instance.new("ScreenGui")
if gethui then
    NovaUI.Parent = gethui()
else
    NovaUI.Parent = game:GetService("CoreGui")
end

-- 2. Variables de Seguridad (Uso de Local para velocidad)
local Player = game.Players.LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()
local Hum = Char:WaitForChild("Humanoid")

-- 3. Función de Velocidad "Bypass" (No te expulsa por saltos de velocidad)
local function SmoothSpeed(target)
    local TweenService = game:GetService("TweenService")
    local info = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    TweenService:Create(Hum, info, {WalkSpeed = target}):Play()
end

-- 4. Diseño del Menú (Estilo Neón Moderno)
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 220, 0, 120)
Main.Position = UDim2.new(0.5, -110, 0.5, -60)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.BorderSizePixel = 0
Main.Parent = NovaUI

local Corner = Instance.new("UICorner") -- Bordes redondeados pro
Corner.CornerRadius = Tool.new(0, 12)
Corner.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "NOVA PROJECT v1.0"
Title.TextColor3 = Color3.fromRGB(0, 255, 180) -- Color Neón
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Parent = Main

-- 5. Botón de Activación
local Btn = Instance.new("TextButton")
Btn.Size = UDim2.new(0, 180, 0, 40)
Btn.Position = UDim2.new(0.5, -90, 0, 50)
Btn.Text = "ACTIVAR SPEED BYPASS"
Btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Btn.TextColor3 = Color3.white
Btn.Parent = Main

Btn.MouseButton1Click:Connect(function()
    SmoothSpeed(45) -- Velocidad segura para evitar ban
    Btn.Text = "ESTADO: ACTIVO"
    Btn.TextColor3 = Color3.fromRGB(0, 255, 100)
end)