local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Tu Script de Vuelo",
   LoadingTitle = "Cargando...",
   LoadingSubtitle = "por Gemini",
   Theme = "Default",
})

local MovementTab = Window:CreateTab("Movimiento", nil) -- 'nil' es para el icono

-- Toggle para 30 Metros
MovementTab:CreateToggle({
   Name = "Vuelo 30 Metros",
   CurrentValue = false,
   Callback = function(Value)
      _G.FlyMode30 = Value
      if Value then _G.FlyMode90 = false end -- Apaga el otro
   end,
})

-- Toggle para 90 Metros
MovementTab:CreateToggle({
   Name = "Vuelo 90 Metros",
   CurrentValue = false,
   Callback = function(Value)
      _G.FlyMode90 = Value
      if Value then _G.FlyMode30 = false end -- Apaga el otro
   end,
})

-- Solo este Toggle debe estar en tu script
MovementTab:CreateToggle({
   Name = "Activar Velocidad 300",
   CurrentValue = false,
   Callback = function(Value)
      _G.SpeedEnabled = Value
      local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
      if hum then
         hum.WalkSpeed = Value and 300 or 16
      end
   end,
})

local RunService = game:GetService("RunService")
local LocalPlayer = game.Players.LocalPlayer

RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    -- Lógica para 30m
    if _G.FlyMode30 then
        local bv = root:FindFirstChild("FlyBV") or Instance.new("BodyVelocity", root)
        bv.Name = "FlyBV"
        bv.MaxForce = Vector3.new(0, 100000, 0)
        bv.Velocity = (root.Position.Y < 30) and Vector3.new(0, 20, 0) or Vector3.new(0, 0, 0)
    
    -- Lógica para 90m
    elseif _G.FlyMode90 then
        local bv = root:FindFirstChild("FlyBV") or Instance.new("BodyVelocity", root)
        bv.Name = "FlyBV"
        bv.MaxForce = Vector3.new(0, 100000, 0)
        bv.Velocity = (root.Position.Y < 90) and Vector3.new(0, 30, 0) or Vector3.new(0, 0, 0)
        
    -- Limpieza total si ambos están apagados
    else
        if root:FindFirstChild("FlyBV") then
            root.FlyBV:Destroy()
        end
    end
end)

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Esta es la ÚNICA lógica de velocidad que debe existir en tu script
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end

    -- Si el interruptor (_G.SpeedEnabled) está activado, fuerza 300. Si no, fuerza 16.
    local targetSpeed = (_G.SpeedEnabled == true) and 300 or 16
    
    if hum.WalkSpeed ~= targetSpeed then
        hum.WalkSpeed = targetSpeed
    end
end)
