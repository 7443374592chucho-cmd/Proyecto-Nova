-- ==================================================
-- SCRIPT: KRYNEX FARMER (ELIMINACIÓN UNIVERSAL)
-- ==================================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "Krynex - Farmer Final", Theme = "Default"})
local MovementTab = Window:CreateTab("Main", nil)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
_G.SpeedValue = 100 

-- 1. Auto-Farm (La lógica que ya te funcionaba)
MovementTab:CreateToggle({
   Name = "Auto-Farm (Avanzar)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarm = Value
      while _G.AutoFarm do
         local char = LocalPlayer.Character
         if char and char:FindFirstChild("Humanoid") then
            char.Humanoid:MoveTo(Vector3.new(0, 0, 100000)) 
         end
         task.wait(0.5)
      end
   end,
})

-- Variable para la altura (predeterminada en 5)
_G.FlyHeight = 5

MovementTab:CreateSlider({
   Name = "Altura de Vuelo",
   Range = {24, 90},
   Increment = 1,
   Suffix = "m",
   CurrentValue = 5,
   Callback = function(Value)
      _G.FlyHeight = Value
   end,
})

MovementTab:CreateToggle({
   Name = "Activar Vuelo",
   CurrentValue = false,
   Callback = function(Value)
      _G.FlyMode = Value
   end,
})


-- 3. Velocidad Persistente
MovementTab:CreateSlider({
   Name = "Velocidad de Movimiento",
   Range = {16, 1000},
   Increment = 10,
   CurrentValue = 100,
   Callback = function(Value)
      _G.SpeedValue = Value
   end,
})

game:GetService("RunService").Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        if char.Humanoid.WalkSpeed ~= _G.SpeedValue then
            char.Humanoid.WalkSpeed = _G.SpeedValue
        end
    end
end)

game:GetService("RunService").Heartbeat:Connect(function()
    local player = game.Players.LocalPlayer
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    
    if _G.FlyMode and root then
        -- Creamos o buscamos el BodyVelocity
        local bv = root:FindFirstChild("FlyBV") or Instance.new("BodyVelocity", root)
        bv.Name = "FlyBV"
        bv.MaxForce = Vector3.new(0, 50000, 0)
        
        -- Calculamos la altura dinámicamente según lo que elegiste en el Slider
        -- Mantener la altura respecto a la gravedad para que sea fluido
        bv.Velocity = Vector3.new(0, 0, 0)
        
        -- Esta parte mantiene la altura elegida sin teletransportar
        local currentY = root.Position.Y
        local targetY = _G.FlyHeight -- La altura que elijas en el Slider
        
        -- Si estás muy lejos de la altura objetivo, aplicamos un empuje suave
        if math.abs(currentY - targetY) > 0.5 then
            root.CFrame = root.CFrame:Lerp(CFrame.new(root.Position.X, targetY, root.Position.Z), 0.1)
        end
        
    elseif root and root:FindFirstChild("FlyBV") then
        root.FlyBV:Destroy()
    end
end)

Rayfield:LoadConfiguration()
