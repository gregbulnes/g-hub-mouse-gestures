--[[
Author: Mark van den Berg
Version: 0.8
Date: 01-05-2020

Special credits to https://github.com/wookiefriseur for showing a way to do this for windows gestures which inspired this script
For some windows gestures check https://github.com/wookiefriseur/LogitechMouseGestures

This script wil let you use a button on your mouse to act like the "Gesture button" from Logitech Options.
It will also let you use another button on your mouse for navigating between browser pages using gestures.

The default settings below will be for the multytasking gestures from macOS
 - Up 		Mission Control 	(Control+Up-Arrow)
 - Down 	Application Windows (Control+Down-Arrow)
 - Left 	move right a space 	(Control+Right-Arrow)
 - Right 	move left a space 	(Control+Left-Arrow)

The default settings below will be for the navigation gestures for in browsers
 - Up 		{ no action }
 - Down 	{ no action }
 - Left 	next page 		(Command+Right-Bracket)
 - Right 	previous page 	(Command+Left-Bracket)
]]--

 
-- The buttons your gestures are mapped to G1 = 1, G2 = 2 etc..
-- This is the G-number of the physical button, not the action assigned to it in G HUB.
-- On an ambidextrous mouse both sides can be assigned "Button 4"/"Button 5" and still
-- have their own G-number. For the PRO Wireless:
--   left side:  G4 (rear), G5 (front)
--   right side: G7 (rear), G8 (front)
-- (G6 is the DPI button on the bottom.)
gestureButtonNumbers = {4, 7};

-- The buttons navigation actions are mapped to G1 = 1, G2 = 2 etc..
navigationButtonNumbers = {5, 8};

-- The minimal horizontal/vertical distance your mouse needs to be moved for the gesture to recognize in pixels
minimalHorizontalMovement = 200;
minimalVerticalMovement = 200;

-- Default values for 
horizontalStartingPosistion = 0;
verticalStartingPosistion = 0;
horizontalEndingPosistion = 0;
verticalEndingPosistion = 0;

-- Delay between keypresses in millies
delay = 20

-- Here you can enable/disable features of the script
missionControlEnabled = true
applicationWindowsEnabled = true
moveBetweenSpacesEnabled = true
browserNavigationEnabled = true

-- Toggles debugging messages
debuggingEnabeld = false

-- Event detection
function OnEvent(event, arg, family)
	-- Logged for every mouse button, also the ones that are not mapped, so you can look up the number of a button
	if debuggingEnabeld and (event == "MOUSE_BUTTON_PRESSED" or event == "MOUSE_BUTTON_RELEASED") then
		OutputLogMessage("\nEvent: " .. event .. " for button: " .. arg .. "\n")
	end

	if event == "MOUSE_BUTTON_PRESSED" and (isGestureButton(arg) or isNavigationButton(arg)) then

		-- Get stating mouse posistion
		horizontalStartingPosistion, verticalStartingPosistion = GetMousePosition()
		
		if debuggingEnabeld then 
			OutputLogMessage("Horizontal starting posistion: " .. horizontalStartingPosistion .. "\n") 
			OutputLogMessage("Vertical starting posistion: " .. verticalStartingPosistion .. "\n") 
		end
	end

	if event == "MOUSE_BUTTON_RELEASED" and (isGestureButton(arg) or isNavigationButton(arg)) then

		-- Get ending mouse posistion
		horizontalEndingPosistion, verticalEndingPosistion = GetMousePosition()
		
		if debuggingEnabeld then 
			OutputLogMessage("Horizontal ending posistion: " .. horizontalEndingPosistion .. "\n") 
			OutputLogMessage("Vertical ending posistion: " .. verticalEndingPosistion .. "\n") 
		end

		-- Calculate differences between start and end posistions
		horizontalDifference = horizontalStartingPosistion - horizontalEndingPosistion
		verticalDifference = verticalStartingPosistion - verticalEndingPosistion

		-- Determine the direction of the mouse and if the mouse moved far enough
		if horizontalDifference > minimalHorizontalMovement then mouseMovedLeft(arg) end
		if horizontalDifference < -minimalHorizontalMovement then mouseMovedRight(arg) end
		if verticalDifference > minimalVerticalMovement then mouseMovedDown(arg) end
		if verticalDifference < -minimalVerticalMovement then mouseMovedUp(arg) end
	end
