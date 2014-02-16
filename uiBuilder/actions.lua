local addon, ns = ...
local builder = ns.builder

local buildName = function(parent, name)
	return name:gsub("$parent", parent:GetName())
end

builder.addAction("size", function(self, value)
	self:SetSize(unpack(value))
end)

builder.addAction("points", function(self, value)

	for i, array in ipairs(value) do
		local point, other, otherPoint, x, y = unpack(array)

		self:SetPoint(point, buildName(self:GetParent(), other), otherPoint, x, y)
	end

end)
