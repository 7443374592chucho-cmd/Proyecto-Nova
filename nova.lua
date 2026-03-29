local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")

-- APRENDE ESTO: Esta función busca la carpeta de eventos aunque cambie de nombre
local function EncontrarEvento()
    for _, v in pairs(RS:GetDescendants()) do
        if v:IsA("RemoteEvent") and v.Name:find("Hit") then
            return v -- Encontramos el "cable" correcto
        end
    end
end

local EventoDaño = EncontrarEvento()

-- Bucle de Farm (Simplificado para que aprendas la lógica)
task.spawn(function()
    while task.wait(0.5) do
        if EventoDaño then
            pcall(function()
                for _, obj in pairs(game.Workspace:GetChildren()) do
                    -- Filtramos: Si es un árbol y está cerca
                    if obj.Name:lower():find("tree") then
                        local dist = (LP.Character.HumanoidRootPart.Position - obj.Position).Magnitude
                        if dist < 30 then
                            -- MANDAMOS EL GOLPE
                            EventoDaño:FireServer("FireAllClients", obj.Name, "Old Axe")
                        end
                    end
                end
            end)
        else
            warn("¡No se encontró el evento de daño! El juego cambió de nuevo.")
        end
    end
end)
