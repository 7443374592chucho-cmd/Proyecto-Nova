-- [[ PROJECT NOVA: 99 NIGHTS FIX - V8.0 ]]
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local LP = game:GetService("Players").LocalPlayer

local Window = Fluent:CreateWindow({
    Title = "PROJECT NOVA | 99 NIGHTS",
    SubTitle = "v8.0 Premium Fixed",
    TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = false, Theme = "Dark"
})

local Tabs = {
    Farm = Window:AddTab({ Title = "Auto-Farm", Icon = "pickaxe" }),
    Combat = Window:AddTab({ Title = "Kill Aura", Icon = "swords" })
}

local Options = Fluent.Options

-- [[ AUTO-FARM SEPARADO ]]
Tabs.Farm:AddToggle("AutoWood", {Title = "Auto-Talar (Madera)", Default = false})
Tabs.Farm:AddToggle("AutoStone", {Title = "Auto-Minería (Piedra)", Default = false})

task.spawn(function()
    while task.wait(0.3) do
        if Options.AutoWood.Value or Options.AutoStone.Value then
            pcall(function()
                local tool = LP.Character:FindFirstChildOfClass("Tool") or LP.Backpack:FindFirstChildOfClass("Tool")
                if tool then
                    for _, obj in pairs(game.Workspace:GetChildren()) do
                        if (LP.Character.HumanoidRootPart.Position - obj.Position).Magnitude < 22 then
                            local isTree = Options.AutoWood.Value and obj.Name:lower():find("tree")
                            local isRock = Options.AutoStone.Value and obj.Name:lower():find("rock")
                            if isTree or isRock then
                                game:GetService("ReplicatedStorage").Events.PlayEnemyHitSound:FireServer("FireAllClients", obj.Name, tool.Name)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- [[ KILL AURA SEPARADO ]]
Tabs.Combat:AddToggle("KillAura", {Title = "Activar Kill Aura", Default = false})

task.spawn(function()
    while task.wait(0.15) do
        if Options.KillAura.Value then
            pcall(function()
                for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        if (LP.Character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude < 20 then
                            game:GetService("ReplicatedStorage").Events.PlayEnemyHitSound:FireServer("FireAllClients", enemy.Name, "Old Axe")
                        end
                    end
                end
            end)
        end
    end
end)

-- [[ BOTÓN FLOTANTE "NOVA" - FIX DEL ERROR ]]
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
local btn = Instance.new("TextButton", sg)
btn.Size = UDim2.fromOffset(65, 65)
btn.Position = UDim2.new(0.02, 0, 0.4, 0)
btn.Text = "NOVA"
btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Draggable = true
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 50)

-- EL FIX: Usamos la función nativa de Fluent para minimizar
btn.MouseButton1Click:Connect(function()
    Window:Minimize() -- Esto abre/cierra correctamente sin errores
end)

Fluent:Notify({Title = "Nova v8", Content = "Botón NOVA listo para usar.", Duration = 5})