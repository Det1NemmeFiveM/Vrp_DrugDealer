local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_drugs")

print("[PLES/Syndicate] Las aici creditele ca nu s scartar!Ples e vaita")  --progressBars

local tdCords = {2506.0776367188,4800.7451171875,34.996700286865}
local lots = {0}

local menu_confisca = {
	name = "Drugs",
	css={top = "75px", header_color="rgba(226, 87, 36, 0.75)"}
}

menu_confisca["Agang til kokain marken"] = {function(player, choice)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		if vRP.hasPermission({user_id, "harvest.weed"}) then
			vRPclient.notify(player, {"Okay okay, resten af din tid i byen har du adgang..."})
			TriggerClientEvent("ples:startPlant", player)
		else
			vRPclient.notify(player, {"~r~Du er vist ikke kriminel..."})
		end
	end
	vRP.closeMenu({player})
end, "Hvis du ville have adgang til marken, skal du spoerge mig foerst!"}

local function updateWeed(player, k, v)
	TriggerClientEvent("ples:updateLots", player, k, v)
	TriggerClientEvent("ples:updateStates", -1, k, v)
	if v ~= 2 then
		TriggerClientEvent("ples:setLotName", -1, k, GetPlayerName(player))
	else
		TriggerClientEvent("ples:setLotName", -1, k, nil)
	end
end

local lotOwners = {0}

RegisterServerEvent("ples:planteazaTata")
AddEventHandler("ples:planteazaTata", function(lotID)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if lots[lotID] ~= 2 then
			if vRP.hasPermission({user_id, "harvest.weed"}) then
		if vRP.tryGetInventoryItem({user_id, "kokainblade", 1, false}) then

			lotOwners[lotID] = user_id
			vRPclient.playAnim(player, {false, {task="WORLD_HUMAN_GARDENER_PLANT"}, false})
			SetTimeout(10000, function()
				vRPclient.stopAnim(player, {false})
				SetTimeout(5000, function()
					-- apare planta mica
					lots[lotID] = 1
					updateWeed(player, lotID, lots[lotID])

					-- creste weed-ul
					SetTimeout(40000, function()
						lots[lotID] = 2
						updateWeed(player, lotID, lots[lotID])

						SetTimeout(11000, function()
							if lots[lotID] == 2 then
								lotOwners[lotID] = 0
								lots[lotID] = 0
								updateWeed(player, lotID, lots[lotID])
							end
						end)
					end)
				end)
			end)
		else
			vRPclient.notify(player, {"~r~Du har ingen frø at plante"})
		end
	else
		vRPclient.notify(player, {"~r~Du må ikke plante her!"})
	end
	elseif lots[lotID] == 2 then

		if lotOwners[lotID] == user_id then
			vRPclient.playAnim(player, {false, {task="PROP_HUMAN_PARKING_METER"}, false})
			SetTimeout(6000, function()
				vRPclient.stopAnim(player, {false})
				lots[lotID] = 0
                local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"kokain"})
			if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
				vRP.giveInventoryItem({user_id, "kokain", math.random(1, 3), true})
				updateWeed(player, lotID, lots[lotID])
			else
				vRPclient.notify(player, {"~r~Inventar fuldt!"})
			end
			end)
		else
			vRPclient.notify(player, {"~r~Planten tilhører ikke dig"})
		end

	end
end)

local function build_confisca(source)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		TriggerClientEvent("ples:syncOwners", source, lotOwners) 


		local x, y, z = table.unpack(tdCords)

		local conf_enter = function(player, area)
			local user_id = vRP.getUserId({player})
			if user_id ~= nil then
				if menu_confisca then vRP.openMenu({player, menu_confisca}) end

			end
		end

		local conf_leave = function(player, area)
			vRP.closeMenu({player})
		end

		vRPclient.addBlip(source, {x, y, z, 496, 69, "Kokain mark"})
		vRPclient.addMarker(source,{x,y,z-0.95,1,1,0.9,0, 66, 134, 244,150})
		vRP.setArea({source, "vRP:confisatdePles", x, y, z, 3, 2, conf_enter, conf_leave})
	end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
	  if user_id ~= nil then
			  build_confisca(source)
	  end
	end
  end)

  RegisterCommand("mark", function(ply)
    build_confisca(ply)
end)
