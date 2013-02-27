local addon, ns = ...
local fonts = ns.media.fonts
local settings = ns.settings


local fake = function() end

local Style = {
	
	new = function()

		local this = {}

		this.actionButton = function(button)
			
			local name = button:GetName()
			
			local icon = _G[name.."Icon"]
			local count = _G[name.."Count"]
			local flash	 = _G[name.."Flash"]
			local hotkey = _G[name.."HotKey"]
			local border  = _G[name.."Border"]
			local buttonName = _G[name.."Name"]
			local normalTexture  = _G[name.."NormalTexture"]

			button:SetNormalTexture("")
			flash:SetTexture("")

			border:Hide()
			border = fake

			count:ClearAllPoints()
			count:SetPoint("BOTTOMRIGHT", 0, 2)
			count:SetFont(fonts.normal, 12, "OUTLINE")

			buttonName:SetTextColor(hotkey:GetTextColor())
			buttonName:SetFont(fonts.normal, 10, "OUTLINE")
			buttonName:SetJustifyH("LEFT")
			buttonName:ClearAllPoints()
			buttonName:SetPoint("TOPLEFT", button, 0, 0)
		 
			hotkey:ClearAllPoints()
			hotkey:SetPoint("TOPRIGHT", 2, 0)
			hotkey:SetFont(fonts.normal, 10, "OUTLINE")
			hotkey:SetJustifyH("RIGHT")

			hotkey.ClearAllPoints = fake
			hotkey.SetPoint = fake

			normalTexture:ClearAllPoints()
			normalTexture:SetPoint("TOPLEFT")
			normalTexture:SetPoint("BOTTOMRIGHT")

			icon:SetTexCoord(.08, .92, .08, .92)
			icon:SetPoint("TOPLEFT", button, 0, 0)
			icon:SetPoint("BOTTOMRIGHT", button, 0, 0)

			button:GetPushedTexture():SetTexture(0.9,0.8,0.1,0.3)
			button:GetHighlightTexture():SetTexture(1,1,1,0.3)

			if settings.showmacrokey ~= true or buttonName:GetText() == nil or buttonName:GetText() == "" then
				buttonName:SetText("")
			else
				buttonName:SetText("M")
			end
			
			if settings.showhotkey ~= true then
				hotkey:SetText("")
				D.Kill(hotkey)
			end

		end


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

			return shadow
			
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
			
			return bg
			
		end

		return this

	end,
}
	
ns.style = Style.new()