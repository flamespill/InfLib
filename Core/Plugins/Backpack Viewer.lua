local plugin = {
	["PluginCreator"] = "/";  -- Discord UserId: Unknown
	["PluginName"] = "Backpack Viewer";
	["PluginDescription"] = "Creates a small popup, letting you see inside a player's backpack.";
	["Commands"] = {
		["backpack"] = {
			["ListName"] = "backpack";
			["Description"] = "View a player's backpack";
			["Aliases"]={"backpack","bp","inventory"};
			["Function"] = function(args,speaker)
				local backpackViewer = Instance.new("ScreenGui")
				local backdrop = Instance.new("Frame")
				local middleBar = Instance.new("Frame")
				local title = Instance.new("TextLabel")
				local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
				local Inventory = Instance.new("ScrollingFrame")
				local itemEXAMPLE = Instance.new("TextLabel")
				local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
				local UIListLayout = Instance.new("UIListLayout")
				backpackViewer.Name = "backpackViewer"
				backpackViewer.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
				backpackViewer.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
				backdrop.Name = "backdrop"
				backdrop.Parent = backpackViewer
				backdrop.AnchorPoint = Vector2.new(0, 1)
				backdrop.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
				backdrop.BorderSizePixel = 0
				backdrop.Position = UDim2.new(0, 0, 1.22500002, 0)
				backdrop.Size = UDim2.new(0.133651555, 0, 0.21344541, 0)
				middleBar.Name = "middleBar"
				middleBar.Parent = backdrop
				middleBar.AnchorPoint = Vector2.new(0.5, 0.5)
				middleBar.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
				middleBar.BorderSizePixel = 0
				middleBar.Position = UDim2.new(0.5, 0, 0.102004275, 0)
				middleBar.Size = UDim2.new(1, 0, 0.123952113, 0)
				title.Name = "title"
				title.Parent = middleBar
				title.AnchorPoint = Vector2.new(0.5, 0.5)
				title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				title.BackgroundTransparency = 1.000
				title.Position = UDim2.new(0.5, 0, 0.5, 0)
				title.Size = UDim2.new(0.949999988, 0, 0.75, 0)
				title.Font = Enum.Font.SourceSans
				title.Text = "@hyraioo's Backpack"
				title.TextColor3 = Color3.fromRGB(231, 231, 231)
				title.TextScaled = true
				title.TextSize = 14.000
				title.TextWrapped = true
				title.TextXAlignment = Enum.TextXAlignment.Left
				UIAspectRatioConstraint.Parent = backdrop
				UIAspectRatioConstraint.AspectRatio = 1.311
				Inventory.Name = "Inventory"
				Inventory.Parent = backdrop
				Inventory.Active = true
				Inventory.AnchorPoint = Vector2.new(0.5, 0.5)
				Inventory.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Inventory.BackgroundTransparency = 1.000
				Inventory.BorderSizePixel = 0
				Inventory.Position = UDim2.new(0.5, 0, 0.584999979, 0)
				Inventory.Size = UDim2.new(0.953000009, 0, 0.779999971, 0)
				Inventory.BottomImage = ""
				Inventory.ScrollBarThickness = 2
				Inventory.TopImage = ""
				itemEXAMPLE.Name = "itemEXAMPLE"
				itemEXAMPLE.Parent = Inventory
				itemEXAMPLE.AnchorPoint = Vector2.new(0.5, 0.5)
				itemEXAMPLE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				itemEXAMPLE.BackgroundTransparency = 1.000
				itemEXAMPLE.Position = UDim2.new(0.5, 0, 0.0230158083, 0)
				itemEXAMPLE.Size = UDim2.new(0.943299353, 0, 0.0460310318, 0)
				itemEXAMPLE.Font = Enum.Font.SourceSansBold
				itemEXAMPLE.Text = "1x   :  Dagger"
				itemEXAMPLE.TextColor3 = Color3.fromRGB(221, 221, 221)
				itemEXAMPLE.TextScaled = true
				itemEXAMPLE.TextSize = 14.000
				itemEXAMPLE.TextWrapped = true
				itemEXAMPLE.TextXAlignment = Enum.TextXAlignment.Left
				itemEXAMPLE.Visible = false
				UITextSizeConstraint.Parent = itemEXAMPLE
				UITextSizeConstraint.MaxTextSize = 14
				UIListLayout.Parent = Inventory
				UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.Padding = UDim.new(0.00999999978, 0)
				local thep = args[1];
				local player;
				for _,p in pairs(game.Players:GetPlayers()) do
					if string.find(string.lower(p.Name),string.lower(thep)) or string.find(string.lower(p.DisplayName),string.lower(thep)) then
						player=p; break;
					end;
				end;
				if player then
					local tools = {};
					local function getTools(player: Player)
						for _,tool in pairs(player.Backpack:GetChildren()) do
							table.insert(tools,tool.Name);
						end;
						for _,tool in pairs(player.Character:GetChildren()) do
							if tool:IsA('Tool') then
								table.insert(tools,tool.Name);
							end;
						end;
					end;
					getTools(player);
					title.Text = ("@%s's backpack"):format(player.Name);
					local arrangedItems = {};
					for _, item in ipairs(tools) do
						if arrangedItems[item] then
							arrangedItems[item] = arrangedItems[item] + 1;
						else
							arrangedItems[item] = 1;
						end;
					end;
					local result = {};
					for item, count in pairs(arrangedItems) do
						local newItem = itemEXAMPLE:Clone();
						newItem.Parent=Inventory;
						newItem.Text = string.format("%dx  :  %s",count,item);
						newItem.Visible=true;
					end;
					task.spawn(function()
						backdrop:TweenPosition(UDim2.new(0, 0,1, 0),Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,0.5,true,nil);
						task.wait(6.0);
						backdrop:TweenPosition(UDim2.new(0, 0, 1.22500002, 0),Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,0.5,true,nil);
						task.wait(0.5);
						backpackViewer:Destroy();
					end);
					print("did it?")
				else
					print("no plr found");
				end;
				-- stop skidding this code please, thank you.
			end;
		};
	}; 
};

return plugin;
