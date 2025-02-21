-- Only set one to true, or it will default to ScaleFrame.
-- Heavily recommend choosing ScaleFrame
local SizeType = {
	ScaleText = false;
	ScaleFrame = true
}

if SizeType.ScaleText == SizeType.ScaleFrame then
	SizeType.ScaleText = false; SizeType.ScaleFrame = true
end

if SizeType.ScaleText == true then
	Title_2.TextScaled = true
	Text_2.TextScaled = true
elseif SizeType.ScaleFrame == true then
	Notification.Position = UDim2.new(1, -250, 1, 0)
	Notification.AnchorPoint = Vector2.new(1, 0)
	Notification.AutomaticSize = Enum.AutomaticSize.XY
	Title_2.Size = UDim2.new(1, 0, 0, 20)
	Title_2.AutomaticSize = Enum.AutomaticSize.X
	Text_2.AutomaticSize = Enum.AutomaticSize.XY
end

local Plugin = {
	["PluginCreator"] = "flamespill",
	["PluginName"] = "BetterNotifySize",
	["PluginDescription"] = "Resizes Notifications to fit the content inside.",
}

return Plugin
