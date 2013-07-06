require 'class'


Platform = class()

function Platform:init(x, y, w, h, t)
	self.x = x
	self.y = y
	self.w = w
	self.h = h
	self.text = t
end
