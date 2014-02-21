local addon, ns = ...
local ui = ns.ui
local builder = ns.builder

local function recurseControls(savers, loaders, control)

	if control.save then
		table.insert(savers, control.save)
	end

	if control.load then
		table.insert(loaders, control.load)
	end

	for i, child in ipairs(control.children) do
		recurseControls(savers, loaders, child)
	end

end

local collectActions = function(control)

	local savers = {}
	local loaders = {}

	recurseControls(savers, loaders, control)

	local save = function()
		for i, action in ipairs(savers) do
			action()
		end
	end

	local load = function()
		for i, action in ipairs(loaders) do
			action()
		end
	end

	return save, load

end

local options = {

	new = function()

		local panel = CreateFrame("Frame", "DarkOptions")
		panel.name = "Dark.UI Options"

		local this = {}

		this.register = function(name, config)

			local configUi = CreateFrame("Frame", "DarkOptions"..name)
			configUi.name = name
			configUi.parent = panel.name

			local header = ui.createFont(configUi)
			header:SetPoint("TOPLEFT", configUi, "TOPLEFT", 10, -5)
			header:SetPoint("TOPRIGHT", configUi, "TOPRIGHT", -10, -5)
			header:SetHeight(30)
			header:SetText(config.description)

			local container = CreateFrame("Frame", "$parentContainer", configUi)
			container:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, 5)
			container:SetPoint("TOPRIGHT", header, "BOTTOMRIGHT", 0, 5)
			container:SetPoint("BOTTOM", configUi, "BOTTOM", 0, 10)

			builder.build(container, config)

			local save, load = collectActions(container)

			configUi.okay = save
			configUi.refresh = load

			InterfaceOptions_AddCategory(configUi)

		end

		InterfaceOptions_AddCategory(panel)

		return this

	end,

}

ns.options = options
