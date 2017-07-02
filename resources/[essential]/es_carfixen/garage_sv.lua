RegisterServerEvent('garage:askmoney')
AddEventHandler('garage:askmoney', function(total)
  	print("Player ID " ..source)

	-- Get the players money amount
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (tonumber(user.money) >= tonumber(total)) then
			TriggerClientEvent('garage:FixingCar',source)
	  	-- update player money amount
			user:removeMoney((total + 0.0))
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Secte Banque", false, "Vous avez paye ".. tonumber(total).." ~g~$ de reparation")
		else
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Garage", false, "Vous n'avez pas assez d'argent pour cela!\n")
		end
 	end)
end)