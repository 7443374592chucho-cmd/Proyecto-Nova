Local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Crear GUI Única
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "AntiFlingMaster"

-- Marco del Menú (Para arrastrar)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 200, 0, 160)
MainFrame.Position = UDim2.new(0, 20, 0, 100)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.Active = true
MainFrame.Draggable = true

-- TU CÓDIGO ORIGINAL (SIN MODIFICACIONES)
local Button = Instance.new("TextButton", MainFrame)
Button.Size = UDim2.new(0, 180, 0, 50)
Button.Position = UDim2.new(0, 10, 0, 10)
Button.Text = "Anti-Fling MASTER: OFF"
Button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)

local active = false

Button.MouseButton1Click:Connect(function()
    active = not active
    Button.Text = active and "Anti-Fling MASTER: ON" or "Anti-Fling MASTER: OFF"
    Button.BackgroundColor3 = active and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
end)

-- PESTAÑA DE ATAQUE (NUEVA)
local FlingBtn = Instance.new("TextButton", MainFrame)
FlingBtn.Size = UDim2.new(0, 180, 0, 50)
FlingBtn.Position = UDim2.new(0, 10, 0, 70)
FlingBtn.Text = "Fling Player: OFF"
FlingBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)

local flingActive = false
FlingBtn.MouseButton1Click:Connect(function()
    flingActive = not flingActive
    FlingBtn.Text = flingActive and "Fling Player: ON" or "Fling Player: OFF"
end)

-- BUCLE ÚNICO
RunService.Heartbeat:Connect(function()
    -- 1. TU CÓDIGO ORIGINAL (Ejecutándose tal cual)
    if active and LocalPlayer.Character then
        local HRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if HRP then
            -- 1. Eliminar cualquier fuerza extraña (BodyMovers)
            for _, obj in pairs(LocalPlayer.Character:GetDescendants()) do
                if obj:IsA("BodyVelocity") or obj:IsA("BodyForce") or obj:IsA("AlignPosition") or obj:IsA("LinearVelocity") then
                    obj:Destroy()
                end
            end
            
            -- 2. Desactivar colisiones con otros jugadores
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    for _, part in pairs(player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end
        end
    end

        -- 2. LÓGICA DE ATAQUE CORREGIDA Y POTENCIADA
    if flingActive and LocalPlayer.Character then
        local mouse = LocalPlayer:GetMouse()
        local target = mouse.Target
        
        -- Verificamos si apuntamos a algo que sea parte de un personaje
        if target and target.Parent then
            local character = target.Parent
            local hrp = character:FindFirstChild("HumanoidRootPart")
            
            -- Si encontramos al jugador, le damos un empujón masivo
            if hrp then
                -- Usamos AssemblyLinearVelocity (más efectivo que .Velocity)
                hrp.AssemblyLinearVelocity = Vector3.new(0, 1000, 0)
                
                -- Opcional: Si el jugador tiene "Anchored", esto lo romperá
                hrp.Anchored = false
            end
        end
    end
