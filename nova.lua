local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local LP = game:GetService("Players").LocalPlayer

-- [[ EL RADAR: Busca el evento de golpe sin importar el nombre ]]
local function BuscarEvento()
    for _, v in pairs(game:GetDescendants()) do
        -- Buscamos un evento que mencione "Hit" o "Damage"
        if v:IsA("RemoteEvent") and (v.Name:find("Hit") or v.Name:find("Damage")) then
            return v
        end
    end
end

local RemoteGolpe = BuscarEvento()

-- [[ INTERFAZ ESTILO FOXNAME ]]
local Window = Fluent:CreateWindow({
    Title = "Foxname - 99 NIGHTS",
    SubTitle = "v28.0 (Radar Fixed)",
    TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = false, Theme = "Dark"
})

local Tabs = {
    Combat = Window:AddTab({ Title = "Combat", Icon = "zap" }),
    Tree = Window:AddTab({ Title = "Tree", Icon = "tree" }),
    Bring = Window:AddTab({ Title = "Bring", Icon = "box" })
}

local Options = Fluent.Options

-- [[ LAS OPCIONES ]]
Tabs.Combat:AddToggle("KillAura", {Title = "Kill Aura", Default = false})
Tabs.Tree:AddToggle("TreeAura", {Title = "Tree Aura", Default = false})
Tabs.Bring:AddToggle("BringMode", {Title = "Bring Mode", Default = false})

-- [[ EL CEREBRO DEL SCRIPT ]]
task.spawn(function()
    while task.wait(0.3) do
        pcall(function()
            local hrp = LP.Character.HumanoidRootPart
            local tool = LP.Character:FindFirstChildOfClass("Tool")
            
            -- Si el radar encontró el evento, lo usamos
            if RemoteGolpe then
                for _, obj in pairs(game.Workspace:GetChildren()) do
                    -- TREE AURA
                    if Options.TreeAura.Value and obj.Name:lower():find("tree") then
                        if (hrp.Position - obj.Position).Magnitude < 40 then
                            RemoteGolpe:FireServer("FireAllClients", obj.Name, (tool and tool.Name or "Old Axe"))
                        end
                    end
                    
                    -- BRING MODE (NIÑOS Y COFRES)
                    if Options.BringMode.Value and (obj.Name:lower():find("child") or obj.Name:lower():find("chest")) then
                        obj.CFrame = hrp.CFrame
                    end
                end
            end
        end)
    end
end)
