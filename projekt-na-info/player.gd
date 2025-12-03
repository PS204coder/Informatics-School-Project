extends CharacterBody2D

const SPEED = 100

@onready var animations: AnimatedSprite2D = $animations
@onready var player: CharacterBody2D = $"."

var jumping = false
var gravity_changer = 1
var is_on_left_wall = false
var is_on_right_wall = false

var wall_jump_available = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animations.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta * gravity_changer
		jumping = false
	
	if is_on_floor():
		wall_jump_available = 1
	if animations.animation == "jump" and is_on_floor() and animations.is_playing() == false:
		animations.play("idle")
	if Input.is_action_just_pressed("jump") and is_on_wall_only() and wall_jump_available > 0:
		jumping = true
		animations.stop()
		animations.play("jump")
		velocity.y = -Global.jump_speed
		wall_jump_available = 0
	if Input.is_action_pressed("jump") and is_on_floor():
		jumping = true
		animations.stop()
		animations.play("jump")
		velocity.y -= Global.jump_speed
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		if animations.animation != "jump":
			animations.play("left")
	elif Input.is_action_pressed("right"):
		velocity.x = SPEED
		if animations.animation != "jump":
			animations.play("right")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor() and animations.animation != "jump":
			animations.play("idle")

	
	#Sticking on wall

	if is_on_right_wall == true  and velocity.y > 0:
		gravity_changer = 0.05
		animations.play("wall_right")
	elif is_on_left_wall == true and velocity.y > 0:
		gravity_changer = 0.05
		animations.play("wall_left")
	else:
		gravity_changer = 1

	
	
	if position.y > 0:
		get_tree().reload_current_scene()
	move_and_slide()




func _on_wall_checker_right_body_entered(body: Node2D) -> void:
	if body != player:
		is_on_right_wall = true
func _on_wall_checker_left_body_entered(body: Node2D) -> void:
	if body != player:
		is_on_left_wall = true
func _on_wall_checker_left_body_exited(body: Node2D) -> void:
	if body != player:
		is_on_left_wall = false

func _on_wall_checker_right_body_exited(body: Node2D) -> void:
	if body != player:
		is_on_right_wall = false
