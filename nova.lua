-- [[ PROYECTO NOVA: Edición Profesional optimized ]] --
-- 1. Crear el contenedor principal
local NovaUI = Instance.new("ScreenGui")
NovaUI.Name = "NovaHub"
if gethui then
    NovaUI.Parent = gethui()
else
    NovaUI.Parent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

-- 2. Variables de Seguridad
local Player = game.Players.LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()
local Hum = Char:WaitForChild("Humanoid")

-- 3. Función de Velocidad "TweenService" (Suave y Seguro)
local function SmoothSpeed(target)
    local TweenService = game:GetService("TweenService")
    local info = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    TweenService:Create(Hum, info, {WalkSpeed = target}):Play()
end

-- 4. Diseño del Menú (Estilo Neón Moderno)
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 220, 0, 120) -- Un poco más alto
Main.Position = UDim2.new(0.5, -110, 0.5, -60) -- Centrado perfecto
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Gris oscuro (Base neón)
Main.BorderSizePixel = 2
Main.BorderColor3 = Color3.fromRGB(0, 255, 255) -- Bordes Cian Neón (Esto lo hace brillar)
Main.Parent = NovaUI
Main.ZIndex = 10 -- Lo pone por encima de todo

-- 5. Efecto de Esquinas Redondeadas
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim2.new(0, 12)
Corner.Parent = Main

-- 6. Botón de Velocidad
local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0, 180, 0, 40)
Button.Position = UDim2.new(0.5, -90, 0.5, -20)
Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Button.Text = "ACTIVAR VELOCIDAD 100"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.GothamBold
Button.TextSize = 14
Button.Parent = Main
Button.ZIndex = 11

-- 7. Efecto de Esquinas en el Botón
local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim2.new(0, 8)
ButtonCorner.Parent = Button

-- 8. Evento del Botón
local toggled = false
Button.MouseButton1Click:Connect(function()
    if not toggled then
        SmoothSpeed(100) -- Velocidad para bypass
        Button.Text = "VELOCIDAD: [ON]"
        Button.TextColor3 = Color3.fromRGB(0, 255, 0) -- Verde neón
    else
        SmoothSpeed(16) -- Velocidad normal
        Button.Text = "VELOCIDAD: [OFF]"
        Button.TextColor3 = Color3.fromRGB(255, 0, 0) -- Rojo neón
    end
    toggled = not toggled
end)

-- 9. Notificación de Carga
pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "PROYECTO NOVA V1",
        Text = "Script cargado con éxito",
        Icon = "rbxassetid://123456789", -- Icono por defecto (opcional)
        Duration = 5
    })
end)