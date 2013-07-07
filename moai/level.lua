require 'class'
require 'platform'
require 'string'
require 'string_split'
require 'io'


part = nil
parts = {}

Level = class()


function Level:init(layer, world)
	worldBody = world:addBody(MOAIBox2DBody.STATIC)
	
	charcodes = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,:;!?()&/-'
	font = MOAIFont.new ()
	font:loadFromTTF ( 'WalterTurncoat.ttf', charcodes, 60, 163 )
	
	--self:addPlatform(-100, -50, "welcome") -- WELCOME
	--self:addPlatform(-500, 15, "to")

	lines = io.lines('platforms.ini')
	for line in lines do
		parsed = genPlatform(line)
		self:addPlatform(tonumber(parsed[1]), tonumber(parsed[2]), tostring(parsed[3]))
	end
	
	self.buildPlatforms(layer, world)
end

function genPlatform(line)
	sp = line:split('	')
	return sp
end

function Level:addPlatform(x, y, text)
	--print("FOO")
	--print(tostring(x))
	--print(tostring(y))
	--print(tostring(text))
	part = Platform(x, y, text) -- WELCOME
	table.insert(parts, part)
end

function Level:buildPlatforms()
	for i, v in pairs(parts) do
		
		textbox = MOAITextBox.new ()
		textbox:setString ( v.text )
		textbox:setFont ( font )
		textbox:setTextSize ( 60 )
		if v.x and v.y then
			textbox:setRect ( v.x, v.y, v.x + 1000, v.y + 1000 )
			end
		
		local num1 = 0
		local num2 = 0
		local num3 = 0
		local num4 = 0

		num1, num2, num3, num4 = textbox:getStringBounds(1, 1000)
		--print(num1, num2, num3, num4)
		if num1 and num2 and num3 and num4 then
			textbox:setRect ( num1, num2, num3 + 4, num4 + 4)
		
			layer:insertProp ( textbox )
			
			fixture = worldBody:addRect(num1, num2, num3 + 4, num4 + 4)
			fixture:setFilter(0x02)
		else
			print("ERROR: " .. tostring(v.text))
		end
	end	
end

