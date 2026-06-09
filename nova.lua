-- Crear el menú
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
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

-- Botón Fly (Declarado antes para poder actualizarlo desde el bucle)
local FlyBtn = Instance.new("TextButton", MainFrame)
FlyBtn.Size = UDim2.new(0, 60, 0, 40)
FlyBtn.Position = UDim2.new(0.65, 0, 0.1, 0)
FlyBtn.Text = "Fly"
FlyBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 0)

-- Lógica de Vuelo
game:GetService("RunService").RenderStepped:Connect(function()
    local player = game.Players.LocalPlayer
    local char = player.Character
    local hum = char and char:FindFirstChild("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    
    -- ARREGLO: Si muere, apagamos el vuelo y reseteamos el botón
    if hum and hum.Health <= 0 then
        if flying then
            flying = false
            FlyBtn.Text = "Fly"
        end
        if bv then bv:Destroy() bv = nil end
        if bg then bg:Destroy() bg = nil end
    end
    
    if flying and hrp and hum and hum.Health > 0 then
        hum.PlatformStand = true 
        if not bv then
            bv = Instance.new("BodyVelocity", hrp)
            bv.MaxForce = Vector3.new(100000, 100000, 100000)
        end
        if not bg then
            bg = Instance.new("BodyGyro", hrp)
            bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bg.P = 10000 
            bg.D = 100   
            bg.CFrame = hrp.CFrame
        end
        
        local cam = workspace.CurrentCamera
        if hum.MoveDirection.Magnitude > 0 then
            bv.Velocity = cam.CFrame.LookVector * flySpeed
            bg.CFrame = CFrame.new(hrp.Position, hrp.Position + hum.MoveDirection)
        else
            bv.Velocity = Vector3.new(0, 0, 0)
            hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        end
    end
end)

FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    FlyBtn.Text = flying and "Fly ON" or "Fly"
    
    if not flying then
        local char = game.Players.LocalPlayer.Character
        local hum = char and char:FindFirstChild("Humanoid")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hum then hum.PlatformStand = false end
        if bv then bv:Destroy() bv = nil end
        if bg then bg:Destroy() bg = nil end
        if hrp then 
            hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        end
        if hum then hum:ChangeState(Enum.HumanoidStateType.GettingUp) end
    end
end)

-- Etiqueta de velocidad
local SpeedLabel = Instance.new("TextBox", MainFrame)
SpeedLabel.Size = UDim2.new(0, 40, 0, 40)
SpeedLabel.Position = UDim2.new(0.2, 0, 0.1, 0)
SpeedLabel.Text = tostring(flySpeed)
SpeedLabel.BackgroundColor3 = Color3.fromRGB(255, 128, 0)

-- Botón +
local PlusBtn = Instance.new("TextButton", MainFrame)
PlusBtn.Size = UDim2.new(0, 40, 0, 40)
PlusBtn.Position = UDim2.new(0.05, 0, 0.1, 0)
PlusBtn.Text = "+"
PlusBtn.MouseButton1Click:Connect(function()
    flySpeed = flySpeed + 10
    SpeedLabel.Text = tostring(flySpeed)
end)

-- Botón -
local MinusBtn = Instance.new("TextButton", MainFrame)
MinusBtn.Size = UDim2.new(0, 40, 0, 40)
MinusBtn.Position = UDim2.new(0.35, 0, 0.1, 0)
MinusBtn.Text = "-"
MinusBtn.MouseButton1Click:Connect(function()
    flySpeed = math.max(10, flySpeed - 10)
    SpeedLabel.Text = tostring(flySpeed)
end)

-- ... (Todo tu código de Vuelo y el MainFrame que creaste al principio) ...

-- NO crees otro ScreenGui. Usa el MainFrame que ya tenías.

-- Botón Anti Damage (Posición separada: Y = 0.5)
local AntiBtn = Instance.new("TextButton", MainFrame)
AntiBtn.Size = UDim2.new(0, 180, 0, 30)
AntiBtn.Position = UDim2.new(0.05, 0, 0.5, 0) -- El 0.5 es lo que lo separa
AntiBtn.Text = "Anti Damage: OFF"
AntiBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)

AntiBtn.MouseButton1Click:Connect(function()
    _G.AntiDamage = not _G.AntiDamage
    AntiBtn.Text = _G.AntiDamage and "Anti Damage: ON" or "Anti Damage: OFF"
    AntiBtn.BackgroundColor3 = _G.AntiDamage and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
end)

-- El bucle Heartbeat lo puedes dejar al final, no crea menú, solo ejecuta la lógica.
game:GetService("RunService").Heartbeat:Connect(function()
    if _G.AntiDamage then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("TouchTransmitter") then
                obj:Destroy()
            end
        end
    end
end)