end

-- Mouese Moved
function mouseMovedUp(buttonNumber)
	if debuggingEnabeld then OutputLogMessage("mouseMovedUp\n") end
	
	if isGestureButton(buttonNumber) and missionControlEnabled then 
		performMissionControlGesture()
	end
end

function mouseMovedDown(buttonNumber)
	if debuggingEnabeld then OutputLogMessage("mouseMovedDown\n") end
	
	if isGestureButton(buttonNumber) and applicationWindowsEnabled then 
		performApplicationWindowsGesture()
	end
end

function mouseMovedLeft(buttonNumber)
	if debuggingEnabeld then OutputLogMessage("mouseMovedLeft\n") end
	
	if isGestureButton(buttonNumber) and moveBetweenSpacesEnabled then 
		performSwipeLeftGesture()
	end
	if isNavigationButton(buttonNumber) and browserNavigationEnabled then 
		performNextPageGesture()
	end
end

function mouseMovedRight(buttonNumber)
	if debuggingEnabeld then OutputLogMessage("mouseMovedRight\n") end
	
	if isGestureButton(buttonNumber) and moveBetweenSpacesEnabled then 
		performSwipeRightGesture()
	end
	if isNavigationButton(buttonNumber) and browserNavigationEnabled then 
		performPreviousPageGesture()
	end
end

-- Gesture Functions
function performMissionControlGesture()
	if debuggingEnabeld then OutputLogMessage("performMissionControlGesture\n") end
	firstKey = "lctrl"
	secondKey = "up"
	pressTwoKeys(firstKey, secondKey)
end

function performApplicationWindowsGesture()
	if debuggingEnabeld then OutputLogMessage("performApplicationWindowsGesture\n") end
	firstKey = "lctrl"
	secondKey = "down"
	pressTwoKeys(firstKey, secondKey)
end

function performSwipeLeftGesture()
	if debuggingEnabeld then OutputLogMessage("performSwipeLeftGesture\n") end
	firstKey = "lctrl"
	secondKey = "right"
	pressTwoKeys(firstKey, secondKey)
end

function performSwipeRightGesture()
	if debuggingEnabeld then OutputLogMessage("performSwipeRightGesture\n") end
	firstKey = "lctrl"
	secondKey = "left"
	pressTwoKeys(firstKey, secondKey)
end

-- Browser Navigation Functions
function performNextPageGesture()
	if debuggingEnabeld then OutputLogMessage("performNextPageGesture\n") end
	firstKey = "lgui"
	secondKey = "rbracket"
	pressTwoKeys(firstKey, secondKey)
end

function performPreviousPageGesture()
	if debuggingEnabeld then OutputLogMessage("performPreviousPageGesture\n") end
	firstKey = "lgui"
	secondKey = "lbracket"
	pressTwoKeys(firstKey, secondKey)
end

-- Helper Functions
function isGestureButton(buttonNumber)
	return listContains(gestureButtonNumbers, buttonNumber)
end

function isNavigationButton(buttonNumber)
	return listContains(navigationButtonNumbers, buttonNumber)
end

function listContains(list, value)
	for _, item in ipairs(list) do
		if item == value then return true end
	end
	return false
end

function pressTwoKeys(firstKey, secondKey)
	PressKey(firstKey)
	Sleep(delay)
	PressKey(secondKey)
	Sleep(delay)
	ReleaseKey(firstKey)
	ReleaseKey(secondKey)
end

