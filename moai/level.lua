require 'class'
require 'platform'

part = nil
parts = {}

Level = class()


function Level:init(layer, world)
	worldBody = world:addBody(MOAIBox2DBody.STATIC)
	
	charcodes = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,:;!?()&/-'
	font = MOAIFont.new ()
	font:loadFromTTF ( 'WalterTurncoat.ttf', charcodes, 16, 163 )
	
	self:addPlatform(-100, -50, 0, 0, "welcome") -- WELCOME
	self:addPlatform(-500, 15, 500, 40, "to")
	
	self.buildPlatforms(layer, world)
end

function Level:addPlatform(x, y, w, h, text)
	part = Platform(x, y, w, h, text) -- WELCOME
	table.insert(parts, part)
end

function Level:buildPlatforms()
	for i, v in pairs(parts) do
		fixture = worldBody:addRect(v.x, v.y, v.w, v.h)
		fixture:setFilter(0x02)
		
		textbox = MOAITextBox.new ()
		textbox:setString ( v.text )
		textbox:setFont ( font )
		textbox:setTextSize ( 12 )
		textbox:setRect ( v.x, v.y, v.w, v.h )
		layer:insertProp ( textbox )
	end	
end

