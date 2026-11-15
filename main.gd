extends Node2D

var index = 0


func spawn(m):
	var child = load("res://enemy.tscn").instantiate()
	$enemies.add_child(child)
	child.position  = [$spawn.position,$spawn2.position,$spawn3.position][index]
	index = index + 1
	child.waveCountMultiplier = m
	if index >= 2:
		index = 0
	
var wave =  [1,2,3,4,5,6,7,8,9,10]
var waveCount = 0

func _process(delta: float) -> void:
	if $enemies.get_child_count() == 0:
		for i in range(wave[waveCount]):
			spawn(waveCount+1)
			await get_tree().create_timer(1).timeout
		waveCount += 1
	$Player/Camera2D/CanvasLayer/Control/ProgressBar.value = $enemies.get_child_count()/wave[waveCount-1]
	$Player/Camera2D/CanvasLayer/Control/healthBar.value = $Player/Sprite2D.health
