require "resources/[essential]/essentialmode/lib/MySQL"
MySQL:open("127.0.0.1", "gta5_gamemode_essential", "root", "force1")

local inServiceDeps = {}

function addDep(identifier)
	MySQL:executeQuery("INSERT INTO depanneur (`identifier`) VALUES ('@identifier')", { ['@identifier'] = identifier})
end

function remDep(identifier)
	MySQL:executeQuery("DELETE FROM depanneur WHERE identifier = '@identifier'", { ['@identifier'] = identifier})
end

function checkIsDep(identifier)
	local query = MySQL:executeQuery("SELECT * FROM depanneur WHERE identifier = '@identifier'", { ['@identifier'] = identifier})
	local result = MySQL:getResults(query, {'rank'}, "identifier")

	if(not result[1]) then
		TriggerClientEvent('depanneur:receiveIsDep', source, "inconnu")
	else
		TriggerClientEvent('depanneur:receiveIsDep', source, result[1].rank)
	end
end

function s_checkIsDep(identifier)
	local query = MySQL:executeQuery("SELECT * FROM depanneur WHERE identifier = '@identifier'", { ['@identifier'] = identifier})
	local result = MySQL:getResults(query, {'rank'}, "identifier")

	if(not result[1]) then
		return "nil"
	else
		return result[1].rank
	end
end

RegisterServerEvent('depanneur:sv_setService')
AddEventHandler('depanneur:sv_setService',
function(service)
  TriggerEvent('es:getPlayerFromId', source,
  function(user)
    user:setenService(2)
  end
)
end
)


AddEventHandler('playerDropped', function()
	if(inServiceDeps[source]) then
		inServiceDeps[source] = nil

		for i, c in pairs(inServiceDeps) do
			TriggerClientEvent("depanneur:resultAllDepsInService", i, inServiceDeps)
		end
	end
end)

AddEventHandler('es:playerDropped', function(player)
		local isDep = s_checkIsDep(player.identifier)
		if(isDep ~= "nil") then
			TriggerEvent("jobssystem:disconnectReset", player, 1)
		end
end)

RegisterServerEvent('depanneur:checkIsDep')
AddEventHandler('depanneur:checkIsDep', function()
	TriggerEvent("es:getPlayerFromId", source, function(user)
		local identifier = user.identifier
		checkIsDep(identifier)
	end)
end)

RegisterServerEvent('depanneur:takeService')
AddEventHandler('depanneur:takeService', function()

	if(not inServiceDeps[source]) then
		inServiceDeps[source] = GetPlayerName(source)

		for i, c in pairs(inServiceDeps) do
			TriggerClientEvent("depanneur:resultAllDepsInService", i, inServiceDeps)
		end
	end
end)

RegisterServerEvent('depanneur:breakService')
AddEventHandler('depanneur:breakService', function()

	if(inServiceDeps[source]) then
		inServiceDeps[source] = nil

		for i, c in pairs(inServiceDeps) do
			TriggerClientEvent("depanneur:resultAllDepsInService", i, inServiceDeps)
		end
	end
end)

RegisterServerEvent('depanneur:getAllDepsInService')
AddEventHandler('depanneur:getAllDepsInService', function()
	TriggerClientEvent("depanneur:resultAllDepsInService", source, inServiceDeps)
end)

-----------------------------------------------------------------------
----------------------EVENT SPAWN POLICE VEH---------------------------
-----------------------------------------------------------------------
RegisterServerEvent('CheckDepanneurVeh')
AddEventHandler('CheckDepanneurVeh', function(vehicle)
	TriggerEvent('es:getPlayerFromId', source, function(user)

			TriggerClientEvent('FinishDepanneurCheckForVeh',source)
			-- Spawn depanneur vehicle
			TriggerClientEvent('depanneurveh:spawnVehicle', source, vehicle)
	end)
end)

-----------------------------------------------------------------------
---------------------COMMANDE ADMIN AJOUT / SUPP COP-------------------
-----------------------------------------------------------------------
TriggerEvent('es:addGroupCommand', 'depadd', "admin", function(source, args, user) --COMMANDE QUI SERT A S'AJOUTER POUR ETRE DEPANNEUR
     if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Usage : /depadd [ID]")
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				addDep(target.identifier)
				TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Bien Recu !")
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "Government", false, "Hey, vous voila Depanneur !~w~.")
				TriggerClientEvent('depanneur:nowDep', player)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Pas de joueur trouvé avec cette ID !")
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Vous n'avez pas les permission pour ajouté ou Virer !")
end)

TriggerEvent('es:addGroupCommand', 'deprem', "admin", function(source, args, user) --COMMANDE QUI SERT A RETIRER POUR VIRER DES DEPANNEUR
     if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Usage : /deprem [ID]")
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				remDep(target.identifier)
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "Government", false, "Vous n'êtes plus Depanneur !~w~.")
				TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Bien Recu !")
				--TriggerClientEvent('chatMessage', player, 'GOVERNMENT', {255, 0, 0}, "You're no longer a dep !")
				TriggerClientEvent('depanneur:noLongerDep', player)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Pas de joueur trouvé avec cette ID !")
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Vous n'avez pas les permission pour ajouté ou Virer !")
end)
