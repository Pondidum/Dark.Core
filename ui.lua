local addon, ns = ...

local UI = {
	
	new = function()

		local this = {}

		this.createFont = function(parent, fontName, fontHeight, fontStyle)

			local fs = parent:CreateFontString(nil, "OVERLAY")
			
			fs:SetFont(fontName, fontHeight, fontStyle)
			fs:SetJustifyH("LEFT")
			fs:SetShadowColor(0, 0, 0)
			fs:SetShadowOffset(1.25, -1.25)

			return fs

		end

		return this 

	end,

}

ns.ui = UI