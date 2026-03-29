-- [[ PROJECT NOVA: 99 NIGHTS - FINAL SYNC v9.5 ]]
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local LP = game:GetService("Players").LocalPlayer

local Window = Fluent:CreateWindow({
    Title = "PROJECT NOVA | 99 NIGHTS",
    SubTitle = "v9.5 Premium",
    TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = false, Theme = "Dark"
})

local Tabs = {
    Farm = Window:AddTab({ Title = "Auto-Farm", Icon = "pickaxe" }),
    Combat = Window:AddTab({ Title = "Combate", Icon = "zap" })
}

local Options = Fluent.Options

-- [[ FUNCIÓN DE GOLPE (CORREGIDA) ]]
local function Hit(targetName, toolName)
    local ev = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
    if ev and ev:FindFirstChild("PlayEnemyHitSound") then
        -- Usamos los 3 argumentos exactos de tu consola
        ev.PlayEnemyHitSound:FireServer("FireAllClients", targetName, toolName)
    end
end

-- [[ AUTO-FARM ]]
Tabs.Farm:AddToggle("AutoWood", {Title = "Auto-Talar (Madera)", Default = false})
Tabs.Farm:AddToggle("AutoStone", {Title = "Auto-Minería (Piedra)", Default = false})

task.spawn(function()
    while task.wait(0.3) do
        if Options.AutoWood.Value or Options.AutoStone.Value then
            pcall(function()
                local tool = LP.Character:FindFirstChildOfClass("Tool")
                if tool then
                    for _, obj in pairs(game.Workspace:GetChildren()) do
                        -- Radio de 25 para alcanzar árboles grandes
                        if (LP.Character.HumanoidRootPart.Position - obj.Position).Magnitude < 25 then
                            if Options.AutoWood.Value and obj.Name:lower():find("tree") then
                                Hit(obj.Name, tool.Name)
                            elseif Options.AutoStone.Value and (obj.Name:lower():find("rock") or obj.Name:lower():find("stone")) then
                                Hit(obj.Name, tool.Name)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- [[ BOTÓN NOVA ]]
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
local btn = Instance.new("TextButton", sg)
btn.Size = UDim2.fromOffset(65, 65)
btn.Position = UDim2.new(0.02, 0, 0.4, 0)
btn.Text = "NOVA"
btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Draggable = true
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 50)
btn.MouseButton1Click:Connect(function() Window:Minimize() end)

Fluent:Notify({Title = "Nova v9.5", Content = "Presiona el botón verde en GitHub y luego ejecuta.", Duration = 5})
