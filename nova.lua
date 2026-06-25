local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Elite Script Hub [Multi-Game]",
   LoadingTitle = "Iniciando Hub Profesional...",
   Theme = "Default",
})

-- // Función actualizada para destruir la interfaz al cargar un script
local function safeLoad(url)
   Rayfield:Destroy() -- Se destruye la librería al ejecutar
   local success, err = pcall(function()
       loadstring(game:HttpGet(url))()
   end)
   if not success then
       warn("Error al cargar: " .. tostring(err))
   end
end

-- // 1. BLOX FRUIT
local BF = Window:CreateTab("Blox Fruits", nil)
BF:CreateButton({Name = "MinXt2 Eng", Callback = function() safeLoad("https://raw.githubusercontent.com/LuaCrack/Min/refs/heads/main/MinXt2Eng") end})
BF:CreateButton({Name = "Tsuo Hub", Callback = function() safeLoad("https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/Tsuoscripts") end})
BF:CreateButton({Name = "BF New V3", Callback = function() safeLoad("https://raw.githubusercontent.com/indexeduu/BF-NewVer/refs/heads/main/V3New.lua") end})
BF:CreateButton({Name = "BlueX Hub", Callback = function() safeLoad("https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/Main.lua") end})
BF:CreateButton({Name = "Banana Hub", Callback = function() safeLoad("https://raw.githubusercontent.com/obiiyeuem/vthangsitink/main/BananaHub.lua") end})

-- // 2. BRAINROT
local BR = Window:CreateTab("Brainrot", nil)
BR:CreateButton({Name = "PusarX Loader", Callback = function() safeLoad("https://raw.githubusercontent.com/Estevansit0/KJJK/refs/heads/main/PusarX-loader.lua") end})
BR:CreateButton({Name = "Brainrot New", Callback = function() safeLoad("https://raw.githubusercontent.com/Akbar123s/Script-Roblox-/refs/heads/main/Script%20Brainrot%20New") end})
BR:CreateButton({Name = "LurkHack V4", Callback = function() safeLoad("https://raw.githubusercontent.com/egor2078f/lurkhackv4/refs/heads/main/main.lua") end})
BR:CreateButton({Name = "NEOX Hub", Callback = function() safeLoad("https://raw.githubusercontent.com/hassanxzayn-lua/NEOXHUBMAIN/refs/heads/main/StealABrainrot") end})
BR:CreateButton({Name = "Overflow", Callback = function() safeLoad("https://raw.githubusercontent.com/OverflowBGSI/Overflow/refs/heads/main/loader.txt") end})

-- // 3. JARDÍN (GAG)
local GG = Window:CreateTab("Jardín (GaG)", nil)
GG:CreateButton({Name = "Gag Script", Callback = function() safeLoad("https://raw.githubusercontent.com/Kuploit/GagScript/refs/heads/main/Script") end})
GG:CreateButton({Name = "FFJ1 Loader", Callback = function() safeLoad("https://raw.githubusercontent.com/FFJ1/Roblox-Exploits/main/scripts/Loader.lua") end})
GG:CreateButton({Name = "ThundarZ Main", Callback = function() safeLoad("https://raw.githubusercontent.com/ThundarZ/Welcome/refs/heads/main/Main/GaG/Main.lua") end})
GG:CreateButton({Name = "ThanHub", Callback = function() safeLoad("https://raw.githubusercontent.com/thantzy/thanhub/refs/heads/main/thanv1") end})
GG:CreateButton({Name = "Zusume Hub", Callback = function() safeLoad("https://raw.githubusercontent.com/ZusumeHub/ZusumeHub/refs/heads/main/GAg5") end})

-- // 4. FISCH
local FS = Window:CreateTab("Fisch", nil)
FS:CreateButton({Name = "Space Hub", Callback = function() safeLoad("https://raw.githubusercontent.com/ago106/SpaceHub/refs/heads/main/Multi") end})
FS:CreateButton({Name = "Speed Hub X", Callback = function() safeLoad("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua") end})
FS:CreateButton({Name = "Disch Script", Callback = function() safeLoad("https://raw.githubusercontent.com/hakariqScripts/disch2/refs/heads/main/disch%20script") end})
FS:CreateButton({Name = "Zenith Hub", Callback = function() safeLoad("https://raw.githubusercontent.com/Efe0626/ZenithHub/refs/heads/main/Loader") end})

-- // 5. FOREST/FORGE
local FF = Window:CreateTab("Forest/Forge", nil)
FF:CreateButton({Name = "H4x Loader", Callback = function() safeLoad("https://raw.githubusercontent.com/H4xScripts/Loader/refs/heads/main/loader.lua") end})
FF:CreateButton({Name = "99 Nights Prem", Callback = function() safeLoad("https://raw.githubusercontent.com/yoursvexyyy/VEX-OP/refs/heads/main/99%20nights%20in%20the%20forest%20premium") end})
FF:CreateButton({Name = "Foxname Hub", Callback = function() safeLoad("https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/FoxnameHub.lua") end})
FF:CreateButton({Name = "The Forge Kam", Callback = function() safeLoad("https://raw.githubusercontent.com/EnesKam21/theforge/refs/heads/main/theforgekam.lua") end})
FF:CreateButton({Name = "Forge X", Callback = function() safeLoad("https://raw.githubusercontent.com/AnonymoDGH/scripts/refs/heads/main/forgex.lua") end})
FF:CreateButton({Name = "Haze API", Callback = function() safeLoad("https://haze.wtf/api/script") end})
FF:CreateButton({Name = "Bcode Forge", Callback = function() safeLoad("https://raw.githubusercontent.com/Baconlovecode/SECRET/refs/heads/main/BCODEFORGEV2.lua") end})

-- // 6. TSB
local TSB = Window:CreateTab("TSB", nil)
TSB:CreateButton({Name = "JNHH TSB Script", Callback = function() safeLoad("https://raw.githubusercontent.com/JNHHGaming/The-strong-battlegrounds/refs/heads/main/Tsb") end})
TSB:CreateButton({Name = "TSB Luna", Callback = function() safeLoad("https://raw.githubusercontent.com/Emerson2-creator/Scripts-Roblox/refs/heads/main/TSBLuna.lua") end})
TSB:CreateButton({Name = "Pastefy TSB", Callback = function() safeLoad("https://pastefy.app/Z7DawZJB/raw") end})
TSB:CreateButton({Name = "BaldyToSorcerer", Callback = function() getgenv().morph = true; safeLoad("https://raw.githubusercontent.com/skibiditoiletfan2007/BaldyToSorcerer/refs/heads/main/LatestV2.lua") end})
TSB:CreateButton({Name = "Phantasm TSB", Callback = function() safeLoad("https://raw.githubusercontent.com/ATrainz/Phantasm/refs/heads/main/Games/TSB.lua") end})
TSB:CreateButton({Name = "Speed Hub X", Callback = function() safeLoad("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/SpeedHubX.lua") end})
TSB:CreateButton({Name = "Arc Script", Callback = function() safeLoad("https://raw.githubusercontent.com/Mikasuru/Arc/refs/heads/main/Arc.lua") end})
