local espModels = {}
local modelEspTrigger = nil
function modelAdded(model)
  if #espModels > 0 then
    if FindInTable(espModels, model.Name:lower()) then
      if not model:FindFirstChild(model.Name:lower().."_MESP") then
        local a = Instance.new("BoxHandleAdornment")
        a.Name = model.Name:lower().."_MESP"
        a.Parent = model
        a.Adornee = model
        a.AlwaysOnTop = true
        a.ZIndex = 0
        a.Size = model:GetExtentsSize()
        a.Transparency = espTransparency
        a.Color = BrickColor.new("Cyan")
      end
    end
  else
    modelEspTrigger:Disconnect()
    modelEspTrigger = nil
  end
end

local Plugin = {
	["PluginCreator"] = "coolest_smug", -- Discord Id: 807464610147598336
	["PluginName"] = "ModelCMDs+",
	["PluginDescription"] = "More commands regarding models, improved version of flamespill's ModelCMDs.",
	["Commands"] = {
		["viewmodel"] = {
			["ListName"] = "viewmodel / viewm [model name]",
			["Description"] = "View a model",
			["Aliases"] = {"viewm"},
			["Function"] = function(args,speaker)
				for i,v in pairs(workspace:GetDescendants()) do
					if v.Name:lower() == getstring(1):lower() and v:IsA("Model") then
						wait(0.1)
						workspace.CurrentCamera.CameraSubject = v
					end
				end
			end
		};
		["bringmodel"] = {
			["ListName"] = "bringmodel [model name] (CLIENT)",
			["Description"] = "Moves a model or multiple models to your character",
			["Aliases"] = {""},
			["Function"] = function(args,speaker)
				for i,v in pairs(workspace:GetDescendants()) do
					if v.Name:lower() == getstring(1):lower() and v:IsA("Model") then
						v:PivotTo(getRoot(speaker.Character).CFrame)
					end
				end
			end
		};
["modelesp"] = {
  ["ListName"] = "modelesp / mesp [model name]",
  ["Description"] = "Highlights a model or multiple models",
  ["Aliases"] = {"mesp"},
  ["Function"] = function(args,speaker)
    local modelEspName = getstring(1):lower()
    if not FindInTable(espModels,modelEspName) then
      table.insert(espModels,modelEspName)
      for i,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v.Name:lower() == modelEspName then
          if not v:FindFirstChild(modelEspName.."_MESP") then
            local a = Instance.new("BoxHandleAdornment")
            a.Name = modelEspName.."_MESP"
            a.Parent = v
            a.Adornee = v
            a.AlwaysOnTop = true
            a.ZIndex = 0
            a.Size = v:GetExtentsSize()
            a.Transparency = espTransparency
            a.Color = BrickColor.new("Cyan")
          end
        end
      end
    end
    if not modelEspTrigger then
      modelEspTrigger = workspace.DescendantAdded:Connect(modelAdded)
    end
  end
};
		["unmodelesp"] = {
			["ListName"] = "unmodelesp / unmesp [model name]",
			["Description"] = "removes modelesp",
			["Aliases"] = {"unmesp"},
			["Function"] = function(args,speaker)
				if args[1] then
					local modelEspName = getstring(1):lower()
					if FindInTable(espModels,modelEspName) then
						table.remove(espModels, GetInTable(espModels, modelEspName))
					end
					for i,v in pairs(workspace:GetDescendants()) do
						if v:IsA("BoxHandleAdornment") and v.Name == modelEspName..'_MESP' then
							v:Destroy()
						end
					end
				else
					modelEspTrigger:Disconnect()
					modelEspTrigger = nil
					espModels = {}
					for i,v in pairs(workspace:GetDescendants()) do
						if v:IsA("BoxHandleAdornment") and v.Name:sub(-5) == '_MESP' then
							v:Destroy()
						end
					end
				end
			end
		};
	}
}

return Plugin
