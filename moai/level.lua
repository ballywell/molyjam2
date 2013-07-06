require 'class'
require 'platform'

part = nil

Level = class()


function Level:init(world)
	worldBody = world:addBody(MOAIBox2DBody.STATIC)
	part = Platform(worldBody, -500, 15, 500, 20)
	part = Platform(worldBody, -100, -50, 0, 0) -- WELCOME
end

