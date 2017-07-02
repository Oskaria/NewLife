
--[[
#####################################################################################################
           - TAXI UPDATE LE 28/06/2017 BY SUPER.COOL.NINJA
		   - MERCI A LOKO POUR SA COOPÉRATION
		   - MERCI A Jyben POUR SONDE CODE EMERGENCY
		   - MERCI A Vodkhard POUR SONT SCRIPT POUR RECEVOIR LES APPEL
		   - MERCI A LA LIFE DE PARTAGER SES SCRIPTS OPEN SOURCE	
#####################################################################################################
--]]

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

Citizen.CreateThread(
	function()
		local x = 906.204
		local y = -174.885
		local z = 74.084

		while true do
			Citizen.Wait(1)

			local playerPos = GetEntityCoords(GetPlayerPed(-1), true)

			if (Vdist(playerPos.x, playerPos.y, playerPos.z, x, y, z) < 100.0) then
				-- Service
				DrawMarker(1, x, y, z - 1, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 1.5001, 255, 165, 0,165, 0, 0, 0,0)

				if (Vdist(playerPos.x, playerPos.y, playerPos.z, x, y, z) < 2.0) then
					if isInService then
						DisplayHelpText(txt[lang]['dropService'])
					else
						DisplayHelpText(txt[lang]['getService'])
					end

					if (IsControlJustReleased(1, 51)) then
						TriggerServerEvent('taxi:sv_getJobId')
						 TriggerServerEvent("player:serviceOn", "taxi")
					end
				end
			end
		end
end)


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
		['getService'] = 'Appuyez sur ~g~E~s~ pour prendre votre service',
		['dropService'] = 'Appuyez sur ~g~E~s~ pour terminer votre service',
		['getAmbulance'] = 'Appuyez sur ~g~E~s~ pour obtenir votre Taxi',
		['RangerTaxi'] = 'Appuyez sur ~g~E~s~ pour ranger votre Taxi',
		['callTaken'] = 'L\'appel a été pris par ~b~',
		['emergency'] = '<b>~r~URGENCE~s~ <br><br>~b~Raison~s~: </b>',
		['takeCall'] = '<b>Appuyez sur ~g~Y~s~ pour prendre l\'appel</b>',
		['callExpires'] = '<b>~r~URGENCE~s~ <br><br>Attention, l\'appel précèdent a expiré !</b>',
		['gps'] = 'Un point a été placé sur votre GPS là où se trouve la victime en détresse',
		['notDoc'] = 'Vous n\'êtes pas taxi',
		['stopService'] = 'Vous n\'êtes plus en service',
		['startService'] = 'Début du service'
  },

	['en'] = {
		['getService'] = 'Press ~g~E~s~ to take your service',
		['dropService'] = 'Press ~g~E~s~ to stop your service',
		['getAmbulance'] = 'Press ~g~E~s~ to get your car',
		['callTaken'] = 'The call is taken by ~b~',
		['emergency'] = '<b>~r~EMERGENCY~s~ <br><br>~b~Reason~s~: </b>',
		['takeCall'] = '<b>Press ~g~Y~s~ to take the call</b>',
		['callExpires'] = '<b>~r~EMERGENCY~s~ <br><br>Warning, the previous call has expired</b>',
		['gps'] = 'A point has been placed on your GPS where the victim is in distress',
		['notDoc'] = 'Your are not a doctor',
		['stopService'] = 'You are no longer in service',
		['startService'] = 'Start of service'
	}
}

local isInService = false
local jobId = -1
local notificationInProgress = false
local playerInComaIsADoc = false
local existingVeh = nil

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(
	function()
		local x = 906.204
		local y = -174.885
		local z = 74.084

		while true do
			Citizen.Wait(1)

			local playerPos = GetEntityCoords(GetPlayerPed(-1), true)

			if (Vdist(playerPos.x, playerPos.y, playerPos.z, x, y, z) < 100.0) then
				-- Service
				DrawMarker(1, x, y, z - 1, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 1.5001, 255, 165, 0,165, 0, 0, 0,0)

				if (Vdist(playerPos.x, playerPos.y, playerPos.z, x, y, z) < 2.0) then
					if isInService then
						DisplayHelpText(txt[lang]['dropService'])
					else
						DisplayHelpText(txt[lang]['getService'])
					end

					if (IsControlJustReleased(1, 51)) then
						TriggerServerEvent('taxi:sv_getJobId')
					end
				end
			end
		end
end)

