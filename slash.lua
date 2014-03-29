local addon, ns = ...

local splitParts = function(args)

	local parts = {}
	local part = ''
	local inQuote = false

	for letter in args:gmatch(".") do

		if letter == ' ' and not inQuote then

			table.insert(parts, part)
			part = ''

		elseif letter == '"' or letter == "'" then

			inQuote = not inQuote

		else

			part = part .. letter

		end

	end

	if part ~= '' then
		table.insert(parts, part)
	end

	return parts

end

local slash = {

	new = function()

		local handlers = {}
		local this = {}

		this.register = function(name, graph)
			handlers[name] = graph
		end

		this.process = function(args)

			local parts = splitParts(args)
			local parent = handlers

			for i, part in ipairs(parts) do

				local current = parent[part]
				local t = type(current)

				if current == nil then
					print(string.format("Unknown argument '%s'", part))
					return
				elseif t == "table" then
					parent = current
				elseif t == "function" then
					current(select(i+1, unpack(parts)))
				else
					return
				end

			end

		end

		SLASH_DARK1 = "/dark"
		SlashCmdList["DARK"] = function (args)
			this.process(args)
		end

		return this

	end,

}

ns.slash = slash

--[[
local s = slash.new()


local testGraph = {
	enable = function() print("enable") end,
	channel = function(value) print("channel", value) end,
	suffix = function(value) print("suffix", value) end,
}

s.register("omg", testGraph)

s.process('omg enable')
s.process('omg channel')
s.process('omg channel test')
s.process('omg channel party test')
s.process('omg suffix one')
s.process('omg suffix winkle next')
s.process('omg suffix "winkle next"')
]]