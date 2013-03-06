local addon, ns = ...

local cache = {
	
	new = function(createAction)

		local items = {}

		local this = {}
			
		this.get = function()

			for i, entry in ipairs(items) do
		
				if not entry.inUse then
					entry.inUse = true
					return entry
				end

			end

			local entry = createAction(#items+1)
			entry.inUse = true

			table.insert(items, entry)

			return entry
		end

		this.recycle = function(entry)
			entry.inUse = false
		end

		this.recycleAll = function()

			for i, entry in pairs(items) do
				entry.inUse = false
			end

		end

		this.debug = function()

			local total = #items
			local inUse = 0

			for i, v in ipairs(items) do
				if v.inUse then
					inUse = inUse + 1
				end
			end

			print(string.format("Cache contains %d items, with %d in use.", total, inUse))

		end

		return this

	end,

}

ns.cache = cache