local addon, ns = ...

ns.layout.addEngine("VERTICAL", function(frame, children)
	
	local settings = frame.layout


	local x = settings.paddingLeft
	local y = settings.paddingTop
	local currentColWidth = 0
	
	local direction = -1

	if settings.origin:find("BOTTOM") then
		direction = 1
	end

	local total = 0

	for i, child in ipairs(children) do
		
		if settings.wrap and y + child:GetHeight() > frame:GetHeight() then
			y = settings.mrginTop
			x = x + currentColWidth + settings.marginLeft
			currentColWidth = currentColWidth:GetWidth()
		end
		
		child:SetPoint(settings.origin, frame, settings.origin, x, y * direction)
		
		y = y + child:GetHeight() + settings.marginBottom
		
		if child:GetWidth() > currentColWidth then
			currentColWidth = child:GetWidth()
		end
		
		total = y

	end

	if settings.autosize then
		frame:SetSize(currentColWidth, total)
	end
	
end)
