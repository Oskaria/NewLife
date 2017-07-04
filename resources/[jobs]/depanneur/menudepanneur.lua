--[[
#####################################################################################################
           - DEPANNEUR CREE LE 04/07/2017 BY SUPER.COOL.NINJA
		   - MERCI A N3TMV POUR SES FUNCTION ^^
		   - MERCI A Vodkhard POUR SONT SCRIPT POUR RECEVOIR LES APPEL
		   - MERCI A LA LIFE DE PARTAGER SES SCRIPTS OPEN SOURCE	
#####################################################################################################
--]]

local menudepanneur = {
	opened = false,
	title = "Menu Dépanneur",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 },
	menu = {
		x = 0.11,
		y = 0.25,
		width = 0.2,
		height = 0.04,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.4,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Animations", description = ""},
				{name = "Interaction", description = ""},
				{name = "Depanneuse", description = ""},
				{name = "Fermer", description = ""},
			}
		},
		["Animations"] = {
			title = "ANIMATIONS",
			name = "Animations",
			buttons = {
				{name = "Gerer le Traffic", description = ''},
				{name = "Prendre Notes", description = ''},
			}
		},
		["Interaction"] = {
			title = "VEHICLE INTERACTIONS",
			name = "Interaction",
			buttons = {
				{name = "Inspecter la voiture", description = ''},
				{name = "Reparer rapidement", description = ''},
				{name = "Reparer completement", description = ''},
				{name = "Crocheter le Vehicule", description = ''},
			}
		},
		["Depanneuse"] = {
			title = "Interaction Depanneuse",
			name = "Depanneuse",
			buttons = {
				{name = "Remorquer le Vehicule", description = ''},
			}
		},
	}
}
-------------------------------------------------
----------------CONFIG SELECTION----------------
-------------------------------------------------
function ButtonSelectedDepanneur(button)
	local ped = GetPlayerPed(-1)
	local this = menudepanneur.currentmenu
	local btn = button.name
	if this == "main" then
		if btn == "Animations" then
			OpenMenuDepanneur('Animations')
		elseif btn == "Interaction" then
			OpenMenuDepanneur('Interaction')
		elseif btn == "Depanneuse" then
			OpenMenuDepanneur('Depanneuse')
		elseif btn == "Fermer" then
			CloseMenuDepanneur()
		end
	elseif this == "Animations" then
		if btn == "Gerer le Traffic" then
			Circulation()
		elseif btn == "Prendre Notes" then
			Note()
		end
	elseif this == "Interaction" then
		if btn == "Inspecter la voiture" then
			getStatusVehicle()
		elseif btn == "Reparer rapidement" then
			repareVehicle()
		elseif btn == "Reparer completement" then
			fullRepairVehicle()
		elseif btn == "Crocheter le Vehicule" then
			unlockCar()	
		end
	elseif this == "Depanneuse" then
		if btn == "Remorquer le Vehicule" then
			Remorquer()
		end
	end
end

-------------------------------------------------
----------------FONCTION DEPANNEUR---------------
-------------------------------------------------

local function CustomVehicleDommage() --Function qui sert a definir Les degats pour les véhicules 
  local myPed = GetPlayerPed(-1)
  local vehicle = GetVehiclePedIsIn(myPed, 0)
  if vehicle ~= 0 then
    local engineHealth = GetVehicleEngineHealth(vehicle)
    local vehicleHealth = GetEntityHealth(vehicle)
    local petrolTankeHealth = GetVehiclePetrolTankHealth(vehicle)
    local total = engineHealth + vehicleHealth + petrolTankeHealth
    local bodyHealth = GetVehicleBodyHealth(vehicle)
    if total < 2800 and engineHealth >= 1 then
      if vehicleHealth + petrolTankeHealth < 1800 or vehicleHealth < 750 then
        SetVehicleEngineHealth(vehicle, -1.0)
        SetVehicleEngineOn(vehicle, 0, 0, 0)
        SetVehicleBodyHealth(vehicle, vehicleHealth * 0.1 )
      else
        SetVehicleEngineHealth(vehicle, 0.0)
        SetVehicleEngineOn(vehicle, 0, 0, 0)
      end
    end
  end
end


