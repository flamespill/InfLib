local PluginName = "InfLib"
local PluginDescription = "A library packed with Infinite Yield plugins, ready for instant download with just a click."
local PluginVersion = "1.0.2"
local DiscordLink = "discord.gg/nfkfKqUbGC"

local PluginNameVersion = PluginName.." v"..PluginVersion

local CoreGui = gethui() or cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
local HttpService = cloneref(game:GetService("HttpService")) or game:GetService("HttpService")

if not IY_LOADED then
	loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
	task.wait(1)
	if not writefileExploit() then notify(PluginNameVersion, "Your exploit doesn‘t support file functions, InfLib won‘t work.") return end
	writefile("InfLib.iy", 'return loadstring(game:HttpGet("https://raw.githubusercontent.com/flamespill/InfLib/refs/heads/main/Core/Main.lua"))()')
	addPlugin(PluginName)
	return
end

local function DownloadPlugin(PluginName)
	if isfile(PluginName..".iy") then notify(PluginNameVersion, PluginName..' is already downloaded.') return end
	local URLFixedName = PluginName:gsub(" ", "%%20")
	writefile(PluginName..".iy", 'return loadstring(game:HttpGet("https://raw.githubusercontent.com/flamespill/InfLib/refs/heads/main/Core/Plugins/'..URLFixedName..'.lua"))()')
	addPlugin(PluginName)
end

local function RemovePlugin(PluginName)
	if not isfile(PluginName..".iy") then notify(PluginNameVersion, PluginName..' is not a downloaded plugin.') return end
	deletePlugin(PluginName)
	delfile(PluginName..".iy")
end

local ScreenGui_Name = randomString()
local ScreenGui = Instance.new("ScreenGui", CoreGui); ScreenGui.Name = ScreenGui_Name

local ConfigColors = {
	Shade1 = Color3.fromRGB(36, 36, 37),
	Shade2 = Color3.fromRGB(46, 46, 47),
	Shade3 = Color3.fromRGB(78,78,79),
	Text1 = Color3.fromRGB(255, 255, 255),
	Text2 = Color3.fromRGB(0, 0, 0),
	Scroll = Color3.fromRGB(78,78,79)
}

