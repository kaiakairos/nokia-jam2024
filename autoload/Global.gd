extends Node

var player : Player = null


func runDialogue(text:String,delay:float=0.02,endOfDialogue:bool=false):
	await player.say(text,delay,endOfDialogue)
	return
