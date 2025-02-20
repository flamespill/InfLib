local Plugin = {
    ["PluginCreator"] = "ellllieee",
    ["PluginName"] = "TouchFling",
    ["PluginDescription"] = "Adds a TouchFling Command that's superior to IY's WalkFling.",
    ["Commands"] = {
        ["touchfling"] = {
            ["ListName"] = "touchfling / tf",
            ["Description"] = "Any unanchored part you touch, it gets flung.",
            ["Aliases"] = {"tf", "touchfling"},
            ["Function"] = function(args,speaker)
                local RunService = game:GetService("RunService")
                getgenv().TouchFling = not getgenv().TouchFling
                if getgenv().TouchFling then
                    notify("TouchFling", "TouchFling is now on.")
                    while getgenv().TouchFling do
                        if speaker.Character and speaker.Character:FindFirstChild("HumanoidRootPart") then
                            local rootPart = speaker.Character.HumanoidRootPart
                            local vel = rootPart.Velocity
                            rootPart.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
                            RunService.RenderStepped:Wait()
                            rootPart.Velocity = vel
                            RunService.Stepped:Wait()
                            rootPart.Velocity = vel + Vector3.new(0, 0.1, 0)
                        end
                        task.wait()
                    end
                else
                     notify("TouchFling", "TouchFling is now off.")
                end
            end
        }
    }
}
return Plugin
