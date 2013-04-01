local addon, ns = ...

ns.layout.addEngine("VERTICAL", function(frame, children)
	
	local settings = frame.layout
	local x = settings.paddingLeft
	local y = settings.paddingTop
	
	local direction = -1

	if settings.origin:find("BOTTOM") then
		direction = 1
	end

	local maxWidth = 0
	for i, child in ipairs(children) do
		
		if settings.wrap and y + child:GetHeight() > frame:GetHeight() then
			y = settings.settings.paddingTop
			x = x + maxWidth + settings.marginLeft + settings.marginRight
			maxWidth = 0
		end
		
		child:SetPoint(settings.origin, frame, settings.origin, x, y * direction)
		
		y = y + child:GetHeight() + settings.marginBottom + settings.marginTop
		
		if child:GetWidth() > maxWidth then
			maxWidth = child:GetWidth()
		end

	end

	if settings.autosize then
	
		y = y - settings.marginBottom - settings.marginTop + settings.paddingBottom
		x = x + maxWidth + settings.paddingRight

		frame:SetSize(x, y)
		
	end
	
end)
