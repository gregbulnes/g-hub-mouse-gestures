# G-HUB Mouse Gestures
Lua script to use mouse gestures in macOS using g-hub

## Installation:
In G-HUB select the profile you want to use these gestures in. Click on "scripting". Click on "create a new lua script". (optional) Give the script a name and description. Click on "edit script". Copy the code from this script and paste it in the script editor that just opened. Click "script>save" or press Command+S to save the script. The script should now be working :)

## How to use:
You perform the gestures by pressing the designated button, moving the mouse in the direction of the funtion that you want to use and then releasing the button.

## Gestures for button G4 (and G7):
Direction | Function  | Buttons | Default
---- | ------- | ----------- | -------
Up | Mission Control | Control+Up-Arrow | Enabled
Down | Application Windows | Control+Down-Arrow | Enabled
Left | Move right a Space | Control+Right-Arrow | Enabled
Right | Move left a Space | Control+Left-Arrow | Enabled

## Gestures for button G5 (and G8):
Direction | Function  | Buttons | Default
---- | ------- | ----------- | -------
Up | none | n/a | n/a
Down | none | n/a | n/a
Left | Next page | Command+Right-Bracket | Enabled
Right | Previous page | Command+Left-Bracket | Enabled

## Ambidextrous mice (side buttons on both sides)
The script identifies a button by its G-number, not by the action G HUB assigns to it. On an ambidextrous mouse the buttons on both sides can show up as "Button 4" and "Button 5" in G HUB while still having different G-numbers, so each side has to be listed in the script.

The defaults cover the PRO Wireless, where the rear and front button do the same thing on both sides:

Button | Position | Used for
---- | ------- | -----------
G4 | Left side, rear | Gestures
G5 | Left side, front | Browser navigation
G7 | Right side, rear | Gestures
G8 | Right side, front | Browser navigation

For another mouse, set debuggingEnabeld to true, press the button and read its number in the console of the script editor.

## Editing the script
If you want to map the gestures to other buttons change the button numbers in gestureButtonNumbers, for example `{4, 7}` or just `{4}`
The same goes for browser navigation, in that case change the button numbers in navigationButtonNumbers

If you want the gesture to happen with more of less movement of your mouse change the value of minimalHorizontalMovement and/or minimalVerticalMovement.

If you want to disable some of the features change the value of missionControlEnabled/ applicationWindowsEnabled/ moveBetweenSpacesEnabled/ browserNavigationEnabled to false

If you want to switch functions just switch the function calls around, it's pretty modular.
If you want to add functions (for example to the two open spots) create a new function, add the keys that bind to the action you want to perform. Call the function from the prefferd "mouseMoved..." function for the preferred buttonNumber.

If you have trouble with understanding what calls get made in what order you can set debuggingEnabeld to true. This will display messages in the console of the editor about what is happening, including the number of every mouse button you press.

If you have trouble with for example finding the names of buttons then in the editor click "Help>Scripting API". This will show you the documentation of scripting with the g-series lua api.
