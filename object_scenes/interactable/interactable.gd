extends Area2D
class_name Interactable

@export var originSetWhenInteracting : Vector2 = Vector2.ZERO
@export var treeFunction :String = ""

func _ready():
	set_process(false)

func _process(delta):
	
	if !is_instance_valid(Global.player):
		return
	
	Global.player.newOrigin = originSetWhenInteracting
	Global.player.originTicks = 3

func runCast():
	
	if !DialogueTrees.has_method(treeFunction):
		print_debug("WARNING: I DO NOT HAVE A CORRECT DIALOGUE TREE: " + str(self))
		return
	
	if originSetWhenInteracting != Vector2.ZERO:
		set_process(true)
	
	var callable = Callable(DialogueTrees, treeFunction)
	
	await callable.call()
	set_process(false)

