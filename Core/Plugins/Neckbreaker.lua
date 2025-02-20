local function PlayAnimation(Humanoid:Humanoid, AnimationId:number)
	local Animation = Instance.new("Animation")
	Animation.AnimationId = "rbxassetid://"..AnimationId
	return(Humanoid:LoadAnimation(Animation))
end

local Plugin = {
	["PluginCreator"] = "flamespill",
	["PluginName"] = "Neckbreaker",
	["PluginDescription"] = "Adds a command that breaks your character's neck, that's it.",
	["Commands"] = {

		["breakneck"] = {
			["ListName"] = "breakneck",
			["Description"] = "Break your character's neck",
			["Aliases"] = {"breakneck"},
			["Function"] = function(args,speaker)
				if r15(speaker) then notify("Neckbreaker", "Your rig must be R6.") return end
				
				local Animation = PlayAnimation(speaker.Character:FindFirstChildOfClass("Humanoid"), 35154961)
				Animation:Play()
				Animation:AdjustSpeed(3)
				task.wait(.65)
				execCmd("reset")
			end
		};

	}
}

return Plugin
