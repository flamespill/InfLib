local function PlayAnimation(Humanoid:Humanoid, AnimationId:number)
	local Animation = Instance.new("Animation")
	Animation.AnimationId = "rbxassetid://"..AnimationId
	return(Humanoid:LoadAnimation(Animation))
end

local Plugin = {
	["PluginCreator"] = "flamespill",
	["PluginName"] = "Hug Tool",
	["PluginDescription"] = "Adds a tool which you can use to hug people.",
	["Commands"] = {
		["hugtool"] = {
			["ListName"] = "hugtool / hug",
			["Description"] = "Gives you a tool which you can use to hug people.",
			["Aliases"] = {"hugtool", "hug"},
			["Function"] = function(args, speaker)
				local humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")
				local backpack = speaker:FindFirstChildWhichIsA("Backpack")
				if not humanoid or not backpack then return end
				if r15(speaker) then notify('R6 Required','This command requires the r6 rig type') return end
				
				local tool = Instance.new("Tool")
				tool.Name = "Hug"
				tool.ToolTip = "A tool which you can use to hug people"
				tool.RequiresHandle = false
				tool.Parent = backpack
				
				tool.Equipped:Connect(function()
					Animation = PlayAnimation(humanoid, 183294396)
					Animation:Play()
				end)
				tool.Unequipped:Connect(function()
					Animation:Stop()
				end)
				humanoid.Died:Connect(function()
					Animation:Stop()
				end)
			end
		}
	}
}

return Plugin
