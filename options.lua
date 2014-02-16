local addon, ns = ...
local ui = ns.ui
local builder = ns.builder

local options = {

	new = function()

		local panel = CreateFrame("Frame", "DarkOptions")
		panel.name = "Dark.UI Options"

		local this = {}

		this.register = function(name, config)

			local configUi = CreateFrame("Frame", "DarkOptions"..name)
			configUi.name = name
			configUi.parent = panel.name

			InterfaceOptions_AddCategory(configUi)

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

		end

		InterfaceOptions_AddCategory(panel)

		return this

	end,

}

ns.options = options
