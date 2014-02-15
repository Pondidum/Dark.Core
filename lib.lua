local addon, ns = ...

local initalise = function()

	local core = {
		events = ns.events,
		settings = ns.settings,

		textures = ns.media.textures,
		colors = ns.media.colors,
		fonts = ns.media.fonts,

		ui = ns.ui,
		layout = ns.layout,
		style = ns.style,

		cache = ns.cache,
		slash = ns.slash.new(),
		options = ns.options.new(),
	}

	if Dark == nil then
		Dark = {}
	end

	Dark.core = core

end

initalise()
