--[[
################################################################
- Creator: Jyben
- Date: 02/05/2017
- Url: https://github.com/Jyben/emergency
- Licence: Apache 2.0
################################################################
--]]

require "resources/[essential]/essentialmode/lib/MySQL"

MySQL:open("127.0.0.1", "gta5_gamemode_essential", "root", "1202")

RegisterServerEvent('taxi:sendEmergency')
AddEventHandler('taxi:sendEmergency',
function(reason, playerIDInComa, x, y, z)
  TriggerEvent("es:getPlayers", function(players)
    for i,v in pairs(players) do
      TriggerClientEvent('taxi:sendEmergencyToDocs', i, reason, playerIDInComa, x, y, z, source)
    end
  end)
end
)

RegisterServerEvent('taxi:getTheCall')
AddEventHandler('taxi:getTheCall', function(playerName, playerID, x, y, z, sourcePlayerInComa)
  local fullname = playerName
  TriggerEvent('es:getPlayerFromId', source, function(user)
    fullname = user:getPrenom() .. " " .. user:getNom()
  end)
  TriggerEvent("es:getPlayers", function(players)
    for i,v in pairs(players) do
      TriggerClientEvent('taxi:callTaken', i, fullname, playerID, x, y, z, sourcePlayerInComa)
    end
  end)
end
)

RegisterServerEvent('taxi:sv_resurectPlayer')
AddEventHandler('taxi:sv_resurectPlayer',
function(sourcePlayerInComa)
  TriggerClientEvent('taxi:cl_resurectPlayer', sourcePlayerInComa)
end
)

RegisterServerEvent('taxi:sv_getJobId')
AddEventHandler('taxi:sv_getJobId', function()
TriggerEvent('es:getPlayerFromId', source, function(user)
  local jobid = user:getJob()
  TriggerClientEvent('taxi:cl_setJobId', source, jobid)
end)
end)

RegisterServerEvent('taxi:sv_getDocConnected')
AddEventHandler('taxi:sv_getDocConnected',
function()
  TriggerEvent("es:getPlayers", function(players)
    local identifier
    local table = {}
    local isConnected = false

    for i,v in pairs(players) do
      identifier = GetPlayerIdentifiers(i)
      if (identifier ~= nil) then
        local executed_query = MySQL:executeQuery("SELECT identifier, job_id, job_name FROM users LEFT JOIN jobs ON jobs.job_id = users.job WHERE users.identifier = '@identifier' AND job_id = 5", {['@identifier'] = identifier[1]})
        local result = MySQL:getResults(executed_query, {'job_id'}, "identifier")

        if (result[1] ~= nil) then
          isConnected = true
        end
      end
    end
    TriggerClientEvent('taxi:cl_getDocConnected', source, isConnected)
  end)
end
)

RegisterServerEvent('taxi:sv_setService')
AddEventHandler('taxi:sv_setService',
function(service)
  TriggerEvent('es:getPlayerFromId', source,
  function(user)
    user:setenService(2)
  end
)
end
)

RegisterServerEvent('taxi:sv_removeMoney')
AddEventHandler('taxi:sv_removeMoney',
function()
  TriggerEvent("es:getPlayerFromId", source,
  function(user)
    if(user)then
      if user.money > 0 then
        user:setMoney(0)
      end
      if user.dirty_money > 0 then
        user:setDirty_money(0)
      end
    end
  end
)
end
)

RegisterServerEvent('taxi:sv_sendMessageToPlayerInComa')
AddEventHandler('taxi:sv_sendMessageToPlayerInComa',
function(sourcePlayerInComa)
  TriggerClientEvent('taxi:cl_sendMessageToPlayerInComa', sourcePlayerInComa)
end
)

AddEventHandler('playerDropped', function()
  TriggerEvent('es:getPlayerFromId', source,
  function(user)
    local executed_query = MySQL:executeQuery("UPDATE users SET enService = 0 WHERE users.identifier = '@identifier'", {['@identifier'] = user.identifier})
  end
)
end)

TriggerEvent('es:addCommand', 'respawn', function(source, args, user)
  TriggerClientEvent('taxi:cl_respawn', source)
end)

function GetJobId(source)
  local jobId = -1

  TriggerEvent('es:getPlayerFromId', source,
  function(user)
    local executed_query = MySQL:executeQuery("SELECT identifier, job_id, job_name FROM users LEFT JOIN jobs ON jobs.job_id = users.job WHERE users.identifier = '@identifier' AND job_id IS NOT NULL", {['@identifier'] = user.identifier})
    local result = MySQL:getResults(executed_query, {'job_id'}, "identifier")

    if (result[1] ~= nil) then
      jobId = result[1].job_id
    end
  end
)

return jobId
end
