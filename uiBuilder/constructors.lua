local addon, ns = ...
local builder = ns.builder

builder.addConstructor("checkbox", function(parent, config)
	return CreateFrame("checkbox", buildName(parent, config.name), parent)
end)
