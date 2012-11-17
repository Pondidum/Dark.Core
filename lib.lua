local addon, ns = ...

local Initalise = function()

	if Dark == nil then
		Dark = {}
	end

	Dark.Core = {}
	Dark.Core.events = ns.events.new()

end

Initalise()