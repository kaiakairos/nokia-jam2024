extends CharacterBody2D
class_name Player

var walkTick := 0
const SPEED = 1600

@onready var sprite = $sprite
@onready var camera = $CameraOrigin/Camera2D
@onready var camOrigin = $CameraOrigin

var newOrigin : Vector2 = Vector2.ZERO
var originTicks : int = 0

func _ready():
	Global.player = self


func _process(delta):
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
	else:
		walkTick = 0
	
	move_and_slide()

func shiftCameraOrigin(newPos):
	camOrigin.position = lerp(camOrigin.position,newPos,0.1)
