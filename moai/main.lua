require 'dude'
require 'level'

MOAISim.openWindow("foo", 1280, 720)
viewport = MOAIViewport.new()
viewport:setSize(1280, 720)
viewport:setScale(1280, -720)

layer = MOAILayer2D.new()
layer:setViewport(viewport)
MOAISim.pushRenderPass(layer)

world = MOAIBox2DWorld.new()
world:setGravity(0, 20)
world:setUnitsToMeters(.1)
world:start()
layer:setBox2DWorld(world)

tutorial = Level(layer, world)

stickman = Dude(world, -100, -200)

camera = MOAICamera2D.new()
layer:setCamera(camera)

fitter = MOAICameraFitter2D.new ()
fitter:setViewport ( viewport )
fitter:setCamera ( camera )
fitter:setBounds ( -10000, -10000, 10000, 10000 )
fitter:setMin ( 400 )
fitter:start ()

anchor = MOAICameraAnchor2D.new()
anchor:setParent(stickman.camera_prop)
anchor:setRect(-50, -250, 50, 150)
fitter:insertAnchor(anchor)


function keyboardEvent(key, down)
	if (key == 32 or key == 119 or key == 87) then -- space bar / w / W
		stickman:jump()

	elseif (key == 97 or key == 65) then -- a / A / left arrow
		if down then
			stickman:move('left')
		else
			stickman:unMove('left')
		end
	elseif (key == 100 or key == 68) then -- d / D / right arrow
		if down then
			stickman:move('right')
		else
			stickman:unMove('right')
		end
	end
end


function main()
	MOAIInputMgr.device.keyboard:setCallback(keyboardEvent)

	mainThread = MOAIThread.new()

	mainThread:run(
	function()
	while(true) do
		coroutine.yield()
		stickman:update()
	end
end
)
end

main()
