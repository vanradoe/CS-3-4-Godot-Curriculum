extends npc
class_name enemy

func _on_detection_radius_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_hostile = true
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var knockback_direction = (body.global_position - global_position).normalized()
		body.apply_knockback(knockback_direction, 150.0, 3)
	
func _on_detection_radius_body_exited(body: Node2D) -> void:
		is_hostile = false
