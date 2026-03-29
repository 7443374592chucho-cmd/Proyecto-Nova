-- [[ PROJECT NOVA: 99 NIGHTS - FOXNAME EDITION v20 ]]
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")

local Window = Fluent:CreateWindow({
    Title = "Foxname - 99 NIGHTS",
    SubTitle = "v20.0 Premium",
    TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = false, Theme = "Dark"
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Bring = Window:AddTab({ Title = "Bring", Icon = "box" }),
    Combat = Window:AddTab({ Title = "Combat", Icon = "zap" }),
    Tree = Window:AddTab({ Title = "Tree", Icon = "tree" }),
    TP = Window:AddTab({ Title = "Teleport", Icon = "map" })
}

local Options = Fluent.Options

-- [[ SECCIÓN COMBAT (KILL AURA) ]]
Tabs.Combat:AddToggle("KillAura", {Title = "Kill Aura", Default = false})
Tabs.Combat:AddSlider("KillRange", {Title = "Kill Aura Range", Default = 50, Min = 10, Max = 150, Rounding = 1})

-- [[ SECCIÓN TREE (TREE AURA) ]]
Tabs.Tree:AddToggle("TreeAura", {Title = "Tree Aura", Default = false})
Tabs.Tree:AddSlider("ChopRange", {Title = "Chop Aura Range", Default = 50, Min = 10, Max = 150, Rounding = 1})

-- [[ SECCIÓN BRING (RECOLECCIÓN) ]]
Tabs.Bring:AddToggle("BringMode", {Title = "Bring Mode (Auto-Collect)", Default = false})

-- [[ LÓGICA DE REFERENCIA ]]
task.spawn(function()
    while task.wait(0.2) do
        pcall(function()
            local hrp = LP.Character.HumanoidRootPart
            local tool = LP.Character:FindFirstChildOfClass("Tool")

            for _, obj in pairs(game.Workspace:GetChildren()) do
                -- KILL AURA
                if Options.KillAura.Value and obj:FindFirstChild("Humanoid") and obj.Humanoid.Health > 0 then
                    if (hrp.Position - obj.HumanoidRootPart.Position).Magnitude < Options.KillRange.Value then
                        RS.Events.PlayEnemyHitSound:FireServer("FireAllClients", obj.Name, (tool and tool.Name or "Old Axe"))
                    end
                end
                
                -- TREE AURA
                if Options.TreeAura.Value and tool and obj.Name:lower():find("tree") then
                    if (hrp.Position - obj.Position).Magnitude < Options.ChopRange.Value then
                        RS.Events.PlayEnemyHitSound:FireServer("FireAllClients", obj.Name, tool.Name)
                    end
                end

                -- BRING MODE (Traer Niños, Cofres y Madera)
                if Options.BringMode.Value then
                    if obj.Name:lower():find("child") or obj.Name:lower():find("kid") or obj.Name:lower():find("wood") or obj.Name:lower():find("chest") then
                        obj.CFrame = hrp.CFrame
                        firetouchinterest(hrp, obj, 0)
                        task.wait()
                        firetouchinterest(hrp, obj, 1)
                    end
                end
            end
        end)
    end
end)

-- BOTÓN FLOTANTE
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
local btn = Instance.new("TextButton", sg)
btn.Size = UDim2.fromOffset(60, 60)
btn.Position = UDim2.new(0.02, 0, 0.4, 0)
btn.Text = "NOVA"
btn.Draggable = true
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 50)
btn.MouseButton1Click:Connect(function() Window:Minimize() end)
