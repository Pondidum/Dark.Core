local addon, ns = ...

local Media = {

	new = function()

		local this = {}

		this.textures = {
			shadow = [[Interface\AddOns\Dark.Core\media\textures\shadow]],
			normal = [[Interface\AddOns\Dark.Core\media\textures\normal]],
			raidmarks = [[Interface\AddOns\Dark.Core\media\textures\raidicons.blp]],
			empty = [[Interface\AddOns\Dark.Core\media\textures\empty]]
		}

		this.colors = {
			shadow =  {0, 0, 0, 0.8},
			background = {0, 0, 0, 0.4},
			reaction = {
				[1] = { 222/255, 95/255,  95/255 }, -- Hated
				[2] = { 222/255, 95/255,  95/255 }, -- Hostile
				[3] = { 222/255, 95/255,  95/255 }, -- Unfriendly
				[4] = { 218/255, 197/255, 92/255 }, -- Neutral
				[5] = { 75/255,  175/255, 76/255 }, -- Friendly
				[6] = { 75/255,  175/255, 76/255 }, -- Honored
				[7] = { 75/255,  175/255, 76/255 }, -- Revered
				[8] = { 75/255,  175/255, 76/255 }, -- Exalted
			},
		}

		this.fonts = {
			normal = [[Interface\AddOns\Dark.Core\media\fonts\PT-Sans-Narrow.ttf]],
			unitframes = [[Interface\AddOns\Darkui\media\fonts\BigNoodleTitling.ttf]],
			combat = [[Interface\AddOns\Dark.Core\media\fonts\Ultima_Campagnoli.ttf]],
		}

		return this

	end,

}

ns.media = Media.new()