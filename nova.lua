-- [[ PROJECT NOVA: 99 NIGHTS - ULTIMATE FARM v17 ]]
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")

local Window = Fluent:CreateWindow({
    Title = "PROJECT NOVA",
    SubTitle = "v17.0 Ultimate Magnet",
    TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = false, Theme = "Dark"
})

local Tabs = {
    Farm = Window:AddTab({ Title = "Auto-Farm", Icon = "tree" })
}

local Options = Fluent.Options

-- [[ AUTO-FARM + AUTO-COLLECT ]]
Tabs.Farm:AddToggle("UltraMagnet", {Title = "Talar y Succionar Leña", Default = false})

task.spawn(function()
    while task.wait(0.2) do -- Más rápido para que no se escape nada
        if Options.UltraMagnet.Value then
            pcall(function()
                local char = LP.Character
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local tool = char:FindFirstChildOfClass("Tool")
                
                if tool and hrp then
                    -- 1. TALADO REMOTO (Radio 70)
                    for _, obj in pairs(game.Workspace:GetChildren()) do
                        if obj.Name:lower():find("tree") or obj.Name:lower():find("rock") then
                            if (hrp.Position - obj.Position).Magnitude < 70 then
                                RS.Events.PlayEnemyHitSound:FireServer("FireAllClients", obj.Name, tool.Name)
                            end
                        end
                    end
                    
                    -- 2. SUCCIÓN DE LEÑA (Trae todo al centro de tu personaje)
                    for _, item in pairs(game.Workspace:GetChildren()) do
                        -- Buscamos Wood, Log, Stone o cualquier material suelto
                        if item:IsA("BasePart") and (item.Name:lower():find("wood") or item.Name:lower():find("log") or item.Name:lower():find("stone")) then
                            -- El item vuela hacia ti y se auto-recolecta
                            item.CanCollide = false
                            item.CFrame = hrp.CFrame
                            firetouchinterest(hrp, item, 0)
                            task.wait()
                            firetouchinterest(hrp, item, 1)
                        end
                    end
                end
            end)
        end
    end
end)

-- [[ BOTÓN FLOTANTE ESTILO FOXNAME ]]
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
local btn = Instance.new("TextButton", sg)
btn.Size = UDim2.fromOffset(65, 65)
btn.Position = UDim2.new(0.02, 0, 0.4, 0)
btn.Text = "NOVA"
btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Draggable = true
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 50)
Instance.new("UIStroke", btn).Thickness = 2 -- Un borde pro

btn.MouseButton1Click:Connect(function()
    Window:Minimize()
end)

Fluent:Notify({Title = "Nova v17", Content = "Sistema de Succión de Leña Activado", Duration = 5})
