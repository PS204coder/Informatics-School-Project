extends CharacterBody2D
	
	
func _physics_process(delta: float) -> void:
	if Global.player_vel.x > 0:
		position.x -= 0.1
	elif Global.player_vel.x < 0:
		position.x += 0.1

	if Global.player_vel.y < 0 and Global.player_pos.y < -60:
		position.y -= 0.1
	elif Global.player_vel.y > 0 and Global.player_pos.y < -60:
		position.y += 0.1
		
