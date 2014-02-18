local addon, ns = ...

local eventMap = {}
local updateMap = {}

local events = {

	new = function()

		local this = {}
		local frame = CreateFrame("Frame", "DarkCoreEventFrame")

		this.register = function(event, handler)

			if not event then return end
			if not handler then return end

			if not eventMap[event] then
				eventMap[event] = {}
				frame:RegisterEvent(event)
			end

			eventMap[event][this] = handler

		end

		this.unregister = function(event)

			if not event then return end

			if eventMap[event] and eventMap[event][this] then
				eventMap[event][this] = nil
			end

		end

		this.isRegistered = function(event)

			if not eventMap[event] then
				return false
			end

			if not eventMap[event][this] then
				return false
			end

			return true

		end

		this.registerOnUpdate = function(handler)

			if not handler then return end

			updateMap[this] = handler

		end

		this.unregisterOnUpdate = function()
			updateMap[this] = nil
		end

		frame:SetScript("OnEvent", function(self, event, ...)

			if eventMap[event] then
				for i, handler in pairs(eventMap[event]) do
					handler(self, event, ...)
				end
			end

		end)

		frame:SetScript("OnUpdate", function(self, elapsed)

			for key, handler in pairs(updateMap) do
				handler(self, elapsed)
			end

		end)

		return this

	end,

}

ns.events = events