RegisterNetEvent('taxi:sendEmergencyToDocs')
AddEventHandler('taxi:sendEmergencyToDocs',
	function(reason, playerIDInComa, x, y, z, sourcePlayerInComa)
		local playerServerId = GetPlayerServerId(PlayerId())

		if playerIDInComa == playerServerId then playerInComaIsADoc = true else playerInComaIsADoc = false end

		Citizen.CreateThread(
			function()
				if isInService and jobId == 5 and not playerInComaIsADoc then
					local controlPressed = false

					while notificationInProgress do
						Citizen.Wait(0)
					end

					local notifReceivedAt = GetGameTimer()

					SendNotification(txt[lang]['emergency'] .. reason)
					SendNotification(txt[lang]['takeCall'])

					while not controlPressed do
						Citizen.Wait(0)
						notificationInProgress = true

						if (GetTimeDifference(GetGameTimer(), notifReceivedAt) > 15000) then
							notificationInProgress = false
							controlPressed = true
							SendNotification(txt[lang]['callExpires'])
						end

						if IsControlPressed(1, Keys["Y"]) then
							controlPressed = true
							TriggerServerEvent('taxi:getTheCall', GetPlayerName(PlayerId()), playerServerId, x, y, z, sourcePlayerInComa)
						end

						if controlPressed then
							notificationInProgress = false
						end
					end
				end
			end
		)
	end
)

local stationGarage = {
	{x=431.436, y= - 996.786, z=25.1887}
}

function getIsInService()
	return isInService
end

--[[
#####################################################################################################
            Function UPDATE TAXI QUI SERT A INDIQUE LA POSITION DU GARAGE POUR RANGER LE VEHICULE
#####################################################################################################
--]]

