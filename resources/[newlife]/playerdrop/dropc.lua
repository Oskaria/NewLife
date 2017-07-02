RegisterNetEvent("dropweapon")
AddEventHandler('dropweapon', function()
	local ped = GetPlayerPed(-1)
	if DoesEntityExist(ped) and not IsEntityDead(ped) then
		SetPedDropsWeapon(ped)
		ShowNotification("~r~You have dropped your weapon.")
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 82) then
          TriggerEvent("dropweapon", p)
        end
    end
end)

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end
