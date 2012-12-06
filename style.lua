local addon, ns = ...
local fonts = ns.media.fonts
local settings = ns.settings


local fake = function() end

local Style = {
	
	new = function()

		local this = {}

		this.actionButton = function(button)
			
			local name = button:GetName()
			
			--> fixing a taint issue while changing totem flyout button in combat.
			if name:match("MultiCast") then return end 
			if name:match("ExtraActionButton") then return end
			
			local Icon = _G[name.."Icon"]
			local Count = _G[name.."Count"]
			local flash	 = _G[name.."Flash"]
			local hotkey = _G[name.."HotKey"]
			local Border  = _G[name.."Border"]
			local buttonName = _G[name.."Name"]
			local normalTexture  = _G[name.."NormalTexture"]
			
			button:SetNormalTexture("")
			flash:SetTexture("")

			Border:Hide()
			Border = fake

			Count:ClearAllPoints()
			Count:SetPoint("BOTTOMRIGHT", 0, 2)
			Count:SetFont(fonts.normal, 12, "OUTLINE")

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

			Icon:SetTexCoord(.08, .92, .08, .92)
			Icon:SetPoint("TOPLEFT", button, 0, 0)
			Icon:SetPoint("BOTTOMRIGHT", button, 0, 0)

			-- if not _G[name.."Panel"] then
			-- 	-- resize all button not matching S.actionbars.buttonsize
			-- 	if button:GetHeight() ~= S.actionbars.buttonsize and not InCombatLockdown() then --Taint fix for Flyout Buttons
			-- 		button:SetSize(S.actionbars.buttonsize, S.actionbars.buttonsize)
			-- 	end

			-- 	-- create the bg/border panel
			-- 	local panel = CreateFrame("Frame", name.."Panel", button)
			-- 	panel:SetPoint("CENTER", button, "CENTER", 0, 0)
			-- 	panel:SetSize(S.actionbars.buttonsize, S.actionbars.buttonsize)
		 
			-- 	panel:SetFrameStrata(button:GetFrameStrata())
			-- 	panel:SetFrameLevel(button:GetFrameLevel() - 1)
		 
		 -- 		if Icon then
			-- 	end

			-- end

			if settings.showmacrokey ~= true or buttonName:GetText() == nil or buttonName:GetText() == "" then
				buttonName:SetText("")
			else
				buttonName:SetText("M")
			end
			
			if settings.showhotkey ~= true then
				hotkey:SetText("")
				D.Kill(hotkey)
			end

			-- multiactionbars
			-- local background = _G[name.."FloatingBG"]
			-- if background then
			-- 	D.Kill(background)
			-- end
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