local function CreateGUI()

	if isfile("IY_FE.iy") then
		local UserConfig = HttpService:JSONDecode(readfile("IY_FE.iy"))
		ConfigColors = {
			Shade1 = Color3.new(UserConfig.currentShade1[1], UserConfig.currentShade1[2], UserConfig.currentShade1[3]) or Color3.fromRGB(36, 36, 37),
			Shade2 = Color3.new(UserConfig.currentShade2[1], UserConfig.currentShade2[2], UserConfig.currentShade2[3]) or Color3.fromRGB(46, 46, 47),
			Shade3 = Color3.new(UserConfig.currentShade3[1], UserConfig.currentShade3[2], UserConfig.currentShade3[3]) or Color3.fromRGB(78,78,79),
			Text1 = Color3.new(UserConfig.currentText1[1], UserConfig.currentText1[2], UserConfig.currentText1[3]) or Color3.fromRGB(255, 255, 255),
			Text2 = Color3.new(UserConfig.currentText2[1], UserConfig.currentText2[2], UserConfig.currentText2[3]) or Color3.fromRGB(0, 0, 0),
			Scroll = Color3.new(UserConfig.currentScroll[1], UserConfig.currentScroll[2], UserConfig.currentScroll[3]) or Color3.fromRGB(78,78,79)
		}
	end

	ScreenGui.Enabled = false; ScreenGui.IgnoreGuiInset = true; ScreenGui.ResetOnSpawn = false

	local MainFrame = Instance.new("Frame", ScreenGui)
	MainFrame.BackgroundColor3 = ConfigColors.Shade1
	MainFrame.BorderSizePixel = 0
	MainFrame.Size = UDim2.new(0, 400, 0, 250)
	MainFrame.Position = UDim2.new(0.5, -MainFrame.Size.X.Offset / 2, 0.5, -MainFrame.Size.Y.Offset / 2)
	dragGUI(MainFrame)

	local Title = Instance.new("TextLabel", MainFrame)
	Title.BackgroundColor3 = ConfigColors.Shade2
	Title.BorderSizePixel = 0
	Title.Size = UDim2.new(1, 0, 0, 20)
	Title.Font = Enum.Font.SourceSans
	Title.TextColor3 = ConfigColors.Text1
	Title.TextSize = 14
	Title.Text = "Infinite Library v"..PluginVersion
	Title.ZIndex = 2

	do
		local emoji = ({
			["01 01"] = "🎆",
			[(function(Year)
				local A = math.floor(Year/100)
				local B = math.floor((13+8*A)/25)
				local C = (15-B+A-math.floor(A/4))%30
				local D = (4+A-math.floor(A/4))%7
				local E = (19*(Year%19)+C)%30
				local F = (2*(Year%4)+4*(Year%7)+6*E+D)%7
				local G = (22+E+F)
				if E == 29 and F == 6 then
					return "04 19"
				elseif E == 28 and F == 6 then
					return "04 18"
				elseif 31 < G then
					return ("04 %02d"):format(G-31)
				end
				return ("03 %02d"):format(G)
			end)(tonumber(os.date"%Y"))] = "🥚",
			["10 31"] = "🎃",
			["12 25"] = "🎄"
		})[os.date("%m %d")]
		if emoji then
			Title.Text = ("%s %s %s"):format(emoji, Title.Text, emoji)
		end
	end

	local CloseButton = Instance.new("ImageButton", Title)
	CloseButton.AnchorPoint = Vector2.new(1, 0.5)
	CloseButton.BackgroundTransparency = 1
	CloseButton.Position = UDim2.new(1, -5, 0.5, 0)
	CloseButton.Size = UDim2.new(0, 10, 0, 10)
	CloseButton.Image = "rbxassetid://5054663650"
	CloseButton.ZIndex = 10
	CloseButton.MouseButton1Click:Connect(function()
		ScreenGui.Enabled = not ScreenGui.Enabled
	end)

	local TabSelector = Instance.new("Frame", MainFrame)
	TabSelector.AnchorPoint = Vector2.new(0, 1)
	TabSelector.BackgroundColor3 = ConfigColors.Shade2
	TabSelector.BorderSizePixel = 0
	TabSelector.Position = UDim2.new(0, 0, 1, 0)
	TabSelector.Size = UDim2.new(0, 100, 1, -20)
	TabSelector.ClipsDescendants = true
	local TabSelector_UIListLayout = Instance.new("UIListLayout", TabSelector)
	TabSelector_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	local TabSelector_UIPadding = Instance.new("UIPadding", TabSelector)
	TabSelector_UIPadding.PaddingTop = UDim.new(0, 1)

	local TabHolder = Instance.new("Frame", MainFrame)
	TabHolder.AnchorPoint = Vector2.new(0, 1)
	TabHolder.BackgroundTransparency = 1
	TabHolder.Position = UDim2.new(0, 100, 1, 0)
	TabHolder.Size = UDim2.new(1, -100, 1, -20)
	TabHolder.ClipsDescendants = true
	local TabHolder_UIPadding = Instance.new("UIPadding", TabHolder)
	TabHolder_UIPadding.PaddingTop = UDim.new(0, 5)
	TabHolder_UIPadding.PaddingBottom = UDim.new(0, 5)
	TabHolder_UIPadding.PaddingLeft = UDim.new(0, 5)
	TabHolder_UIPadding.PaddingRight = UDim.new(0, 5)

	local function Tab_AddText(Tab, Text, TextSize)
		local NewTextLabel = Instance.new("TextLabel", Tab)
		NewTextLabel.BackgroundTransparency = 1
		NewTextLabel.AutomaticSize = Enum.AutomaticSize.XY
		NewTextLabel.Font = Enum.Font.SourceSans
		NewTextLabel.TextWrapped = true
		NewTextLabel.RichText = true
		NewTextLabel.TextYAlignment = Enum.TextYAlignment.Top
		NewTextLabel.TextXAlignment = Enum.TextXAlignment.Left
		NewTextLabel.TextColor3 = ConfigColors.Text1
		NewTextLabel.TextSize = TextSize or 14
		NewTextLabel.Text = Text
	end

	local function Tab_AddLine(Tab)
		local Line = Instance.new("Frame", Tab)
		Line.BackgroundColor3 = ConfigColors.Shade2
		Line.BorderSizePixel = 0
		Line.Size = UDim2.new(1, 0, 0, 1)
	end

	local function Tab_AddTab(TabName)
		local NewTabButton = Instance.new("TextButton", TabSelector)
		NewTabButton.BackgroundColor3 = ConfigColors.Shade2
		NewTabButton.BorderColor3 = ConfigColors.Shade1
		NewTabButton.Size = UDim2.new(1, 0, 0, 25)
		NewTabButton.Font = Enum.Font.SourceSans
		NewTabButton.TextColor3 = ConfigColors.Text1
		NewTabButton.TextSize = 14
		NewTabButton.Text = TabName

		local NewTab = Instance.new("Frame", TabHolder)
		NewTab.Name = TabName
		NewTab.Visible = false
		NewTab.BackgroundTransparency = 1
		NewTab.Size = UDim2.new(1, 0, 1, 0)
		local NewTab_UIListLayout = Instance.new("UIListLayout", NewTab)
		NewTab_UIListLayout.Padding = UDim.new(0, 5)
		NewTab_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

		Tab_AddText(NewTab, "<b>"..TabName.."</b>", 18)
		Tab_AddLine(NewTab)

		NewTabButton.MouseButton1Click:Connect(function()
			for i,v in pairs(TabHolder:GetChildren()) do
				if v:IsA("Frame") or v:IsA("ScrollingFrame") then
					v.Visible = false
				end
			end

			NewTab.Visible = true
		end)

		return(NewTab)
	end

	-- Home
	local HomeTab = Tab_AddTab("Home"); HomeTab.Visible = true
	ScreenGui:GetPropertyChangedSignal("Enabled"):Connect(function()
		MainFrame.Position = UDim2.new(0.5, -MainFrame.Size.X.Offset / 2, 0.5, -MainFrame.Size.Y.Offset / 2)

		for i,v in pairs(TabHolder:GetChildren()) do
			if v:IsA("Frame") or v:IsA("ScrollingFrame") then
				v.Visible = false
			end
		end

		HomeTab.Visible = true
	end)
	Tab_AddText(HomeTab, "A library packed with Infinite Yield plugins, ready for instant download with just a click.")
	Tab_AddLine(HomeTab)
	Tab_AddText(HomeTab, "Would you like to submit your plugin, get your plugin removed, or report a bug?\nJoin the Discord!")
	Tab_AddText(HomeTab, "<b>"..DiscordLink.."</b>")
	Tab_AddLine(HomeTab)
	Tab_AddText(HomeTab, "This project is in desperate need of more plugins, please join the Discord and submit a plugin if you want to help the project.")


	local PluginsTab = Tab_AddTab("Plugins")

	-- Credits
	local CreditsTab = Tab_AddTab("Credits")
	Tab_AddText(CreditsTab, "<b>flamespill</b> — Founder of InfLib")
	Tab_AddLine(CreditsTab)
	Tab_AddText(CreditsTab, "<b>Infinite Store</b> — The project that inspired InfLib")
	Tab_AddLine(CreditsTab)
	Tab_AddText(CreditsTab, "<b>All Plugin Creators</b> — Thank you for being awesome!")

	-- Plugins
	local PluginInfoTab = Instance.new("Frame", TabHolder)
	PluginInfoTab.Name = "PluginInfoTab"
	PluginInfoTab.Visible = false
	PluginInfoTab.BackgroundTransparency = 1
	PluginInfoTab.Size = UDim2.new(1, 0, 1, 0)
	local NewTab_UIListLayout = Instance.new("UIListLayout", PluginInfoTab)
	NewTab_UIListLayout.Padding = UDim.new(0, 5)
	NewTab_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	local PluginName = Instance.new("TextLabel", PluginInfoTab)
	PluginName.BackgroundTransparency = 1
	PluginName.AutomaticSize = Enum.AutomaticSize.XY
	PluginName.Font = Enum.Font.SourceSans
	PluginName.TextWrapped = true
	PluginName.RichText = true
	PluginName.TextYAlignment = Enum.TextYAlignment.Top
	PluginName.TextXAlignment = Enum.TextXAlignment.Left
	PluginName.TextColor3 = ConfigColors.Text1
	PluginName.TextSize = 18
	local PluginCreator = Instance.new("TextLabel", PluginInfoTab)
	PluginCreator.BackgroundTransparency = 1
	PluginCreator.AutomaticSize = Enum.AutomaticSize.XY
	PluginCreator.Font = Enum.Font.SourceSans
	PluginCreator.TextWrapped = true
	PluginCreator.RichText = true
	PluginCreator.TextYAlignment = Enum.TextYAlignment.Top
	PluginCreator.TextXAlignment = Enum.TextXAlignment.Left
	PluginCreator.TextColor3 = ConfigColors.Text1
	PluginCreator.TextSize = 14
	Tab_AddLine(PluginInfoTab)
	local PluginDescription = Instance.new("TextLabel", PluginInfoTab)
	PluginDescription.BackgroundTransparency = 1
	PluginDescription.AutomaticSize = Enum.AutomaticSize.XY
	PluginDescription.Font = Enum.Font.SourceSans
	PluginDescription.TextWrapped = true
	PluginDescription.RichText = true
	PluginDescription.TextYAlignment = Enum.TextYAlignment.Top
	PluginDescription.TextXAlignment = Enum.TextXAlignment.Left
	PluginDescription.TextColor3 = ConfigColors.Text1
	PluginDescription.TextSize = 14
	Tab_AddLine(PluginInfoTab)
	local CloseButton = Instance.new("TextButton", PluginInfoTab)
	CloseButton.Size = UDim2.new(0, 0, 0, 0)
	CloseButton.AutomaticSize = Enum.AutomaticSize.XY
	CloseButton.BackgroundColor3 = ConfigColors.Shade2
	CloseButton.BorderSizePixel = 0
	CloseButton.Font = Enum.Font.SourceSans
	CloseButton.TextColor3 = ConfigColors.Text1
	CloseButton.TextSize = 18
	CloseButton.Text = "Close"
	local CloseButton_UIPadding = Instance.new("UIPadding", CloseButton)
	CloseButton_UIPadding.PaddingLeft = UDim.new(0, 12)
	CloseButton_UIPadding.PaddingRight = UDim.new(0, 12)
	CloseButton_UIPadding.PaddingTop = UDim.new(0, 6)
	CloseButton_UIPadding.PaddingBottom = UDim.new(0, 6)
	CloseButton.MouseButton1Click:Connect(function()
		PluginInfoTab.Visible = false
		PluginsTab.Visible = true
	end)
	local function PluginInfoTab_Setup(pname)
		local URLFixedName = pname:gsub(" ", "%%20")
		local PluginInfo = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/flamespill/InfLib/refs/heads/main/Core/Plugins/"..URLFixedName..".lua"))()

		local pcreator = PluginInfo["PluginCreator"]
		local pdesc = PluginInfo["PluginDescription"]

		PluginName.Text = "<b>"..pname.."</b>"; if isfile(pname..".iy") then PluginName.Text = PluginName.Text.." [<font color='rgb(0, 255, 0)'>Installed</font>]" end
		PluginCreator.Text = "<b>Creator: </b>"..pcreator
		PluginDescription.Text = pdesc
		PluginInfoTab.Visible = true
		PluginsTab.Visible = false
	end

	local PluginsTab_SearchBar = Instance.new("TextBox", PluginsTab)
	PluginsTab_SearchBar.BackgroundColor3 = ConfigColors.Shade2
	PluginsTab_SearchBar.BorderSizePixel = 0
	PluginsTab_SearchBar.Size = UDim2.new(1, 0, 0, 20)
	PluginsTab_SearchBar.Font = Enum.Font.SourceSans
	PluginsTab_SearchBar.TextSize = 14
	PluginsTab_SearchBar.Text = ""
	PluginsTab_SearchBar.PlaceholderColor3 = Color3.fromRGB(173, 173, 173)
	PluginsTab_SearchBar.PlaceholderText = "Search for a Plugin"
	PluginsTab_SearchBar.TextColor3 = ConfigColors.Text1
	PluginsTab_SearchBar.ClearTextOnFocus = true
	PluginsTab_SearchBar.TextWrapped = true
	local PluginsTab_ScrollingFrame = Instance.new("ScrollingFrame", PluginsTab)
	PluginsTab_ScrollingFrame.BackgroundTransparency = 1
	PluginsTab_ScrollingFrame.Size = UDim2.new(1, 0, 1, -64)
	PluginsTab_ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	PluginsTab_ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	PluginsTab_ScrollingFrame.BorderSizePixel = 0
	PluginsTab_ScrollingFrame.ScrollBarThickness = 8
	PluginsTab_ScrollingFrame.TopImage = PluginsTab_ScrollingFrame.MidImage
	PluginsTab_ScrollingFrame.BottomImage = PluginsTab_ScrollingFrame.MidImage
	PluginsTab_ScrollingFrame.ScrollBarImageColor3 = ConfigColors.Scroll
	local PluginsTab_ScrollingFrame_UIListLayout = Instance.new("UIListLayout", PluginsTab_ScrollingFrame)
	PluginsTab_ScrollingFrame_UIListLayout.Padding = UDim.new(0, 5)
	PluginsTab_ScrollingFrame_UIListLayout.SortOrder = Enum.SortOrder.Name

	PluginsTab_SearchBar.Changed:Connect(function()
		for i,v in pairs(PluginsTab_ScrollingFrame:GetChildren()) do
			if v:IsA("TextLabel") then
				v.Visible = string.find(v.Name:lower(), PluginsTab_SearchBar.Text:lower()) ~= nil
			end
		end
	end)

	local function PluginsTab_AddPlugin(PluginName)
		local PluginTitle = Instance.new("TextLabel", PluginsTab_ScrollingFrame)
		PluginTitle.Name = PluginName
		PluginTitle.BackgroundColor3 = ConfigColors.Shade1
		PluginTitle.BackgroundTransparency = 0
		PluginTitle.BorderColor3 = ConfigColors.Shade2
		PluginTitle.Size = UDim2.new(1, -10, 0, 20)
		PluginTitle.Font = Enum.Font.SourceSans
		PluginTitle.TextColor3 = ConfigColors.Text1
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
		InformationButton.BackgroundColor3 = ConfigColors.Shade2
		InformationButton.BorderSizePixel = 0
		InformationButton.Font = Enum.Font.SourceSans
		InformationButton.TextColor3 = ConfigColors.Text1
		InformationButton.TextSize = 14
		InformationButton.Text = "Info"
		local InformationButton_UIPadding = Instance.new("UIPadding", InformationButton)
		InformationButton_UIPadding.PaddingLeft = UDim.new(0, 6)
		InformationButton_UIPadding.PaddingRight = UDim.new(0, 6)
		InformationButton.MouseButton1Click:Connect(function()
			PluginInfoTab_Setup(PluginName)
		end)

		local InstallUninstallButton = Instance.new("TextButton", PluginTitle)
		InstallUninstallButton.Size = UDim2.new(0, 0,1, 0)
		InstallUninstallButton.AutomaticSize = Enum.AutomaticSize.X
		InstallUninstallButton.BackgroundColor3 = ConfigColors.Shade2
		InstallUninstallButton.BorderSizePixel = 0
		InstallUninstallButton.Font = Enum.Font.SourceSans
		InstallUninstallButton.TextColor3 = ConfigColors.Text1
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
			if InstallUninstallButton.Text == "Uninstall" then
				RemovePlugin(PluginName)
				PluginTitle.Text = PluginName
				InstallUninstallButton.Text = "Install"
			elseif InstallUninstallButton.Text == "Install" then
				DownloadPlugin(PluginName)
				PluginTitle.Text = PluginName.." [<font color='rgb(0, 255, 0)'>Installed</font>]"
				InstallUninstallButton.Text = "Uninstall"
			end
		end)

	end

	for i,v in pairs(ScreenGui:GetDescendants()) do
		v.Name = randomString()
	end

	local PluginsList = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/flamespill/InfLib/refs/heads/main/Core/PluginsList.lua"))()
	for i,v in ipairs(PluginsList) do
		PluginsTab_AddPlugin(v)
	end

