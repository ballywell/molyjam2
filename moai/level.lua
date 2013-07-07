require 'class'
require 'platform'
require 'string'
require 'string_split'


part = nil
parts = {}

Level = class()


function Level:init(layer, world)
	worldBody = world:addBody(MOAIBox2DBody.STATIC)
	
	charcodes = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,:;!?()&/-'
	font = MOAIFont.new ()
	font:loadFromTTF ( 'WalterTurncoat.ttf', charcodes, 16, 163 )
	bitmapFontReader = MOAIBitmapFontReader.new()
	bitmapFontReader:loadPage('FontVerdana18.png', charcodes,16)
	font:setReader(bitmapFontReader)
	
	self:addPlatform(-100, -50, "welcome") -- WELCOME
	self:addPlatform(-500, 15, "to")

	lines = io.lines('platforms.ini')
	for line in lines do
		parsed = genPlatform(line)
		self:addPlatform(tonumber(parsed[1]), tonumber(parsed[2]), tonumber(parsed[3]))
	end
	
	self.buildPlatforms(layer, world)
end

function genPlatform(line)
	sp = line:split('	')
	return sp
end

function Level:addPlatform(x, y, text)
	part = Platform(x, y, text) -- WELCOME
	table.insert(parts, part)
end

function Level:buildPlatforms()
	for i, v in pairs(parts) do
		
		textbox = MOAITextBox.new ()
		textbox:setString ( v.text )
		textbox:setFont ( font )
		textbox:setTextSize ( 12 )
		textbox:setRect ( v.x, v.y, v.x + 1000, v.y + 1000 )
		
		num1, num2, num3, num4 = textbox:getStringBounds(1, 1000)
		--print(num1, num2, num3, num4)
		textbox:setRect ( num1, num2, num3 + 2, num4 + 2)
		
		layer:insertProp ( textbox )
		
		fixture = worldBody:addRect(num1, num2, num3, num4)
		fixture:setFilter(0x02)
	end	
end

