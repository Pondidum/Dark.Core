local addon, ns = ...

local Events = {
	
	new = function()

		local this = {}
		local eventMap = {}
		local frame = CreateFrame("Frame", "DarkCoreEventFrame")

		this.register = function(event, key, handler)

			if not event then return end
			if not handler then return end

			if not eventMap[event] then
				eventMap[event] = {}
				frame:RegisterEvent(event)
			end

			if key and key ~= "" then
				eventMap[event][key] = handler
			else
				table.insert(eventMap[event], handler)
			end

		end

		this.unregister = function(event, key)

			if not event then return end
			if not key then return end

			if eventMap[event] and eventMap[event][key] then
				eventMap[event][key] = nil
			end

		end

		frame:SetScript("OnEvent", function(self, event, ...)
			
			if eventMap[event] then
				for i, handler in pairs(eventMap[event]) do
					handler(self, event, ...)
				end
			end

		end)


		return this

	end,

}

ns.events = Events