RegisterNetEvent('depann:tow') --Register qui sert a pouvoir Remorquer le Vehicule
AddEventHandler('depann:tow',function()

    local playerped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(playerped, true)
	
	local towmodel = GetHashKey('flatbed') -- FlatBed
	local isVehicleTow = IsVehicleModel(vehicle, towmodel)
			
	if isVehicleTow then
	
		local coordA = GetEntityCoords(playerped, 1)
		local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
		local targetVehicle = getVehicleInDirection(coordA, coordB)
		
		if currentlyTowedVehicle == nil then
			if targetVehicle ~= 0 then
				if not IsPedInAnyVehicle(playerped, true) then
					if vehicle ~= targetVehicle then
						AttachEntityToEntity(targetVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						currentlyTowedVehicle = targetVehicle
					drawNotification("~g~Véhicule attaché !") -- Vehicle attached
					else
						drawNotification("~r~Vous ne pouvez pas dépanner votre véhicule !") -- You can't attach your vehicle
					end
				end
			else
			drawNotification("~r~Trop loin du véhicule !") -- You are not near vehicle
			end
		else
			AttachEntityToEntity(currentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
			DetachEntity(currentlyTowedVehicle, true, true)
			currentlyTowedVehicle = nil
			drawNotification("~r~Véhicule déttaché !") -- Vehicle removed
		end
	end

end)

function Remorquer() --Function qui sert a pouvoir Executer le Register pour pouvoir remorquer le Vehicule
TriggerEvent('depann:tow')
end



function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

local function GetVehicleInDirection( coordFrom, coordTo )
  local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed( -1 ), 0 )
  local _, _, _, _, vehicle = GetRaycastResult( rayHandle )
  return vehicle
end

local function GetVehicleLookByPlayer(ped, dist)
  local playerPos = GetEntityCoords(ped, 1)
  local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, dist, 0.0 )
  return GetVehicleInDirection( playerPos, inFrontOfPlayer )
end



