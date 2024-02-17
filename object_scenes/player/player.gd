extends CharacterBody2D

var walkTick := 0
const SPEED = 1600

@onready var sprite = $sprite

func _ready():
	pass


func _process(delta):
	
	playerMovement(delta)

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
