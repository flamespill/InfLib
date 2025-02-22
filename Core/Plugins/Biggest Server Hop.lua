local Plugin = {
	["PluginCreator"] = "shlexr", -- Discord UserId: 837791888643588136
	["PluginName"] = "Biggest Server Hop",
	["PluginDescription"] = "Joins the largest available server.",
	["Commands"] = {
		["bigserverhop"] = {
			["ListName"] = "bigserverhop / bigshop",
			["Description"] = "Joins the largest available server.",
			["Aliases"] = {"bigserverhop","bigshop"},
			["Function"] = function(args,speaker)
				local highestnumber = 0
				local srvs = {}
				for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
					if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
						if v.playing > highestnumber then
							highestnumber = v.playing
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