function isNearStationGarage()
	for i = 1, #stationGarage do
		local ply = GetPlayerPed(-1)
		local plyCoords = GetEntityCoords(ply, 0)
		local distance = GetDistanceBetweenCoords(stationGarage[i].x, stationGarage[i].y, stationGarage[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
		if(distance < 30) then
			DrawMarker(1, stationGarage[i].x, stationGarage[i].y, stationGarage[i].z-1, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.5, 0, 0, 255, 155, 0, 0, 2, 0, 0, 0, 0)
		end
		if(distance < 2) then
			return true
		end
	end
end


--[[
##########################################
            Function TAXI VEHICULE
##########################################
--]]


Citizen.CreateThread(
	function()
		local x = 915.989
		local y = -162.973
		local z = 74.6949

		while true do
			Citizen.Wait(1)

			local playerPos = GetEntityCoords(GetPlayerPed(-1), true)

			if (Vdist(playerPos.x, playerPos.y, playerPos.z, x, y, z) < 10.0) and isInService and jobId == 5 then
				-- Service car
				DrawMarker(1, x, y, z - 1, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 1.5001, 255, 165, 0,165, 0, 0, 0,0) --Marker Pour sortir le véhicule ou ranger.
				
			if(isInService) then
			if(isNearStationGarage()) then
					if(existingVeh ~= nil) then
					end
				end
			end
				if (Vdist(playerPos.x, playerPos.y, playerPos.z, x, y, z) < 2.0) then
					DisplayHelpText('Appuyer sur ~INPUT_CONTEXT~ pour ranger ~b~votre véhicule',0,1,0.5,0.8,0.6,155,255,255,255) 
				else
					DisplayHelpText('Appuyer sur ~INPUT_CONTEXT~ pour sortir votre ~b~véhicule',0,1,0.5,0.8,0.6,255,255,255,255)
				end
					if (IsControlJustReleased(1, 51)) then
					if(existingVeh ~= nil) then
						SetEntityAsMissionEntity(existingVeh, true, true)
						Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
						existingVeh = nil
					else
						local car = GetHashKey("taxi") -- Sert a faire spawn le Vehicule au Choix Taxi
						local ply = GetPlayerPed(-1)
						local plyCoords = GetEntityCoords(ply, 0)
							
						RequestModel(car)
						while not HasModelLoaded(car) do
								Citizen.Wait(0)
						end
							
						existingVeh = CreateVehicle(car, plyCoords["x"], plyCoords["y"], plyCoords["z"], 90.0, true, false)
						local id = NetworkGetNetworkIdFromEntity(existingVeh)
						SetNetworkIdCanMigrate(id, true)
						TaskWarpPedIntoVehicle(ply, existingVeh, -1)
					end
				end
			end
	end
end)

--[[
################################
            EVENTS
################################
--]]

local working

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(1)

        if jobId == 5 then
            if not working then
                TriggerServerEvent("player:serviceOff", "taxi") --Sert a faire fonctionner Vdk Call
            else
                TriggerServerEvent("player:serviceOn", "taxi") --Sert a faire fonctionner Vdk Call
            end
            working = not working
        end
    end
end)

RegisterNetEvent('taxi:callTaken')
AddEventHandler('taxi:callTaken',
	function(playerName, playerID, x, y, z, sourcePlayerInComa)
		local playerServerId = GetPlayerServerId(PlayerId())

		if isInService and jobId == 5 and not playerInComaIsADoc then
			SendNotification(txt[lang]['callTaken'] .. playerName .. '~s~')
		end

		if playerServerId == playerID then
			TriggerServerEvent('taxi:sv_sendMessageToPlayerInComa', sourcePlayerInComa)
			StartEmergency(x, y, z, sourcePlayerInComa)
		end
end)

RegisterNetEvent('taxi:cl_setJobId')
AddEventHandler('taxi:cl_setJobId',
	function(p_jobId)
		jobId = p_jobId
		GetService()
	end
)

--[[
################################################################
       FUNCTION ID JOBS TAXI JOB ID DU TAXI = jobId = 5
################################################################
--]]


function GetService() --Récupère l'id du Jobs
	local playerPed = GetPlayerPed(-1)

	if jobId ~= 5 then
	SendNotification(txt[lang]['notDoc'])
	isInService = false
		return
	end

	if isInService then
		SendNotification(txt[lang]['stopService'])
		TriggerServerEvent("vmenu:lastChar")
		TriggerServerEvent('taxi:sv_setService', 0)
		TriggerServerEvent("jobssystem:jobs", 1) -- Sert a ne plus recevoir D'appel en fin de service
	else
		SendNotification(txt[lang]['startService'])
		TriggerServerEvent('taxi:sv_setService', 1)
	end

	isInService = not isInService

	if GetEntityModel(GetPlayerPed(-1)) == 1885233650 then -- Tenue Homme
	SetPedComponentVariation(GetPlayerPed(-1), 11, 82, 5, 0)
    SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 0)
    SetPedComponentVariation(GetPlayerPed(-1), 4, 7, 4, 0)
    SetPedComponentVariation(GetPlayerPed(-1), 6, 1, 3, 0)
	end
	
	if GetEntityModel(GetPlayerPed(-1)) == -1667301416 then --Tenue Femme --Merci A loKo pour ce bout de code ^^
	SetPedComponentVariation(GetPlayerPed(-1), 11, 2, 2, 0) --haut
    SetPedComponentVariation(GetPlayerPed(-1), 3, 29, 0, 0) --gants
    SetPedComponentVariation(GetPlayerPed(-1), 4, 4, 5, 0) -- pant
    SetPedComponentVariation(GetPlayerPed(-1), 6, 31, 0, 0) -- chaussure
	SetPedPropIndex(GetPlayerPed(-1), 1, 7, 0, 2)--Lunette
	end
end

--[[
################################
        USEFUL METHODS
################################
--]]

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function SendNotification(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(false, false)
end

function GetClosestPlayer()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)

	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
			if(closestDistance == -1 or closestDistance > distance) then
				closestPlayer = value
				closestDistance = distance
			end
		end
	end

	return closestPlayer, closestDistance
end

function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end
