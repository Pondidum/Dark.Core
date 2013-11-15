local addon, ns = ...

ns.layout.addEngine("HORIZONTAL", function(frame, children)

	local settings = frame.layout
	local x = settings.paddingLeft 
	local y = settings.paddingTop

	local direction = 1

	if settings.origin:find("RIGHT") then
		direction = -1
	end
	
	local maxHeight = 0
	for i, child in ipairs(children) do
		
		if child:GetWidth() <= 0 or settings.forceChildSize then
			child:SetWidth(settings.defaultChildWidth)
		end

		if child:GetHeight() <= 0 or settings.forceChildSize  then
			child:SetHeight(settings.defaultChildHeight)
		end
				
		if settings.wrap and x + child:GetWidth() > frame:GetWidth() then
			x = settings.paddingLeft
			y = y + maxHeight + settings.marginBottom + settings.marginTop
			maxHeight = 0
		end

		child:SetPoint(settings.origin, frame, settings.origin, x * direction, -y)
		
		x = x + child:GetWidth() + settings.marginLeft + settings.marginRight
				
		if child:GetHeight() > maxHeight then
			maxHeight = child:GetHeight()
		end
		
	end

	if settings.autosize then

		x = x - settings.marginLeft - settings.marginRight + settings.paddingRight
		y = y + maxHeight + settings.paddingBottom

		frame:SetSize(x, y)
		
	end

end)
