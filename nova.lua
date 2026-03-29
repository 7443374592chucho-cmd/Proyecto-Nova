-- [[ PROJECT NOVA: 99 NIGHTS ULTIMATE EDITION ]]
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "PROJECT NOVA | 99 NIGHTS",
    SubTitle = "by @7443374592chucho-cmd",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Supervivencia", Icon = "shield" }),
    Combat = Window:AddTab({ Title = "Combate Fast", Icon = "zap" }),
    Settings = Window:AddTab({ Title = "Configuración", Icon = "settings" })
}

local Options = Fluent.Options

-- [[ FUNCIÓN ÚNICA: AUTO-REPARAR BASE ]]
-- Esta función busca estructuras dañadas y las repara al instante
Tabs.Main:AddToggle("AutoRepair", {Title = "Auto-Reparar Estructuras", Default = false})

task.spawn(function()
    while task.wait(0.5) do -- Revisión cada medio segundo para no dar lag
        if Options.AutoRepair.Value then
            pcall(function()
                -- Buscamos en el Workspace las construcciones del jugador
                for _, obj in pairs(game.Workspace.Buildings:GetChildren()) do 
                    if obj:FindFirstChild("Health") and obj.Health.Value < obj.MaxHealth.Value then
                        -- Disparamos el remoto de reparación (ajustar según el juego)
                        game:GetService("ReplicatedStorage").Remotes.Repair:FireServer(obj)
                    end
                end
            end)
        end
    end
end)

-- [[ FUNCIÓN: FAST GATHER (RECOLECCIÓN RÁPIDA) ]]
Tabs.Main:AddToggle("FastGather", {Title = "Recolección Instantánea", Default = false})

task.spawn(function()
    while task.wait() do
        if Options.FastGather.Value then
            pcall(function()
                -- Detecta recursos en un radio cercano y los recolecta
                local char = game.Players.LocalPlayer.Character
                for _, res in pairs(game.Workspace.Resources:GetChildren()) do
                    if (char.HumanoidRootPart.Position - res.Position).Magnitude < 15 then
                        game:GetService("ReplicatedStorage").Remotes.Collect:FireServer(res)
                    end
                end
            end)
        end
    end
end)

-- [[ COMBATE: KILL AURA OPTIMIZADO ]]
Tabs.Combat:AddToggle("KillAura", {Title = "Kill Aura (Noches Seguras)", Default = false})
Tabs.Combat:AddSlider("AuraRange", {Title = "Rango de Ataque", Default = 20, Min = 10, Max = 100, Rounding = 1})

game:GetService("RunService").Heartbeat:Connect(function()
    if Options.KillAura.Value then
        pcall(function()
            local lp = game.Players.LocalPlayer
            for _, mob in pairs(game.Workspace.Enemies:GetChildren()) do
                if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                    local dist = (lp.Character.HumanoidRootPart.Position - mob.HumanoidRootPart.Position).Magnitude
                    if dist <= Options.AuraRange.Value then
                        -- Ataque rápido sin cooldown (Fast Attack)
                        game:GetService("ReplicatedStorage").Remotes.Attack:FireServer(mob)
                    end
                end
            end
        end)
    end
end)

-- Notificación de inicio profesional
Fluent:Notify({
    Title = "Proyecto Nova Cargado",
    Content = "Funciones para 99 Noches activas.",
    Duration = 5
})

Window:SelectTab(1)