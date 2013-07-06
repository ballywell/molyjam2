require 'class'

Platform = class()

function Platform:init(body, x, y, w, h)
	fixture = body:addRect(x, y, w, h) -- WELCOME
	fixture:setFilter(0x02)
end
