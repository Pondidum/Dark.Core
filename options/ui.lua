local addon, ns = ...
local ui = ns.ui

local options = {

	new = function()

		local panel = CreateFrame("Frame", "Dark.Options")
		panel.name = "Dark.UI Options"

		local this = {}

		this.register = function(name, config)

			local configUi = CreateFrame("Frame", "Dark.Options."..name)
			configUi.name = name
			configUi.parent = panel.name

			local header = ui.createFont(configUi)
			header:SetPoint("LEFT")
			header:SetPoint("RIGHT")
			header:SetPoint("TOP")
			header:SetHeight(30)

			header:SetText(config.description)

			InterfaceOptions_AddCategory(configUi)

		end

		InterfaceOptions_AddCategory(panel)
		return this

	end,

}

ns.options = options
