-- Crear el menú y hacerlo persistente
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local ScreenGui = Instance.new("ScreenGui", playerGui)
ScreenGui.ResetOnSpawn = false -- El menú no desaparecerá al morir

-- Advertencia y nota de uso
local WarningFrame = Instance.new("Frame", ScreenGui)
WarningFrame.Size = UDim2.new(0, 300, 0, 180) -- Un poco más alto
WarningFrame.Position = UDim2.new(0.5, -150, 0.5, -90)
WarningFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
WarningFrame.BorderSizePixel = 2
WarningFrame.BorderColor3 = Color3.fromRGB(255, 200, 0)
WarningFrame.ZIndex = 10

local WarningText = Instance.new("TextLabel", WarningFrame)
WarningText.Size = UDim2.new(0.9, 0, 0.6, 0)
WarningText.Position = UDim2.new(0.05, 0, 0.05, 0)
WarningText.Text = "ADVERTENCIA:\n1. Usa con moderación para evitar bans o expulsiones del juego sobre todo el uso del flyn usalo solo para pasar las atapas no para (volar alto)si no a tu beneficio esquivar lo que te hace daño o volar arriba de el donde no te toque .\n2. El 'Anti Daño' solo es efectivo contra algunas fuentes de daño específicas, no todas. Para agarrar las win o trofeos solo desactiva el anti daño ."
WarningText.TextColor3 = Color3.fromRGB(255, 255, 255)
WarningText.TextSize = 14
WarningText.TextScaled = true -- ESTO HACE QUE EL TEXTO SEA VISIBLE
WarningText.BackgroundTransparency = 1
WarningText.TextWrapped = true
WarningText.ZIndex = 11

local CloseBtn = Instance.new("TextButton", WarningFrame)
CloseBtn.Size = UDim2.new(0, 100, 0, 30)
CloseBtn.Position = UDim2.new(0.5, -50, 0.75, 0)
CloseBtn.Text = "Entendido"
CloseBtn.ZIndex = 12
CloseBtn.MouseButton1Click:Connect(function() WarningFrame:Destroy() end)

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 200, 0, 100)
MainFrame.Position = UDim2.new(0.3, 0, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MainFrame.Active = true
MainFrame.Draggable = true 

local flying = false
local flySpeed = 50 
local bv = nil
local bg = nil 

-- Botón Fly
local FlyBtn = Instance.new("TextButton", MainFrame)
FlyBtn.Size = UDim2.new(0, 60, 0, 40)
FlyBtn.Position = UDim2.new(0.65, 0, 0.1, 0)
FlyBtn.Text = "Fly"
FlyBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 0)

game:GetService("RunService").RenderStepped:Connect(function()
    local char = player.Character
    local hum = char and char:FindFirstChild("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    
    if hum and hum.Health <= 0 then
        if flying then flying = false FlyBtn.Text = "Fly" end
        if bv then bv:Destroy() bv = nil end
        if bg then bg:Destroy() bg = nil end
    end
    
    if flying and hrp and hum and hum.Health > 0 then
        hum.PlatformStand = true 
        if not bv then bv = Instance.new("BodyVelocity", hrp) bv.MaxForce = Vector3.new(100000, 100000, 100000) end
        if not bg then bg = Instance.new("BodyGyro", hrp) bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge) bg.P = 10000 bg.D = 100 end
        
        local cam = workspace.CurrentCamera
        if hum.MoveDirection.Magnitude > 0 then
            bv.Velocity = cam.CFrame.LookVector * flySpeed
            bg.CFrame = CFrame.new(hrp.Position, hrp.Position + hum.MoveDirection)
        else
            bv.Velocity = Vector3.new(0, 0, 0)
        end
    end
end)

FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    FlyBtn.Text = flying and "Fly ON" or "Fly"
    if not flying then
        local char = player.Character
        local hum = char and char:FindFirstChild("Humanoid")
        if hum then hum.PlatformStand = false hum:ChangeState(Enum.HumanoidStateType.GettingUp) end
        if bv then bv:Destroy() bv = nil end
        if bg then bg:Destroy() bg = nil end
    end
end)

-- Controles de Velocidad
local SpeedLabel = Instance.new("TextBox", MainFrame)
SpeedLabel.Size = UDim2.new(0, 40, 0, 40)
SpeedLabel.Position = UDim2.new(0.2, 0, 0.1, 0)
SpeedLabel.Text = tostring(flySpeed)
SpeedLabel.BackgroundColor3 = Color3.fromRGB(255, 128, 0)

local PlusBtn = Instance.new("TextButton", MainFrame)
PlusBtn.Size = UDim2.new(0, 40, 0, 40)
PlusBtn.Position = UDim2.new(0.05, 0, 0.1, 0)
PlusBtn.Text = "+"
PlusBtn.MouseButton1Click:Connect(function() flySpeed = flySpeed + 10 SpeedLabel.Text = tostring(flySpeed) end)

local MinusBtn = Instance.new("TextButton", MainFrame)
MinusBtn.Size = UDim2.new(0, 40, 0, 40)
MinusBtn.Position = UDim2.new(0.35, 0, 0.1, 0)
MinusBtn.Text = "-"
MinusBtn.MouseButton1Click:Connect(function() flySpeed = math.max(10, flySpeed - 10) SpeedLabel.Text = tostring(flySpeed) end)

-- Botón Anti Damage (Optimizado para no ser detectado)
_G.AntiDamage = false
local AntiBtn = Instance.new("TextButton", MainFrame)
AntiBtn.Size = UDim2.new(0, 180, 0, 30)
AntiBtn.Position = UDim2.new(0.05, 0, 0.5, 0)
AntiBtn.Text = "Anti Daño: OFF"
AntiBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)

AntiBtn.MouseButton1Click:Connect(function()
    _G.AntiDamage = not _G.AntiDamage
    AntiBtn.Text = _G.AntiDamage and "Anti Damage: ON" or "Anti Damage: OFF"
    AntiBtn.BackgroundColor3 = _G.AntiDamage and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
    
    local char = player.Character
    if char then
        -- Aplicamos el cambio de forma sutil para evitar detección
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanTouch = not _G.AntiDamage
            end
        end
    end
end)
-- Arreglo para mantener el estado del Anti Damage al respawnear
player.CharacterAdded:Connect(function(newChar)
    if _G.AntiDamage then
        task.wait(0.5) -- Espera breve para asegurar que el personaje cargue bien
        for _, part in pairs(newChar:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanTouch = false
            end
        end
    end
end)
