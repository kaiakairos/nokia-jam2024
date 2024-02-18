extends Node

var player : Player = null


func runDialogue(text:String,endOfDialogue:bool=false,delay:float=0.02):
	await player.say(text.to_upper(),delay,endOfDialogue)
	return
