--[[
#####################################################################################################
           - DEPANNEUR CREE LE 04/07/2017 BY SUPER.COOL.NINJA
		   - MERCI A N3TMV POUR SES FUNCTION ^^
		   - MERCI A Vodkhard POUR SONT SCRIPT POUR RECEVOIR LES APPEL
		   - MERCI A LA LIFE DE PARTAGER SES SCRIPTS OPEN SOURCE	
#####################################################################################################
--]]


local isDep = false
local isInService = false
local rank = "inconnu"
local checkpoints = {}
local existingVeh = nil
local handCuffed = false
local isAlreadyDead = false
local allServiceDeps = {}
local blipsDeps = {}

local takingService = {
  --{x=850.156677246094, y=-1283.92004394531, z=28.0047378540039},
  {x=473.072845458984, y=-1309.66833496094, z=29.2292041778564}
  --{x=1856.91320800781, y=3689.50073242188, z=34.2670783996582},
  --{x=-450.063201904297, y=6016.5751953125, z=31.7163734436035}
}

local stationGarage = {
	{x=490.509521484375, y=-1332.66052246094, z=29.3340606689453}
}

AddEventHandler("playerSpawned", function()
	TriggerServerEvent("depanneur:checkIsDep")
end)

RegisterNetEvent('depanneur:receiveIsDep')
AddEventHandler('depanneur:receiveIsDep', function(result)
	if(result == "inconnu") then
		isDep = false
	else
		isDep = true
		rank = result
	end
end)

RegisterNetEvent('depanneur:nowDep')
AddEventHandler('depanneur:nowDep', function()
	isDep = true
end)

RegisterNetEvent('depanneur:noLongerDep')
AddEventHandler('depanneur:noLongerDep', function()
	isDep = false
	isInService = false

	local playerPed = GetPlayerPed(-1)

	TriggerServerEvent("skin_customization:SpawnPlayer")
	RemoveAllPedWeapons(playerPed)

	if(existingVeh ~= nil) then
		SetEntityAsMissionEntity(existingVeh, true, true)
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
		existingVeh = nil
	end

	ServiceOff()
end)

RegisterNetEvent('depanneur:resultAllDepsInService')
AddEventHandler('depanneur:resultAllDepsInService', function(array)
	allServiceDeps = array
	enableDepBlips()
end)

function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
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

function getIsInService()
	return isInService
end

function isNearTakeService()
	for i = 1, #takingService do
		local ply = GetPlayerPed(-1)
		local plyCoords = GetEntityCoords(ply, 0)
		local distance = GetDistanceBetweenCoords(takingService[i].x, takingService[i].y, takingService[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
		if(distance < 30) then
			DrawMarker(1, takingService[i].x, takingService[i].y, takingService[i].z-1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 155, 255, 200, 0, 0, 2, 0, 0, 0, 0)
		end
		if(distance < 2) then
			return true
		end
	end
end

function isNearStationGarage()
	for i = 1, #stationGarage do
		local ply = GetPlayerPed(-1)
		local plyCoords = GetEntityCoords(ply, 0)
		local distance = GetDistanceBetweenCoords(stationGarage[i].x, stationGarage[i].y, stationGarage[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
		if(distance < 30) then
			DrawMarker(1, stationGarage[i].x, stationGarage[i].y, stationGarage[i].z-1, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 0, 155, 255, 200, 0, 0, 2, 0, 0, 0, 0)
		end
		if(distance < 2) then
			return true
		end
	end
end

function ServiceOn()
	isInService = true
	
    TriggerServerEvent("player:serviceOn", "Depanneur") --Sert a pouvoir faire fonctionner les appel depanneur
	TriggerServerEvent("jobssystem:jobs", 13)
	TriggerServerEvent("depanneur:takeService")
end

function ServiceOff()
	isInService = false
	TriggerServerEvent("jobssystem:jobs", 1)
	TriggerServerEvent("depanneur:breakService")
	TriggerServerEvent("player:serviceOff", "Depanneur") --Sert a pouvoir ne plus recevoir d'appel en fin de service

	allServiceDeps = {}

	for k, existingBlip in pairs(blipsDeps) do
        RemoveBlip(existingBlip)
    end
	blipsDeps = {}
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if(isDep) then
			if(isNearTakeService()) then

				DisplayHelpText('Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le vestiaire ~b~depanneur',0,1,0.5,0.8,0.6,255,255,255,255) -- ~g~E~s~
				if IsControlJustPressed(1,51) then
					OpenMenuVest()
				end
			end
			if(isInService) then
				if IsControlJustPressed(1,166) then
					OpenDepanneurMenu()
				end
			end

			if(isInService) then
				if(isNearStationGarage()) then
					if(depanneurvehicle ~= nil) then --existingVeh
						DisplayHelpText('Appuyer sur ~INPUT_CONTEXT~ pour ranger ~b~votre véhicule',0,1,0.5,0.8,0.6,255,255,255,255)
					else
						DisplayHelpText('Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le garage ~b~depanneur',0,1,0.5,0.8,0.6,255,255,255,255)
					end

					if IsControlJustPressed(1,51) then
						if(depanneurvehicle ~= nil) then
							SetEntityAsMissionEntity(depanneurvehicle, true, true)
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(depanneurvehicle))
							depanneurvehicle = nil
						else
							OpenVeh()
						end
					end
				end


			end
		else
			if (handCuffed == true) then
			  RequestAnimDict('mp_arresting')

			  while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(0)
			  end

			  local myPed = PlayerPedId()
			  local animation = 'idle'
			  local flags = 16

			  TaskPlayAnim(myPed, 'mp_arresting', animation, 8.0, -8, -1, flags, 0, 0, 0, 0)
			end
		end
    end
end)
---------------------------------------------------------------------------------------
-------------------------------SPAWN HELI AND CHECK DEATH------------------------------
---------------------------------------------------------------------------------------
local alreadyDead = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if(isDep) then
			if(isInService) then

				if(IsPlayerDead(PlayerId())) then
					if(alreadyDead == false) then
						ServiceOff()
						alreadyDead = true
					end
				else
					alreadyDead = false
				end

				DrawMarker(1,0,0,0,0,0,0,0,0,0,2.0,2.0,2.0,0,155,255,200,0,0,0,0)

				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 0,0,0, true ) < 5 then
					if(existingVeh ~= nil) then
						DisplayHelpText('Press ~INPUT_CONTEXT~ to store ~b~your ~b~helidepter',0,1,0.5,0.8,0.6,255,255,255,255)
					else
						DisplayHelpText('Press ~INPUT_CONTEXT~ to drive an helidepter out',0,1,0.5,0.8,0.6,255,255,255,255)
					end

					if IsControlJustPressed(1,51)  then
						if(existingVeh ~= nil) then
							SetEntityAsMissionEntity(existingVeh, true, true)
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
							existingVeh = nil
						else
							local car = GetHashKey("polmav")
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
		end
    end
end)
