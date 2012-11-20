local addon, ns = ...

local Settings = {
	
	new = function()

		local this = {}

		this.showmacrokey = true
		this.showhotkey = true

		return this

	end,
}

ns.settings = Settings.new()