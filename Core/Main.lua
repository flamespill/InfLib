local VersionNumber = "0.0.1"
local ILTitle = "InfLib v"..VersionNumber
local DiscordLink = "discord.gg/nfkfKqUbGC"

local CoreGui = gethui() or cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
local HttpService = cloneref(game:GetService("HttpService")) or game:GetService("HttpService")

local function DownloadPlugin(Name)
	if isfile(Name..".iy") then notify(ILTitle, Name..' is already downloaded.') return end
	writefile(Name..".iy", 'return loadstring(game:HttpGet("https://raw.githubusercontent.com/flamespill/InfLib/refs/heads/main/Core/Plugins/'..Name..'"))()')
	addPlugin(Name)
end

local function RemovePlugin(Name, Type)
	if not isfile(Name..".iy") then notify(ILTitle, Name..' is not a downloaded plugin.') return end
	deletePlugin(Name)
	delfile(Name..".iy")
end

local GUIName = randomString()

local function CreateGUI()
	notify(ILTitle, 'Hold on a sec')

	self = {}

	self.ScreenGui = Instance.new("ScreenGui", CoreGui)
	self.ScreenGui.Name = GUIName
	self.ScreenGui.IgnoreGuiInset = true; self.ScreenGui.ResetOnSpawn = false

	self.MainFrame = Instance.new("Frame", self.ScreenGui)
	self.MainFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
	self.MainFrame.BorderSizePixel = 0
	self.MainFrame.Size = UDim2.new(0, 400, 0, 250)
	self.MainFrame.Position = UDim2.new(0.5, -self.MainFrame.Size.X.Offset / 2, 0.5, -self.MainFrame.Size.Y.Offset / 2)

	self.Title = Instance.new("TextLabel", self.MainFrame)
	self.Title.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	self.Title.BorderSizePixel = 0
	self.Title.Size = UDim2.new(1, 0, 0, 20)
	self.Title.Font = Enum.Font.SourceSans
	self.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	self.Title.TextSize = 14
	self.Title.Text = ILTitle
	self.Title.ZIndex = 2

	self.TabSelector = Instance.new("Frame", self.MainFrame)
	self.TabSelector.AnchorPoint = Vector2.new(0, 1)
	self.TabSelector.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	self.TabSelector.BorderSizePixel = 0
	self.TabSelector.Position = UDim2.new(0, 0, 1, 0)
	self.TabSelector.Size = UDim2.new(0, 100, 1, -20)
	self.TabSelector.ClipsDescendants = true

	self.TabSelector_UIListLayout = Instance.new("UIListLayout", self.TabSelector)
	self.TabSelector_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	self.TabSelector_UIPadding = Instance.new("UIPadding", self.TabSelector)
	self.TabSelector_UIPadding.PaddingTop = UDim.new(0, 1)

	self.TabHolder = Instance.new("Frame", self.MainFrame)
	self.TabHolder.AnchorPoint = Vector2.new(0, 1)
	self.TabHolder.BackgroundTransparency = 1
	self.TabHolder.Position = UDim2.new(0, 100, 1, 0)
	self.TabHolder.Size = UDim2.new(1, -100, 1, -20)
	self.TabSelector.ClipsDescendants = true

	self.CloseButton = Instance.new("ImageButton", self.Title)
	self.CloseButton.AnchorPoint = Vector2.new(1, 0.5)
	self.CloseButton.BackgroundTransparency = 1
	self.CloseButton.Position = UDim2.new(1, -5, 0.5, 0)
	self.CloseButton.Size = UDim2.new(0, 10, 0, 10)
	self.CloseButton.Image = "rbxassetid://5054663650"
	self.CloseButton.ZIndex = 10
	self.CloseButton.MouseButton1Click:Connect(function()
		self.ScreenGui.Enabled = not self.ScreenGui.Enabled
	end)

	dragGUI(self.MainFrame)

	for i,v in pairs(self.ScreenGui:GetDescendants()) do
		v.Name = randomString()
	end

	local function Tab_CreateText(Tab, Text, TextSize)
		local Title = Instance.new("TextLabel", Tab)
		Title.BackgroundTransparency = 1
		Title.Size = UDim2.new(0, 0, 0, 0)
		Title.AutomaticSize = Enum.AutomaticSize.XY
		Title.Font = Enum.Font.SourceSans
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title.TextSize = TextSize or 14
		Title.RichText = true
		Title.Text = Text
		Title.TextWrapped = true
		Title.TextXAlignment = Enum.TextXAlignment.Left
	end

	local function Tab_CreateLine(Tab)
		local Line = Instance.new("Frame", Tab)
		Line.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
		Line.BorderSizePixel = 0
		Line.Size = UDim2.new(1, 0, 0, 1)
	end

	local function CreateTab(Name, Class)
		local NewTabButton = Instance.new("TextButton", self.TabSelector)
		NewTabButton.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
		NewTabButton.BorderColor3 = Color3.fromRGB(36, 36, 37)
		NewTabButton.Size = UDim2.new(1, 0, 0, 25)
		NewTabButton.Font = Enum.Font.SourceSans
		NewTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		NewTabButton.TextSize = 14
		NewTabButton.Text = Name

		local NewTab
		if Class == "ScrollingFrame" or not Class then
			NewTab = Instance.new("ScrollingFrame", self.TabHolder)
			NewTab.AutomaticCanvasSize = Enum.AutomaticSize.Y
			NewTab.ScrollBarThickness = 0
			NewTab.CanvasSize = UDim2.new(0, 0, 0, 0)
		elseif Class == "Frame" then
			NewTab = Instance.new("Frame", self.TabHolder)
		end
		NewTab.Name = Name
		NewTab.BackgroundTransparency = 1
		NewTab.Size = UDim2.new(1, 0, 1, 0)
		NewTab.Visible = false
		local NewTab_UIListLayout = Instance.new("UIListLayout", NewTab)
		NewTab_UIListLayout.Padding = UDim.new(0, 5)
		NewTab_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		local NewTab_UIPadding = Instance.new("UIPadding", NewTab)
		NewTab_UIPadding.PaddingBottom = UDim.new(0, 5)
		NewTab_UIPadding.PaddingLeft = UDim.new(0, 5)
		NewTab_UIPadding.PaddingRight = UDim.new(0, 5)
		NewTab_UIPadding.PaddingTop = UDim.new(0, 5)

		Tab_CreateText(NewTab, "<b>"..Name.."</b>", 18)
		Tab_CreateLine(NewTab)

		NewTabButton.MouseButton1Click:Connect(function()
			for i,v in pairs(self.TabHolder:GetChildren()) do
				if v:IsA("ScrollingFrame") or v:IsA("Frame") then
					v.Visible = false
				end
			end

			NewTab.Visible = true
		end)
	end

	CreateTab("Home", "ScrollingFrame")
	CreateTab("Plugins", "Frame")
	CreateTab("Credits", "ScrollingFrame")

	local HomeTab = self.TabHolder:WaitForChild("Home"); HomeTab.Visible = true
	Tab_CreateText(HomeTab, "A library packed with Infinite Yield plugins, ready for instant download with just a click.")
	Tab_CreateLine(HomeTab)
	Tab_CreateText(HomeTab, "Would you like to submit your plugin, get your plugin removed, or report a bug?\nJoin the Discord!")
	Tab_CreateText(HomeTab, "<b>"..DiscordLink.."</b>")
	Tab_CreateLine(HomeTab)
	Tab_CreateText(HomeTab, "This project is in desperate need of more plugins, please join the Discord and submit a plugin if you want to help the project.")

	local CreditsTab = self.TabHolder:WaitForChild("Credits")
	Tab_CreateText(CreditsTab, "<b>flamespill</b> — Founder of InfLib")
	Tab_CreateLine(CreditsTab)
	Tab_CreateText(CreditsTab, "<b>Infinite Store</b> — The project that inspired InfLib!")
	Tab_CreateLine(CreditsTab)
	Tab_CreateText(CreditsTab, "<b>All Plugin Creators</b> — Thank you for being awesome!")

	local PluginsTab = self.TabHolder:WaitForChild("Plugins")
	
	local PluginsTab_SearchBar = Instance.new("TextBox", PluginsTab)
	PluginsTab_SearchBar.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	PluginsTab_SearchBar.BorderSizePixel = 0
	PluginsTab_SearchBar.Size = UDim2.new(1, 0, 0, 20)
	PluginsTab_SearchBar.Font = Enum.Font.SourceSans
	PluginsTab_SearchBar.TextSize = 14
	PluginsTab_SearchBar.Text = ""
	PluginsTab_SearchBar.PlaceholderColor3 = Color3.fromRGB(173, 173, 173)
	PluginsTab_SearchBar.PlaceholderText = "Search for a Plugin"
	PluginsTab_SearchBar.TextColor3 = Color3.fromRGB(255, 255, 255)
	PluginsTab_SearchBar.ClearTextOnFocus = true
	PluginsTab_SearchBar.TextWrapped = true
	local PluginsTab_ScrollingFrame = Instance.new("ScrollingFrame", PluginsTab)
	PluginsTab_ScrollingFrame.BackgroundTransparency = 1
	PluginsTab_ScrollingFrame.Size = UDim2.new(1, 0, 1, -64)
	PluginsTab_ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	PluginsTab_ScrollingFrame.ScrollBarThickness = 0
	PluginsTab_ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	local PluginsTab_ScrollingFrame_UIListLayout = Instance.new("UIListLayout", PluginsTab_ScrollingFrame)
	PluginsTab_ScrollingFrame_UIListLayout.Padding = UDim.new(0, 5)
	PluginsTab_ScrollingFrame_UIListLayout.SortOrder = Enum.SortOrder.Name

	PluginsTab_SearchBar.Changed:Connect(function()
		local searchText = PluginsTab_SearchBar.Text:lower()
		for _, item in pairs(PluginsTab_ScrollingFrame:GetChildren()) do
			if item:IsA("TextLabel") then
				item.Visible = string.find(item.Text:lower(), searchText) ~= nil
			end
		end
	end)

	
	local PluginInfoTab = Instance.new("ScrollingFrame", self.TabHolder)
	PluginInfoTab.Name = randomString()
	PluginInfoTab.BackgroundTransparency = 1
	PluginInfoTab.Size = UDim2.new(1, 0, 1, 0)
	PluginInfoTab.Visible = false
	PluginInfoTab.AutomaticCanvasSize = Enum.AutomaticSize.Y
	PluginInfoTab.ScrollBarThickness = 0
	PluginInfoTab.CanvasSize = UDim2.new(0, 0, 0, 0)
	local PluginInfoTab_UIListLayout = Instance.new("UIListLayout", PluginInfoTab)
	PluginInfoTab_UIListLayout.Padding = UDim.new(0, 5)
	PluginInfoTab_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	local PluginInfoTab_UIPadding = Instance.new("UIPadding", PluginInfoTab)
	PluginInfoTab_UIPadding.PaddingBottom = UDim.new(0, 5)
	PluginInfoTab_UIPadding.PaddingLeft = UDim.new(0, 5)
	PluginInfoTab_UIPadding.PaddingRight = UDim.new(0, 5)
	PluginInfoTab_UIPadding.PaddingTop = UDim.new(0, 5)
	
	local function PluginsTab_Setup_DescriptionTab(PluginName)
		for i,v in pairs(PluginInfoTab:GetChildren()) do
			if v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("Frame") then
				v:Destroy()
			end
		end
		
		local PluginInfo = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/flamespill/InfLib/refs/heads/main/Core/Plugins/"..PluginName))()
		
		Tab_CreateText(PluginInfoTab, "<b>"..PluginName.."</b>", 18)
		Tab_CreateText(PluginInfoTab, "<b>Creator:</b> "..PluginInfo["PluginCreator"], 18)
		Tab_CreateLine(PluginInfoTab)
		Tab_CreateText(PluginInfoTab, PluginInfo["PluginDescription"], 14)
		Tab_CreateLine(PluginInfoTab)
		local CloseButton = Instance.new("TextButton", PluginInfoTab)
		CloseButton.Size = UDim2.new(0, 0, 0, 0)
		CloseButton.AutomaticSize = Enum.AutomaticSize.XY
		CloseButton.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
		CloseButton.BorderSizePixel = 0
		CloseButton.Font = Enum.Font.SourceSans
		CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		CloseButton.TextSize = 18
		CloseButton.Text = "Close"
		local CloseButton_UIPadding = Instance.new("UIPadding", CloseButton)
		CloseButton_UIPadding.PaddingLeft = UDim.new(0, 9)
		CloseButton_UIPadding.PaddingRight = UDim.new(0, 9)
		CloseButton_UIPadding.PaddingTop = UDim.new(0, 6)
		CloseButton_UIPadding.PaddingBottom = UDim.new(0, 6)
		
		CloseButton.MouseButton1Click:Connect(function()
			PluginInfoTab.Visible = false
			PluginsTab.Visible = true
		end)
		
		PluginInfoTab.Visible = true
		PluginsTab.Visible = false
	end
	
	local function PluginsTab_AddPlugin(PluginName)
		local PluginTitle = Instance.new("TextLabel", PluginsTab_ScrollingFrame)
		PluginTitle.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
		PluginTitle.BackgroundTransparency = 0
		PluginTitle.BorderColor3 = Color3.fromRGB(46, 46, 47)
		PluginTitle.Size = UDim2.new(1, 0, 0, 20)
		PluginTitle.Font = Enum.Font.SourceSans
		PluginTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
		PluginTitle.TextSize = 14
		PluginTitle.RichText = true
		PluginTitle.Text = PluginName
		PluginTitle.TextWrapped = true
		PluginTitle.TextXAlignment = Enum.TextXAlignment.Left
		local PluginTitle_UIListLayout = Instance.new("UIListLayout", PluginTitle)
		PluginTitle_UIListLayout.Padding = UDim.new(0, 5)
		PluginTitle_UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		PluginTitle_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		PluginTitle_UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		PluginTitle_UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		
		local InformationButton = Instance.new("TextButton", PluginTitle)
		InformationButton.Size = UDim2.new(0, 0,1, 0)
		InformationButton.AutomaticSize = Enum.AutomaticSize.X
		InformationButton.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
		InformationButton.BorderSizePixel = 0
		InformationButton.Font = Enum.Font.SourceSans
		InformationButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		InformationButton.TextSize = 14
		InformationButton.Text = "Info"
		local InformationButton_UIPadding = Instance.new("UIPadding", InformationButton)
		InformationButton_UIPadding.PaddingLeft = UDim.new(0, 6)
		InformationButton_UIPadding.PaddingRight = UDim.new(0, 6)

		InformationButton.MouseButton1Click:Connect(function()
			PluginsTab_Setup_DescriptionTab(PluginName)
		end)
		
		local InstallUninstallButton = Instance.new("TextButton", PluginTitle)
		InstallUninstallButton.Size = UDim2.new(0, 0,1, 0)
		InstallUninstallButton.AutomaticSize = Enum.AutomaticSize.X
		InstallUninstallButton.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
		InstallUninstallButton.BorderSizePixel = 0
		InstallUninstallButton.Font = Enum.Font.SourceSans
		InstallUninstallButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		InstallUninstallButton.TextSize = 14
		InstallUninstallButton.Text = "Install"
		local InstallUninstallButton_UIPadding = Instance.new("UIPadding", InstallUninstallButton)
		InstallUninstallButton_UIPadding.PaddingLeft = UDim.new(0, 6)
		InstallUninstallButton_UIPadding.PaddingRight = UDim.new(0, 6)
		
		if isfile(PluginName..".iy") then
			InstallUninstallButton.Text = "Uninstall"
			PluginTitle.Text = PluginName.." [<font color='rgb(0, 255, 0)'>Installed</font>]"
		end
		
		InstallUninstallButton.MouseButton1Click:Connect(function()
			if InstallUninstallButton.Text == "Uninstall" and isfile(PluginName..".iy") then
				RemovePlugin(PluginName)
				PluginTitle.Text = PluginName
				InstallUninstallButton.Text = "Install"
			elseif InstallUninstallButton.Text == "Install" and not isfile(PluginName..".iy") then
				DownloadPlugin(PluginName)
				PluginTitle.Text = PluginName.." [<font color='rgb(0, 255, 0)'>Installed</font>]"
				InstallUninstallButton.Text = "Uninstall"
			end
		end)
		
	end
	
	local PluginsList = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/flamespill/InfLib/refs/heads/main/Core/PluginsList"))()
	for i,v in ipairs(PluginsList) do
		PluginsTab_AddPlugin(v)
	end
