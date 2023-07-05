-- Trident Survival

-- Variables
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Ignore = workspace:FindFirstChild("Ignore") or workspace:WaitForChild("Ignore")

-- Tables
local Connections = {}
local Debounce = {}

-- Match Model

-- Match Model | Check Property
local function CheckProperty(Part, Property)
    local Check = Part[Property]
end
-- Match Model | Function
local function MatchModel(Reference, Model)
	-- Check
	if #Reference:GetChildren() ~= #Model:GetChildren() then return end
	-- Variables
	local Parts = {}
	local PropertyCount = 0
  local PartCount = 0
	local PropertiesFound = 0
	local PartsFound = 0
	-- Properties
	local Properties = {
		["MeshPart"] = {
			"MeshId",
			"TextureID",
			"Color",
			"Material"
		},
		["Other"] = {
			"Color",
			"Material",
			"Size"
		}
	}
	-- Reference
	for _, Part in Reference:GetChildren() do
		if Part:IsA("BasePart") then
			if Part:IsA("MeshPart") then Parts[Part] = {}
				for _, Property in Properties["MeshPart"] do
					local Success = pcall(function() CheckProperty(Part, Property) end)
					if Success then
						Parts[Part][Property] = Part[Property]; PropertyCount += 1
					end
				end
				Parts[Part]["Count"] = PropertyCount; PropertyCount = 0; PartCount += 1
			else Parts[Part] = {}
				for _, Property in Properties["Other"] do
					local Success = pcall(function() CheckProperty(Part, Property) end)
					if Success then
						Parts[Part][Property] = Part[Property]; PropertyCount += 1
					end
				end
				Parts[Part]["Count"] = PropertyCount; PropertyCount = 0; PartCount += 1
			end
		end
	end
	-- Model
	for _, Part in Model:GetChildren() do
		if Part:IsA("BasePart") then
			for _, ReferencePart in Parts do
				for Property, Value in ReferencePart do
					pcall(function ()
						if Property ~= "Count" and Part[Property] == Value then
							PropertiesFound += 1
						end
					end)
				end
				if PropertiesFound == ReferencePart["Count"] then
					PartsFound += 1; PropertiesFound = 0; break
				else
					PropertiesFound = 0
				end
			end
		end
	end
	if PartsFound == PartCount then return true else return false end
end

-- Change Properties 

-- Change Properties | Original Properties
local OriginalProperties = {}
-- Change Properties | Function
local function ChangeProperties(Instance, Properties)
	if not OriginalProperties[Instance] then OriginalProperties[Instance] = {}
		for Property, Value in Properties do
			local Success = pcall(function() CheckProperty(Instance, Property) end)
			if Success then
				OriginalProperties[Instance][Property] = Instance[Property]; Instance[Property] = Value
			end
		end
	else
		for Property, Value in Properties do
			local Success = pcall(function() CheckProperty(Instance, Property) end)
			if Success then
				Instance[Property] = Value
			end
		end
	end
end

-- Players
local Players = {}
-- Players | Setup Players
for _, Player in workspace:GetChildren() do
	if Player:IsA("Model") and Player:FindFirstChild("HumanoidRootPart") then
		table.insert(Players, Player)
	end
end
-- Players | Update Players
Connections["Update Players"] = workspace.DescendantAdded:Connect(function(Player)
	if Player.Name == "HumanoidRootPart" and Player.Parent:IsA("Model") then
		table.insert(Players, Player.Parent); Debounce["Players"] = false
	end
end)
-- Players | Remove Players
Connections["Remove Players"] =  workspace.ChildRemoved:Connect(function(Player)
	if table.find(Players, Player) then
		table.remove(Players, table.find(Players, Player)); Debounce["Players"] = false
	end
end)


-- UI Library

