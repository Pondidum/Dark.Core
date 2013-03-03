local addon, ns = ...


local layoutEngine = {
	
	new = function()

		local layoutProperties = { 
			__index = {
				marginLeft = 2,
				marginRight = 2,
				marginTop = 2,
				marginBottom = 2,

				paddingLeft = 2,
				paddingRight = 2,
				paddingTop = 2,
				paddingBottom = 2,

				defaultChildHeight = 32,
				defaultChildWidth = 32,
				forceChildSize = false,

				wrap = false, 
				autosize = false,
				origin = "TOPLEFT",
				type = "HORIZONTAL",
			} 
		}

		local engines = {}
		local this = {}

		this.addEngine = function(type, action) 
			engines[type] = action
		end

		this.init = function(frame, config)

			frame.children = {}

			frame.layout = setmetatable(config or {}, layoutProperties)

			frame.add = function(child)

				if child == nil then return end

				if child:GetWidth() <= 0 or frame.layout.forceChildSize then
					child:SetWidth(frame.layout.defaultChildWidth)
				end

				if child:GetHeight() <= 0 or frame.layout.forceChildSize  then
					child:SetHeight(frame.layout.defaultChildHeight)
				end

				table.insert(frame.children, child)

				frame.performLayout()

				return child

			end

			frame.clear = function()
				frame.children = {}
				frame.performLayout()
			end

			frame.performLayout = function()

				local engine = engines[frame.layout.type]

				if engine then
					engine(frame, frame.children)
				end

			end

		end

		return this 

	end,

}

ns.layout = layoutEngine.new()
