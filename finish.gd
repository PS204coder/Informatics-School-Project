extends Node2D

@export var which_lvl_tp_go: String
func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	body.visible = false
	$AnimatedSprite2D.play("finish")
	


func _on_animated_sprite_2d_animation_finished() -> void:
	print("abc")
	get_tree().change_scene_to_file(which_lvl_tp_go)
