local addon, ns = ...

local frameSeries = {

	extend = function(self, this)
		return setmetatable(this, { __index = self})
	end,

	init = function(self)
		self.container = CreateFrame("Frame", self.name, self.parent or UIParent)
		self.frameSize = 25
		self.spacing = 6
	end,

	beforeLayout = function(self)
	end,

	layout = function(self)

		self:beforeLayout()

		local containerWidth = ((self.frameSize + self.spacing) * self.columns) - self.spacing
		local containerHeight = ((self.frameSize + self.spacing) * self.rows) - self.spacing

		self.container:SetSize(containerWidth, containerHeight)

		local previous = first

		for i = 1, #self.frames do

			local frame = self.frames[i]

			self:customiseFrame(frame)

			frame:SetSize(self.frameSize, self.frameSize)
			frame:ClearAllPoints()

			if (i - 1) % self.columns == 0 then

				local row = math.floor((i - 1) / self.columns)
				local offset = (self.frameSize + self.spacing) * row

				frame:SetPoint("TOPLEFT", self.container, "TOPLEFT", 0, -offset)
			else
				frame:SetPoint("LEFT", previous, "RIGHT", self.spacing, 0)
			end

			previous = frame

		end

		self:afterLayout()

	end,

	afterLayout = function(self)
	end,

	customiseFrame = function(self, frame)
	end,

}

ns.frameSeries = frameSeries
