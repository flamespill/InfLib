local PluginName = "InfLib"
local PluginDescription = "A library packed with Infinite Yield plugins, ready for instant download with just a click."
local PluginVersion = "1.1.7"
local DiscordLink = "discord.gg/nfkfKqUbGC"

local PluginNameVersion = PluginName.." v"..PluginVersion

local CoreGui = gethui() or cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
local HttpService = cloneref(game:GetService("HttpService")) or game:GetService("HttpService")
local StarterGui = cloneref(game:GetService("StarterGui")) or game:GetService("StarterGui")

if not IY_LOADED then

	loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
	repeat wait() until IY_LOADED
	if not writefileExploit() then notify(PluginNameVersion, "Your exploit doesn‘t support file functions, InfLib won‘t work.") return end

	local function DownloadInfLib()
		writefile("InfLib.iy", 'return loadstring(game:HttpGet("'.."https://raw.githubusercontent.com/flamespill/InfLib/refs/heads/main/Core/Source.lua"..'"))()')
		addPlugin("InfLib")
	end

	if isfile("InfLib.iy") then
		if readfile("InfLib.iy") == 'return loadstring(game:HttpGet("'.."https://raw.githubusercontent.com/flamespill/InfLib/refs/heads/main/Core/Source.lua"..'"))()' then
			notify(PluginNameVersion, "InfLib is already set up, you don't have to run the installer. Use the command 'plugins'.")
		else
			DownloadInfLib()
		end
	else
		DownloadInfLib()
	end

else

	if not isfile("InfLib.iy") then
		StarterGui:SetCore("SendNotification", {
			Title = PluginNameVersion,
			Text = "Infinite Yield is already executed, installation will not work now. Rejoin and follow the How To Download steps on the GitHub Page.",
			Duration = 20
		})
		return
	end

end

local function SetLinkCompatible(Link:string)
	return Link:gsub(" ", "%%20"):gsub("%+", "%%2B")
end

local function DownloadPlugin(PluginName:string)	
	writefile(PluginName..".iy", 'return loadstring(game:HttpGet("'..'https://raw.githubusercontent.com/flamespill/InfLib/refs/heads/main/Core/Plugins/'..SetLinkCompatible(PluginName)..'.lua"))()')
	addPlugin(PluginName)
end

local function DeletePlugin(PluginName:string)
	deletePlugin(PluginName)
	delfile(PluginName..".iy")
