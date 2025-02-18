local Plugin = {
	["PluginCreator"] = "toonarch",
	["PluginName"] = "SmallHop",
	["PluginDescription"] = "Join the smallest server possible",
	["Commands"] = {
		["smallserverhop"] = {
			["ListName"] = "smallserverhop / smallshop",
			["Description"] = "join smallest server possible",
			["Aliases"] = {"smallserverhop","smallshop"},
			["Function"] = function(args, speaker)
				local lowestnumber = 2
				local srvs = {}
				for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
					if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
						if v.playing <= lowestnumber then
							lowestnumber = v.playing
							srvs[1] = v.id
						end
					end
				end
				if #srvs > 0 then
					game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, srvs[1])
				end
			end
		},
	}
}
return Plugin
