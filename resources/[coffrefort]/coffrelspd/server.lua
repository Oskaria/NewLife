require "resources/mysql-async/lib/MySQL"

function idJob(player)
	local player = player
   return MySQL.Sync.fetchScalar("SELECT job FROM users WHERE identifier=@identifier ",{['@identifier'] = player})
end

function updateCoffre(player, prixavant,prixtotal,prixajoute)
 return MySQL.Sync.fetchScalar("UPDATE coffre SET `solde`= @prixtotal , identifier = @identifier , lasttransfert = @prixajoute WHERE solde = @prixavant AND id = 1 ",{['@prixtotal'] = prixtotal, ['@identifier'] = player ,['@prixajoute'] = prixajoute,['@prixavant'] = prixavant })
end

function GetSolde()
	local solde = solde
 return MySQL.Sync.fetchScalar("SELECT solde FROM coffre WHERE id ='1'",{['@solde'] = solde})
end

RegisterServerEvent('coffrelspd:getsolde')
AddEventHandler('coffrelspd:getsolde',function()
TriggerEvent('es:getPlayerFromId', source, function(user)
	local player = user.identifier
	local idjob = idJob(player)
    if idjob == 10 and user.police >= 2 then
			local data = GetSolde()
			print(data)
			TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Coffre Fort", false, "Solde restant : "..data.."~g~$")
    else
			TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Attention", false, "~r~Vous n'avez pas la permisison !")
    end
end)
end)

RegisterServerEvent('coffrelspd:ajoutsolde')
AddEventHandler('coffrelspd:ajoutsolde',function(ajout)
TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local idjob = idJob(player)
 -- Here change id Job (allowed to withdraw/deposit )
    if idjob == 10 then
      local prixavant = GetSolde()
      local prixajoute = ajout
      local prixtotal = prixavant+prixajoute

      print(player)
      print(prixavant)
      print(prixajoute)
      print(prixtotal)

      if((user.dirtymoney - prixajoute)>=0)then
        user:removeDMoney((prixajoute))
        updateCoffre(player,prixavant,prixtotal,prixajoute)
        TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Accuse de reception", false, "Vous avez rajouter : "..prixajoute.." ~g~$")
      else
         TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Attention", false, "~r~Vous n'avez pas assez d'argent !")
      end
    else
      TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Attention", false, "~r~Vous n'avez pas la permisison !")
    end
end)
end)

RegisterServerEvent('coffrelspd:retirersolde')
AddEventHandler('coffrelspd:retirersolde',function(ajout)
TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local idjob = idJob(player)
 -- Here change id Job (allowed to withdraw/deposit )
    if idjob == 10 and user.police >= 4 then
      local prixavant = GetSolde()
      local prixenleve = ajout
      local prixtotal = prixavant-prixenleve

      print(player)
      print(prixavant)
      print(prixenleve)
      print(prixtotal)

      if(prixtotal<-1)then
        TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Attention", false, "~r~Coffre vide !")
      else
        updateCoffre(player,prixavant,prixtotal,prixenleve)
        user:addDMoney((prixenleve))
        TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Accuse de reception", false, "Vous avez enlever : "..prixenleve.." ~r~$")
      end
    else
      TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Attention", false, "~r~Vous n'avez pas la permisison !")
    end
end)
end)


--Createur Nelyo  :   https://github.com/ElNelyo/cop-coffre

--Modification  : Irtas Momaki / Walter White
