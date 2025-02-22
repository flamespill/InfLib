local players  = game:GetService('Players')
local textService = game:GetService('TextService')
local tweenService = game:GetService('TweenService')
local userInputService = game:GetService('UserInputService')
local runService = game:GetService('RunService')
local teams = game:GetService('Teams')
local coreGui = game:GetService('CoreGui')

local Bar = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UIPadding = Instance.new("UIPadding")
local UIListLayout = Instance.new("UIListLayout")
local UIPadding_2 = Instance.new("UIPadding")

local cmdBar = Instance.new("TextBox")
local highlight = Instance.new("TextLabel")
local suggestionsUI = Instance.new("ScrollingFrame")
local suggestionTemplate = Instance.new("TextLabel")

Bar.Parent = coreGui
Bar.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Bar.Enabled = false

Frame.Parent = Bar
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.fromScale(0.5, 0.75) -- Change this line to change position, the first number is left,right, and the second number is up,down, >0.5 to down or right | 0.5< to up or left
Frame.Size = UDim2.fromOffset(380, 45) -- Change this line to change the size of the bar, the first number is the width, the second is the height

suggestionsUI.Parent = Frame
suggestionsUI.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
suggestionsUI.BackgroundTransparency = 1.000
suggestionsUI.BorderColor3 = Color3.fromRGB(0, 0, 0)
suggestionsUI.BorderSizePixel = 0
suggestionsUI.Position = UDim2.new(0, 0, 1, 0)
suggestionsUI.Selectable = false
suggestionsUI.Size = UDim2.new(1, 0, 0, 280)
suggestionsUI.CanvasSize = UDim2.new(0, 0, 0, 0)
suggestionsUI.AutomaticCanvasSize = Enum.AutomaticSize.Y
suggestionsUI.ScrollBarThickness = 0
suggestionsUI.ScrollingEnabled = false

suggestionTemplate.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
suggestionTemplate.BorderColor3 = Color3.fromRGB(0, 0, 0)
suggestionTemplate.BorderSizePixel = 0
suggestionTemplate.Size = UDim2.new(1, 0, 0, 35)
suggestionTemplate.Font = Enum.Font.Gotham
suggestionTemplate.Text = ""
suggestionTemplate.RichText = true
suggestionTemplate.TextColor3 = Color3.fromRGB(255, 255, 255)
suggestionTemplate.TextSize = 14.000
suggestionTemplate.TextXAlignment = Enum.TextXAlignment.Left

UIPadding.Parent = suggestionTemplate
UIPadding.PaddingLeft = UDim.new(0, 7)

UIListLayout.Parent = suggestionsUI
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

cmdBar.Parent = Frame
cmdBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
cmdBar.BackgroundTransparency = 1.000
cmdBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
cmdBar.BorderSizePixel = 0
cmdBar.Selectable = false
cmdBar.Size = UDim2.new(1, 0, 1, 0)
cmdBar.ClearTextOnFocus = false
cmdBar.Font = Enum.Font.GothamMedium
cmdBar.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
cmdBar.Text = ""
cmdBar.TextColor3 = Color3.fromRGB(222, 222, 222)
cmdBar.TextSize = 16.000
cmdBar.TextXAlignment = Enum.TextXAlignment.Left

UIPadding_2.Parent = cmdBar
UIPadding_2.PaddingLeft = UDim.new(0, 13)

highlight.Parent = cmdBar
highlight.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
highlight.BackgroundTransparency = 1.000
highlight.BorderColor3 = Color3.fromRGB(0, 0, 0)
highlight.BorderSizePixel = 0
highlight.Size = UDim2.new(0, 0, 1, 0)
highlight.Font = Enum.Font.GothamMedium
highlight.Text = ""
highlight.TextColor3 = Color3.fromRGB(125, 125, 125)
highlight.TextSize = 16.000
highlight.TextXAlignment = Enum.TextXAlignment.Left

local lastArgument = ''
local currentSelection = 0
local buttons = {}
local suggestions = {}
local seperatedCommand = ''
local prevButton = nil

