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

builder.addAction("text", function(self, value)
	self:SetText(value)
end)

builder.addAction("items", function(self, value)

	UIDropDownMenu_Initialize(self, function(self, level)

		for k, v in pairs(value) do

			local info = UIDropDownMenu_CreateInfo()
			info.text = v
			info.value = k

			UIDropDownMenu_AddButton(info, level)

		end

	end)

end)
