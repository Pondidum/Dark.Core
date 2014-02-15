local addon, ns = ...
local builder = ns.builder

builder.addAction("size", function(self, value)
	self:SetSize(unpack(value))
end)

builder.addAction("points", function(self, value)

	for i, point in ipairs(value) do
		self:SetPoint(unpack(point))
	end

end)