local maxSuggestions = 5 -- change this line to increase or decrease the number of max entries of the suggestions
suggestionsUI.Size = UDim2.new(1, 0, 0, suggestionTemplate.AbsoluteSize.Y*maxSuggestions)

local specialCasses = {'all', 'others', 'me', 'random', 'allies', 'enemies', 'team', 'nonteam', 'friends', 'nonfriends', 'nearest', 'farthest', 'alive', 'dead'}
local coreGuiTypes = {'inventory', 'playerlist', 'chat', 'reset', 'emotes', 'all'}

local commands = {}
local types = {
	['player'] = 'player';
	['team name'] = 'team';
	['class name'] = 'class';
	['inventory/playerlist/chat/reset/emotes/all'] = 'coregui';
}

function parseCommand(command)
	local aliases = command:split(' / ')
	local lastAlias = aliases[#aliases]

	local arguments = {}
	for arg in lastAlias:gmatch('%[(.-)%]') or {} do
		table.insert(arguments, types[arg] or 'any')
	end

	for _, alias in pairs(aliases) do
		alias = alias:match('^%s*(%w+)')
		if alias then commands[alias] = arguments end
	end
end

for _, label in pairs(CMDsF:GetChildren()) do
	if label:IsA('TextButton') and label.Text ~= '' then
		parseCommand(label.Text)
	end
end

CMDsF.ChildAdded:Connect(function(label)
	runService.RenderStepped:Wait()

	if label:IsA('TextButton') and label.Text ~= '' then
		parseCommand(label.Text)
	end
end)

local argumentTypes = {
	command = function(start)
		if start == '' then
			return {}
		end

		local start = start:lower()
		local suggestions = {}

		for command, _ in pairs(commands) do
			local cmdStart = command:sub(0, #start)
			if cmdStart == start then
				table.insert(suggestions, command)
			end
		end

		return suggestions
	end,

	player = function(start)
		if start == '' then
			return {}
		end

		local suggestions = {}

		local players = players:GetPlayers()
		for _, player in pairs(players) do
			local nameStart = player.Name:sub(0, #start):lower()
			local displayStart = player.DisplayName:sub(0, #start):lower()

			if nameStart == start then
				table.insert(suggestions, player.Name)
			elseif displayStart == start then
				table.insert(suggestions, player.DisplayName)
			end
		end

		for _, arg in pairs(specialCasses) do
			local cmdStart = arg:sub(0, #start):lower()
			if cmdStart == start then
				table.insert(suggestions, arg)
			end
		end

		return suggestions
	end,

	coregui = function(start)
		local start = start:lower()
		local suggestions = {}

		for _, arg in pairs(coreGuiTypes) do
			local cmdStart = arg:sub(0, #start)
			if start == cmdStart then
				table.insert(suggestions, arg)
			end
		end

		return suggestions
	end,

	team = function(start)
		local start = start:lower()
		local suggestions = {}

		for _, team in pairs(teams:GetTeams()) do
			local cmdStart = team.Name:sub(0, #start)
			if cmdStart == start then
				table.insert(suggestions, team.Name)
			end
		end

		return suggestions
	end,

	class = function()
		return {} -- TODO
	end,

	any = function() 
		return {} 
	end
}

function clearSuggestions()
	for _, suggestion in pairs(buttons) do
		suggestion:Destroy()
	end
end

function updateSelection()
	if prevButton then
		prevButton.BackgroundColor3 = Color3.fromRGB(46, 46, 47) 
	end

	local button = buttons[currentSelection + 1]
	if button then
		button.BackgroundColor3 = Color3.fromRGB(70, 70, 71)
		prevButton = button
	end

	tweenService:Create(suggestionsUI, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
		CanvasPosition = Vector2.new(0, math.round(currentSelection - maxSuggestions/2) * suggestionTemplate.AbsoluteSize.Y)
	}):Play()

	local suggestion = (suggestions[currentSelection+1] or ''):sub(#lastArgument+1)
	local offset = textService:GetTextSize(cmdBar.Text, cmdBar.TextSize, cmdBar.Font, Vector2.new(cmdBar.AbsoluteSize.X, cmdBar.AbsoluteSize.Y))
	highlight.Position = UDim2.fromOffset(offset.X, 0)
	highlight.Text = suggestion
end

function renderSuggestions(text)
	clearSuggestions()

	local lastCommand = text:split('\\')
	lastCommand = lastCommand[#lastCommand]

	local arguments = lastCommand:split(' ')
	local command = arguments[1]
	seperatedCommand = command:match('[^%^]+$') or command

	local lastIndex = #arguments
	lastArgument = arguments[lastIndex]

	buttons = {}
	suggestions = {}

	if lastIndex == 1 then
		lastArgument = seperatedCommand
		suggestions = argumentTypes.command(lastArgument)
	elseif lastIndex > 1 then
		local commandArguments = commands[seperatedCommand:lower()]
		if commandArguments then
			local argumentType = commandArguments[lastIndex-1]
			
			if argumentType == 'player' then
				local players = lastArgument:split(',')
				lastArgument = players[#players]
			end
			
			if argumentType then 
				suggestions = argumentTypes[argumentType](lastArgument) 
			end
		end
	end

	for _, suggestion in pairs(suggestions) do
		local newSuggestion = suggestionTemplate:Clone()
		newSuggestion.Parent = suggestionsUI
		newSuggestion.Text = `<b>{lastArgument}</b>`..suggestion:sub(#lastArgument+1)

		table.insert(buttons, newSuggestion)
	end

	currentSelection = math.clamp(currentSelection, 0, math.max(#suggestions-1, 0))
	updateSelection()
end

cmdBar:GetPropertyChangedSignal('Text'):Connect(function()
	local text = cmdBar.Text
	renderSuggestions(text)
end)

cmdBar.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		if #suggestions > 1 and not commands[seperatedCommand] then
			local suggestion = (suggestions[currentSelection+1] or ''):sub(#lastArgument+1)
			cmdBar.Text = cmdBar.Text .. suggestion .. ' '
		end

		execCmd(cmdBar.Text)
	end
	
	cmdBar.Text = ''
	Bar.Enabled = false
end)

userInputService.InputBegan:Connect(function(input, gameProccesed)
	if not gameProccesed then
		return
	end

	if not cmdBar:IsFocused() then
		return
	end

	if input.KeyCode == Enum.KeyCode.Tab then
		local currentText = cmdBar.Text
		local suggestion = (suggestions[currentSelection+1] or ''):sub(#lastArgument+1)

		runService.RenderStepped:Wait()

		cmdBar.Text = currentText..suggestion..' '
		cmdBar.CursorPosition = #cmdBar.Text+1
	end

	if input.KeyCode == Enum.KeyCode.Down then
		local hold = true

		connection = userInputService.InputEnded:Connect(function(input)
			if input.KeyCode == Enum.KeyCode.Down then
				hold = false
				connection:Disconnect()
			end
		end)

		while hold do
			currentSelection = (currentSelection + 1) % #suggestions
			updateSelection()

			task.wait(0.2)
		end
	end

	if input.KeyCode == Enum.KeyCode.Up then
		local hold = true

		connection = userInputService.InputEnded:Connect(function(input)
			if input.KeyCode == Enum.KeyCode.Up then
				hold = false
				connection:Disconnect()
			end
		end)

		while hold do
			currentSelection = (currentSelection + #suggestions - 1) % #suggestions
			updateSelection()

			task.wait(0.2)
		end
	end
end)

return {
	['PluginCreator'] = 'im_real.', -- Discord UserId: 1036966866301767731
	['PluginName'] = 'Quickbar',
	['PluginDescription'] = 'Lets you quickly type commands using a new custom & simple command bar.',
	['Commands'] = {
		['cmdbar'] = {
			["ListName"] = "cmdbar",
			['Description'] = "Launches Quickbar",
			['Aliases'] = {'cmdbar'},
			['Function'] = function(args, speaker)
				runService.RenderStepped:Wait()
				
				Bar.Enabled = true
				cmdBar:CaptureFocus()
			end,
		}
	}
}