end

local function ResetGUI()
	if CoreGui:FindFirstChild(GUIName) then
		local MainFrame = CoreGui[GUIName]:FindFirstChildOfClass("Frame")
		MainFrame.Position = UDim2.new(0.5, -MainFrame.Size.X.Offset / 2, 0.5, -MainFrame.Size.Y.Offset / 2)

		for i,Frame in pairs(MainFrame:GetDescendants()) do
			if Frame.Name == "Home" then

				for o,Tab in pairs(Frame.Parent:GetChildren()) do
					if Tab:IsA("ScrollingFrame") or Tab:IsA("Frame") then
						Tab.Visible = false
					end
				end

				Frame.Visible = true

			end
		end

	end
end

local Plugin = {
	["PluginName"] = ILTitle;
	["PluginDescription"] = "A library packed with Infinite Yield plugins, ready for instant download with just a click.";
	["Commands"] = {
		["InfLib"] = {
			["ListName"] = "InfLib";
			["Description"] = "Opens the InfLib UI";
			["Aliases"] = {"InfLib", "InfiniteLibrary", "InfLibrary", "InfiniteLib"},
			["Function"] = function()
				if not writefileExploit() then notify(ILTitle, "Your exploit doesn‘t support file functions, InfLib won‘t work.") return end

				if CoreGui:FindFirstChild(GUIName) then ResetGUI(); CoreGui[GUIName].Enabled = not CoreGui[GUIName].Enabled return else CreateGUI() end
			end
		}
	}
}

return Plugin
