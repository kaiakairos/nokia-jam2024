extends Node

var game = null
var player : Player = null
var items :Array= [""]

func runDialogue(text:String,endOfDialogue:bool=false,delay:float=0.02):
	await player.say(text.to_upper(),delay,endOfDialogue)
	return
