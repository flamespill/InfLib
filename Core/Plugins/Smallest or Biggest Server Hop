local Plugin = {
	["PluginCreator"] = "toonarch and shlexr", -- Discord UserId: 712521210302300161, 837791888643588136
	["PluginName"] = "Smallest/Biggest Server Hop",
	["PluginDescription"] = "Join the smallest or biggest available server. Might not work on games with more servers.",
	["Commands"] = {
		["smallserverhop"] = {
			["ListName"] = "smallserverhop / smallshop",
			["Description"] = "Joins the smallest available server.",
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
