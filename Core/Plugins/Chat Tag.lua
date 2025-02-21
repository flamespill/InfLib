local Plugin = {
    ["PluginCreator"] = "visiblename",
    ["PluginName"] = "ChatTag",
    ["PluginDescription"] = "Adds a custom tag behind your username. (client-sided)",
    ["Commands"] = {
        ["Tag"] = {
            ["ListName"] = "Tag [color] [tagname]",
            ["Description"] = "ofc its clientsided!",
            ["Aliases"] = {"tagging", "chattag", "name"},
            ["Function"] = function(args, speaker)
                local chatTagSettings = {
                    colorCode = args[1] or "#cd2c18",
                    tagLabel = args[2] or "[IY]"
                }
                game:GetService("TextChatService").OnIncomingMessage = function(messageData)
                    local messageProps = Instance.new("TextChatMessageProperties")
                    local sender = game:GetService("Players"):GetPlayerByUserId(messageData.TextSource.UserId)
                    if sender.Name == game:GetService("Players").LocalPlayer.Name then
                        messageProps.PrefixText = string.format('<font color="%s">%s</font> %s', chatTagSettings.colorCode, chatTagSettings.tagLabel, messageData.PrefixText)
                    end
                    return messageProps
                end
            end
        }
    }
}

return Plugin
