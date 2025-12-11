extends Node2D

@export var wait_time_till_spawn = 1
@export var x = 0
@export var y = 0

var LOG = preload("uid://xn7q5t0x1ri4")

func _physics_process(delta: float) -> void:
	$Timer.wait_time = wait_time_till_spawn


func _on_timer_timeout() -> void:
	var log = LOG.instantiate()
	log.position.x = x
	log.position.y = y
	add_child(log)
