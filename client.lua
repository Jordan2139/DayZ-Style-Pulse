--------------------------------------------------------------
-- Pulse Plus - A Simple FiveM Script, Made By Jordan.#2139 --
--------------------------------------------------------------
----------------------------------------------------------------------------------------------
                  -- !WARNING! !WARNING! !WARNING! !WARNING! !WARNING! --
        -- DO NOT TOUCH THIS FILE OR YOU /WILL/ FUCK SHIT UP! EDIT THE CONFIG.LUA --
-- DO NOT BE STUPID AND WHINE TO ME ABOUT THIS BEING BROKEN IF YOU TOUCHED THE LINES BELOW. --
----------------------------------------------------------------------------------------------

------------------------------------------
-- Variables - Don't Touch (Use Config) --
------------------------------------------

local pulse = 0

-----------------------------------------
-- Commands - Don't Touch (Use Config) --
-----------------------------------------

RegisterCommand("testp", function(source, args)
    local player = GetClosestPlayer()
    if player ~= false then
        if config.use_chat then TriggerClientEvent("chatMessage", "^2[Pulse +]", {255,255,255}, " ^4Testing...") else notify('~h~~p~[Pulse + ] ~b~Testing...') end
        TriggerServerEvent('GetPedPulse-S', player)
    else
        if config.use_chat then TriggerClientEvent("chatMessage", "^2[Pulse +]", {255,255,255}, " ^1There is no nearby player!") else notify('~r~There is no nearby player!') end 
    end
end)

RegisterCommand("pulseset", function(source, args)
    if config.set_pulse then
        pulse = OnScreenKeyBoard('Pulse - Normal Resting Rate: 60 to 100')
            if pulse == nil or pulse == '' or tonumber(pulse) == nil then
                notify('~r~Invalid Pulse Provided!')
            end
            TriggerServerEvent('PulseSet-S', tonumber(pulse))
                if config.use_chat then TriggerEvent("chatMessage", "^2[Pulse +]", {255,255,255}, " ^4Pulse Set To: ^2" .. tostring(pulse)) else notify('~h~~p~[Pulse + ] ~b~Pulse Set To: ~g~' .. tostring(pulse)) end
        else
            if config.use_chat then TriggerEvent("chatMessage", "^2[Pulse +]", {255,255,255}, " ^4This server has disabled the ability to set your own pulse. Your pulse will be set automatically based on your health!") else notify('~h~~p~[Pulse + ] ~b~This server has disabled the ability to set your own pulse. Your pulse will be set automatically based on your health!') end
    end
end)

RegisterCommand('resetpulse', function(source, args)
    if config.set_pulse then
        TriggerServerEvent('PulseSet-S', nil)
        if config.use_chat then TriggerEvent("chatMessage", "^2[Pulse +]", {255,255,255}, " ^4Pulse Has Been Reset!") else notify('~h~~p~[Pulse + ] ~b~Pulse Has Been Reset') end
    else 
        if config.use_chat then TriggerEvent("chatMessage", "^2[Pulse +]", {255,255,255}, " ^4This server has disabled the ability to set your own pulse. Your pulse will be set automatically based on your health!") else notify('~h~~p~[Pulse + ] ~b~This server has disabled the ability to set your own pulse. Your pulse will be set automatically based on your health!') end
    end
end)

------------------------------------------------
-- Citizen Threads - Don't Touch (Use Config) --
------------------------------------------------

