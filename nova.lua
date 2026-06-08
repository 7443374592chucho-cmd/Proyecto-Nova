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

-- 2. Anular Daño (Desactiva la capacidad de matar de las piezas)
MovementTab:CreateToggle({
   Name = "Anular Daño (Universal)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AntiKill = Value
      while _G.AntiKill do
         for _, v in pairs(workspace:GetDescendants()) do
            -- En lugar de destruir, simplemente apagamos el sensor de daño
            if v:IsA("BasePart") and v:FindFirstChild("TouchInterest") then
               local char = LocalPlayer.Character
               if char and char:FindFirstChild("HumanoidRootPart") then
                  if (v.Position - char.HumanoidRootPart.Position).Magnitude < 40 then
                     v.CanTouch = false -- Esto hace que la pieza sea inofensiva
                  end
               end
            end
         end
         task.wait(0.2)
      end
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

Rayfield:LoadConfiguration()
