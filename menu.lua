local composer = require( "composer" )

local scene = composer.newScene()

local musicTrack

local function gotoGame()
	composer.gotoScene( "game", { time=800, effect="crossFade" } )
end

local function gotoScores()
	composer.gotoScene( "highscore", { time=800, effect="crossFade" } )
end

function scene:create( event )

	local sceneGroup = self.view
	
	local background = display.newImageRect("./background.jpg", 1000, 1500)
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	background.ID = "background"

	local title = display.newText('Blackjack', display.contentCenterX, display.contentCenterY - 330, native.systemFont, 40)
	title.x = display.contentCenterX
	title.y = 8
	title:setFillColor( 0, 0, 255, 1 )

	local playButton = display.newText('Play', display.contentCenterX, display.contentCenterY - 330, native.systemFont, 30)
	playButton:setFillColor( 0, 0, 255, 1 )
	playButton.y = 300

	local scoreButton = display.newText('Highscore', display.contentCenterX, display.contentCenterY - 330, native.systemFont, 100 )
	scoreButton:setFillColor( 0, 0, 255, 1 )
	scoreButton.y = 1300

	playButton:addEventListener( "tap", gotoGame )
	scoreButton:addEventListener( "tap", gotoScores )

	musicTrack = audio.loadStream( "./casino.mp3" )
end

function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		audio.play( musicTrack, { channel=1, loops=-1 } )
	end
end

function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		-- Stop the music!
		audio.stop( 1 )
	end
end

function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	-- Dispose audio!
	audio.dispose( musicTrack )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene