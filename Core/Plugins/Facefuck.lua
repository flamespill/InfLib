
local connections = {
    facefuckrun = nil,
    facefuckanim = nil
}
local Facefuck = {

    ["PluginCreator"] = "lordofmountain_", -- Discord UserId: 1212781365259403326
    ["PluginName"] = "Facefuck",
    ["PluginDescription"] = "Adds a command similar to the bang command, but does it to the other player's face.",
    ["Commands"] = {
        ["facefuck"] = {
            ["ListName"] = "facefuck (player)",
            ["Description"] = "Makes you get blowjob",
            ["Aliases"] = {"bj","blowjob","head","facefuck"},
            ["Function"] = function(args,speaker)

   
                local Players = game:GetService("Players")
                local victim = getPlayer(args[1],speaker)
                for i,v in victim do
                    
                victim = Players[v]
                end
                
                
                local animation = Instance.new("Animation")
                animation.AnimationId = not r15(speaker) and "rbxassetid://148840371" or "rbxassetid://5918726674"
                connections.facefuckanim= speaker.Character.Humanoid:LoadAnimation(animation)
                connections.facefuckanim:Play()
                connections.facefuckanim:AdjustSpeed(args[2])

                connections.facefuckrun = game:GetService("RunService").Heartbeat:Connect(function()
                Players.LocalPlayer.Character.HumanoidRootPart.CFrame = victim.Character.Head.CFrame *CFrame.new(0,0.72,-1) --+Vector3.new(1.5,1,0)
Players.LocalPlayer.Character.HumanoidRootPart.CFrame *= CFrame.Angles(0, math.rad(552), 0)

                end)
                victim.ChildRemoved:Connect(function()
                connections.facefuckanim:Stop()
                connections.facefuckrun:Disconnect()
                notify("Player left.")
                end)
                
            end
        },
        ["unfacefuck"] = {
            ["ListName"] = "unfacefuck (stops the facefuck)",
            ["Description"] = "makes you get head",
            ["Aliases"] = {"unbj","unblowjob","unhead"},
            ["Function"] = function()
               connections.facefuckanim:Stop()
               connections.facefuckrun:Disconnect()
                
            end
        }
    }
}

return Facefuck
