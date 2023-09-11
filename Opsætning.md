Dette er den skriftlige step-by-step opsætnings guide af: vrp_drug_dealer

Den virsuelle version af opsætningen findes på youtube-kanalen: DetNemmeFiveM
https://www.youtube.com/channel/UCf5yzID5Ast1Vng3LuG_rww 

1. Download scriptet

2. Smid mappen i en valgfri mappe i din server

3. Giv kriminel adgang til marken ved at åbne: resources -> [vrp] -> vrp -> cfg -> groups.lua
Søg derefter efter navnet kriminel indtil du finder jobbet. 
Indsæt en ny linje under: "   },   " som meget gerne skulle være på en individuel linje. 
På linjen skal der stå: "harvest.weed"
Så jobbet nogenlunde ser sådan ud:

	},
		["Kriminel"] = {
		_config = {
	    gtype = "job",
		onjoin = function(player)
			TriggerClientEvent("pNotify:SendNotification", player,{text = "Du er nu Kriminel.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end,
		onspawn = function(player) end,
		onleave = function(player) vRPclient.stopMission(player) end
		},
		"kriminel.adgang",
		"nojob.paycheck",
		"harvest.weed"
	},

4. Gå nu i din server.cfg og start scriptet: "start vrp_drug_dealer"