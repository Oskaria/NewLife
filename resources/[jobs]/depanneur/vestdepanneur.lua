-----------------------------------------------------------------------------------------------------------------
----------------------------------------------------MENU DEPANNEUR BY SUPER.COOL.NINJA---------------------------------------------
-----------------------------------------------------------------------------------------------------------------
local vestdepanneur = {
	opened = false,
	title = "Vestiaire de Depanneur",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 }, -- ???
	menu = {
		x = 0.11,
		y = 0.25,
		width = 0.2,
		height = 0.04,
		buttons = 10,  --Nombre de bouton
		from = 1,
		to = 10,
		scale = 0.4,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Prendre son Service", description = ""},
				{name = "Quitter son Service", description = ""},
			}
		},
	}
}

local hashSkin = GetHashKey("mp_m_freemode_01")
-------------------------------------------------
----------------CONFIG SELECTION----------------
-------------------------------------------------
function ButtonSelectedVest(button)
	local ped = GetPlayerPed(-1)
	local this = vestdepanneur.currentmenu
	local btn = button.name
	if this == "main" then
		if btn == "Prendre son Service" then
			ServiceOn()    --NE PAS TOUCHER !!                                           
			giveUniforme() --Function qui ajoute La tenue Depanneur    
			drawNotification("Vous êtes maintenant en service")
			drawNotification("Appuyer sur ~g~F5~w~ pour ouvrir le menu de ~b~depanneur")
		elseif btn == "Quitter son Service" then
			ServiceOff() --NE PAS TOUCHER !!       
			removeUniforme()   --Function qui retire La tenue Depanneur                                        
			drawNotification("Vous avez fini votre service")
		end
	end
end
-------------------------------------------------
------------------Function Tenue Depanneur--------------
-------------------------------------------------
function giveUniforme() --Tenue Depanneur
	Citizen.CreateThread(function()

		local myPed = GetPlayerPed(-1) 
        SetPedComponentVariation(myPed, 3, 11, 0, 2) -- Torse
        SetPedComponentVariation(myPed, 11, 43, 0, 2) -- Torse 2
        SetPedComponentVariation(myPed, 4, 41, 0, 2) -- Jambe
        SetPedComponentVariation(myPed, 6, 25, 0, 2) -- Chaussure
        SetPedComponentVariation(myPed, 8, 15, 0, 2) -- ACCESSORIE
		
		GiveWeaponToPed(myPed, 'WEAPON_PETROLCAN', 0, 0, 0)
	end)
end

function removeUniforme()  --a Changer selon le mods que vous Utiliser Comme Skin
	Citizen.CreateThread(function()
		--TriggerServerEvent("skin_customization:SpawnPlayer")
		TriggerServerEvent("vmenu:lastChar") -- Code pour la life Sert a reprendre sa tenue de Base
		RemoveAllPedWeapons(GetPlayerPed(-1))
	end)
end
-------------------------------------------------
----------------CONFIG OPEN MENU-----------------
-------------------------------------------------
function OpenVestMenu(menu)
	vestdepanneur.menu.from = 1
	vestdepanneur.menu.to = 10
	vestdepanneur.selectedbutton = 0
	vestdepanneur.currentmenu = menu
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end


function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


function drawMenuTitle(txt,x,y)
local menu = vestdepanneur.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.5, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end


function drawMenuButton(button,x,y,selected)
	local menu = vestdepanneur.menu
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


function drawMenuInfo(text)
	local menu = vestdepanneur.menu
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


function drawMenuRight(txt,x,y,selected)
	local menu = vestdepanneur.menu
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


function BackVest()
	if backlock then
		return
	end
	backlock = true
	if vestdepanneur.currentmenu == "main" then
		CloseMenuVest()
	end
end

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
function OpenMenuVest()
	vestdepanneur.currentmenu = "main"
	vestdepanneur.opened = true
	vestdepanneur.selectedbutton = 0
end
-------------------------------------------------
----------------FONCTION CLOSE-------------------
-------------------------------------------------
function CloseMenuVest()
		vestdepanneur.opened = false
		vestdepanneur.menu.from = 1
		vestdepanneur.menu.to = 10
end
-------------------------------------------------
----------------FONCTION OPEN MENU---------------
-------------------------------------------------
local backlock = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if GetDistanceBetweenCoords(473.072845458984, -1309.66833496094, 29.2292041778564,GetEntityCoords(GetPlayerPed(-1))) > 2 then
			if vestdepanneur.opened then
				CloseMenuVest()
			end
		end
		if vestdepanneur.opened then
			local ped = LocalPed()
			local menu = vestdepanneur.menu[vestdepanneur.currentmenu]
			drawTxt(vestdepanneur.title,1,1,vestdepanneur.menu.x,vestdepanneur.menu.y,1.0, 255,255,255,255)
			drawMenuTitle(menu.title, vestdepanneur.menu.x,vestdepanneur.menu.y + 0.08)
			drawTxt(vestdepanneur.selectedbutton.."/"..tablelength(menu.buttons),0,0,vestdepanneur.menu.x + vestdepanneur.menu.width/2 - 0.0385,vestdepanneur.menu.y + 0.067,0.4, 255,255,255,255)
			local y = vestdepanneur.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false

			for i,button in pairs(menu.buttons) do
				if i >= vestdepanneur.menu.from and i <= vestdepanneur.menu.to then

					if i == vestdepanneur.selectedbutton then
						selected = true
					else
						selected = false
					end
					drawMenuButton(button,vestdepanneur.menu.x,y,selected)
					if button.distance ~= nil then
						drawMenuRight(button.distance.."m",vestdepanneur.menu.x,y,selected)
					end
					y = y + 0.04
					if selected and IsControlJustPressed(1,201) then
						ButtonSelectedVest(button)
					end
				end
			end
		end
		if vestdepanneur.opened then
			if IsControlJustPressed(1,202) then
				BackVest()
			end
			if IsControlJustReleased(1,202) then
				backlock = false
			end
			if IsControlJustPressed(1,188) then
				if vestdepanneur.selectedbutton > 1 then
					vestdepanneur.selectedbutton = vestdepanneur.selectedbutton -1
					if buttoncount > 10 and vestdepanneur.selectedbutton < vestdepanneur.menu.from then
						vestdepanneur.menu.from = vestdepanneur.menu.from -1
						vestdepanneur.menu.to = vestdepanneur.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				if vestdepanneur.selectedbutton < buttoncount then
					vestdepanneur.selectedbutton = vestdepanneur.selectedbutton +1
					if buttoncount > 10 and vestdepanneur.selectedbutton > vestdepanneur.menu.to then
						vestdepanneur.menu.to = vestdepanneur.menu.to + 1
						vestdepanneur.menu.from = vestdepanneur.menu.from + 1
					end
				end
			end
		end

	end
end)
