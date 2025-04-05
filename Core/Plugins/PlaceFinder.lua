local Plugin = {
	["PluginCreator"] = "dazy0349", -- Discord UserId: 1151873820286787614
	["PluginName"] = "Place Finder",
	["PluginDescription"] = "View places inside of a experience",
	["Commands"] = {
		["findplaces"] = {
			["ListName"] = "findplaces",
			["Description"] = "Find secret places.",
			["Aliases"] = {"findplaces","fsp"},
			["Function"] = function(args,speaker)
				--// Variables \\--
				local Envs = {
					cloneref = cloneref or function(a) return a end,
					setclipboard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
				}

				local CoreGui = Envs.cloneref(game:GetService("CoreGui"))
				local StarterGui = Envs.cloneref(game:GetService("StarterGui"))
				local TweenService = Envs.cloneref(game:GetService("TweenService"))
				local TeleportService = Envs.cloneref(game:GetService("TeleportService"))
				local AssetService = Envs.cloneref(game:GetService("AssetService"))
				local Players = Envs.cloneref(game:GetService("Players"))
				local Player = Players.LocalPlayer
				
				if Player:GetAttribute("PlaceFinder") then
					notify("Find Places", "You already executed this!")
					return
				else
					Player:SetAttribute("PlaceFinder", true)
				end

				--// Instances \\--
				local PlaceFinder = Instance.new("ScreenGui")
				local Top = Instance.new("Frame")
				local Error = Instance.new("Sound")
				local Success = Instance.new("Sound")
				local UIStroke_1 = Instance.new("UIStroke")
				local Body = Instance.new("Frame")
				local UIStroke_2 = Instance.new("UIStroke")
				local Places = Instance.new("ScrollingFrame")
				local Default = Instance.new("Frame")
				local UIStroke_3 = Instance.new("UIStroke")
				local Teleport = Instance.new("TextButton")
				local TextLabel = Instance.new("TextLabel")
				local CopyId = Instance.new("TextButton")
				local TextLabel_2 = Instance.new("TextLabel")
				local PlaceFound = Instance.new("TextLabel")
				local TextLabel_3 = Instance.new("TextLabel")
				local UIListLayout = Instance.new("UIListLayout")
				local CloseB = Instance.new("TextButton")
				local ImageLabel = Instance.new("ImageLabel")
				local MinimizeB = Instance.new("TextButton")
				local ImageLabel_2 = Instance.new("ImageLabel")
				local MaximizeB = Instance.new("TextButton")
				local ImageLabel_3 = Instance.new("ImageLabel")
				local TextLabel_4 = Instance.new("TextLabel")

				--// Properties \\--
				PlaceFinder.Name = "PlaceFinder"
				PlaceFinder.Parent = CoreGui

				Top.Name = "Top"
				Top.Parent = PlaceFinder
				Top.Active = true
				Top.Draggable = true
				Top.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
				Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Top.BorderSizePixel = 0
				Top.Position = UDim2.new(0.464376599, 0, 0.358040214, 0)
				Top.Size = UDim2.new(0, 380, 0, 20)
				Top.ZIndex = 2

				Error.Name = "Error"
				Error.Parent = Top
				Error.SoundId = "rbxassetid://9066167010"
				Error.Volume = 10

				Success.Name = "Success"
				Success.Parent = Top
				Success.SoundId = "rbxassetid://3450794184"
				Success.Volume = 10

				UIStroke_1.Parent = Top
				UIStroke_1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				UIStroke_1.Color = Color3.fromRGB(60, 60, 60)
				UIStroke_1.Thickness = 2

				Body.Name = "Body"
				Body.Parent = Top
				Body.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
				Body.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Body.BorderSizePixel = 0
				Body.ClipsDescendants = true
				Body.Size = UDim2.new(0, 380, 0, 250)

				UIStroke_2.Parent = Body
				UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				UIStroke_2.Color = Color3.fromRGB(50, 50, 50)
				UIStroke_2.Thickness = 2

				Places.Name = "Places"
				Places.Parent = Body
				Places.Active = true
				Places.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Places.BackgroundTransparency = 1.000
				Places.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Places.BorderSizePixel = 0
				Places.Position = UDim2.new(0, 0, 0, 20)
				Places.Size = UDim2.new(0, 380, 0, 229)
				Places.CanvasSize = UDim2.new(0, 0, 0, 0)
				Places.AutomaticCanvasSize = Enum.AutomaticSize.Y

				Default.Name = "Default"
				Default.Parent = Places
				Default.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Default.BackgroundTransparency = 1.000
				Default.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Default.BorderSizePixel = 0
				Default.Size = UDim2.new(0, 380, 0, 60)
				Default.Visible = false

				UIStroke_3.Parent = Default
				UIStroke_3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				UIStroke_3.Color = Color3.fromRGB(35, 35, 35)
				UIStroke_3.Thickness = 1

				Teleport.Name = "Teleport"
				Teleport.Parent = Default
				Teleport.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				Teleport.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Teleport.BorderSizePixel = 0
				Teleport.Position = UDim2.new(0.649999976, 0, 0, 0)
				Teleport.Size = UDim2.new(0, 133, 0, 30)
				Teleport.Font = Enum.Font.SourceSans
				Teleport.Text = ""
				Teleport.TextColor3 = Color3.fromRGB(0, 0, 0)
				Teleport.TextSize = 14.000

				TextLabel.Parent = Teleport
				TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel.BackgroundTransparency = 1.000
				TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextLabel.BorderSizePixel = 0
				TextLabel.Position = UDim2.new(0, 0, 0.0549999997, 0)
				TextLabel.Size = UDim2.new(1, 0, 0.883999646, 0)
				TextLabel.Font = Enum.Font.SourceSans
				TextLabel.Text = "Teleport"
				TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel.TextScaled = true
				TextLabel.TextSize = 14.000
				TextLabel.TextWrapped = true

				CopyId.Name = "CopyId"
				CopyId.Parent = Default
				CopyId.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				CopyId.BorderColor3 = Color3.fromRGB(0, 0, 0)
				CopyId.BorderSizePixel = 0
				CopyId.Position = UDim2.new(0.649999976, 0, 0.5, 0)
				CopyId.Size = UDim2.new(0, 133, 0, 30)
				CopyId.Font = Enum.Font.SourceSans
				CopyId.Text = ""
				CopyId.TextColor3 = Color3.fromRGB(0, 0, 0)
				CopyId.TextSize = 14.000

				TextLabel_2.Parent = CopyId
				TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel_2.BackgroundTransparency = 1.000
				TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextLabel_2.BorderSizePixel = 0
				TextLabel_2.Position = UDim2.new(0, 0, 0.0549999997, 0)
				TextLabel_2.Size = UDim2.new(1, 0, 0.883999646, 0)
				TextLabel_2.Font = Enum.Font.SourceSans
				TextLabel_2.Text = "Copy ID"
				TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel_2.TextScaled = true
				TextLabel_2.TextSize = 14.000
				TextLabel_2.TextWrapped = true

				PlaceFound.Name = "PlaceFound"
				PlaceFound.Parent = Default
				PlaceFound.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				PlaceFound.BorderColor3 = Color3.fromRGB(0, 0, 0)
				PlaceFound.BorderSizePixel = 0
				PlaceFound.Size = UDim2.new(0, 247, 0, 60)
				PlaceFound.Font = Enum.Font.SourceSans
				PlaceFound.Text = ""
				PlaceFound.TextColor3 = Color3.fromRGB(0, 0, 0)
				PlaceFound.TextSize = 14.000

				TextLabel_3.Parent = PlaceFound
				TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel_3.BackgroundTransparency = 1.000
				TextLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextLabel_3.BorderSizePixel = 0
				TextLabel_3.Position = UDim2.new(0.0140000004, 0, 0.0579999983, 0)
				TextLabel_3.Size = UDim2.new(0.975708544, 0, 0.883333325, 0)
				TextLabel_3.Font = Enum.Font.SourceSans
				TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel_3.TextScaled = true
				TextLabel_3.TextSize = 14.000
				TextLabel_3.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel_3.TextWrapped = true

				UIListLayout.Parent = Places
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

				CloseB.Name = "CloseB"
				CloseB.Parent = Top
				CloseB.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
				CloseB.BorderColor3 = Color3.fromRGB(0, 0, 0)
				CloseB.BorderSizePixel = 0
				CloseB.Position = UDim2.new(0.947368443, 0, 0, 0)
				CloseB.Size = UDim2.new(0.0526315793, 0, 1, 0)
				CloseB.ZIndex = 2
				CloseB.Font = Enum.Font.SourceSans
				CloseB.Text = ""
				CloseB.TextColor3 = Color3.fromRGB(0, 0, 0)
				CloseB.TextSize = 14.000

				ImageLabel.Parent = CloseB
				ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageLabel.BackgroundTransparency = 1.000
				ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageLabel.BorderSizePixel = 0
				ImageLabel.Size = UDim2.new(1, 0, 1, 0)
				ImageLabel.ZIndex = 2
				ImageLabel.Image = "rbxassetid://16898613869"
				ImageLabel.ImageRectOffset = Vector2.new(869, 906)
				ImageLabel.ImageRectSize = Vector2.new(48, 48)

				MinimizeB.Name = "MinimizeB"
				MinimizeB.Parent = Top
				MinimizeB.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
				MinimizeB.BorderColor3 = Color3.fromRGB(0, 0, 0)
				MinimizeB.BorderSizePixel = 0
				MinimizeB.Position = UDim2.new(0.894736826, 0, 0, 0)
				MinimizeB.Size = UDim2.new(0.0526315793, 0, 1, 0)
				MinimizeB.ZIndex = 2
				MinimizeB.Font = Enum.Font.SourceSans
				MinimizeB.Text = ""
				MinimizeB.TextColor3 = Color3.fromRGB(0, 0, 0)
				MinimizeB.TextSize = 14.000

				ImageLabel_2.Parent = MinimizeB
				ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageLabel_2.BackgroundTransparency = 1.000
				ImageLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageLabel_2.BorderSizePixel = 0
				ImageLabel_2.Size = UDim2.new(1, 0, 1, 0)
				ImageLabel_2.ZIndex = 2
				ImageLabel_2.Image = "rbxassetid://16898728878"
				ImageLabel_2.ImageRectOffset = Vector2.new(514, 0)
				ImageLabel_2.ImageRectSize = Vector2.new(256, 256)

				MaximizeB.Name = "MaximizeB"
				MaximizeB.Parent = Top
				MaximizeB.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
				MaximizeB.BorderColor3 = Color3.fromRGB(0, 0, 0)
				MaximizeB.BorderSizePixel = 0
				MaximizeB.Position = UDim2.new(0.894736826, 0, 0, 0)
				MaximizeB.Size = UDim2.new(0.0526315793, 0, 1, 0)
				MaximizeB.Visible = false
				MaximizeB.ZIndex = 2
				MaximizeB.Font = Enum.Font.SourceSans
				MaximizeB.Text = ""
				MaximizeB.TextColor3 = Color3.fromRGB(0, 0, 0)
				MaximizeB.TextSize = 14.000

				ImageLabel_3.Parent = MaximizeB
				ImageLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageLabel_3.BackgroundTransparency = 1.000
				ImageLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageLabel_3.BorderSizePixel = 0
				ImageLabel_3.Size = UDim2.new(1, 0, 1, 0)
				ImageLabel_3.ZIndex = 2
				ImageLabel_3.Image = "rbxassetid://16898612819"
				ImageLabel_3.ImageRectOffset = Vector2.new(196, 918)
				ImageLabel_3.ImageRectSize = Vector2.new(48, 48)

				TextLabel_4.Parent = Top
				TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel_4.BackgroundTransparency = 1.000
				TextLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextLabel_4.BorderSizePixel = 0
				TextLabel_4.Position = UDim2.new(0, 6, 0, 1)
				TextLabel_4.Size = UDim2.new(0.878947377, 0, 0.899999976, 0)
				TextLabel_4.ZIndex = 2
				TextLabel_4.Font = Enum.Font.SourceSans
				TextLabel_4.Text = "Place Finder"
				TextLabel_4.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel_4.TextScaled = true
				TextLabel_4.TextSize = 14.000
				TextLabel_4.TextWrapped = true
				TextLabel_4.TextXAlignment = Enum.TextXAlignment.Left

				--// Scripts \\--
				if Envs.setclipboard == nil then
					Error:Play()
					notify("Find Places", "Your executor doesn't support setclipboard()")
				end

				local Debounce = false

				-- Find Places
				local PlacesPages = AssetService:GetGamePlacesAsync()

				for _, v in PlacesPages:GetCurrentPage() do
					local FoundPlace = Default:Clone()
					FoundPlace.Name = "FoundPlace"
					FoundPlace.Parent = Places
					FoundPlace.Visible = true
					FoundPlace.PlaceFound.TextLabel.Text = v.Name .. "\nID: " .. v.PlaceId

					FoundPlace.Teleport.MouseButton1Click:Connect(function()
						notify("Find Places", "Teleporting...")
						TeleportService:Teleport(v.PlaceId, Player)
					end)
					FoundPlace.CopyId.MouseButton1Click:Connect(function()
						if Envs.setclipboard then
							Envs.setclipboard(tostring(v.PlaceId))
							Success:Play()
							notify("Find Places", "Copied Place ID")
						else
							notify("Find Places", "Your executor doesn't support setclipboard()")
						end
					end)
				end

				-- Animations
				local Info = TweenInfo.new(.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
				local MinFrameAnim = TweenService:Create(Body, Info, {Size = UDim2.fromOffset(380, 20)})
				local MaxFrameAnim = TweenService:Create(Body, Info, {Size = UDim2.fromOffset(380, 250)})

				-- Default Events
				MinimizeB.MouseButton1Click:Connect(function()
					if Debounce == false then
						Debounce = true

						MinimizeB.Visible = false
						MaximizeB.Visible = true

						MinFrameAnim:Play()
						task.wait(.4)
						Debounce = false
					end
				end)
				MaximizeB.MouseButton1Click:Connect(function()
					if Debounce == false then
						Debounce = true

						MinimizeB.Visible = true
						MaximizeB.Visible = false

						MaxFrameAnim:Play()
						task.wait(.4)
						Debounce = false
					end
				end)
				CloseB.MouseButton1Click:Once(function()
					PlaceFinder:Destroy()
					Player:SetAttribute("PlaceFinder", nil)
				end)
			end
		}
	}
}

return Plugin
