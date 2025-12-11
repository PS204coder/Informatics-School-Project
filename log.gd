extends RigidBody2D
@export var direction_of_spin = 1
@export var speed = 50

func _ready() -> void:
	$AnimatedSprite2D.play("spin")

func _physics_process(delta: float) -> void:
	
	
	if $AnimatedSprite2D.animation == "spin":
		linear_velocity.x = speed * direction_of_spin
	elif $AnimatedSprite2D.animation == "spin_end":
		linear_velocity.x = move_toward(linear_velocity.x, 0, 1)

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "spin":
		$AnimatedSprite2D.play("spin_end")
	else:
		queue_free()


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if $AnimatedSprite2D.animation != "spin_end":
		Global.player_died = true
