-- [[ PROJECT NOVA: 99 NIGHTS - MEGA-NOVA v13 ]]
local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService") -- Para TP suave si quieres

_G.MassiveFarm = false
_G.AuraRescue = false

-- [[ FUNCIÓN DE GOLPE MAESTRO (3 ARGUMENTOS) ]]
local function MasterHit(targetName, toolName)
    local ev = RS:FindFirstChild("Events") and RS.Events:FindFirstChild("PlayEnemyHitSound")
    if ev then
        ev:FireServer("FireAllClients", targetName, toolName)
    end
end

-- [[ BUCLE 1: TALADO MASIVO (Muchos a la vez) ]]
task.spawn(function()
    while task.wait(0.4) do
        if _G.MassiveFarm then
            pcall(function()
                local tool = LP.Character:FindFirstChildOfClass("Tool")
                if tool then
                    -- Buscamos TODO en un radio de 40 studs (muy amplio)
                    for _, obj in pairs(game.Workspace:GetChildren()) do
                        if (obj.Name:find("Tree") or obj.Name:find("Rock")) then
                            local dist = (LP.Character.HumanoidRootPart.Position - obj.Position).Magnitude
                            if dist < 40 then
                                MasterHit(obj.Name, tool.Name) -- Golpea a todos los que estén cerca
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- [[ BUCLE 2: RESCATE AUTOMÁTICO (Niños y Cofres) ]]
task.spawn(function()
    while task.wait(0.5) do
        if _G.AuraRescue then
            pcall(function()
                for _, item in pairs(game.Workspace:GetChildren()) do
                    -- Si es un niño (Child) o Cofre (Chest)
                    if item.Name:find("Child") or item.Name:find("Chest") or item.Name:find("Kid") then
                        local dist = (LP.Character.HumanoidRootPart.Position - item.Position).Magnitude
                        if dist < 50 then
                            -- TP al item para recogerlo y luego vuelve (opcional) o intenta activarlo
                            LP.Character.HumanoidRootPart.CFrame = item.CFrame
                            task.wait(0.1)
                        end
                    end
                end
            end)
        end
    end
end)

-- [[ INTERFAZ MEJORADA ]]
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
local main = Instance.new("Frame", sg)
main.Size = UDim2.fromOffset(180, 200)
main.Position = UDim2.new(0.02, 0, 0.4, 0)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.Draggable = true
Instance.new("UICorner", main)

local function CreateBtn(name, text, pos, toggleVar)
    local b = Instance.new("TextButton", main)
    b.Size = UDim2.new(0.9, 0, 0.2, 0)
    b.Position = pos
    b.Text = text .. ": OFF"
    b.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    b.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", b)
    
    b.MouseButton1Click:Connect(function()
        _G[toggleVar] = not _G[toggleVar]
        b.Text = text .. (_G[toggleVar] and ": ON" or ": OFF")
        b.BackgroundColor3 = _G[toggleVar] and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    end)
end

CreateBtn("Farm", "TALAR MASIVO", UDim2.new(0.05, 0, 0.1, 0), "MassiveFarm")
CreateBtn("Rescue", "RESCATAR/COFRES", UDim2.new(0.05, 0, 0.4, 0), "AuraRescue")

-- BOTÓN TP A BASE (Útil)
local tpBase = Instance.new("TextButton", main)
tpBase.Size = UDim2.new(0.9, 0, 0.2, 0)
tpBase.Position = UDim2.new(0.05, 0, 0.7, 0)
tpBase.Text = "TP A BASE"
tpBase.BackgroundColor3 = Color3.fromRGB(0, 80, 200)
tpBase.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", tpBase)

tpBase.MouseButton1Click:Connect(function()
    -- Aquí pondrías la coordenada de tu base (ejemplo)
    LP.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0) -- Cambia por coords reales
end)
