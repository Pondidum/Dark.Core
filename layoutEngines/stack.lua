local addon, ns = ...

local bottomMode = {
	firstAnchor = "BOTTOMLEFT",
	secondAnchor = "BOTTOMRIGHT",
	direction = 1,

	getSpacing 				= function(s) return s.marginTop + s.marginBottom end,
	getStartPadding 		= function(s) return s.paddingBottom end,
	getFinishPadding 		= function(s) return s.paddingTop end,
	getChildDimension 		= function(c) return c:GetHeight() end,
	setContainerDimension 	= function(container, value) container:SetHeight(value) end,
}

local topMode = {
	firstAnchor = "TOPLEFT",
	secondAnchor = "TOPRIGHT",
	direction = -1,

	getSpacing 				= function(s) return s.marginTop + s.marginBottom end,
	getStartPadding 		= function(s) return s.paddingTop end,
	getFinishPadding 		= function(s) return s.paddingBottom end,
	getChildDimension 		= function(c) return c:GetHeight() end,
	setContainerDimension 	= function(container, value) container:SetHeight(value) end,
}

local leftMode = {
	firstAnchor = "TOPLEFT",
	secondAnchor = "BOTTOMLEFT",
	direction = 1,

	getSpacing 				= function(s) return s.marginLeft + s.marginRight end,
	getStartPadding 		= function(s) return s.paddingLeft end,
	getFinishPadding 		= function(s) return s.paddingRight end,
	getChildDimension 		= function(c) return c:GetWidth() end,
	setContainerDimension 	= function(container, value) container:SetWidth(value) end,
}

local 

local modes = {
	BOTTOM = bottomMode,
	TOP = topMode,
}

local getSortedChildren = function(children)

	local sorted = {}

	local badIndex = false

	for i, child in ipairs(children) do
		
		if child.index == nil then
			badIndex = true
			break
		end
		
		sorted[child.index] = child
	end

	if badIndex then
		sorted = children
	end

	return sorted
end

ns.layout.addEngine("STACK", function(frame, children)
	print("stacking")
	local settings = frame.layout
	local sorted = getSortedChildren(children)
	
	local mode = modes[settings.origin] or bottomMode

	local space = mode.getSpacing(settings) --settings.marginTop + settings.marginBottom
	local offset = mode.getStartPadding(settings) --settings.paddingBottom
	
	for i, child in ipairs(sorted) do
		
		print(i, child:GetName(), child.index)
		child:ClearAllPoints()
		child:SetPoint(mode.firstAnchor, frame, mode.firstAnchor, settings.paddingLeft, offset * mode.direction)
		child:SetPoint(mode.secondAnchor, frame, mode.secondAnchor, -settings.paddingRight, offset * mode.direction)
		
		offset = offset + mode.getChildDimension(child) + space
		
	end    
	
	if settings.autosize then
		offset = offset - space + mode.getFinishPadding(settings) --settings.paddingTop
		mode.setContainerDimension(frame, offset) --frame:SetHeight(offset)
	end
		
end)
