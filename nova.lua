-- [[ PROJECT NOVA: 99 NIGHTS - ULTRA LIGHT v10 ]]
local Success, Fluent = pcall(function()
    return loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
end)

if not Success or not Fluent then return end

local LP = game:GetService("Players").LocalPlayer

local Window = Fluent:CreateWindow({
    Title = "PROJECT NOVA",
    SubTitle = "v10 Light",
    TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = false, Theme = "Dark"
})

local Tabs = { Main = Window:AddTab({ Title = "Principal", Icon = "pickaxe" }) }
local Options = Fluent.Options

-- [[ AUTO-FARM REHECHO (MÁS SIMPLE) ]]
Tabs.Main:AddToggle("Farm", {Title = "Auto-Farm Todo", Default = false})

task.spawn(function()
    while task.wait(0.5) do
        if Options.Farm and Options.Farm.Value then
            pcall(function()
                local tool = LP.Character:FindFirstChildOfClass("Tool")
                if tool then
                    for _, obj in pairs(game.Workspace:GetChildren()) do
                        -- Si el nombre tiene Tree o Rock y está cerca
                        if (obj.Name:find("Tree") or obj.Name:find("Rock")) and (LP.Character.HumanoidRootPart.Position - obj.Position).Magnitude < 25 then
                            game:GetService("ReplicatedStorage").Events.PlayEnemyHitSound:FireServer("FireAllClients", obj.Name, tool.Name)
                        end
                    end
                end
            end)
        end
    end
end)

-- [[ BOTÓN FLOTANTE ANTI-ERRORES ]]
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
local btn = Instance.new("TextButton", sg)
btn.Size = UDim2.fromOffset(60, 60)
btn.Position = UDim2.new(0.02, 0, 0.4, 0)
btn.Text = "NOVA"
btn.Draggable = true
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 50)

btn.MouseButton1Click:Connect(function()
    if Window then
        Window:Minimize()
    end
end)
