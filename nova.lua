-- [[ PROJECT NOVA: 99 NIGHTS - MULTITASK v19 ]]
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")

local Window = Fluent:CreateWindow({
    Title = "PROJECT NOVA | 99 NIGHTS",
    SubTitle = "v19.0 Premium",
    TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = false, Theme = "Dark"
})

-- PESTAÑAS
local Tabs = {
    Farm = Window:AddTab({ Title = "Auto-Farm", Icon = "pickaxe" }),
    Rescue = Window:AddTab({ Title = "Rescate/Cofres", Icon = "box" }),
    TP = Window:AddTab({ Title = "Teleports", Icon = "map" }),
    Player = Window:AddTab({ Title = "Jugador", Icon = "user" })
}

local Options = Fluent.Options

-- [[ PESTAÑA: FARM ]]
Tabs.Farm:AddToggle("MultiChop", {Title = "Talar Árboles (Muchos a la vez)", Default = false})
Tabs.Farm:AddToggle("AutoStone", {Title = "Minería Automática (Piedras)", Default = false})
Tabs.Farm:AddToggle("AutoCollect", {Title = "Succionar Leña/Materiales", Default = false})

-- [[ PESTAÑA: RESCATE ]]
Tabs.Rescue:AddToggle("RescateNiños", {Title = "Auto-Rescatar Niños", Default = false})
Tabs.Rescue:AddToggle("CofresAura", {Title = "Auto-Abrir Cofres", Default = false})

-- [[ PESTAÑA: JUGADOR ]]
Tabs.Player:AddSlider("WalkSpeed", {Title = "Velocidad", Default = 16, Min = 16, Max = 200, Rounding = 1, Callback = function(Value) LP.Character.Humanoid.WalkSpeed = Value end})
Tabs.Player:AddSlider("JumpPower", {Title = "Salto", Default = 50, Min = 50, Max = 300, Rounding = 1, Callback = function(Value) LP.Character.Humanoid.JumpPower = Value end})

-- [[ PESTAÑA: TELEPORTS ]]
Tabs.TP:AddButton({Title = "Ir a la Base", Callback = function() LP.Character.HumanoidRootPart.CFrame = CFrame.new(-34, 5, 20) end})
Tabs.TP:AddButton({Title = "Ir a Zona de Niños", Callback = function() LP.Character.HumanoidRootPart.CFrame = CFrame.new(100, 5, 100) end})

-- [[ LÓGICA DE FUNCIONAMIENTO ]]
task.spawn(function()
    while task.wait(0.3) do
        pcall(function()
            local hrp = LP.Character.HumanoidRootPart
            local tool = LP.Character:FindFirstChildOfClass("Tool")
            
            for _, obj in pairs(game.Workspace:GetChildren()) do
                -- 1. TALADO Y MINERÍA MULTIPLE
                if tool and (Options.MultiChop.Value and obj.Name:lower():find("tree")) or (Options.AutoStone.Value and obj.Name:lower():find("rock")) then
                    if (hrp.Position - obj.Position).Magnitude < 60 then
                        RS.Events.PlayEnemyHitSound:FireServer("FireAllClients", obj.Name, tool.Name)
                    end
                end
                
                -- 2. SUCCIONAR LEÑA / PIEDRA
                if Options.AutoCollect.Value and (obj.Name:lower():find("wood") or obj.Name:lower():find("log") or obj.Name:lower():find("stone")) then
                    obj.CFrame = hrp.CFrame
                    firetouchinterest(hrp, obj, 0)
                    task.wait()
                    firetouchinterest(hrp, obj, 1)
                end

                -- 3. RESCATE DE NIÑOS Y COFRES
                if (Options.RescateNiños.Value and (obj.Name:lower():find("child") or obj.Name:lower():find("kid"))) or (Options.CofresAura.Value and obj.Name:lower():find("chest")) then
                    if (hrp.Position - obj.Position).Magnitude < 50 then
                        hrp.CFrame = obj.CFrame
                        task.wait(0.5)
                    end
                end
            end
        end)
    end
end)

-- BOTÓN FLOTANTE "NOVA"
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
local btn = Instance.new("TextButton", sg)
btn.Size = UDim2.fromOffset(60, 60)
btn.Position = UDim2.new(0.02, 0, 0.4, 0)
btn.Text = "NOVA"
btn.Draggable = true
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 50)
btn.MouseButton1Click:Connect(function() Window:Minimize() end)
