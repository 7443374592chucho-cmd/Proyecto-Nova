-- [[ PROJECT NOVA: 99 NIGHTS - ARMORED v11 ]]
local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")

-- ESTADO INICIAL
_G.NovaFarm = false
_G.NovaKill = false

-- FUNCIÓN DE GOLPE (SIN LIBRERÍAS PESADAS)
local function Hit(targetName, toolName)
    local event = RS:FindFirstChild("Events") and RS.Events:FindFirstChild("PlayEnemyHitSound")
    if event then
        event:FireServer("FireAllClients", targetName, toolName)
    end
end

-- BUCLE AUTO-FARM
task.spawn(function()
    while task.wait(0.4) do
        if _G.NovaFarm then
            pcall(function()
                local tool = LP.Character:FindFirstChildOfClass("Tool")
                if tool then
                    for _, obj in pairs(game.Workspace:GetChildren()) do
                        if (obj.Name:find("Tree") or obj.Name:find("Rock")) then
                            if (LP.Character.HumanoidRootPart.Position - obj.Position).Magnitude < 25 then
                                Hit(obj.Name, tool.Name)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- BUCLE KILL-AURA
task.spawn(function()
    while task.wait(0.2) do
        if _G.NovaKill then
            pcall(function()
                for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        if (LP.Character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude < 20 then
                            Hit(enemy.Name, "Old Axe")
                        end
                    end
                end
            end)
        end
    end
end)

-- INTERFAZ NATIVA (SÚPER LIGERA)
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
local main = Instance.new("Frame", sg)
main.Size = UDim2.fromOffset(160, 130)
main.Position = UDim2.new(0.02, 0, 0.4, 0)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0.3, 0)
title.Text = "NOVA v11"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1

local btnFarm = Instance.new("TextButton", main)
btnFarm.Size = UDim2.new(0.9, 0, 0.3, 0)
btnFarm.Position = UDim2.new(0.05, 0, 0.3, 0)
btnFarm.Text = "FARM: OFF"
btnFarm.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
btnFarm.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", btnFarm)

local btnKill = Instance.new("TextButton", main)
btnKill.Size = UDim2.new(0.9, 0, 0.3, 0)
btnKill.Position = UDim2.new(0.05, 0, 0.65, 0)
btnKill.Text = "KILL: OFF"
btnKill.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
btnKill.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", btnKill)

-- EVENTOS
btnFarm.MouseButton1Click:Connect(function()
    _G.NovaFarm = not _G.NovaFarm
    btnFarm.Text = _G.NovaFarm and "FARM: ON" or "FARM: OFF"
    btnFarm.BackgroundColor3 = _G.NovaFarm and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

btnKill.MouseButton1Click:Connect(function()
    _G.NovaKill = not _G.NovaKill
    btnKill.Text = _G.NovaKill and "KILL: ON" or "KILL: OFF"
    btnKill.BackgroundColor3 = _G.NovaKill and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)
