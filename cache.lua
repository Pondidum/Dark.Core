local addon, ns = ...

local cache = {

	new = function(createAction)

		local items = {}
		local count = 0

		local this = {}

		this.get = function()

			for entry, active in pairs(items) do

				if active == false then
					items[entry] = true
					return entry
				end

			end

			count = count + 1
			local entry = createAction(count)

			items[entry] = true

			return entry
		end

		this.recycle = function(entry)
			items[entry] = false
		end

		this.recycleAll = function(extraAction)

			for entry, active in pairs(items) do
				items[entry] = false

				if extraAction then
					extraAction(entry)
				end

			end

		end

		this.debug = function()

			local total = 0
			local inUse = 0

			for entry, active in pairs(items) do

				total = total + 1

				if active then
					inUse = inUse + 1
				end
			end

			print(string.format("Cache contains %d items, with %d in use.", total, inUse))

		end

		return this

	end,

}

ns.cache = cache