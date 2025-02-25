local R6Dances = {
	dance = "27789359",
	moonwalk = "30196114",
	tara = "248263260",
	disco = "45834924",
	party = "33796059",
	goal = "28488254",
	flute = "52155728"
}
local R15Dances = {
	river = "3333432454",
	keeper = "4555808220",
	line = "4049037604",
	air = "4555782893",
	flare = "10214311282",
	burberry = "10714010337",
	town = "10713981723",
	idol = "10714372526",
	fancy = "10714076981",
	robot = "10714392151",
	still = "11444443576"
}

local function PlayAnimation(Humanoid:Humanoid, AnimationId:number)
	local Animation = Instance.new("Animation")
	Animation.AnimationId = "rbxassetid://"..AnimationId
	return(Humanoid:LoadAnimation(Animation))
end

local Plugin = {
	["PluginCreator"] = "flamespill", -- Discord UserId: 1018142081878851595
	["PluginName"] = "Specific Dance",
	["PluginDescription"] =
	[[Allows you to choose specific animations from the dance command
	R15: river, keeper, line, air, flare, burberry, town, idol, fancy, robot, still
	R6: dance, moonwalk, tara, disco, party, goal, flute]],
	["Commands"] = {
		["specdance"] = {
			["ListName"] = "specificdance / specdance [DANCE-NAME]",
			["Description"] = "Play a specific animation from the dance command",
			["Aliases"] = {"specdance", "specificdance"},
			["Function"] = function(args, speaker)
				pcall(execCmd, "undance")

				local Humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")

				local DanceTable = r15(speaker) and R15Dances or R6Dances

				local AnimationId = DanceTable[string.lower(args[1])]
				if not AnimationId then return end

				danceTrack = PlayAnimation(Humanoid, AnimationId)
				danceTrack.Looped = true
				danceTrack:Play()
			end
		}
	}
}

return Plugin
