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

PulseList = {}

---------------------------------------
-- Events - Don't Touch (Use Config) --
---------------------------------------

RegisterNetEvent('GetPedPulse-S')
AddEventHandler('GetPedPulse-S', function (ID)
	local pulse = PulseList[ID]
    if pulse ~= nil then
	TriggerClientEvent('GetPedPulse-C', source, pulse)
    else
        if GetEntityHealth(GetPlayerPed(ID)) >= 175 then
            TriggerClientEvent('GetPedPulse-C', source, math.random(60, 100))
        elseif GetEntityHealth(GetPlayerPed(ID)) >= 125 and GetEntityHealth(GetPlayerPed(ID)) < 175 then
            TriggerClientEvent('GetPedPulse-C', source, math.random(120, 140))
        elseif GetEntityHealth(GetPlayerPed(ID)) >= 75 and GetEntityHealth(GetPlayerPed(ID)) < 125 then
            TriggerClientEvent('GetPedPulse-C', source, math.random(40, 60))
        elseif GetEntityHealth(GetPlayerPed(ID)) >= 2 and GetEntityHealth(GetPlayerPed(ID)) < 75 then
            TriggerClientEvent('GetPedPulse-C', source, math.random(25, 50))
        elseif GetEntityHealth(GetPlayerPed(ID)) == 1 then
            TriggerClientEvent('GetPedPulse-C', source, 0)
        end
    end
end)

RegisterServerEvent('PulseSet-S')
AddEventHandler('PulseSet-S', function(pulse)
	PulseList[source] = pulse
end)

RegisterNetEvent('IsMofoDead')
AddEventHandler('IsMofoDead', function(player)
    if GetEntityHealth(GetPlayerPed(player)) == 1 then
        return true
    else
        return false
    end
end)