end

local Plugin = {
	["PluginCreator"] = "flamespill";
	["PluginName"] = PluginNameVersion;
	["PluginDescription"] = PluginDescription;
	["Commands"] = {
		["inflib"] = {
			["ListName"] = "InfLib / Plugins";
			["Description"] = "Opens the InfLib UI";
			["Aliases"] = {"plugins"},
			["Function"] = function()
				if not writefileExploit() then notify(PluginNameVersion, "Your exploit doesn‘t support file functions, InfLib won‘t work.") return end

				if not ScreenGui:FindFirstChildOfClass("Frame") then notify(PluginNameVersion, 'Hold on a sec'); CreateGUI() else end
				ScreenGui.Enabled = not ScreenGui.Enabled

			end
		},
		["reinflib"] = {
			["ListName"] = "RefreshInfLib / ReInfLib";
			["Description"] = "Refreshes the InfLib UI";
			["Aliases"] = {"refreshinflib"},
			["Function"] = function()
				if not writefileExploit() then notify(PluginNameVersion, "Your exploit doesn‘t support file functions, InfLib won‘t work.") return end

				notify(PluginNameVersion, 'Hold on a sec')
				ScreenGui:ClearAllChildren()
				CreateGUI()
				ScreenGui.Enabled = true

			end
		}
	}
}

return Plugin
