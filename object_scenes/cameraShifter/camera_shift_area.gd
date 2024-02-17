extends Area2D

@export var originSet : Vector2 = Vector2.ZERO

func _process(delta):
	
	if !is_instance_valid(Global.player):
		return
	
	if get_overlapping_bodies().has(Global.player):
		Global.player.newOrigin = originSet
		Global.player.originTicks = 3