end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = randomString(); ScreenGui.Enabled = false; ScreenGui.IgnoreGuiInset = true; ScreenGui.ResetOnSpawn = false
local function CreateGUI()

	local IY_Config
	if isfile("IY_FE.iy") then
		IY_Config = HttpService:JSONDecode(readfile("IY_FE.iy"))
	end

	local UIColors
	if IY_Config then
		UIColors = {
			Shade1 = Color3.new(IY_Config.currentShade1[1], IY_Config.currentShade1[2], IY_Config.currentShade1[3]) or Color3.fromRGB(36, 36, 37),
			Shade2 = Color3.new(IY_Config.currentShade2[1], IY_Config.currentShade2[2], IY_Config.currentShade2[3]) or Color3.fromRGB(46, 46, 47),
			Shade3 = Color3.new(IY_Config.currentShade3[1], IY_Config.currentShade3[2], IY_Config.currentShade3[3]) or Color3.fromRGB(78,78,79),
			Text1 = Color3.new(IY_Config.currentText1[1], IY_Config.currentText1[2], IY_Config.currentText1[3]) or Color3.fromRGB(255, 255, 255),
			Text2 = Color3.new(IY_Config.currentText2[1], IY_Config.currentText2[2], IY_Config.currentText2[3]) or Color3.fromRGB(0, 0, 0),
			Scroll = Color3.new(IY_Config.currentScroll[1], IY_Config.currentScroll[2], IY_Config.currentScroll[3]) or Color3.fromRGB(78,78,79)
		}
	else
		local UIColors = {
			Shade1 = Color3.fromRGB(36, 36, 37),
			Shade2 = Color3.fromRGB(46, 46, 47),
			Shade3 = Color3.fromRGB(78,78,79),
			Text1 = Color3.fromRGB(255, 255, 255),
			Text2 = Color3.fromRGB(0, 0, 0),
			Scroll = Color3.fromRGB(78,78,79)
		}
	end

	local MainFrame = Instance.new("Frame", ScreenGui)
	MainFrame.BackgroundColor3 = UIColors.Shade1
	MainFrame.BorderSizePixel = 0
	MainFrame.Size = UDim2.new(0, 400, 0, 250)
	MainFrame.Position = UDim2.new(0.5, -MainFrame.Size.X.Offset / 2, 0.5, -MainFrame.Size.Y.Offset / 2)
	dragGUI(MainFrame)

	local MainFrame_Title = Instance.new("TextLabel", MainFrame)
	MainFrame_Title.BackgroundColor3 = UIColors.Shade2
	MainFrame_Title.BorderSizePixel = 0
	MainFrame_Title.Size = UDim2.new(1, 0, 0, 20)
	MainFrame_Title.Font = Enum.Font.SourceSans
	MainFrame_Title.TextColor3 = UIColors.Text1
	MainFrame_Title.TextSize = 14
	MainFrame_Title.Text = "Infinite Library v"..PluginVersion
	MainFrame_Title.ZIndex = 2

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
			MainFrame_Title.Text = ("%s %s %s"):format(emoji, MainFrame_Title.Text, emoji)
		end
	end

	local MainFrame_Title_CloseButton = Instance.new("ImageButton", MainFrame_Title)
	MainFrame_Title_CloseButton.AnchorPoint = Vector2.new(1, 0.5)
	MainFrame_Title_CloseButton.BackgroundTransparency = 1
	MainFrame_Title_CloseButton.Position = UDim2.new(1, -5, 0.5, 0)
	MainFrame_Title_CloseButton.Size = UDim2.new(0, 10, 0, 10)
	MainFrame_Title_CloseButton.Image = "rbxassetid://5054663650"
	MainFrame_Title_CloseButton.ZIndex = 10
	MainFrame_Title_CloseButton.MouseButton1Click:Connect(function()
		ScreenGui.Enabled = not ScreenGui.Enabled
	end)

	local MainFrame_TabSelector = Instance.new("Frame", MainFrame)
	MainFrame_TabSelector.AnchorPoint = Vector2.new(0, 1)
	MainFrame_TabSelector.BackgroundColor3 = UIColors.Shade2
	MainFrame_TabSelector.BorderSizePixel = 0
	MainFrame_TabSelector.Position = UDim2.new(0, 0, 1, 0)
	MainFrame_TabSelector.Size = UDim2.new(0, 100, 1, -20)
	MainFrame_TabSelector.ClipsDescendants = true
	local MainFrame_TabSelector_UIListLayout = Instance.new("UIListLayout", MainFrame_TabSelector)
	MainFrame_TabSelector_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	local MainFrame_TabSelector_UIPadding = Instance.new("UIPadding", MainFrame_TabSelector)
	MainFrame_TabSelector_UIPadding.PaddingTop = UDim.new(0, 1)

	local MainFrame_TabHolder = Instance.new("Frame", MainFrame)
	MainFrame_TabHolder.AnchorPoint = Vector2.new(0, 1)
	MainFrame_TabHolder.BackgroundTransparency = 1
	MainFrame_TabHolder.Position = UDim2.new(0, 100, 1, 0)
	MainFrame_TabHolder.Size = UDim2.new(1, -100, 1, -20)
	MainFrame_TabHolder.ClipsDescendants = true
	local MainFrame_TabHolder_UIPadding = Instance.new("UIPadding", MainFrame_TabHolder)
	MainFrame_TabHolder_UIPadding.PaddingTop = UDim.new(0, 5)
	MainFrame_TabHolder_UIPadding.PaddingBottom = UDim.new(0, 5)
	MainFrame_TabHolder_UIPadding.PaddingLeft = UDim.new(0, 5)
	MainFrame_TabHolder_UIPadding.PaddingRight = UDim.new(0, 5)

	local TabCreateElement = {
		SeperationLine = function(Tab:Frame)
			local NewSeperationLine = Instance.new("Frame", Tab)
			NewSeperationLine.BackgroundColor3 = UIColors.Shade2
			NewSeperationLine.BorderSizePixel = 0
			NewSeperationLine.Size = UDim2.new(1, 0, 0, 1)
		end;

		TextLabel = function(Tab:Frame, Text:string, TextSize:number)
			local NewTextLabel = Instance.new("TextLabel", Tab)
			NewTextLabel.BackgroundTransparency = 1
			NewTextLabel.AutomaticSize = Enum.AutomaticSize.XY
			NewTextLabel.Font = Enum.Font.SourceSans
			NewTextLabel.TextWrapped = true
			NewTextLabel.RichText = true
			NewTextLabel.TextYAlignment = Enum.TextYAlignment.Top
			NewTextLabel.TextXAlignment = Enum.TextXAlignment.Left
			NewTextLabel.TextColor3 = UIColors.Text1
			NewTextLabel.TextSize = TextSize or 14
			NewTextLabel.Text = Text
		end;
	}

	local function CreateTab(TabName:string)
		local NewTabHolder = Instance.new("Frame", MainFrame_TabHolder)
		NewTabHolder.BackgroundTransparency = 1
		NewTabHolder.Size = UDim2.new(1, 0, 1, 0)
		NewTabHolder.Visible = false

		local NewTab = Instance.new("Frame", NewTabHolder)
		NewTab.BackgroundTransparency = 1
		NewTab.Size = UDim2.new(1, 0, 1, 0)
		local NewTab_UIListLayout = Instance.new("UIListLayout", NewTab)
		NewTab_UIListLayout.Padding = UDim.new(0, 5)
		NewTab_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

		TabCreateElement.TextLabel(NewTab, "<b>"..TabName.."</b>", 18)
		TabCreateElement.SeperationLine(NewTab)

		local NewTabButton = Instance.new("TextButton", MainFrame_TabSelector)
		NewTabButton.BackgroundColor3 = UIColors.Shade2
		NewTabButton.BorderColor3 = UIColors.Shade1
		NewTabButton.Size = UDim2.new(1, 0, 0, 25)
		NewTabButton.Font = Enum.Font.SourceSans
		NewTabButton.TextColor3 = UIColors.Text1
		NewTabButton.TextSize = 14
		NewTabButton.Text = TabName

		NewTabButton.MouseButton1Click:Connect(function()
			for _,Tab in pairs(MainFrame_TabHolder:GetChildren()) do
				if Tab:IsA("Frame") then
					Tab.Visible = false
				end
			end

			NewTabHolder.Visible = true
		end)

		return(NewTab)
	end

	local HomeTab = CreateTab("Home"); local PluginsTab = CreateTab("Plugins"); local CreditsTab = CreateTab("Credits")
	HomeTab.Parent.Visible = true

	-- Home Tab
	TabCreateElement.TextLabel(HomeTab, PluginDescription, 14)
	TabCreateElement.SeperationLine(HomeTab)
	TabCreateElement.TextLabel(HomeTab, "Would you like to submit your plugin, get your plugin removed, or report a bug?\nJoin the Discord!", 14)
	TabCreateElement.TextLabel(HomeTab, "<b>"..DiscordLink.."</b>", 14)
	TabCreateElement.SeperationLine(HomeTab)
	TabCreateElement.TextLabel(HomeTab, "This project is in desperate need of more plugins, please join the Discord and submit a plugin if you want to help the project.", 14)
	-- Credits Tab
	TabCreateElement.TextLabel(CreditsTab, "<b>flamespill</b> — Founder of InfLib", 14)	
	TabCreateElement.SeperationLine(CreditsTab)
	TabCreateElement.TextLabel(CreditsTab, "<b>Infinite Store</b> — The project that inspired InfLib", 14)	
	TabCreateElement.SeperationLine(CreditsTab)
	TabCreateElement.TextLabel(CreditsTab, "<b>All Plugin Creators</b> — Thank you for being awesome!", 14)	

	-- Plugins Tab

	-- Searching
	local SearchBar_Filter_Holder = Instance.new("Frame", PluginsTab)
	SearchBar_Filter_Holder.BackgroundTransparency = 1
	SearchBar_Filter_Holder.Size = UDim2.new(1, 0, 0, 20)
	local PluginsTab_SearchBar = Instance.new("TextBox", SearchBar_Filter_Holder)
	PluginsTab_SearchBar.BackgroundColor3 = UIColors.Shade2
	PluginsTab_SearchBar.BorderSizePixel = 0
	PluginsTab_SearchBar.Size = UDim2.new(1, 0, 0, 20) -- -25
	PluginsTab_SearchBar.Font = Enum.Font.SourceSans
	PluginsTab_SearchBar.TextSize = 14
	PluginsTab_SearchBar.Text = ""
	PluginsTab_SearchBar.PlaceholderColor3 = Color3.fromRGB(173, 173, 173)
	PluginsTab_SearchBar.PlaceholderText = "Search for a Plugin"
	PluginsTab_SearchBar.TextColor3 = UIColors.Text1
	PluginsTab_SearchBar.ClearTextOnFocus = true
	PluginsTab_SearchBar.TextWrapped = true
