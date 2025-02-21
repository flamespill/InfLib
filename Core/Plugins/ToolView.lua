local Plugin = {
    ["PluginCreator"] = "weszin3",
    ["PluginName"] = "Tool Viewer",
    ["PluginDescription"] = "view another player's tools",
    ["Commands"] = {
        ["toolview"] = {
            ["ListName"] = "toolview / tview [user]",
            ["Description"] = "backpack + character",
            ["Aliases"] = {"toolview", "tview"},
            ["Function"] = function(args, speaker)
                local s, e = pcall(function()
                local pl = Players:FindFirstChild(getPlayer(args[1], speaker)[1])
                if not pl then return notify("invalid argument passed") end
                local t, chartool = {}, pl.Character:FindFirstChildOfClass("Tool")

                for _, v in pl.Backpack:GetChildren() do
                    if not v:IsA("Tool") then continue end
                    table.insert(t, tostring(v))
                end
                
                if chartool then 
                    notify(("%s's tools"):format(tostring(pl)), tostring(chartool).. ", " ..table.concat(t, ", "))
                else
                    notify(("%s's tools"):format(tostring(pl)), table.concat(t, ", "))
                end
                end)
                print(e)
            end
        }
    }
}
return Plugin
