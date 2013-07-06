
Textboxes = class()

function Textboxes:init(world, x, y)
MOAISim.openWindow ( "Textboxes", 320, 480 )
 
viewport = MOAIViewport.new ()
viewport:setScale ( 320, 480 )
viewport:setSize ( 320, 480 )
layer = MOAILayer2D.new ()
layer:setViewport ( viewport )
MOAISim.pushRenderPass ( layer )

font = MOAIFont.new ()
font:loadFromTTF ( 'Bastarda-K.ttf', charcodes, 16, 163 )

textbox = MOAITextBox.new ()
textbox:setString ( "This is our text for the tutorial over textboxes" )
textbox:setFont ( font )
textbox:setTextSize ( font:getScale ())
textbox:setRect ( -150, -230, 150, 230 )
textbox:setYFlip ( true )
layer:insertProp ( textbox )