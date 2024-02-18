extends Area2D
class_name Interactable

@export var originSetWhenInteracting : Vector2 = Vector2.ZERO
@export var treeFunction :String = ""
@export var mustBeInteracted :bool = true

@export var teleportPlayer : bool = false
@export var teleportPos :Vector2 = Vector2.ZERO

@export var oneShot :bool = false
var activated = false

func _ready():
	set_process(false)

func _process(delta):
	
	if !is_instance_valid(Global.player):
		return
	
	Global.player.newOrigin = originSetWhenInteracting
	Global.player.originTicks = 3

func runCast():
	
	if oneShot and activated:
		return
	
	if !mustBeInteracted:
		return
	
	if !DialogueTrees.has_method(treeFunction):
		print_debug("WARNING: I DO NOT HAVE A CORRECT DIALOGUE TREE: " + str(self))
		return
	
	if originSetWhenInteracting != Vector2.ZERO:
		set_process(true)
	
	var callable = Callable(DialogueTrees, treeFunction)
	
	await callable.call()
	set_process(false)
	
	if teleportPlayer:
		Global.player.teleport(teleportPos)
	
	activated = true


func _on_body_entered(body):
	if mustBeInteracted:
		return
	if oneShot and activated:
		return
	if body == Global.player:
		if DialogueTrees.has_method(treeFunction):
			if originSetWhenInteracting != Vector2.ZERO:
				set_process(true)
			var callable = Callable(DialogueTrees, treeFunction)
		
			await callable.call()
			set_process(false)
			
		if teleportPlayer:
			body.teleport(teleportPos)
		
		activated = true