function getVehicleInDirection2(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

function getStatusVehicle() --Function qui sert a analysé le Véhicule

  local myPed = GetPlayerPed(-1)
  local vehicle = GetVehicleLookByPlayer(myPed, 3.0)
  local p = GetEntityCoords(vehicle, 0)
  local h = GetEntityHeading(vehicle)
  if vehicle ~= 0 then
    Citizen.CreateThread(function()
      TaskStartScenarioInPlace(myPed, 'PROP_HUMAN_BUM_SHOPPING_CART', 0, true)
      Citizen.Wait(8000)
      ClearPedTasks(myPed)
      local engineHealth = GetVehicleEngineHealth(vehicle)
      if engineHealth >= 950 then
        drawNotification('~g~Aucun probleme',8000)
      elseif engineHealth >= 0 then
        drawNotification('~o~Le véhicule est endommager, mais il est réparable sur place',8000)
      else
        drawNotification("~r~Véhicule HS, il doit etre rapatrié dans un garage pour réparation",8000)
      end
    end)
  else
    drawNotification("~r~Placer vous devant un véhicule", 8000)
  end
end

function repareVehicle() --Function qui sert a réparer rapidement le Véhicule
    local myPed = GetPlayerPed(-1)
    local vehicle = GetVehicleLookByPlayer(myPed, 3.0)
    if vehicle ~= 0 then 
        -- local capotOpen = GetVehicleDoorAngleRatio(vehicle, 4) > 0.5
        -- if not capotOpen then 
        --     showMessageInformation(TEXT.CapotFerme)
        -- else
            local scenario = 'WORLD_HUMAN_VEHICLE_MECHANIC'
            local pos = GetOffsetFromEntityInWorldCoords(myPed, 0.0, 0.02, 0.0)
            local h = GetEntityHeading(myPed)
            TaskStartScenarioAtPosition(myPed, scenario, pos.x, pos.y, pos.z, h + 180 , 8000, 1, 0)
            --TaskStartScenarioAtPosition(myPed, scenario,8000,1)
            Citizen.Wait(8000)
            ClearPedTasks(myPed)
            local vehicleHealth = GetEntityHealth(vehicle)
            if vehicleHealth >= 0 then
                SetVehicleEngineHealth(vehicle, 960.0)
                SetVehicleEngineOn(vehicle, 0, 0, 0)
                SetVehicleUndriveable(vehicle, false)
                SetVehicleEngineTorqueMultiplier(vehicle, 1.0)
                drawNotification("~g~Le véhicule a subit une réparation d'apoint", 5000)
            else
                drawNotification("~r~Le véhicule ne peut etre réparer sur place", 5000)
            end
        -- end
    else
         drawNotification("~r~Placer vous devant un véhicule", 5000)
    end
end


function fullRepairVehicle() --Function qui sert a réparer completement le véhicule

  local myPed = GetPlayerPed(-1)
  local myPos = GetEntityCoords(myPed)
  local vehicle = GetVehicleLookByPlayer(myPed, 3.0)
  if vehicle ~= 0 then
    Citizen.CreateThread(function()
      local scenario = 'WORLD_HUMAN_VEHICLE_MECHANIC'
      local pos = GetEntityCoords(myPed, 1)
      local h = GetEntityHeading(myPed)
      TaskStartScenarioAtPosition(myPed, scenario, pos.x, pos.y, pos.z, h-180, 0, 0, 1)
      local value = GetVehicleBodyHealth(vehicle)

      while( value < 999.9 ) do
        value = GetVehicleBodyHealth(vehicle)
        SetVehicleBodyHealth(vehicle, value + 1.0)
        drawNotification('Réparation en cours ~b~' .. math.floor(value) .. '/1000', 125)
        Citizen.Wait(125)
      end

      Citizen.Wait(250)
      ClearPedTasks(myPed)
      SetVehicleBodyHealth(vehicle, 1000.0)
      SetVehicleEngineHealth(vehicle, 1000.0)
      SetEntityHealth(vehicle,1000)
      SetVehiclePetrolTankHealth(vehicle,1000.0)
      SetVehicleEngineOn(vehicle, 0, 0, 0)
      SetVehicleBodyHealth(vehicle, 1000.0)
      SetVehicleFixed(vehicle)
      SetVehicleDeformationFixed(vehicle)
      SetVehicleUndriveable(vehicle, false)
      drawNotification('~g~Le véhicule est comme neuf', 5000)
    end)
  else
    drawNotification("~r~Placer vous devant un véhicule", 5000)
  end
end

function unlockCar() --Function qui sert a crocheter le véhicule
  local myPed = GetPlayerPed(-1)
  local vehicle = GetVehicleLookByPlayer(myPed, 3.0)
  if vehicle ~= 0 then
    Citizen.CreateThread(function()
    	TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_WELDING", 0, true)
    	Citizen.Wait(20000)
      SetVehicleDoorsLocked(vehicle, 1)
    	ClearPedTasksImmediately(GetPlayerPed(-1))
    	drawNotification("Le vehicule est maintenant ~g~ouvert~w~.")
  	end)
  end
end

-------------------------------------------------
----------------FONCTION ANIMATIONS---------------
-------------------------------------------------
function Circulation() --Function qui sert a faire la circulation comme animation
	Citizen.CreateThread(function()
        TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_CAR_PARK_ATTENDANT", 0, false)
        Citizen.Wait(60000)
        ClearPedTasksImmediately(GetPlayerPed(-1))
    end)
	drawNotification("~g~Vous faire de la Circulation.")
end

function Note() --Function qui sert a prendre Note
	Citizen.CreateThread(function()
        TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_CLIPBOARD", 0, false)
        Citizen.Wait(20000)
        ClearPedTasksImmediately(GetPlayerPed(-1))
    end)
	drawNotification("~g~Je Note tous.")
end

-------------------------------------------------
----------------CONFIG OPEN MENU-----------------
-------------------------------------------------
function OpenMenuDepanneur(menu) 
	menudepanneur.lastmenu = menudepanneur.currentmenu
	if menu == "Animations" then
		menudepanneur.lastmenu = "main"
	elseif menu == "Interaction" then
		menudepanneur.lastmenu = "main"
	elseif menu == "Depanneuse" then
		menudepanneur.lastmenu = "main"
	end
	menudepanneur.menu.from = 1
	menudepanneur.menu.to = 10
	menudepanneur.selectedbutton = 0
	menudepanneur.currentmenu = menu
end


-------------------------------------------------
------------------FUNCTION DEPANNEUR--------------------
-------------------------------------------------

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    CustomVehicleDommage()
  end
end)

-------------------------------------------------
------------------DRAW NOTIFY--------------------
-------------------------------------------------
function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end
--------------------------------------
-------------DISPLAY HELP TEXT--------
--------------------------------------
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
-------------------------------------------------
------------------DRAW TITLE MENU----------------
-------------------------------------------------
function drawMenuTitle(txt,x,y)
local menu = menudepanneur.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.5, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end
-------------------------------------------------
------------------DRAW MENU BOUTON---------------
-------------------------------------------------
function drawMenuButton(button,x,y,selected)
	local menu = menudepanneur.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end
