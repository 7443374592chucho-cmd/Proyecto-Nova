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

-- 2. Anti-Muerte (Ignorar eventos de daño)
MovementTab:CreateToggle({
   Name = "Anti-Muerte (Bloqueo de Eventos)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AntiDeath = Value
      local char = LocalPlayer.Character
      if char and char:FindFirstChild("Humanoid") then
         -- Desconectamos los eventos que causan que el Humanoid muera
         if _G.AntiDeath then
            char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
         else
            char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
         end
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
