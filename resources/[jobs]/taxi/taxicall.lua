--[[
################################################################
- Creator: Jyben
- Date: 30/04/2017
- Url: https://github.com/Jyben/emergency
- Licence: Apache 2.0
################################################################
--]]

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local lang = 'fr'

local txt = {
  ['fr'] = {
		['taxiIsComming'] = 'Un ~b~taxi~s~ est en route !',
		['callTaxi'] = 'Appuyez sur ~g~E~s~ pour appeler un taxi',
		['youCallTaxi'] = 'Vous avez appelé un ~b~taxi~s~'
  },

	['en'] = {
		['taxiIsComming'] = 'An ambulance arrives !',
		['callTaxi'] = 'Press ~g~E~s~ to call an ambulance.',
		['youCallTaxi'] = 'You called an ~b~ambulance~s~'
	}
}

local isDead = false
local isKO = false
local isRes = false
local emergencyComes = false


--[[
################################
            THREADS
################################
--]]

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    --NetworkResurrectLocalPlayer(357.757, -597.202, 28.6314, true, true, false)
    local playerPed = GetPlayerPed(-1)
    local playerID = PlayerId()
    local currentPos = GetEntityCoords(playerPed, true)
    local previousPos

    isDead = IsEntityDead(playerPed)

    if isKO and previousPos ~= currentPos then
      isKO = false
    end

    if (GetEntityHealth(playerPed) < 120 and not isDead and not isKO) then
      if (IsPedInMeleeCombat(playerPed)) then
        SetPlayerKO(playerID, playerPed)
      end
    end

    previousPos = currentPos
  end
end)

--[[
################################
            EVENTS
################################
--]]

AddEventHandler("playerSpawned", function(spawn)
    exports.spawnmanager:setAutoSpawn(false)
end)


RegisterNetEvent('taxi:cl_sendMessageToPlayerInComa')
AddEventHandler('taxi:cl_sendMessageToPlayerInComa',
	function()

		emergencyComes = true
		SendNotification(txt[lang]['taxiIsComming'])
	end
)

--[[
################################
        BUSINESS METHODS
################################
--]]


function SendNotification(message)
  SetNotificationTextEntry('STRING')
  AddTextComponentString(message)
  DrawNotification(false, false)
end

--[[
################################
        USEFUL METHODS
################################
--]]
