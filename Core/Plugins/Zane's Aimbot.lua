local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local AimbotEnabled = false
local TeamCheckEnabled = false
local WallCheckEnabled = false
local SmoothenEnabled = false
local ClosestPosition = false
local IgnoreFriends = false
local PredictMovements = false
local AimPart = "Head"
local AlliesTable = {}
local InputPlayer = nil
local Offset = 0
local PredictDistance = 3
local TargetLoop

local function IsEnemy(Player)
    if Player.Team ~= LocalPlayer.Team then
        return true
    else
        return false
    end
end

local function IsFriendOfLocalPlayer(Player)
    return LocalPlayer:IsFriendsWith(Player.UserId)
end

local function IsPlayerListed(Table, Player)
    for _, Target in ipairs(Table) do
        if Target == Player then
            return true
        end
    end
    return false
end

local function RemoveFromTable(Table, Player)
    for i, Target in ipairs(Table) do
        if Target == Player then
            table.remove(Table, i)
            return
        end
    end
end

local function FindPlayerWithName(Name, Speaker)
    local PlayersList = getPlayer(Name, Speaker)
    for _, PlayerName in pairs(PlayersList) do
        local Player = Players:FindFirstChild(PlayerName)
        if Player then
            return Player
        end
    end
    return nil
end

local function GetPart(PartName, Character)
    for _, Child in ipairs(Character:GetChildren()) do
        if Child:IsA("BasePart") and Child.Name:lower() == PartName:lower() then
            return Child
        end
    end
    return nil
end


local function LookAt(Target)
    local LookVector = (Target - Camera.CFrame.Position).unit
    local NewCFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + LookVector)
    local TweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local Tween = game:GetService("TweenService"):Create(Camera, TweenInfo, {CFrame = NewCFrame})
    if not SmoothenEnabled then
        Camera.CFrame = NewCFrame
    else
        Tween:Play()
    end
end

local function PredictMovement(Player)
    local Character = Player.Character or Player.CharacterAdded:Wait()
    if Character and Character:FindFirstChild("HumanoidRootPart") then
        local RootPart = GetPart("HumanoidRootPart", Character)
        local Velocity = RootPart.Velocity
        local MoveDirection = Character:FindFirstChildWhichIsA("Humanoid").MoveDirection
        local FuturePosition = RootPart.Position + Velocity * 0.2 + MoveDirection * PredictDistance 
        return FuturePosition
    end
    return nil
end


function GetClosestEnemyPlayer(TargetPart)
    local NearestPlayer = nil
    local LastDistance = math.huge

    for _, Player in ipairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid") and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").Health > 0 and Player.Character and Player.Character:FindFirstChildWhichIsA("Humanoid") and Player.Character:FindFirstChildWhichIsA("Humanoid").Health > 0 then
            local IsAllowed = true
            if TeamCheckEnabled and IsEnemy(Player) then
                IsAllowed = true
            end

            if IsAllowed and not IsPlayerListed(AlliesTable, Player) and (not IgnoreFriends or not IsFriendOfLocalPlayer(Player)) then
                if not ClosestPosition then
                    local AimObject =  GetPart(TargetPart, Player.Character or Player.CharacterAdded:Wait()) or GetPart("UpperTorso", Player.Character or Player.CharacterAdded:Wait())
                    if AimObject then
                        local EyePos, IsVisible = Camera:WorldToViewportPoint(AimObject.Position)
                        local AimPos = Vector2.new(EyePos.x, EyePos.y)
                        local MousePos = Vector2.new(Camera.ViewportSize.x / 2, Camera.ViewportSize.y / 2)
                        local Distance = (AimPos - MousePos).magnitude
                        if Distance < LastDistance and IsVisible then
                            if WallCheckEnabled then
                                local Ray = Ray.new(Camera.CFrame.Position, (AimObject.Position - Camera.CFrame.Position).Unit * 500)
                                local Part = workspace:FindPartOnRayWithIgnoreList(Ray, {LocalPlayer.Character})
                                if Part and Part:IsDescendantOf(Player.Character) then
                                    LastDistance = Distance
                                    NearestPlayer = Player
                                end
                            else
                                LastDistance = Distance
                                NearestPlayer = Player
                            end
                        end
                    end
                else
                    local LocalPlayerPosition = LocalPlayer.Character and LocalPlayer.Character.PrimaryPart and LocalPlayer.Character.PrimaryPart.Position
                    local TargetPosition = Player.Character and Player.Character.PrimaryPart and Player.Character.PrimaryPart.Position
                    if LocalPlayerPosition and TargetPosition then
                        local Distance = (LocalPlayerPosition - TargetPosition).magnitude
                        if Distance < LastDistance then
                            if WallCheckEnabled then
                                local Ray = Ray.new(LocalPlayerPosition, (TargetPosition - LocalPlayerPosition).Unit * 500)
                                local Part = workspace:FindPartOnRayWithIgnoreList(Ray, {LocalPlayer.Character})
                                if Part and Part:IsDescendantOf(Player.Character) then
                                    LastDistance = Distance
                                    NearestPlayer = Player
                                end
                            else
                                LastDistance = Distance
                                NearestPlayer = Player
                            end
                        end
                    end
                end
            end
        end
    end
    return NearestPlayer
