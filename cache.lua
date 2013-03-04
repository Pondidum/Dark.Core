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

		return this

	end,

}

ns.cache = cache