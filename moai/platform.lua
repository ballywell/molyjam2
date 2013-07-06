require 'class'


Platform = class()

function Platform:init(x, y, w, h, t)
	self.x = x
	self.y = y
	self.w = w
	self.h = h
	self.text = t
	--self.text = t
	--fixture = worldBody:addRect(x, y, w, h) 
	--fixture:setFilter(0x02)
end
