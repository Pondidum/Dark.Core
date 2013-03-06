local addon, ns = ...


local round = function(number, decimals)
	if not decimals then decimals = 0 end
    return (("%%.%df"):format(decimals)):format(number)
end


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

		this.createCooldownBar = function(name, parent)

			local frame = CreateFrame("Statusbar", name, parent)

			local text = this.createFont(frame)
			text:SetAllPoints(frame)
			text:SetJustifyH("RIGHT")
			frame.text = text

			local cdStart, cdDuration = 0, 0
			local fill = false

			frame.setCooldown = function(start, duration)
				cdStart = start
				cdDuration = duration

				frame:SetMinMaxValues(0, duration)
				frame:Show()
			end

			frame.setReverseFill = function(value)
				fill = not value
			end

			frame:SetScript("OnUpdate", function()

				local t = GetTime() - cdStart

				if t > cdDuration then
					frame:Hide()

				elseif fill then
					frame:SetValue(t)
					text:SetText(round(t, 1))

				else
					frame:SetValue(cdDuration - t)
					text:SetText(round(cdDuration - t, 1))

				end

			end)

			return frame

		end
		
		return this 

	end,

}

ns.ui = UI