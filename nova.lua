-- [[ PROJECT NOVA: 99 NIGHTS PREMIUM EDITION ]]
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local LP = game.Players.LocalPlayer

-- [[ VENTANA PRINCIPAL ]]
local Window = Fluent:CreateWindow({
    Title = "PROJECT NOVA | 99 NIGHTS",
    SubTitle = "v6.0 Premium - @7443374592chucho-cmd",
    TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = true, Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

-- [[ SECCIÓN DE PESTAÑAS SEPARADAS ]]
local Tabs = {
    Farm = Window:AddTab({ Title = "Auto-Farm", Icon = "pickaxe" }),
    Combat = Window:AddTab({ Title = "Kill Aura", Icon = "swords" }),
    Settings = Window:AddTab({ Title = "Config", Icon = "settings" })
}

local Options = Fluent.Options

-- ==========================================
-- [[ PESTAÑA: AUTO-FARM SEPARADO ]]
-- ==========================================
Tabs.Farm:AddParagraph({Title = "Estrategia de Recursos", Content = "Selecciona qué quieres recolectar de forma automática."})

Tabs.Farm:AddToggle("AutoWood", {Title = "Auto-Talar Árboles", Default = false})
Tabs.Farm:AddToggle("AutoStone", {Title = "Auto-Minería Piedra", Default = false})

task.spawn(function()
    while task.wait(0.2) do -- Frecuencia segura
        if Options.AutoWood.Value or Options.AutoStone.Value then
            pcall(function()
                local char = LP.Character
                -- FIX: Buscamos la herramienta tanto en el personaje como en el inventario
                local tool = char:FindFirstChildOfClass("Tool") or LP.Backpack:FindFirstChildOfClass("Tool")
                
                if tool then
                    -- Buscamos el recurso más cercano (Radio de 20 studs)
                    for _, obj in pairs(game.Workspace:GetChildren()) do
                        local dist = (char.HumanoidRootPart.Position - obj.Position).Magnitude
                        if dist < 20 then
                            -- Comparamos si es el recurso correcto y lo golpeamos
                            local canHarvest = false
                            if Options.AutoWood.Value and obj.Name:lower():find("tree") then canHarvest = true end
                            if Options.AutoStone.Value and obj.Name:lower():find("rock") then canHarvest = true end
                            
                            if canHarvest then
                                -- EL EVENTO REAL QUE DETECTAMOS EN TU CONSOLA
                                game:GetService("ReplicatedStorage").Events.PlayEnemyHitSound:FireServer(
                                    "FireAllClients", obj.Name, tool.Name
                                )
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- ==========================================
-- [[ PESTAÑA: KILL AURA SEPARADO ]]
-- ==========================================
Tabs.Combat:AddParagraph({Title = "Modo de Defensa", Content = "Elimina a los zombies antes de que toquen tu base."})

Tabs.Combat:AddToggle("KillAura", {Title = "Activar Kill Aura", Default = false})
Tabs.Combat:AddSlider("AuraRange", {Title = "Rango de Ataque", Default = 15, Min = 10, Max = 35, Rounding = 1})

task.spawn(function()
    while task.wait(0.1) do
        if Options.KillAura.Value then
            pcall(function()
                local char = LP.Character
                for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        local dist = (char.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
                        if dist < Options.AuraRange.Value then
                            -- Usamos el mismo evento de daño para matar
                            game:GetService("ReplicatedStorage").Events.PlayEnemyHitSound:FireServer(
                                "FireAllClients", enemy.Name, "Punch" -- Usamos "Punch" o "ZombieFist" si lo prefieres
                            )
                        end
                    end
                end
            end)
        end
    end
end)

-- ==========================================
-- [[ SISTEMA DE BOTÓN FLOTANTE (MINIMIZAR) ]]
-- ==========================================
local OpenUI = Instance.new("ScreenGui")
local ToggleUI = Instance.new("TextButton")
local Corner = Instance.new("UICorner")

OpenUI.Name = "NovaToggleUI"
OpenUI.Parent = game.CoreGui
OpenUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ToggleUI.Name = "ToggleUI"
ToggleUI.Parent = OpenUI
ToggleUI.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleUI.Position = UDim2.fromScale(0.01, 0.4) -- Posición lateral izquierda
ToggleUI.Size = UDim2.fromOffset(60, 60)
ToggleUI.Font = Enum.Font.GothamBold
ToggleUI.Text = "NOVA" -- El texto que sale en el botón
ToggleUI.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleUI.TextSize = 16.000
ToggleUI.ClipsDescendants = true
ToggleUI.Draggable = true -- Lo puedes mover por la pantalla

Corner.CornerRadius = UDim.new(0, 15) -- Bordes redondeados
Corner.Parent = ToggleUI

-- Función para que el botón muestre/oculte el menú
local visible = true
ToggleUI.MouseButton1Click:Connect(function()
    visible = not visible
    Window:SetVisible(visible)
end)

-- [[ NOTIFICACIÓN DE INICIO ]]
Fluent:Notify({
    Title = "Proyecto Nova Cargado",
    Content = "Presiona NOVA en el botón flotante para abrir/cerrar.",
    Duration = 5
})
