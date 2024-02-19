extends Area2D
class_name Interactable

@export var originSetWhenInteracting : Vector2 = Vector2.ZERO
@export var treeFunction :String = ""
@export var mustBeInteracted :bool = true

@export var teleportPlayer : bool = false
@export var teleportPos :Vector2 = Vector2.ZERO

@export var oneShot :bool = false
@export var showSprite :bool = false
var activated = false

@export var needItem:bool = false
@export var item :String = ""
@export var treeIfNoItem :String = ""

func _ready():
	set_process(false)
	$ItemSprite.visible = showSprite

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
	
	var DIALOGUE = treeFunction
	var hasItem = Global.items.has(item)
	if needItem:
		if !hasItem:
			DIALOGUE = treeIfNoItem
	
	if DialogueTrees.has_method(DIALOGUE):
		if originSetWhenInteracting != Vector2.ZERO:
			set_process(true)
	
		var callable = Callable(DialogueTrees, DIALOGUE)
		
		await callable.call()
		set_process(false)
	
	if teleportPlayer and hasItem:
		Global.player.teleport(teleportPos)
	
	if hasItem:
		activated = true
		$ItemSprite.visible = false


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
		$ItemSprite.visible = false
