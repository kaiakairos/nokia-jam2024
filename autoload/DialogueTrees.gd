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

func unfreeze():
	await Global.runDialogue("The machine sits still and silent.")
	await Global.runDialogue("You press its buttons, and hear the machine let out a long, unending breath.")
	await Global.runDialogue("The room slowly gets warmer.",true)
	Global.player.position.y += 300
	return

func unfrozenBeast():
	await Global.runDialogue("The flesh is gone.",true)
	return

func snowMound():
	await Global.runDialogue("A huge mound of ice blocks your way.")
	await Global.runDialogue("You can hear the subtle movement of water.",true)
	return

func brokenLadder():
	await Global.runDialogue("The bunker ladder is broken.")
	await Global.runDialogue("It was torn as easily as paper.",true)
	return

func meltingMound():
	await Global.runDialogue("The dripping of water gets louder and louder.",true)
	return

func frozenDoor():
	await Global.runDialogue("The door is frozen shut.",true)
	return

func lockedDoor():
	await Global.runDialogue("The door is locked.",true)
	return
	
func unlockedDoor():
	await Global.runDialogue("The key opened the door.",true)
	return

func struggleDoor():
	await Global.runDialogue("After some effort, the door snaps open.",true)
	return

func pickUpKeyFirst():
	Global.items.append("key1")
	await Global.runDialogue("You found a dusty old key.",true)
	return

func poop():
	await Global.runDialogue("crap crap fart")
	await Global.runDialogue("crap crap farty stink")
	await Global.runDialogue("yep",true,1.0)
	return


