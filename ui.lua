local addon, ns = ...

local UI = {
	
	new = function()

		local this = {}
		local fake = function() end
		
		this.createFont = function(parent, fontName, fontHeight, fontStyle)

			fontName = fontName or ns.media.fonts.normal
			fontHeight = fontHeight or 12

			local fs = parent:CreateFontString(nil, "OVERLAY")
			
			fs:SetFont(fontName, fontHeight, fontStyle)
			fs:SetJustifyH("LEFT")
			fs:SetShadowColor(0, 0, 0)
			fs:SetShadowOffset(1.25, -1.25)

			return fs

		end

		this.killFrame = function(frame)

			if frame == nil then return end

			if frame.UnregisterAllEvents then
				frame:UnregisterAllEvents()
			end

			frame.Show = fake
			frame:Hide()

		end

		return this 

	end,

}

ns.ui = UI