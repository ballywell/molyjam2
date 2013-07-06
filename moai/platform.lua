require 'class'


Platform = class()

function Platform:init(x, y, t)
	self.x = x
	self.y = y
	self.text = t
end
