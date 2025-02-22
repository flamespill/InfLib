local function PlayAnimation(Humanoid:Humanoid, AnimationId:number)
	local Animation = Instance.new("Animation")
	Animation.AnimationId = "rbxassetid://"..AnimationId
	return(Humanoid:LoadAnimation(Animation))
end

local Plugin = {
	["PluginCreator"] = "flamespill", -- Discord UserId: 1018142081878851595
	["PluginName"] = "Neckbreaker",
	["PluginDescription"] = "Adds a command that breaks your character's neck, that's it.",
	["Commands"] = {

		["breakneck"] = {
			["ListName"] = "breakneck / necksnap",
			["Description"] = "Break your character's neck",
			["Aliases"] = {"breakneck", "necksnap"},
			["Function"] = function(args,speaker)
				if r15(speaker) then notify("Neckbreaker", "Your rig must be R6.") return end
				
				local Animation = PlayAnimation(speaker.Character:FindFirstChildOfClass("Humanoid"), 35154961)
				Animation:Play()
				Animation:AdjustSpeed(3)
				task.wait(.65) -- the reset being late is not a bug, ur ping is too high if that happens
				execCmd("reset")
			end
		};

	}
}

return Plugin
