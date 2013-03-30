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

	x = x - settings.marginLeft - settings.marginRight + settings.paddingRight
	y = y + maxHeight + settings.paddingBottom

	if settings.autosize then
		frame:SetSize(x, y)
	end

end)
