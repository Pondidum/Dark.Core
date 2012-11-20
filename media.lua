local addon, ns = ...

local Media = {
	
	new = function()

		local this = {}

		this.textures = {
			shadow = [[Interface\AddOns\Dark.Core\media\textures\shadow]],
			normal = [[Interface\AddOns\Dark.Core\media\textures\normal]],
		}
		
		this.colors = {
			shadow =  {0, 0, 0, 0.8},
			background = {0, 0, 0, 0.4},
		}

		this.fonts = {
			normal = [[Interface\AddOns\Darkui\media\fonts\PT-Sans-Narrow.ttf]],
			--normal = [[Interface\AddOns\Darkui\media\fonts\PT-Sans-Narrow.ttf]],
		}

		return this 

	end,

}

ns.media = Media.new()