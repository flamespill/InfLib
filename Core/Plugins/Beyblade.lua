local Plugin = {
	["PluginCreator"] = "flamespill",
	["PluginName"] = "Beyblade",
	["PluginDescription"] = "Turns you into a beyblade, allowing you to spin around and fling players.",
	["Commands"] = {

		["beyblade"] = {
			["ListName"] = "beyblade",
			["Description"] = "Turns you into a beyblade, allowing you to spin around and fling players.",
			["Aliases"] = {"beyblade"},
			["Function"] = function(args, speaker)
				if r15(speaker) then notify('R6 Required','This command requires the r6 rig type') return end

				local Humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")

				if not Humanoid then return end

				if beybladeAnimation and beybladeAnimTrack and beybladeSpin then return end

				beybladeAnimation = Instance.new("Animation")
				beybladeAnimation.AnimationId = "rbxassetid://282574440"

				beybladeAnimTrack = Humanoid:LoadAnimation(beybladeAnimation)
				beybladeAnimTrack.Looped = true
				beybladeAnimTrack:Play()

				beybladeSpin = Instance.new("BodyAngularVelocity")
				beybladeSpin.Name = "Spinning"
				beybladeSpin.Parent = getRoot(speaker.Character)
				beybladeSpin.MaxTorque = Vector3.new(0, math.huge, 0)
				beybladeSpin.AngularVelocity = Vector3.new(0, 50, 0)
				
				-- skidded this from ellie ty
				local RunService = cloneref(game:GetService("RunService")) or game:GetService("RunService")
				while beybladeAnimation and beybladeAnimTrack and beybladeSpin do
					local rootPart = getRoot(speaker.Character)
					local vel = rootPart.Velocity
					rootPart.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
					RunService.RenderStepped:Wait()
					rootPart.Velocity = vel
					RunService.Stepped:Wait()
					rootPart.Velocity = vel + Vector3.new(0, 0.1, 0)
					task.wait()
				end

			end
		};

		["unbeyblade"] = {
			["ListName"] = "unbeyblade",
			["Description"] = "Turns you into a beyblade, allowing you to spin around and fling players.",
			["Aliases"] = {"unbeyblade"},
			["Function"] = function(args, speaker)

				if beybladeAnimation then beybladeAnimation:Destroy(); beybladeAnimation = nil end
				if beybladeAnimTrack then beybladeAnimTrack:Stop(); beybladeAnimTrack:Destroy(); beybladeAnimTrack = nil end
				if beybladeSpin then beybladeSpin:Destroy(); beybladeSpin = nil end

			end
		}

	}
}

return Plugin