end

local Plugin = {
    ["PluginCreator"] = "z4nec0des",
    ["PluginName"] = "Zane's Aimbot",
    ["PluginDescription"] = "Aimbot with various options such as team check, wall check, and movement prediction.",
    ["Commands"] = {
        ["aimbot"] = {
            ["ListName"] = "aimbot / aim / ab",
            ["Description"] = "enables or disables the aimbot.",
            ["Aliases"] = {"aimbot", "aim", "ab"},
            ["Function"] = function(args, speaker)
                AimbotEnabled = true
                notify("Aimbot", "Aimbot has been enabled")
                if AimbotEnabled then
                    TargetLoop = RunService.RenderStepped:Connect(function()
                        local ClosestPlayer = GetClosestEnemyPlayer(AimPart)
                        if ClosestPlayer then
                            local TargetPosition
                            if PredictMovements then
                                TargetPosition = PredictMovement(ClosestPlayer)
                            else
                                local AimObject = GetPart(AimPart, ClosestPlayer.Character or ClosestPlayer.CharacterAdded:Wait()) or GetPart("UpperTorso", ClosestPlayer.Character or ClosestPlayer.CharacterAdded:Wait())
                                if AimObject then
                                    TargetPosition = AimObject.Position
                                end
                            end
                            if TargetPosition then
                                LookAt(TargetPosition + Vector3.new(0, Offset, 0))
                            end
                        end
                    end)
                else
                    TargetLoop:Disconnect()
                    TargetLoop = nil
                end
            end
        },
        ["unaimbot"] = {
            ["ListName"] = "unaimbot / unaim / unab",
            ["Description"] = "disables the aimbot.",
            ["Aliases"] = {"unaim", "stopaim", "unab"},
            ["Function"] = function(args, speaker)
                AimbotEnabled = false
                notify("Aimbot", "Aimbot has been disabled")
                if TargetLoop then
                    TargetLoop:Disconnect()
                    TargetLoop = nil
                end
            end
        },
        ["teamcheck"] = {
            ["ListName"] = "teamcheck / team / tc",
            ["Description"] = "enables or disables team checking.",
            ["Aliases"] = {"teamcheck", "team", "tc"},
            ["Function"] = function(args, speaker)
                TeamCheckEnabled = true
                notify("Team Check", "Team check has been enabled")
            end
        },
        ["unteamcheck"] = {
            ["ListName"] = "unteamcheck / noteam / untc",
            ["Description"] = "disables team checking.",
            ["Aliases"] = {"unteamcheck", "noteam", "untc"},
            ["Function"] = function(args, speaker)
                TeamCheckEnabled = false
                notify("Team Check", "Team check has been disabled")
            end
        },
        ["wallcheck"] = {
            ["ListName"] = "wallcheck / wall / wc",
            ["Description"] = "enables or disables wall checking.",
            ["Aliases"] = {"wallcheck", "wall", "wc"},
            ["Function"] = function(args, speaker)
                WallCheckEnabled = true
                notify("Wall Check", "Wall check has been enabled")
            end
        },
        ["unwallcheck"] = {
            ["ListName"] = "unwallcheck / nowall / unwc",
            ["Description"] = "disables wall checking.",
            ["Aliases"] = {"unwallcheck", "nowall", "unwc"},
            ["Function"] = function(args, speaker)
                WallCheckEnabled = false
                notify("Wall Check", "Wall check has been disabled")
            end
        },
        ["smoothen"] = {
            ["ListName"] = "smoothen / smooth / sm",
            ["Description"] = "enables or disables smooth camera movement.",
            ["Aliases"] = {"smoothen", "smooth", "sm"},
            ["Function"] = function(args, speaker)
                SmoothenEnabled = true
                notify("Smooth Camera", "Smooth camera movement has been enabled")
            end
        },
        ["unsmoothen"] = {
            ["ListName"] = "unsmoothen / nosmooth / unsm",
            ["Description"] = "disables smooth camera movement.",
            ["Aliases"] = {"unsmoothen", "nosmooth", "unsm"},
            ["Function"] = function(args, speaker)
                SmoothenEnabled = false
                notify("Smooth Camera", "Smooth camera movement has been disabled")
            end
        },
        ["ignorefriends"] = {
            ["ListName"] = "ignorefriends / ignore / if",
            ["Description"] = "ignores or considers friends of the local player.",
            ["Aliases"] = {"ignorefriends", "ignore", "if"},
            ["Function"] = function(args, speaker)
                IgnoreFriends = true
                notify("Ignore Friends", "Ignoring friends has been enabled")
            end
        },
        ["unignorefriends"] = {
            ["ListName"] = "unignorefriends / noignore / unif",
            ["Description"] = "disables ignoring friends.",
            ["Aliases"] = {"unignorefriends", "noignore", "unif"},
            ["Function"] = function(args, speaker)
                IgnoreFriends = false
                notify("Ignore Friends", "Ignoring friends has been disabled")
            end
        },
        ["predictmovements"] = {
            ["ListName"] = "predictmovements / predict / pm",
            ["Description"] = "enables or disables movement prediction.",
            ["Aliases"] = {"predictmovements", "predict", "pm"},
            ["Function"] = function(args, speaker)
                PredictMovements = true
                notify("Movement Prediction", "Movement prediction has been enabled")
            end
        },
        ["unpredictmovements"] = {
            ["ListName"] = "unpredictmovements / nopredict / unpm",
            ["Description"] = "disables movement prediction.",
            ["Aliases"] = {"unpredictmovements", "nopredict", "unpm"},
            ["Function"] = function(args, speaker)
                PredictMovements = false
                notify("Movement Prediction", "Movement prediction has been disabled")
            end
        },
        ["setoffset"] = {
            ["ListName"] = "setoffset / offset / so [studs]",
            ["Description"] = "sets the offset value for aiming.",
            ["Aliases"] = {"offset", "setoffset", "so"},
            ["Function"] = function(args, speaker)
                Offset = tonumber(args[1]) or 0
                notify("Set Offset", "Offset value set to " .. Offset)
            end
        },
        ["setpredictdistance"] = {
            ["ListName"] = "setpredictdistance / pdist / pd [studs]",
            ["Description"] = "sets the prediction distance value for aiming.",
            ["Aliases"] = {"setpredictdistance", "pdistance", "pd"},
            ["Function"] = function(args, speaker)
                Offset = tonumber(args[1]) or 0
                notify("Set Prediction Distance", "Prediction distance value set to " .. PredictDistance)
            end
        },
        ["settargetpart"] = {
            ["ListName"] = "settargetpart / targetpart / stp [bodypart]",
            ["Description"] = "sets the body part to aim at.",
            ["Aliases"] = {"targetpart", "settarget", "stp"},
            ["Function"] = function(args, speaker)
                local ClosestPlayer = GetClosestEnemyPlayer(AimPart)
                if ClosestPlayer then
                    local DesiredBodyPart = tostring(args[1])
                    if GetPart(DesiredBodyPart, ClosestPlayer.Character or ClosestPlayer.CharacterAdded:Wait()) then
                        AimPart = DesiredBodyPart
                        notify("Set Target Part", "Target part set to " .. DesiredBodyPart)
                    else
                        notify("Set Target Part", DesiredBodyPart .. " is not a valid body part for " .. ClosestPlayer.Name)
                    end
                else
                    notify("Set Target Part", "No closest player found.")
                end
            end
        },
        ["addally"] = {
            ["ListName"] = "addally / ally / aa [plr]",
            ["Description"] = "adds a player to the allies list.",
            ["Aliases"] = {"addally", "ally", "aa"},
            ["Function"] = function(args, speaker)
                local Player = FindPlayerWithName(tostring(args[1]), speaker)
                if Player then
                    if not IsPlayerListed(AlliesTable, Player) then
                        table.insert(AlliesTable, Player)
                        notify("Add Ally", Player.Name .. " added to allies list")
                    else
                        notify("Add Ally", Player.Name .. " is already in allies list")
                    end
                else
                    notify("Add Ally", "Player not found")
                end
            end
        },
        ["removeally"] = {
            ["ListName"] = "removeally / remally / ra [plr]",
            ["Description"] = "removes a player from the allies list.",
            ["Aliases"] = {"removeally", "remally", "ra"},
            ["Function"] = function(args, speaker)
                local Player = FindPlayerWithName(tostring(args[1]), speaker)
                if Player and IsPlayerListed(AlliesTable, Player) then
                    RemoveFromTable(AlliesTable, Player)
                    notify("Remove Ally", Player.Name .. " removed from allies list")
                else
                    notify("Remove Ally", "Player not found or not in allies list")
                end
            end
        },
        ["toggleoffall"] = {
            ["ListName"] = "toggleoffall / offall / disableall / off",
            ["Description"] = "turns off all toggles.",
            ["Aliases"] = {"offall", "disableall", "off"},
            ["Function"] = function(args, speaker)
                AimbotEnabled = false
                TeamCheckEnabled = false
                WallCheckEnabled = false
                SmoothenEnabled = false
                IgnoreFriends = false
                PredictMovements = false
                if TargetLoop then
                    TargetLoop:Disconnect()
                    TargetLoop = nil
                end
                notify("Toggle Off All", "All features have been disabled")
            end
        }
    }
}

return Plugin
