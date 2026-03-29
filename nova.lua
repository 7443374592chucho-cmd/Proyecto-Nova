-- [[ SEGURIDAD Y OPTIMIZACIÓN ]]
if not game:IsLoaded() then game.Loaded:Wait() end

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()

-- Interfaz Única
local Window = Fluent:CreateWindow({
    Title = "PROJECT NOVA",
    SubTitle = "v2.0 | High-Performance",
    TabWidth = 160,
    Size = UDim2.fromOffset(550, 400),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
    Combat = Window:AddTab({ Title = "Combat/Fast", Icon = "zap" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- [[ LÓGICA DE FUNCIÓN "FAST" ]]
local FastConfig = { Active = false, Speed = 0.1 }

Tabs.Combat:AddToggle("FastAttack", {
    Title = "Ultra Fast Mode", 
    Default = false,
    Callback = function(Value)
        FastConfig.Active = Value
    end
})

-- Bucle de alta velocidad optimizado (Dificil de parchar)
-- Usamos task.spawn para que no interfiera con otros procesos
task.spawn(function()
    while task.wait() do
        if FastConfig.Active then
            -- Aquí colocas el RemoteEvent que quieras "spammiar"
            -- Ejemplo genérico para juegos de pelea/clicker:
            pcall(function()
                local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if tool then
                    tool:Activate() -- Activa la herramienta a velocidad máxima
                end
            end)
        end
    end
end)

-- Botón de destrucción segura (Limpia el script del juego)
Tabs.Settings:AddButton({
    Title = "Unload Script",
    Callback = function()
        Window:Destroy()
    end
})

Fluent:Notify({Title = "Nova Loaded", Content = "Presiona RightControl para ocultar.", Duration = 5})
