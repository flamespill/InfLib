Players.LocalPlayer.CharacterAdded:Connect(function()
	NOtFLY()
	Floating = false

	if not Clip then
		execCmd('clip')
	end

	repeat wait() until getRoot(Players.LocalPlayer.Character)

	pcall(function()
		if spawnpoint and not refreshCmd and spawnpos ~= nil then
			wait(spDelay)
			getRoot(Players.LocalPlayer.Character).CFrame = spawnpos
		end
	end)

	onDied()
end)

tFLYING = false

function stFLY(vTfly)
	repeat wait() until Players.LocalPlayer and Players.LocalPlayer.Character and getRoot(Players.LocalPlayer.Character) and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	repeat wait() until IYMouse
	if TflyKeyDown or TflyKeyUp then TflyKeyDown:Disconnect() TflyKeyUp:Disconnect() end

	local T = getRoot(Players.LocalPlayer.Character)
	local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local SPEED = 0

	local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

	local function tFLY()
		tFLYING = true
		local BG = Instance.new('BodyGyro')
		local BV = Instance.new('BodyVelocity')
		BG.P = 9e4
		BG.Parent = T
		BV.Parent = T
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = T.CFrame
		BV.velocity = Vector3.new(0, 0, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)

		local previousVelocity = Vector3.new(0, 0, 0)
		local previousCFrame = T.CFrame

		task.spawn(function()
			repeat wait()
				if not vTfly and Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
					Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
				end
				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					SPEED = 50
				elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
					SPEED = 0
				end
				if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
					local targetVelocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED

					-- Yeah (1)
					local velocityTween = TweenService:Create(BV, tweenInfo, {velocity = targetVelocity})
					velocityTween:Play()

					lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
				elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
					local targetVelocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED

					-- Yeah (2)
					local velocityTween = TweenService:Create(BV, tweenInfo, {velocity = targetVelocity})
					velocityTween:Play()
				else
					-- Stop
					local velocityTween = TweenService:Create(BV, tweenInfo, {velocity = Vector3.new(0, 0, 0)})
					velocityTween:Play()
				end

				-- BodyGyro (camera)
				local gyroTween = TweenService:Create(BG, tweenInfo, {cframe = workspace.CurrentCamera.CoordinateFrame})
				gyroTween:Play()
			until not tFLYING
			CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			SPEED = 0
			BG:Destroy()
			BV:Destroy()
			if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
				Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false -- i refuse to define "Humanoid"
			end
		end)
	end

	TflyKeyDown = IYMouse.KeyDown:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = (vTfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 's' then
			CONTROL.B = - (vTfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 'a' then
			CONTROL.L = - (vTfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 'd' then 
			CONTROL.R = (vTfly and vehicleflyspeed or iyflyspeed)
		end
		pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
	end)

	TflyKeyUp = IYMouse.KeyUp:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = 0
		elseif KEY:lower() == 's' then
			CONTROL.B = 0
		elseif KEY:lower() == 'a' then
			CONTROL.L = 0
		elseif KEY:lower() == 'd' then
			CONTROL.R = 0
		end
	end)

	tFLY()
end


function NOtFLY()
	tFLYING = false
	if TflyKeyDown or TflyKeyUp then TflyKeyDown:Disconnect() TflyKeyUp:Disconnect() end
	if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
		Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false -- i refuse to define "Humanoid" (x2)
	end
	pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end

local velocityHandlerName = randomString()
local gyroHandlerName = randomString()
local mTfly1
local mTfly2

local unmobileTfly = function(speaker)
	pcall(function()
		tFLYING = false
		local root = getRoot(speaker.Character)
		root:FindFirstChild(velocityHandlerName):Destroy()
		root:FindFirstChild(gyroHandlerName):Destroy()
		speaker.Character:FindFirstChildWhichIsA("Humanoid").PlatformStand = false -- hi
		mTfly1:Disconnect()
		mTfly2:Disconnect()
	end)
end

local mobileTfly = function(speaker, vTfly)
	unmobileTfly(speaker)
	tFLYING = true

	local root = getRoot(speaker.Character)
	local camera = workspace.CurrentCamera
	local v3none = Vector3.new()
	local v3zero = Vector3.new(0, 0, 0)
	local v3inf = Vector3.new(9e9, 9e9, 9e9)

	local controlModule = require(speaker.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
	local bv = Instance.new("BodyVelocity")
	bv.Name = velocityHandlerName
	bv.Parent = root
	bv.MaxForce = v3inf
	bv.Velocity = v3none -- Initial

	local bg = Instance.new("BodyGyro")
	bg.Name = gyroHandlerName
	bg.Parent = root
	bg.MaxTorque = v3inf
	bg.P = 1000
	bg.D = 50

	local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out) -- again

	mTfly1 = speaker.CharacterAdded:Connect(function()
		local bv = Instance.new("BodyVelocity")
		bv.Name = velocityHandlerName
		bv.Parent = root
		bv.MaxForce = v3inf
		bv.Velocity = v3none

		local bg = Instance.new("BodyGyro")
		bg.Name = gyroHandlerName
		bg.Parent = root
		bg.MaxTorque = v3inf
		bg.P = 1000
		bg.D = 50
	end)

	mTfly2 = RunService.RenderStepped:Connect(function()
		root = getRoot(speaker.Character)
		camera = workspace.CurrentCamera
		if speaker.Character:FindFirstChildWhichIsA("Humanoid") and root and root:FindFirstChild(velocityHandlerName) and root:FindFirstChild(gyroHandlerName) then
			local humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")
			local VelocityHandler = root:FindFirstChild(velocityHandlerName)
			local GyroHandler = root:FindFirstChild(gyroHandlerName)

			VelocityHandler.MaxForce = v3inf
			GyroHandler.MaxTorque = v3inf
			if not vTfly then humanoid.PlatformStand = true end
			GyroHandler.CFrame = camera.CoordinateFrame

			local direction = controlModule:GetMoveVector()
			local targetVelocity = Vector3.zero

			if direction.X > 0 then
				targetVelocity = targetVelocity + camera.CFrame.RightVector * (direction.X * ((vTfly and vehicleflyspeed or iyflyspeed) * 50))
			end
			if direction.X < 0 then
				targetVelocity = targetVelocity + camera.CFrame.RightVector * (direction.X * ((vTfly and vehicleflyspeed or iyflyspeed) * 50))
			end
			if direction.Z > 0 then
				targetVelocity = targetVelocity - camera.CFrame.LookVector * (direction.Z * ((vTfly and vehicleflyspeed or iyflyspeed) * 50))
			end
			if direction.Z < 0 then
				targetVelocity = targetVelocity - camera.CFrame.LookVector * (direction.Z * ((vTfly and vehicleflyspeed or iyflyspeed) * 50))
			end

			-- Yeah 
			local velocityTween = TweenService:Create(VelocityHandler, tweenInfo, {Velocity = targetVelocity})
			velocityTween:Play()

			-- BodyGyro (camera)
			local gyroTween = TweenService:Create(GyroHandler, tweenInfo, {CFrame = camera.CoordinateFrame})
			gyroTween:Play()
		end
	end)
end

local Plugin = {
	["PluginCreator"] = "cool.o2",
	["PluginName"] = "Tween Flight",
	["PluginDescription"] = "Let's you fly smoother, bypassing some anti-cheats.",
	["Commands"] = {
		["tweenfly"] = {
			["ListName"] = "tweenfly / tfly [speed]",
			["Description"] = "Makes you (smoothly) fly",
			["Aliases"] = {"tfly"},
			["Function"] = function(args, speaker)
				if not IsOnMobile then
					NOFLY()
					NOtFLY()
					wait()
					stFLY()
				else
					mobileTfly(speaker, true)
				end
				if args[1] and isNumber(args[1]) then
					iyflyspeed = args[1]
				end
			end -- <-- Added closing here for tweenfly
		},
		["vehicletweenfly"] = {
			["ListName"] = "vehicletweenfly / vtfly [speed]",
			["Description"] = "Makes you (smoothly) fly, but on a vehicle!",
			["Aliases"] = {"vtfly"},
			["Function"] = function(args, speaker)
				if not IsOnMobile then
					NOFLY()
					NOtFLY()
					wait()
					stFLY(true)
				else
					mobileTfly(speaker, true)
				end
				if args[1] and isNumber(args[1]) then
					iyflyspeed = args[1]
				end
			end
		},
		["untweenfly"] = {
			["ListName"] = "untweenfly / untfly / unvtfly",
			["Description"] = "Stops ALL tween flight commands",
			["Aliases"] = {"untfly","unvtfly"},
				["Function"] = function(args, speaker)
					if not IsOnMobile then NOtFLY() else unmobileTfly(speaker) end
				end
			}
		}
	}

return Plugin
