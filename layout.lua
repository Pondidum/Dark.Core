local addon, ns = ...


local layoutEngine = {
	
	new = function()

		local layoutProperties = { 
			__index = {
				marginLeft = 2,
				marginRight = 2,
				marginTop = 2,
				marginBottom = 2,

				defaultChildHeight = 32,
				defaultChildWidth = 32,
				forceChildSize = false,

				wrap = false, 
				autosize = false,
				origin = "TOPLEFT",
				direction = "HORIZONTAL",
			} 
		}

		local engines = {}
		local this = {}

		this.addEngine = function(direction, action) 
			engines[direction] = action
		end

		this.init = function(frame, config)

			local children = {}

			frame.layout = setmetatable(config or {}, layoutProperties)

			frame.add = function(child)

				if child == nil then return end

				if child:GetWidth() <= 0 or frame.layout.forceChildSize then
					child:SetWidth(frame.layout.defaultChildWidth)
				end

				if child:GetHeight() <= 0 or frame.layout.forceChildSize  then
					child:SetHeight(frame.layout.defaultChildHeight)
				end

				table.insert(children, child)

				frame.performLayout()

				return child

			end

			frame.clear = function()
				children = {}
				frame.performLayout()
			end

			frame.performLayout = function()

				local engine = engines[frame.layout.direction]

				if engine then
					engine(frame, children)
				end

			end

		end

		return this 

	end,

}

ns.layout = layoutEngine.new()
