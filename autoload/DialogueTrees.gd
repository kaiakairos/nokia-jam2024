extends Node


## WRITE GAME DIALOGUE CODES IN HERE ##

func entrance():
	await Global.runDialogue("As you descend into the bunker,")
	await Global.runDialogue("the harsh transition of the cold air")
	await Global.runDialogue("engulfs you like water.",true)
	return

func frozenBeast():
	await Global.runDialogue("Deep in the frozen ice, barely visible")
	await Global.runDialogue("deep maroon red")
	await Global.runDialogue("a thousand eyes staring with blank expression")
	await Global.runDialogue("suspended, inanimate flesh.")
	await Global.runDialogue("You get the sense that you shouldn't be looking at them.",true)
	return

func frozenDoor():
	await Global.runDialogue("The door is frozen shut.",true)
	return

func struggleDoor():
	await Global.runDialogue("After some effort, the door snaps open.",true)
	return

func poop():
	await Global.runDialogue("crap crap fart")
	await Global.runDialogue("crap crap farty stink")
	await Global.runDialogue("yep",true,1.0)
	return


