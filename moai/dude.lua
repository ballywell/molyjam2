require 'class'

lcontact = nil
rcontact = nil

Dude = class()

function Dude:init(world, x, y)
	self.body = world:addBody(MOAIBox2DBody.DYNAMIC)
	self.rect = self.body:addRect(-10, -10, 10, 10)
	self.body:setFixedRotation()
	self.body:setTransform(x, y)
	self.lsensor = self.body:addRect(-9, 8, -8, 12)
	self.rsensor = self.body:addRect(8, 8, 9, 12)
	self.lsensor:setSensor()
	self.rsensor:setSensor()

	self.move_dir = {}

	self.lsensor:setCollisionHandler(handleLCollision, MOAIBox2DArbiter.BEGIN + MOAIBox2DArbiter.END)
	self.rsensor:setCollisionHandler(handleRCollision, MOAIBox2DArbiter.BEGIN + MOAIBox2DArbiter.END)
end

function Dude:move(dir)
	if dir == 'left' then
		self.move_dir['left'] = true
	else
		self.move_dir['right'] = true
	end
--	self:setDir()
end

function Dude:unMove(dir)
	if dir == 'left' then
		self.move_dir['left'] = nil
	else
		self.move_dir['right'] = nil
	end
--	self:setDir()
end

--function Dude:setDir()
--	velX, velY = self.body:getLinearVelocity()
--	if self.move_dir.left then
--		self.body:setLinearVelocity(-50, velY)
--		self.rect:setFriction(0)
--	elseif self.move_dir.right then
--		self.body:setLinearVelocity(50, velY)
--		self.rect:setFriction(0)
--	else
--		self.body:setLinearVelocity(0, velY)
--		self.rect:setFriction(0.5)
--	end
--end

function Dude:jump()
	if lcontact or rcontact then
		velX, velY = self.body:getLinearVelocity()
		self.body:setLinearVelocity(velX, -50)
		self.body:applyLinearImpulse(0, -100)
	end
end

function Dude:update()
	local curX
	local curY
	local curDX
	local curDY

	curX, curY = self.body:getPosition()
	if self.move_dir.left then
		self.body:setTransform(curX-2, curY)
	end
	if self.move_dir.right then
		self.body:setTransform(curX+2, curY)
	end

	curDX, curDY = self.body:getLinearVelocity()
	if not (lcontact or rcontact) then
		if curDY < -10 and curDY > -15 then
			self.body:applyLinearImpulse(0, 50)
		end
	end


	self.body:setAwake(true)
end

function handleLCollision(phase, a, b, arbiter)
	if phase == MOAIBox2DArbiter.BEGIN then
		lcontact = true
	elseif phase == MOAIBox2DArbiter.END then
		lcontact = nil
	end
end

function handleRCollision(phase, a, b, arbiter)
	if phase == MOAIBox2DArbiter.BEGIN then
		rcontact = true
	elseif phase == MOAIBox2DArbiter.END then
		rcontact = nil
	end
end

