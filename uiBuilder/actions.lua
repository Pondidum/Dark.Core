local addon, ns = ...
local builder = ns.builder

builder.addAction("size", function(self, value)
	self:SetSize(unpack(value))
end)
