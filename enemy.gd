extends CharacterBody2D

@onready var target = $"../../Player"
@onready var sound = $hitSound


var speed = 300
var enemyHealth = 100
var waveCountMultiplier = 1 


func _physics_process(delta):
	var direction = (target.position - position).normalized()
	velocity = direction * speed * waveCountMultiplier * 0.2
	look_at(target.position)
	move_and_slide()

func _process(delta: float) -> void:
	for i in $enemyBox.get_overlapping_bodies():
		if i.is_in_group("bullet"):
			i.queue_free()
			enemyHealth = enemyHealth - 25
			sound.play()
			if enemyHealth <= 0:
				queue_free()
			
			
