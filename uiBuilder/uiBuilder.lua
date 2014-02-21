local addon, ns = ...

local constructors = {}
local actions = {}

local function build(host, config)

	local ctor = constructors[config.type]
	local control = host

	if ctor then
		control = ctor(host, config)
	end

	for actionName, value in pairs(config) do

		local action = actions[actionName]

		if action then
			action(control, value)
		end

	end

	control.children = control.children or {}

	if config.children then

		for i, childConfig in ipairs(config.children) do

			control.children[i] = build(control, childConfig)

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
