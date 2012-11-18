local addon, ns = ...

local Initalise = function()

	if Dark == nil then
		Dark = {}
	end

	Dark.core = {}
	Dark.core.events = ns.events.new()
	Dark.core.media = ns.media
	Dark.core.style = ns.style.new()

end

Initalise()