-- [[ PROJECT NOVA: 99 NIGHTS - FOXNAME REPLICA v25 ]]
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")

local Window = Fluent:CreateWindow({
    Title = "Foxname - 99 NIGHTS",
    SubTitle = "v25.0 Exact Replica",
    TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = false, Theme = "Dark"
})

-- PESTAÑAS EXACTAS A FOXNAME
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Bring = Window:AddTab({ Title = "Bring", Icon = "box" }),
    Combat = Window:AddTab({ Title = "Combat", Icon = "zap" }),
    Tree = Window:AddTab({ Title = "Tree", Icon = "tree" }),
    TP = Window:AddTab({ Title = "Teleport", Icon = "map" })
}

local Options = Fluent.Options

-- [[ SECCIÓN MAIN (INFO/AUTO-RES) ]]
Tabs.Main:AddParagraph({Title = "Info", Content = "Replica exacta de Foxname UI. Discord.gg/Foxname"})

-- [[ SECCIÓN COMBAT (KILL AURA) ]]
Tabs.Combat:AddToggle("KillAura", {Title = "Kill Aura", Default = false})
Tabs.Combat:AddSlider("KillRange", {Title = "Kill Aura Range", Default = 50, Min = 10, Max = 150, Rounding = 1})

-- [[ SECCIÓN TREE (TREE AURA) ]]
Tabs.Tree:AddToggle("TreeAura", {Title = "Tree Aura", Default = false})
Tabs.Tree:AddSlider("ChopRange", {Title = "Chop Aura Range", Default = 50, Min = 10, Max = 150, Rounding = 1})

-- [[ SECCIÓN BRING (AUTO-COLLECT) ]]
Tabs.Bring:AddToggle("BringItems", {Title = "Bring Items (Recoger Madera)", Default = false})
Tabs.Bring:AddToggle("BringMode", {Title = "Bring Mode (Traer Niños/Cofres)", Default = false})

-- [[ SECCIÓN TP (TELEPORT A ZONAS) ]]
Tabs.TP:AddButton({Title = "Ir a la Base", Callback = function() LP.Character.HumanoidRootPart.CFrame = CFrame.new(-34, 5, 20) end})

-- [[ LÓGICA DE FUNCIONAMIENTO (DENTRO DE LA UI) ]]
task.spawn(function()
    while task.wait(0.2) do
        pcall(function()
            local hrp = LP.Character.HumanoidRootPart
            local tool = LP.Character:FindFirstChildOfClass("Tool")
            local charPos = hrp.Position

            for _, obj in pairs(game.Workspace:GetChildren()) do
                -- KILL AURA (MATA MONSTRUOS)
                if Options.KillAura.Value and obj:FindFirstChild("Humanoid") and obj.Humanoid.Health > 0 then
                    local targetHrp = obj:FindFirstChild("HumanoidRootPart")
                    if targetHrp and (charPos - targetHrp.Position).Magnitude < Options.KillRange.Value then
                        RS.Events.PlayEnemyHitSound:FireServer("FireAllClients", obj.Name, (tool and tool.Name or "Old Axe"))
                    end
                end
                
                -- TREE AURA (TALA ÁRBOLES)
                if Options.TreeAura.Value and tool and obj.Name:lower():find("tree") then
                    if (charPos - obj.Position).Magnitude < Options.ChopRange.Value then
                        RS.Events.PlayEnemyHitSound:FireServer("FireAllClients", obj.Name, tool.Name)
                    end
                end

                -- BRING ITEMS (TRAER MADERA)
                if Options.BringItems.Value and (obj.Name:lower():find("wood") or obj.Name:lower():find("log")) then
                    obj.CFrame = hrp.CFrame
                    firetouchinterest(hrp, obj, 0)
                    task.wait()
                    firetouchinterest(hrp, obj, 1)
                end

                -- BRING MODE (TRAER NIÑOS Y COFRES)
                if Options.BringMode.Value and (obj.Name:lower():find("child") or obj.Name:lower():find("kid") or obj.Name:lower():find("chest")) then
                    obj.CFrame = hrp.CFrame
                end
            end
        end)
    end
end)

-- BOTÓN FLOTANTE "FOXNAME STYLE"
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
local btn = Instance.new("TextButton", sg)
btn.Size = UDim2.fromOffset(60, 60)
btn.Position = UDim2.new(0.02, 0, 0.4, 0)
btn.Text = "NOVA"
btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Draggable = true
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 50)
btn.MouseButton1Click:Connect(function() Window:Minimize() end)
