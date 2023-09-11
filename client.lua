
paCamp = false

local dmvped = { 
  {type=4, hash=0xc99f21c4, x=2506.0773925781, y=4800.095703125, z=34.001350402832, a=2974170},
  {type=4, hash=0xc99f21c4, x=2499.0810546875, y=4801.26171875, z=33.749999, a=2974170},
}

-- 2499.0810546875,4801.26171875,34.800037384033

local dmvpedpos = {
	{ ['x'] = 2506.0773925781, ['y'] = 4800.095703125, ['z'] = 34.001350402832 },
	{ ['x'] = 2499.0810546875, ['y'] = 4801.26171875, ['z'] = 33.749999 },
}


local function textFain(text, secconds)
	ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(text)
	DrawSubtitleTimed(secconds * 1000, 1)
end
local function drawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*130
    local scale = scale*fov

    if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x, _y)
			local factor = (string.len(text)) / 370
		DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 100)
    end
end
local function drawInfo(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


local locatiiFertile = {
-- ++++




-- RAND 1
		{xyz = {2502.0053710938,4818.5834960938,35.098754882813}},
		{xyz = {2504.7739257813,4815.8920898438,34.863132476807}},
		{xyz = {2507.1203613281,4813.5288085938,34.664619445801}},
		{xyz = {2511.4819335938,4809.3837890625,34.458618164063}},
		{xyz = {2515.2060546875,4806.0102539063,34.33988571167}},


-- RAND 2
		{xyz = {2505.8505859375,4822.0483398438,34.816539764404}},
		{xyz = {2508.4086914063,4819.3256835938,34.581371307373}},
		{xyz = {2511.2321777344,4816.8413085938,34.34126663208}},
		{xyz = {2513.3547363281,4815.0083007813,34.227806091309}},
		{xyz = {2515.8718261719,4812.4467773438,34.165538787842}},

-- RAND 3
		{xyz = {2506.8137207031,4817.8315429688,34.626979827881}},
		{xyz = {2509.177734375,4815.6245117188,34.406951904297}},
		{xyz = {2513.8889160156,4811.0825195313,34.215751647949}},
		{xyz = {2517.6218261719,4807.51171875,34.151554107666}},
		{xyz = {2519.8645019531,4805.4350585938,34.099384307861}},

-- RAND 4

		{xyz = {2505.1889648438,4825.7299804688,35.049999237061}},
		{xyz = {2506.9460449219,4824.0068359375,34.843383789063}},
		{xyz = {2509.40234375,4821.6884765625,34.558944702148}},
		{xyz = {2512.7873535156,4818.4272460938,34.164333343506}},
		{xyz = {2516.8208007813,4814.595703125,34.010280609131}},
-- RAND 5

		{xyz = {2506.7541503906,4826.9448242188,35.061092376709}},
		{xyz = {2508.8625488281,4825.0200195313,34.810230255127}},
		{xyz = {2511.9133300781,4821.8833007813,34.419048309326}},
		{xyz = {2514.6791992188,4819.0209960938,34.063545227051}},
		{xyz = {2517.9353027344,4815.83203125,34.010272979736}},
-- RAND 6

		{xyz = {2508.2873535156,4828.3198242188,35.133148193359}},
		{xyz = {2510.5856933594,4826.1640625,34.817668914795}},
		{xyz = {2513.4814453125,4823.390625,34.466438293457}},
		{xyz = {2520.0231933594,4817.62109375,34.042484283447}},
		{xyz = {2517.1789550781,4820.1552734375,34.098110198975}},
}

RegisterNetEvent("ples:startPlant")
AddEventHandler("ples:startPlant", function()
  	textFain("~w~Gå til ~r~marken ~w~ og plant nogle ~r~frø~w~!", 10)
  	paCamp = true
end)

local lotNames = {}
RegisterNetEvent("ples:setLotName")
AddEventHandler("ples:setLotName", function(k, v)
	lotNames[k] = v
end)

local weedprops = {}
local weedstates = {}

RegisterNetEvent("ples:updateStates")
AddEventHandler("ples:updateStates", function(k, v)
	weedstates[k] = v
end)

RegisterNetEvent("ples:UltraDelete")
AddEventHandler("ples:UltraDelete", function(object)
    if DoesEntityExist(object) then
    NetworkRequestControlOfEntity(object)
    while not NetworkHasControlOfEntity(object) do
        Citizen.Wait(1)
    end
    SetEntityCollision(object, false, false)
    SetEntityAlpha(object, 0.0, true)
    SetEntityAsMissionEntity(object, true, true)
    SetEntityAsNoLongerNeeded(object)
    DeleteEntity(object)
    end
end)

RegisterNetEvent("ples:updateLots")
AddEventHandler("ples:updateLots", function(k, v)

	local pos2 = locatiiFertile[k]
	local pos = pos2.xyz

	TriggerEvent("ples:UltraDelete", weedprops[k])

	if v == 1 then
		weedprops[k] = CreateObject(GetHashKey("prop_weed_02"), pos[1], pos[2], pos[3], true, true, true)
	elseif v == 2 then
		weedprops[k] = CreateObject(GetHashKey("prop_weed_01"), pos[1], pos[2], pos[3], true, true, true)
	end

	if DoesEntityExist(weedprops[k]) then
		PlaceObjectOnGroundProperly(weedprops[k])
		SetEntityRotation(weedprops[k], 0.00, 0.00, 340.00)
		SetEntityCanBeDamaged(weedprops[k], false)
		SetEntityAsMissionEntity(weedprops[k], true, true)
	end
end)


Citizen.CreateThread(function()
	RequestModel(GetHashKey("a_m_y_business_01"))
	while not HasModelLoaded(GetHashKey("a_m_y_business_01")) do
		Wait(1)
	end
		            local p = GetEntityCoords(GetPlayerPed(-1))


	RequestAnimDict("mini@strip_club@idles@bouncer@base")
	while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
		Wait(1)
	end

			-- Spawn the DMV Ped
	for _, item in pairs(dmvped) do
		dmvmainped =  CreatePed(item.type, item.hash, item.x, item.y, item.z, item.a, false, true)
		SetEntityHeading(dmvmainped, 0.0)
		FreezeEntityPosition(dmvmainped, true)
	SetEntityInvincible(dmvmainped, true)
	SetBlockingOfNonTemporaryEvents(dmvmainped, true)
		TaskPlayAnim(dmvmainped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
		end
	local ped = GetPlayerPed(-1)
	while true do
		Citizen.Wait(2)
		if paCamp then
			local pos = GetEntityCoords(ped, true)

			for k,v in pairs(locatiiFertile) do
				local pos2 = v.xyz
				local dist = Vdist(pos.x, pos.y, pos.z, pos2[1], pos2[2], pos2[3])

				if dist < 5.0 then
					if weedstates[k] ~= 1 and weedstates[k] ~= 2 then
						drawText3D(pos2[1], pos2[2], pos2[3] + 0.8, "~w~Her kan du plante ~g~FRØ")
						DrawMarker(1,pos2[1], pos2[2], pos2[3]-1.0, 0, 0, 0, 0, 0, 0, 1.51, 1.51, 0.3, 204, 240, 0, 5001, 0, 0, 2, 0, 0, 0, 0)                                

					elseif weedstates[k] == 1 then
						drawText3D(pos2[1], pos2[2], pos2[3] + 0.8, "~w~Frøene ~o~VOKSER")
						DrawMarker(1,pos2[1], pos2[2], pos2[3]-1.0, 0, 0, 0, 0, 0, 0, 1.51, 1.51, 0.3, 204, 240, 0, 5001, 0, 0, 2, 0, 0, 0, 0)                                
					else
						drawText3D(pos2[1], pos2[2], pos2[3] + 0.8, "~w~Du kan samle ~g~PLANTEN")
						DrawMarker(1,pos2[1], pos2[2], pos2[3]-1.0, 0, 0, 0, 0, 0, 0, 1.51, 1.51, 0.3, 204, 240, 0, 5001, 0, 0, 2, 0, 0, 0, 0)                                
					end

					if lotNames[k] ~= nil and weedstates[k] == 2 and tostring(lotNames[k]) ~= "nil" then
						drawText3D(pos2[1], pos2[2], pos2[3] + 0.91, "~w~Owner ~b~"..tostring(lotNames[k]):upper())
					end

					if dist < 1.0 and weedstates[k] ~= 1 then
						if weedstates[k] ~= 2 then
							drawInfo("Tryk på ~INPUT_CONTEXT~ for at plante frø")
						else
							drawInfo("Tryk på ~INPUT_CONTEXT~ for at samle planterne")
						end

						if IsControlJustPressed(1, 51)  then   
							TriggerServerEvent('ples:planteazaTata', k)
							exports['progressBars']:startUI(11000, "Planter/samler")
							Wait(11000)
						end
					end

					DrawMarker(20, pos2[1], pos2[2], pos2[3], 0, 0, 0, 0, 0, 0, 0.6001,0.6001,0.6001, 5, 144, 51, 100, 0, 0, 0, 1, 0, 0, 0)
				elseif dist >= 400.0 then
					paCamp = false
				end
			end
		end
	end
end)
