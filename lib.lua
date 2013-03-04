local addon, ns = ...

local Initalise = function()

	if Dark == nil then
		Dark = {}
	end

	Dark.core = {}
	Dark.core.events = ns.events.new()
	Dark.core.settings = ns.settings
	
	Dark.core.textures = ns.media.textures
	Dark.core.colors = ns.media.colors
	Dark.core.fonts = ns.media.fonts

	Dark.core.ui = ns.ui.new()
	Dark.core.layout = ns.layout
	Dark.core.style = ns.style

	Dark.core.cache = ns.cache

end

Initalise()