-------------------------------------------------
------------------DRAW MENU INFO-----------------
-------------------------------------------------
function drawMenuInfo(text)
	local menu = menudepanneur.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.45, 0.45)
	SetTextColour(255, 255, 255, 255)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawRect(0.675, 0.95,0.65,0.050,0,0,0,150)
	DrawText(0.365, 0.934)
end
-------------------------------------------------
----------------DRAW MENU DROIT------------------
-------------------------------------------------
function drawMenuRight(txt,x,y,selected)
	local menu = menudepanneur.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	--SetTextRightJustify(1)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 - 0.03, y - menu.height/2 + 0.0028)
end
-------------------------------------------------
-------------------DRAW TEXT---------------------
-------------------------------------------------
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
-------------------------------------------------
----------------CONFIG BACK MENU-----------------
-------------------------------------------------
function BackMenuDepanneur()
	if backlock then
		return
	end
	backlock = true
	if menudepanneur.currentmenu == "main" then
		CloseMenuDepanneur()
	elseif menudepanneur.currentmenu == "Animations" or menudepanneur.currentmenu == "Interaction" or menudepanneur.currentmenu == "Depanneuse" then
		OpenMenuDepanneur(menudepanneur.lastmenu)
	else
		OpenMenuDepanneur(menudepanneur.lastmenu)
	end
end
-------------------------------------------------
---------------------FONCTION--------------------
-------------------------------------------------
function f(n)
return n + 0.0001
end

function LocalPed()
return GetPlayerPed(-1)
end

function try(f, catch_f)
local status, exception = pcall(f)
if not status then
catch_f(exception)
end
end
function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end

function stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end
-------------------------------------------------
----------------FONCTION OPEN--------------------
-------------------------------------------------
function OpenDepanneurMenu()
	menudepanneur.currentmenu = "main"
	menudepanneur.opened = true
	menudepanneur.selectedbutton = 0
end
-------------------------------------------------
----------------FONCTION CLOSE-------------------
-------------------------------------------------
function CloseMenuDepanneur()
		menudepanneur.opened = false
		menudepanneur.menu.from = 1
		menudepanneur.menu.to = 10
end
-------------------------------------------------
----------------FONCTION OPEN MENU---------------
-------------------------------------------------
local backlock = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1,166) and menudepanneur.opened == true then -- Touche pour ouvrir le Menu Depanneur
				CloseMenuDepanneur()
		end
		if menudepanneur.opened then
			local ped = LocalPed()
			local menu = menudepanneur.menu[menudepanneur.currentmenu]
			drawTxt(menudepanneur.title,1,1,menudepanneur.menu.x,menudepanneur.menu.y,1.0, 255,255,255,255)
			drawMenuTitle(menu.title, menudepanneur.menu.x,menudepanneur.menu.y + 0.08)
			drawTxt(menudepanneur.selectedbutton.."/"..tablelength(menu.buttons),0,0,menudepanneur.menu.x + menudepanneur.menu.width/2 - 0.0385,menudepanneur.menu.y + 0.067,0.4, 255,255,255,255)
			local y = menudepanneur.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false

			for i,button in pairs(menu.buttons) do
				if i >= menudepanneur.menu.from and i <= menudepanneur.menu.to then

					if i == menudepanneur.selectedbutton then
						selected = true
					else
						selected = false
					end
					drawMenuButton(button,menudepanneur.menu.x,y,selected)
					if button.distance ~= nil then
						drawMenuRight(button.distance.."m",menudepanneur.menu.x,y,selected)
					end
					y = y + 0.04
					if selected and IsControlJustPressed(1,201) then
						ButtonSelectedDepanneur(button)
					end
				end
			end
		end
		if menudepanneur.opened then
			if IsControlJustPressed(1,202) then
				BackMenuDepanneur()
			end
			if IsControlJustReleased(1,202) then
				backlock = false
			end
			if IsControlJustPressed(1,188) then
				if menudepanneur.selectedbutton > 1 then
					menudepanneur.selectedbutton = menudepanneur.selectedbutton -1
					if buttoncount > 10 and menudepanneur.selectedbutton < menudepanneur.menu.from then
						menudepanneur.menu.from = menudepanneur.menu.from -1
						menudepanneur.menu.to = menudepanneur.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				if menudepanneur.selectedbutton < buttoncount then
					menudepanneur.selectedbutton = menudepanneur.selectedbutton +1
					if buttoncount > 10 and menudepanneur.selectedbutton > menudepanneur.menu.to then
						menudepanneur.menu.to = menudepanneur.menu.to + 1
						menudepanneur.menu.from = menudepanneur.menu.from + 1
					end
				end
			end
		end

	end
end)