Citizen.CreateThread(function ()
    while true do
        for _, player in ipairs(GetActivePlayers()) do
		    local player2 = GetClosestPlayer()
		    local ped = GetPlayerPed(player)
			local playerped = PlayerPedId()
            local pedpos = GetEntityCoords(ped)
			local playerpedpos = GetEntityCoords(playerped)
			local distance = #(playerpedpos - pedpos)
			local x, y, z = table.unpack(GetEntityCoords(ped))
			local offset = 0.1 + 0.1 * 0.1
			z = z + offset
			if distance < config.DistToSee then
                if not config.only_dead then
                    if ped ~= playerped then
                    DrawText3D(vector3(x, y, z), config.PopUpPrompt)
                    if IsControlPressed(0, config.Keybind) then
                        if config.use_chat then TriggerEvent("chatMessage", "^2[Pulse +]", {255,255,255}, " ^4Testing...") else notify('~h~~p~[Pulse + ] ~b~Testing...') end
                        TriggerServerEvent('GetPedPulse-S', player2)
                        Citizen.Wait(10000)
                    end
                end
            else
                if ped ~= playerped then
                    if TriggerServerEvent('IsMofoDead', player2) then
                        DrawText3D(vector3(x, y, z), config.PopUpPrompt)
                        if IsControlPressed(0, config.Keybind) then
                            if config.use_chat then TriggerEvent("chatMessage", "^2[Pulse +]", {255,255,255}, " ^4Testing...") else notify('~h~~p~[Pulse + ] ~b~Testing...') end
                            TriggerServerEvent('GetPedPulse-S', player2)
                            Citizen.Wait(10000)
                        end    
                    end
                end
            end
        end
        end
		Citizen.Wait(0)
    end
end)

---------------------------------------
-- Events - Don't Touch (Use Config) --
---------------------------------------

RegisterNetEvent('GetPedPulse-C')
AddEventHandler('GetPedPulse-C', function(pulse)
    Citizen.Wait(5000)
    if pulse == nil then pulse = 0.00 end
    if tonumber(pulse) < 45 or tonumber(pulse) > 165 then
        if config.use_chat then TriggerEvent("chatMessage", "^2[Pulse +]", {255,255,255}, " ^4Pulse: ^2" .. tostring(pulse)) else notify('~h~~p~[Pulse + ] ~b~Pulse: ~r~' .. tostring(pulse)) end
    else
        if config.use_chat then TriggerEvent("chatMessage", "^2[Pulse +]", {255,255,255}, " ^4Pulse: ^1" .. tostring(pulse)) else notify('~h~~p~[Pulse + ] ~b~Pulse: ~g~' .. tostring(pulse)) end
    end
end)

------------------------------------------
-- Functions - Don't Touch (Use Config) --
------------------------------------------

-- Check who the nearest person is
function GetClosestPlayer() local Ped = PlayerPedId() for _, Player in ipairs(GetActivePlayers()) do if GetPlayerPed(Player) ~= GetPlayerPed(-1) then local Ped2 = GetPlayerPed(Player) local x, y, z = table.unpack(GetEntityCoords(Ped)) if (GetDistanceBetweenCoords(GetEntityCoords(Ped2), x, y, z) <  2) then return GetPlayerServerId(Player) end end end return false end

-- Notify above map (disable in config.lua)
function notify(Text) SetNotificationTextEntry('STRING') AddTextComponentString(Text) DrawNotification(true, true) end

-- Keyboard Input Function For pulseset --
function OnScreenKeyBoard(TextEntry) AddTextEntry('FMMC_KEY_TIP1', TextEntry) DisplayOnscreenKeyboard(1, 'FMMC_KEY_TIP1', '', '', '', '', '', 5) BlockInput = true while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do Citizen.Wait(0) end if UpdateOnscreenKeyboard() ~= 2 then local Result = GetOnscreenKeyboardResult() Citizen.Wait(500) BlockInput = false return Result else Citizen.Wait(500) BlockInput = false return nil end end

-- Draw 3D Text | Credit: https://github.com/Cheleber/tag_admin
function DrawText3D(coords, text) local camCoords = GetGameplayCamCoord() local dist = #(coords - camCoords) local scale = 200 / (GetGameplayCamFov() * dist) SetTextScale(0.2, config.TextSize * scale) SetTextFont(4) SetTextColour(255, 255, 255, 255) SetTextDropshadow(0, 0, 0, 0, 255) SetTextEdge(2, 0, 0, 0, 150) SetTextOutline() SetTextCentre(1) SetTextProportional(1) SetTextDropShadow() SetTextCentre(true) BeginTextCommandDisplayText("STRING") AddTextComponentSubstringPlayerName(text) SetDrawOrigin(coords, 0) EndTextCommandDisplayText(0.0, 0.0) ClearDrawOrigin() end