--[[
	local OpenFiltering = Instance.new("ImageButton", SearchBar_Filter_Holder)
	OpenFiltering.AnchorPoint = Vector2.new(1, 0.5)
	OpenFiltering.Position = UDim2.new(1, 0, 0.5, 0)
	OpenFiltering.Size = UDim2.new(0, 20, 0, 20)
	OpenFiltering.BorderSizePixel = 0
	OpenFiltering.BackgroundColor3 = UIColors.Shade2
	OpenFiltering.Image = "rbxassetid://7964618035"
]]

	local PluginsTab_ScrollingFrame = Instance.new("ScrollingFrame", PluginsTab)
	PluginsTab_ScrollingFrame.BackgroundTransparency = 1
	PluginsTab_ScrollingFrame.Size = UDim2.new(1, 0, 1, -64)
	PluginsTab_ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	PluginsTab_ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	PluginsTab_ScrollingFrame.BorderSizePixel = 0
	PluginsTab_ScrollingFrame.ScrollBarThickness = 8
	PluginsTab_ScrollingFrame.TopImage = PluginsTab_ScrollingFrame.MidImage
	PluginsTab_ScrollingFrame.BottomImage = PluginsTab_ScrollingFrame.MidImage
	PluginsTab_ScrollingFrame.ScrollBarImageColor3 = UIColors.Scroll
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

	-- Plugin Info
	local PluginsTab_PluginInfoTab = Instance.new("Frame", PluginsTab.Parent)
	PluginsTab_PluginInfoTab.BackgroundTransparency = 1
	PluginsTab_PluginInfoTab.Size = UDim2.new(1, 0, 1, 0)
	PluginsTab_PluginInfoTab.Visible = false
	local PluginsTab_PluginInfoTab_UIListLayout = Instance.new("UIListLayout", PluginsTab_PluginInfoTab)
	PluginsTab_PluginInfoTab_UIListLayout.Padding = UDim.new(0, 5)
	PluginsTab_PluginInfoTab_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	local function PluginsTab_PluginInfoTab_AddTextLabel(TextSize:number)
		local PluginsTab_PluginInfoTab_TextLabel = Instance.new("TextLabel", PluginsTab_PluginInfoTab)
		PluginsTab_PluginInfoTab_TextLabel.BackgroundTransparency = 1
		PluginsTab_PluginInfoTab_TextLabel.AutomaticSize = Enum.AutomaticSize.XY
		PluginsTab_PluginInfoTab_TextLabel.Font = Enum.Font.SourceSans
		PluginsTab_PluginInfoTab_TextLabel.TextWrapped = true
		PluginsTab_PluginInfoTab_TextLabel.RichText = true
		PluginsTab_PluginInfoTab_TextLabel.TextYAlignment = Enum.TextYAlignment.Top
		PluginsTab_PluginInfoTab_TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		PluginsTab_PluginInfoTab_TextLabel.TextColor3 = UIColors.Text1
		PluginsTab_PluginInfoTab_TextLabel.TextSize = TextSize or 14
		return(PluginsTab_PluginInfoTab_TextLabel)
	end

	local PluginsTab_PluginInfoTab_PluginName_TextLabel = PluginsTab_PluginInfoTab_AddTextLabel(18)
	local PluginsTab_PluginInfoTab_PluginCreator_TextLabel = PluginsTab_PluginInfoTab_AddTextLabel(14)
	TabCreateElement.SeperationLine(PluginsTab_PluginInfoTab)
	local PluginsTab_PluginInfoTab_PluginDescription_TextLabel = PluginsTab_PluginInfoTab_AddTextLabel(14)
	TabCreateElement.SeperationLine(PluginsTab_PluginInfoTab)
	local PluginInfoTab_ButtonHolder = Instance.new("Frame", PluginsTab_PluginInfoTab)
	PluginInfoTab_ButtonHolder.BackgroundTransparency = 1
	PluginInfoTab_ButtonHolder.AutomaticSize = Enum.AutomaticSize.XY
	local PluginInfoTab_ButtonHolder_UIListLayout = Instance.new("UIListLayout", PluginInfoTab_ButtonHolder)
	PluginInfoTab_ButtonHolder_UIListLayout.Padding = UDim.new(0, 5)
	PluginInfoTab_ButtonHolder_UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	PluginInfoTab_ButtonHolder_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	local PluginInfoTab_ButtonHolder = Instance.new("Frame", PluginsTab_PluginInfoTab)
	PluginInfoTab_ButtonHolder.BackgroundTransparency = 1
	PluginInfoTab_ButtonHolder.AutomaticSize = Enum.AutomaticSize.XY
	local PluginInfoTab_ButtonHolder_UIListLayout = Instance.new("UIListLayout", PluginInfoTab_ButtonHolder)
	PluginInfoTab_ButtonHolder_UIListLayout.Padding = UDim.new(0, 5)
	PluginInfoTab_ButtonHolder_UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	PluginInfoTab_ButtonHolder_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	PluginsTab_SearchBar.Changed:Connect(function()
		for i,v in pairs(PluginsTab_ScrollingFrame:GetChildren()) do
			if v:IsA("TextLabel") then
				v.Visible = string.find(v.Name:lower(), PluginsTab_SearchBar.Text:lower()) ~= nil
			end
		end
	end)

	local function SetUp_PluginsTab_PluginsInfoPage(PluginName:string, PluginsListTitle:TextLabel, PluginsListInstallUninstallButton:TextButton)
		PluginsTab.Visible = false

		for _,TextButton in pairs(PluginInfoTab_ButtonHolder:GetChildren()) do
			if TextButton:IsA("TextButton") then TextButton:Destroy() end
		end

		local PluginInfo = loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/flamespill/InfLib/refs/heads/main/Core/Plugins/'..SetLinkCompatible(PluginName)..".lua"))()

		PluginsTab_PluginInfoTab_PluginName_TextLabel.Text = "<b>"..PluginInfo["PluginName"].."</b>"
		PluginsTab_PluginInfoTab_PluginCreator_TextLabel.Text = "<b>Creator:</b> "..PluginInfo["PluginCreator"]
		PluginsTab_PluginInfoTab_PluginDescription_TextLabel.Text = PluginInfo["PluginDescription"]

		local function AddButton(Text:string)
			local NewButton = Instance.new("TextButton", PluginInfoTab_ButtonHolder)
			NewButton.Size = UDim2.new(0, 0, 0, 0)
			NewButton.AutomaticSize = Enum.AutomaticSize.XY
			NewButton.BackgroundColor3 = UIColors.Shade2
			NewButton.BorderSizePixel = 0
			NewButton.Font = Enum.Font.SourceSans
			NewButton.TextColor3 = UIColors.Text1
			NewButton.TextSize = 18
			NewButton.Text = Text
			local NewButton_UIPadding = Instance.new("UIPadding", NewButton)
			NewButton_UIPadding.PaddingLeft = UDim.new(0, 12)
			NewButton_UIPadding.PaddingRight = UDim.new(0, 12)
			NewButton_UIPadding.PaddingTop = UDim.new(0, 6)
			NewButton_UIPadding.PaddingBottom = UDim.new(0, 6)
			return(NewButton)
		end

		local InstallUninstallButton = AddButton("Install")
		local ReloadButton = AddButton("Reload"); ReloadButton.Visible = false
		local CloseButton = AddButton("Close")

		if isfile(PluginName..".iy") then
			PluginsTab_PluginInfoTab_PluginName_TextLabel.Text = "<b>"..PluginInfo["PluginName"].."</b> [<b>✓</b> Installed]"
			InstallUninstallButton.Text = "Uninstall"
			ReloadButton.Visible = true
		end

		InstallUninstallButton.MouseButton1Click:Connect(function()
			if InstallUninstallButton.Text == "Install" then
				DownloadPlugin(PluginName)
				InstallUninstallButton.Text = "Uninstall"
				PluginsTab_PluginInfoTab_PluginName_TextLabel.Text = "<b>"..PluginInfo["PluginName"].."</b> [<b>✓</b> Installed]"
				PluginsListTitle.Text = "<b>✓</b> "..PluginName
				PluginsListInstallUninstallButton.Text = "Uninstall"
				ReloadButton.Visible = true
			else
				DeletePlugin(PluginName)
				InstallUninstallButton.Text = "Install"
				PluginsTab_PluginInfoTab_PluginName_TextLabel.Text = "<b>"..PluginInfo["PluginName"].."</b>"
				PluginsListTitle.Text = PluginName
				PluginsListInstallUninstallButton.Text = "Install"
				ReloadButton.Visible = false
			end
		end)
		ReloadButton.MouseButton1Click:Connect(function()
			deletePlugin(PluginName)
			wait(1)
			DownloadPlugin(PluginName)
		end)
		CloseButton.MouseButton1Click:Connect(function()
			PluginsTab.Visible = true
			PluginsTab_PluginInfoTab.Visible = false
		end)

		PluginsTab_PluginInfoTab.Visible = true

	end

	local function PluginsTab_AddPlugin(PluginName)
		local PluginTitle = Instance.new("TextLabel", PluginsTab_ScrollingFrame)
		PluginTitle.Name = PluginName
		PluginTitle.BackgroundColor3 = UIColors.Shade1
		PluginTitle.BackgroundTransparency = 0
		PluginTitle.BorderColor3 = UIColors.Shade2
		PluginTitle.Size = UDim2.new(1, -10, 0, 20)
		PluginTitle.Font = Enum.Font.SourceSans
		PluginTitle.TextColor3 = UIColors.Text1
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
		InformationButton.BackgroundColor3 = UIColors.Shade2
		InformationButton.BorderSizePixel = 0
		InformationButton.Font = Enum.Font.SourceSans
		InformationButton.TextColor3 = UIColors.Text1
		InformationButton.TextSize = 14
		InformationButton.Text = "More"
		local InformationButton_UIPadding = Instance.new("UIPadding", InformationButton)
		InformationButton_UIPadding.PaddingLeft = UDim.new(0, 6)
		InformationButton_UIPadding.PaddingRight = UDim.new(0, 6)

		local InstallUninstallButton = Instance.new("TextButton", PluginTitle)
		InstallUninstallButton.Size = UDim2.new(0, 0,1, 0)
		InstallUninstallButton.AutomaticSize = Enum.AutomaticSize.X
		InstallUninstallButton.BackgroundColor3 = UIColors.Shade2
		InstallUninstallButton.BorderSizePixel = 0
		InstallUninstallButton.Font = Enum.Font.SourceSans
		InstallUninstallButton.TextColor3 = UIColors.Text1
		InstallUninstallButton.TextSize = 14
		InstallUninstallButton.Text = "Install"
		local InstallUninstallButton_UIPadding = Instance.new("UIPadding", InstallUninstallButton)
		InstallUninstallButton_UIPadding.PaddingLeft = UDim.new(0, 6)
		InstallUninstallButton_UIPadding.PaddingRight = UDim.new(0, 6)

		InformationButton.MouseButton1Click:Connect(function()
			SetUp_PluginsTab_PluginsInfoPage(PluginName, PluginTitle, InstallUninstallButton)
		end)

		if isfile(PluginName..".iy") then
			InstallUninstallButton.Text = "Uninstall"
			PluginTitle.Text = "<b>✓</b> "..PluginName
		end

		InstallUninstallButton.MouseButton1Click:Connect(function()
			if InstallUninstallButton.Text == "Uninstall" then
				DeletePlugin(PluginName)
				PluginTitle.Text = PluginName
				InstallUninstallButton.Text = "Install"
			elseif InstallUninstallButton.Text == "Install" then
				DownloadPlugin(PluginName)
				PluginTitle.Text = "<b>✓</b> ".. PluginName
				InstallUninstallButton.Text = "Uninstall"
			end
		end)

	end

	local PluginsList = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/flamespill/InfLib/refs/heads/main/Core/PluginsList.lua"))()
	for i,v in ipairs(PluginsList) do
		PluginsTab_AddPlugin(v)
	end

	ScreenGuiToggleReset = ScreenGui:GetPropertyChangedSignal("Enabled"):Connect(function()
		for _,Tab in pairs(MainFrame_TabHolder:GetChildren()) do
			if Tab:IsA("Frame") then Tab.Visible = false end
		end
		PluginsTab.Visible = true; PluginsTab_PluginInfoTab.Visible = false
		HomeTab.Parent.Visible = true
		MainFrame.Position = UDim2.new(0.5, -MainFrame.Size.X.Offset / 2, 0.5, -MainFrame.Size.Y.Offset / 2)
	end)

end

-- Anti-Self-Report
local CaptureService = cloneref(game:GetService("CaptureService")) or game:GetService("CaptureService")
CaptureService.CaptureBegan:Connect(function()
	ScreenGui.Enabled = false
end)
CaptureService.CaptureEnded:Connect(function()
	task.delay(0.1, function()
		ScreenGui.Enabled = true
	end)
end)

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
				ScreenGuiToggleReset:Disconnect()
				ScreenGui:ClearAllChildren()
				CreateGUI()
				ScreenGui.Enabled = true

			end
		}
	}
}
return Plugin
