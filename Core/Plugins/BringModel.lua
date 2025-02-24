local Plugin = {
	["PluginCreator"] = "flamespill",
	["PluginName"] = "BringModel",
	["PluginDescription"] = "Adds a bringmodel to Infinite Yield, behaving like bringpart but for models.",
	["Commands"] = {
		["bringmodel"] = {
			["ListName"] = "bringmodel [model name] (CLIENT)",
			["Description"] = "Moves a model or multiple models to your character",
			["Aliases"] = {"bringmodel"},
			["Function"] = function(args,speaker)
				for i,v in pairs(workspace:GetDescendants()) do
					if v.Name:lower() == getstring(1):lower() and v:IsA("Model") then
						v:PivotTo(getRoot(speaker.Character).CFrame)
					end
				end
			end
		}
	}
}

return Plugin
