extends AnimatedSprite2D

@export var speed = 100
@export var bullet_speed = 2500

@onready var target = $".."
@onready var cooldownTimer = $"../Cooldown"
@onready var throwSound = $"../throw"


var health = 100
var bullet = preload("res://bullet.tscn")
var readytoThrow = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("throw") and readytoThrow == true:
		readytoThrow = false
		cooldownTimer.start()
		throwSound.play()
		var bullet_instance = bullet.instantiate()
		bullet_instance.position = get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		$"../..".add_child(bullet_instance)
		bullet_instance.apply_central_impulse(Vector2(bullet_speed, 0).rotated(rotation))
	for i in $"../Area2D".get_overlapping_bodies():
		if i.is_in_group("bullet") and i.get_node("Timer").time_left == 0:
			i.queue_free()
		if i.is_in_group("enemy"):
			if health <= 0:
				get_tree().change_scene_to_file("res://death.tscn")
			health -=1
			print(health)
	if cooldownTimer.time_left == 0:
		readytoThrow = true
			