-- UI Library | Repository
local Repository = "https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/"
-- UI Library | Links
local Library	 = loadstring(game:HttpGet(Repository .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/rxn-xyz/Themes/main/BBot.lua"))()
local SaveManager  = loadstring(game:HttpGet(Repository .. "addons/SaveManager.lua"))()
-- UI Library | Window
local Window = Library:CreateWindow({
	Title   = "Tokyoware | Trident Survival Made By $ Tokyo#9999",
	Center   = true, 
	AutoShow = true,
})
-- Window | Tabs
local Tabs = {
	["Main"]		= Window:AddTab("Main"),
	["UI Settings"] = Window:AddTab("UI Settings"),
}
-- Main | Boxes
local Boxes = {
	["Hitbox Expander"] = Tabs["Main"]:AddLeftGroupbox("Hitbox Expander"),
	["Visuals"] = Tabs["Main"]:AddRightTabbox("Visuals"),
}

-- Hitbox Expander

-- Hitbox Expander | Head Expander
Boxes["Hitbox Expander"]:AddToggle("Head Expander", {
	Text = "Head",
	Default = false,
})
-- Hitbox Expander | Head Size
Boxes["Hitbox Expander"]:AddSlider("Head Size", {
	Text = "Size",
	Default = 1,
	Min = 1,
	Max = 5,
	Rounding = 1,
	Compact = false,
})
-- Hitbox Expander | Head Transparency
Boxes["Hitbox Expander"]:AddSlider("Head Transparency", {
	Text = "Transparency",
	Default = 0,
	Min = 0,
	Max = 1,
	Rounding = 1,
	Compact = false,
})
-- Hitbox Expander | Divider
Boxes["Hitbox Expander"]:AddDivider()
-- Hitbox Expander | Torso Expander
Boxes["Hitbox Expander"]:AddToggle("Torso Expander", {
	Text = "Torso",
	Default = false,
})
-- Hitbox Expander | Torso Size
Boxes["Hitbox Expander"]:AddSlider("Torso Size", {
	Text = "Size",
	Default = 1,
	Min = 1,
	Max = 5,
	Rounding = 1,
	Compact = false,
})
-- Hitbox Expander | Torso Transparency
Boxes["Hitbox Expander"]:AddSlider("Torso Transparency", {
	Text = "Transparency",
	Default = 0,
	Min = 0,
	Max = 1,
	Rounding = 1,
	Compact = false,
})

-- Hitbox Expander | Properties
local Properties = {
	["Size"] = {
		["Head"] = Vector3.new(1.6732481718063354, 0.8366240859031677, 0.8366240859031677),
		["Torso"] = Vector3.new(0.6530659198760986, 2.220424175262451, 1.4367451667785645)
	},
	["Transparency"] = {
		["Head"] = 0,
		["Torso"] = 0,
	},
}

-- Hitbox Expander | Head Expander | Toggle
Toggles["Head Expander"]:OnChanged(function()
	-- False
	if not Toggles["Head Expander"].Value then
		for _, Player in Players do
			for Property, Value in Properties do
				pcall(function ()
					Player.Head[Property] = Value["Head"]
				end)
			end
		end
		-- Debounce
		Debounce["Players"] = false; return
	end
	-- True
	task.spawn(function()
		while Toggles["Head Expander"].Value do
			if not Toggles["Head Expander"].Value then break end
			for _, Player in Players do
				pcall(function()
					Player.Head.Size = Vector3.new(Options["Head Size"].Value, Options["Head Size"].Value, Options["Head Size"].Value)
					Player.Head.Transparency = Options["Head Transparency"].Value
				end)
			end
			task.wait(1)
		end
	end)
	-- Debounce
	Debounce["Players"] = false
end)
-- Hitbox Expander | Head Size | Update
Options["Head Size"]:OnChanged(function()
	Debounce["Players"] = false
end)
-- Hitbox Expander | Torso Expander | Toggle
Toggles["Torso Expander"]:OnChanged(function()
	-- False
	if not Toggles["Torso Expander"].Value then
		for _, Player in Players do
			for Property, Value in Properties do
				pcall(function ()
					Player.Torso[Property] = Value["Torso"]
				end)
			end
		end
		-- Debounce
		Debounce["Players"] = false; return
	end
	-- True
	task.spawn(function()
		while Toggles["Torso Expander"].Value do
			if not Toggles["Torso Expander"].Value then break end
			for _, Player in Players do
				pcall(function()
					Player.Torso.Size = Vector3.new(Options["Torso Size"].Value, Options["Torso Size"].Value, Options["Torso Size"].Value)
					Player.Torso.Transparency = Options["Torso Transparency"].Value
				end)
			end
			task.wait(1)
		end
	end)
	-- Debounce
	Debounce["Players"] = false
end)
-- Hitbox Expander | Torso Size | Update
Options["Torso Size"]:OnChanged(function()
	Debounce["Players"] = false
end)

-- UI Settings
local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu")
-- Setup
MenuGroup:AddButton("Unload", function() Library:Unload() for _, Connection in next, Connections do Connection:Disconnect() end end)
MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { Default = "LeftAlt", NoUI = true, Text = "Menu keybind" }); Library.ToggleKeybind = Options.MenuKeybind
-- Theme Manager
ThemeManager:SetLibrary(Library)
-- Save Manager
SaveManager:SetLibrary(Library)
-- Setup
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })
ThemeManager:SetFolder("MyScriptHub")
SaveManager:SetFolder("MyScriptHub/specific-game")
SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])