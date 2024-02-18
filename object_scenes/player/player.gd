extends CharacterBody2D
class_name Player

var isInDialogue : bool = false
var isLevelTransitioning : bool = false

var walkTick := 0
const SPEED = 1600

@onready var sprite = $sprite
@onready var camera = $CameraOrigin/Camera2D
@onready var camOrigin = $CameraOrigin
@onready var interactCast = $InteractCast
@onready var dialogueText = $CameraOrigin/Camera2D/Label

var newOrigin : Vector2 = Vector2.ZERO
var originTicks : int = 0

signal pressedContinue

func _ready():
	Global.player = self


func _process(delta):
	
	interacting()
	
	if !isInDialogue and !isLevelTransitioning:
		playerMovement(delta)
	
	if originTicks > 0:
		originTicks -= 1
		shiftCameraOrigin(newOrigin)
	else:
		shiftCameraOrigin(Vector2.ZERO)

func playerMovement(delta):
	var dir := Vector2.ZERO
	if Input.is_action_pressed("moveUP"):
		dir.y -= 1
	if Input.is_action_pressed("moveDOWN"):
		dir.y += 1
	if Input.is_action_pressed("moveRIGHT"):
		dir.x += 1
	if Input.is_action_pressed("moveLEFT"):
		dir.x -= 1
	
	velocity = dir.normalized() * SPEED * delta
	if dir != Vector2.ZERO:
		walkTick += 1
		if walkTick % 10 == 0:
			sprite.flip_h = !sprite.flip_h
		
		interactCast.target_position = dir.normalized() * 5
		
	else:
		walkTick = 0
	
	move_and_slide()

func interacting():
	
	if Input.is_action_just_pressed("interact"):
		
		if isInDialogue:
			emit_signal("pressedContinue")
			return
		
		if interactCast.is_colliding():
			if interactCast.get_collider() is Interactable:
				interactCast.get_collider().runCast()
	
	
	
func shiftCameraOrigin(newPos:Vector2):
	camOrigin.position = lerp(camOrigin.position,newPos,0.1)

func say(text:String,delay:float=0.02,endOfDialogue:bool=false):
	
	isInDialogue = true
	
	dialogueText.visible_characters = 0
	dialogueText.text = text
	
	if delay == 0:
		dialogueText.visible_characters = -1
		
		await pressedContinue
		if endOfDialogue:
			dialogueText.text = ""
			isInDialogue = false
		return

	for i in range(text.length()):
		dialogueText.visible_characters += 1
		await get_tree().create_timer(delay).timeout
	
	await pressedContinue
	if endOfDialogue:
		dialogueText.text = ""
		isInDialogue = false
	return
	
func teleport(newPos):
	isLevelTransitioning = true
	$CameraOrigin/Camera2D/LowCutFade.frame = 1
	await get_tree().create_timer(0.2).timeout
	$CameraOrigin/Camera2D/LowCutFade.frame = 2
	await get_tree().create_timer(0.2).timeout
	$CameraOrigin/Camera2D/LowCutFade.frame = 3
	await get_tree().create_timer(0.2).timeout
	$CameraOrigin/Camera2D/LowCutFade.frame = 4
	await get_tree().create_timer(0.2).timeout
	$CameraOrigin/Camera2D.enabled = false
	
	
	
	position = newPos
	await get_tree().create_timer(1.0).timeout
	$CameraOrigin/Camera2D.enabled = true
	
	$CameraOrigin/Camera2D/LowCutFade.frame = 3
	await get_tree().create_timer(0.2).timeout
	$CameraOrigin/Camera2D/LowCutFade.frame = 2
	await get_tree().create_timer(0.2).timeout
	$CameraOrigin/Camera2D/LowCutFade.frame = 1
	await get_tree().create_timer(0.2).timeout
	$CameraOrigin/Camera2D/LowCutFade.frame = 0
	await get_tree().create_timer(0.2).timeout
	isLevelTransitioning = false
