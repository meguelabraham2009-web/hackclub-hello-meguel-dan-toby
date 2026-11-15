extends CharacterBody2D

@export var speed = 400
@export var dashSpeed = 800
@onready var animated_sprite = $Sprite2D

var normalspeed = true

func get_input():
	if normalspeed:
		velocity = transform.x * Input.get_axis("left","right") * speed
		velocity += transform.y * Input.get_axis("up","down") * speed
		animated_sprite.play("walk")
	else:
		velocity = transform.x * Input.get_axis("left","right") * dashSpeed
		velocity += transform.y * Input.get_axis("up","down") * dashSpeed
		animated_sprite.play("walk")

func _physics_process(delta):
	get_input()
	move_and_slide()
		
	if Input.is_action_pressed("run"):
		normalspeed = false
	else:
		normalspeed = true
