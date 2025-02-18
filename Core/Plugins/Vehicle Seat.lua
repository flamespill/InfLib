local function notifyUser(message)
    notify("Notification", message)
end

local plugin = {
    ["PluginCreator"] = "ffj2.0",
    ["PluginName"] = "Vehicle Seat",
    ["PluginDescription"] = "Change your vehicle speed/torque (only works with vehicles using the default Roblox driving system, you need to be in the drivers seat)",
    ["Commands"] = {
        ["vehiclespeed"] = {
            ["ListName"] = "vehiclespeed [num]",
            ["Description"] = "Changes the speed of the vehicle",
            ["Aliases"] = { "vs" },
            ["Function"] = function(arguments, player)
                local speed = tonumber(arguments[1])
                if not speed then
                    return notifyUser("Please specify a speed in number as an argument.")
                end

                local character = player.Character
                if not character then
                    return notifyUser("You don't have a character yet.")
                end

                local humanoid = character:FindFirstChildWhichIsA("Humanoid")
                if not humanoid then
                    return notifyUser("You don't have a humanoid yet.")
                end

                local seat = humanoid.SeatPart
                if not seat or not seat:IsA("VehicleSeat") then
                    return notifyUser("You are not sitting in a vehicle seat.")
                end

                local canModify = seat.AreHingesDetected
                if canModify < 1 then
                    return notifyUser("Unfortunately, this vehicle's speed cannot be changed. Only vehicles using the default Roblox driving system (with surface-type hinges) can be modified.")
                end

                seat.MaxSpeed = speed
                notifyUser("Changed the vehicle's max speed to " .. tostring(speed))
            end
        },

        ["vehicletorque"] = {
            ["ListName"] = "vehicletorque [num]",
            ["Description"] = "Changes the torque of the vehicle",
            ["Aliases"] = { "vt" },
            ["Function"] = function(arguments, player)
                local torque = tonumber(arguments[1])
                if not torque then
                    return notifyUser("Please specify a torque value in number as an argument.")
                end

                local character = player.Character
                if not character then
                    return notifyUser("You don't have a character yet.")
                end

                local humanoid = character:FindFirstChildWhichIsA("Humanoid")
                if not humanoid then
                    return notifyUser("You don't have a humanoid yet.")
                end

                local seat = humanoid.SeatPart
                if not seat or not seat:IsA("VehicleSeat") then
                    return notifyUser("You are not sitting in a vehicle seat.")
                end

                local canModify = seat.AreHingesDetected
                if canModify < 1 then
                    return notifyUser("Unfortunately, this vehicle's torque cannot be changed. Only vehicles using the default Roblox driving system (with surface-type hinges) can be modified.")
                end

                seat.Torque = torque
                notifyUser("Changed the vehicle's torque to " .. tostring(torque))
            end
        }
    }
}

return plugin
