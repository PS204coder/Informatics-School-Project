extends CharacterBody2D

var movement_speed = 2500

@export var Goal: Node = null


func _ready() -> void:
	scale = Vector2(0.5,0.5)
	$Timer.start()
	$NavigationAgent2D.target_position = Goal.global_position

func _physics_process(delta: float) -> void:
	if scale.x < 1:
		scale = Vector2(move_toward(scale.x, 1, 0.1),move_toward(scale.y, 1, 0.1) )
	movement_speed += 0.1
	if Global.time_passed == 30:
		movement_speed += 100
	if Global.time_passed == 60:
		movement_speed += 100
	
	
	
	if !$NavigationAgent2D.is_target_reached():
		var nav_point_direction = to_local($NavigationAgent2D.get_next_path_position()).normalized()
		velocity = nav_point_direction * movement_speed * delta
		move_and_slide()
		$Spear001.look_at(Global.player_pos)
		$Spear001.rotation_degrees += 90

func _on_timer_timeout() -> void:
	if $NavigationAgent2D.target_position != Goal.global_position:
		$NavigationAgent2D.target_position = Goal.global_position
	$Timer.start()


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body != $".":
		Global.player_died = true
