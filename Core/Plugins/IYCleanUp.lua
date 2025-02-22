local PatchedCommands = {
	"invisfling",
	"givetool",
	"kill",
	"god",
	"joinplayer",
	"attach",
	"fastkill",
	"bring",
	"fastbring",
	"teleport",
	"fastteleport",
	"loopoof",
	"creeper"
}

for _,PatchedCommand in pairs(PatchedCommands) do
	overridecmd(PatchedCommand, function() -- overridecmd not deletecmd because deletecmd keeps it in the list but deletes the command, overriding it with a notification could make it easier for skids
		notify("IYCleanUp", "The command '"..PatchedCommand.."' no longer works.")
	end)
end

local Plugin = {
	["PluginCreator"] = "flamespill", -- Discord UserId: 1018142081878851595
	["PluginName"] = "IYCleanUp",
	["PluginDescription"] = "Deletes commands known not to work."
}
return Plugin
