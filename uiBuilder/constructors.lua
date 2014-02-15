local addon, ns = ...
local builder = ns.builder

local buildName = function(parent, name)
	return name:gsub("$parent", parent:GetName())
end

builder.addConstructor("frame", function(parent, config)
	return CreateFrame("frame", buildName(parent, config.name), parent)
end)

builder.addConstructor("checkbox", function(parent, config)
	return CreateFrame("checkbox", buildName(parent, config.name), parent)
end)
