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


		return this

	end,
}
	
ns.style = Style.new()