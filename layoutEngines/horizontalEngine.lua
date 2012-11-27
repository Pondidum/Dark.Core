local addon, ns = ...

ns.layout.addEngine("HORIZONTAL", function(frame, children)

	local settings = frame.layout


	local x = settings.marginLeft
	local y = settings.marginTop

	local currentRowHeight = 0
	local total = 0
	
	for i, child in ipairs(children) do
		
		if settings.wrap and x + child:GetWidth() > frame:GetWidth() then
			x = settings.marginLeft
			y = y + currentRowHeight + settings.marginTop
			currentRowHeight = child:GetHeight()
		end
		
		child:SetPoint(settings.origin, frame, settings.origin, x, -y)
		
		x = x + child:GetWidth() + settings.marginRight
		
		if child:GetHeight() > currentRowHeight then
			currentRowHeight = child:GetHeight()
		end
		
		total = x
		
	end

	if settings.autosize then
		frame:SetSize(total, currentRowHeight)
	end

end)
