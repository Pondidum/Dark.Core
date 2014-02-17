local addon, ns = ...
local builder = ns.builder

local buildName = function(parent, name)
	local name = name or ""
	return name:gsub("$parent", parent:GetName())
end

builder.addConstructor("frame", function(parent, config)
	return CreateFrame("frame", buildName(parent, config.name), parent)
end)

builder.addConstructor("checkbox", function(parent, config)
	return CreateFrame("checkbutton", buildName(parent, config.name), parent, config.template)
end)

builder.addConstructor("label", function(parent, config)

	local font = parent:CreateFontString(buildName(parent, config.name), "OVERLAY")
	font:SetFont(ns.media.fonts.normal, 12)

	return font
end)

builder.addConstructor("dropdown", function(parent, config)
	return CreateFrame("frame", buildName(parent, config.name), parent, "UIDropDownMenuTemplate")
end)
