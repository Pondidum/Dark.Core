local addon, ns = ...

local UI = {
	
	new = function()

		local this = {}

		this.addShadow = function(frame, offset) 

			if frame.shadow then return end 
			if offset == nil then offset = 3 end
			
			local shadow = CreateFrame("Frame", nil, frame)

			shadow:SetFrameLevel(1)
			shadow:SetFrameStrata(frame:GetFrameStrata())
			shadow:SetPoint("TOPLEFT", -offset, offset)
			shadow:SetPoint("BOTTOMLEFT", -offset, -offset)
			shadow:SetPoint("TOPRIGHT", offset, offset)
			shadow:SetPoint("BOTTOMRIGHT", offset, -offset)
			shadow:SetBackdrop( { 
				edgeFile = ns.media.textures.shadow, 
				edgeSize = offset,
				insets = {
					left = 5, 
					right = 5, 
					top = 5, 
					bottom = 5
				},
			})
			
			shadow:SetBackdropColor(0, 0, 0, 0)
			shadow:SetBackdropBorderColor(unpack(ns.media.colors.shadow))

			frame.shadow = shadow

		end

		this.addBackground = function(frame)

			if frame.bg then return end

			local bg = CreateFrame("Frame", nil, frame)

			bg:SetAllPoints(frame)
			bg:SetFrameLevel(1)
			bg:SetFrameStrata(frame:GetFrameStrata())
			bg:SetBackdrop( { 
				bgFile = ns.media.textures.normal,
				edgeSize = 0,
				tile = true,
			})

			bg:SetBackdropColor(unpack(ns.media.colors.background))

			frame.bg = bg
			
		end

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