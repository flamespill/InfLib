-- credits: some random devfourm and vr3million
local Plugin = {
    ["PluginCreator"] = "omarthebestman",
    ["PluginName"] = "Screenshake",
    ["PluginDescription"] = "Adds a command that shakes your screen.",
    ["Commands"] = {
        ["ScreenShake"] = {
            ["ListName"] = "screenshake [duration] [intensity] [fps]",
            ["Description"] = "Shakes the screen",
            ["Aliases"] = {'earthquake'},
            ["Function"] = function(args, speaker)
                local player = game.Players:FindFirstChild(speaker.Name)
                if not player or not player.Character then
                    notify("Player not found or character does not exist.")
                    return
                end

                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if not humanoid then
                    notify("Humanoid not found.")
                    return
                end

                local runService = game:GetService("RunService")

                local duration = tonumber(args[1]) or 2
                local shakeIntensity = tonumber(args[2]) or 1
                local fps = tonumber(args[3]) or 30

                notify("Starting screen shake for " .. duration .. " seconds with intensity " .. shakeIntensity .. " at " .. fps .. " FPS.")

                local oldOffset = humanoid.CameraOffset
                local shakeIterations = duration * fps

                for i = 0, shakeIterations do
                    local offset = Vector3.new(
                        math.random(-shakeIntensity, shakeIntensity), 
                        math.random(-shakeIntensity, shakeIntensity), 
                        math.random(-shakeIntensity, shakeIntensity)
                    )
                    humanoid.CameraOffset = oldOffset + offset * 0.1
                    runService.Heartbeat:Wait()
                end

                humanoid.CameraOffset = oldOffset

                notify("Screen shake completed")
            end
        }
    }
}

return Plugin
