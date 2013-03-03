local addon, ns = ...

local bottomMode = {

	getSpacing 				= function(s) return s.marginTop + s.marginBottom end,
	getStartPadding 		= function(s) return s.paddingBottom end,
	getFinishPadding 		= function(s) return s.paddingTop end,
	getChildDimension 		= function(c) return c:GetHeight() end,
	setContainerDimension 	= function(container, value) container:SetHeight(value) end,

	setPoint = function(container, child, settings, offset) 
		child:SetPoint("BOTTOMLEFT", container, "BOTTOMLEFT", settings.paddingLeft, offset)
		child:SetPoint("BOTTOMRIGHT", container, "BOTTOMRIGHT", -settings.paddingRight, offset)
	end,
}

local topMode = {

	getSpacing 				= function(s) return s.marginTop + s.marginBottom end,
	getStartPadding 		= function(s) return s.paddingTop end,
	getFinishPadding 		= function(s) return s.paddingBottom end,
	getChildDimension 		= function(c) return c:GetHeight() end,
	setContainerDimension 	= function(container, value) container:SetHeight(value) end,

	setPoint = function(container, child, settings, offset) 
		child:SetPoint("TOPLEFT", container, "TOPLEFT", settings.paddingLeft, -offset)
		child:SetPoint("TOPRIGHT", container, "TOPRIGHT", -settings.paddingRight, -offset)
	end,
}

local leftMode = {

	getSpacing 				= function(s) return s.marginLeft + s.marginRight end,
	getStartPadding 		= function(s) return s.paddingLeft end,
	getFinishPadding 		= function(s) return s.paddingRight end,
	getChildDimension 		= function(c) return c:GetWidth() end,
	setContainerDimension 	= function(container, value) container:SetWidth(value) end,

	setPoint = function(container, child, settings, offset) 
		child:SetPoint("TOPLEFT", container, "TOPLEFT", offset, -settings.paddingTop)
		child:SetPoint("BOTTOMLEFT", container, "BOTTOMLEFT", offset, settings.paddingBottom)
	end,
}

local rightMode = {

	getSpacing 				= function(s) return s.marginLeft + s.marginRight end,
	getStartPadding 		= function(s) return s.paddingRight end,
	getFinishPadding 		= function(s) return s.paddingLeft end,
	getChildDimension 		= function(c) return c:GetWidth() end,
	setContainerDimension 	= function(container, value) container:SetWidth(value) end,

	setPoint = function(container, child, settings, offset) 
		child:SetPoint("TOPRIGHT", container, "TOPRIGHT", -offset, -settings.paddingTop)
		child:SetPoint("BOTTOMRIGHT", container, "BOTTOMRIGHT", -offset, settings.paddingBottom)
	end,
}

local modes = {
	BOTTOM = bottomMode,
	TOP = topMode,
	LEFT = leftMode,
	RIGHT = rightMode,
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

	local settings = frame.layout
	local sorted = getSortedChildren(children)
	
	local mode = modes[settings.origin] or bottomMode

	local space = mode.getSpacing(settings)
	local offset = mode.getStartPadding(settings)
	
	for i, child in ipairs(sorted) do
		
		child:ClearAllPoints()
		mode.setPoint(frame, child, settings, offset)
		
		offset = offset + mode.getChildDimension(child) + space
		
	end    
	
	if settings.autosize then
		offset = offset - space + mode.getFinishPadding(settings)
		mode.setContainerDimension(frame, offset)
	end
		
end)
