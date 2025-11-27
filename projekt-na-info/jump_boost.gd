extends Node2D

@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	Global.jump_speed = 300
	timer.start()
	visible = false


func _on_timer_timeout() -> void:
	Global.jump_speed = 245
	queue_free()
