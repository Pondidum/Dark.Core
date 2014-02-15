local addon, ns = ...

local buildName = function(parent, name)
	return name:gsub("$parent", parent:GetName())
end

local constructors = {

	checkbox = function(parent, config)
		return CreateFrame("checkbox", buildName(parent, config.name), parent)
	end,

}

local actions = {
	size = function(self, value)
		self:SetSize(unpack(value))
	end,
}

local function build(host, config)

	local ctor = constructors[config.type]

	local control = ctor(host, config)

	for actionName, value in pairs(config) do

		local action = actions[actionName]

		if action then
			action(control, value)
		end

	end

	if config.children then

		for i, childConfig in ipairs(config.children) do
			build(control, childConfig)
		end

	end

	return control

end

local builder = {
	
	addAction = function(key, action)
		actions[key] = action
	end,

	addConstructor = function(key, constructor)
		constructors[key] = constructor
	end,

	build = function(parent, config)
		return build(parent, config)
	end,

}

ns.builder = builder
