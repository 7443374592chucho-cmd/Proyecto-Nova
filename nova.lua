-- [[ PROJECT NOVA: 99 NIGHTS ELITE - AUTO-SYNC ]]
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local LP = game.Players.LocalPlayer

local Window = Fluent:CreateWindow({
    Title = "PROJECT NOVA | 99 NIGHTS",
    SubTitle = "v5.0 - Hit Sync Edition",
    TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = true, Theme = "Dark"
})

local Tabs = { Main = Window:AddTab({ Title = "Farm", Icon = "pickaxe" }) }
local Options = Fluent.Options

-- [[ AUTO-FARM INTELIGENTE ]]
Tabs.Main:AddToggle("AutoFarm", {Title = "Auto-Farm (Sync con Servidor)", Default = false})

task.spawn(function()
    while task.wait(0.25) do -- Velocidad segura para no ser kickeado
        if Options.AutoFarm.Value then
            pcall(function()
                local char = LP.Character
                local tool = char:FindFirstChildOfClass("Tool")
                
                if tool then
                    -- Buscamos el árbol o piedra más cercana (Radio de 18 studs)
                    for _, obj in pairs(game.Workspace:GetChildren()) do
                        if (obj.Name:find("Tree") or obj.Name:find("Rock")) and (char.HumanoidRootPart.Position - obj.Position).Magnitude < 18 then
                            
                            -- EL EVENTO REAL (Basado en tu captura)
                            game:GetService("ReplicatedStorage").Events.PlayEnemyHitSound:FireServer(
                                "FireAllClients", -- Arg 1
                                obj.Name,         -- Arg 2: Nombre del árbol/roca
                                tool.Name         -- Arg 3: Tu herramienta (Hacha/Pico)
                            )
                            
                        end
                    end
                else
                    Fluent:Notify({Title = "Aviso", Content = "Equipa una herramienta primero.", Duration = 2})
                end
            end)
        end
    end
end)

-- [[ SPEED HACK MEJORADO ]]
Tabs.Main:AddSlider("WalkSpeed", {
    Title = "Velocidad", Default = 16, Min = 16, Max = 100, Rounding = 1,
    Callback = function(v) LP.Character.Humanoid.WalkSpeed = v end
})

Fluent:Notify({Title = "Nova Sincronizado", Content = "Evento detectado: PlayEnemyHitSound", Duration = 5})
