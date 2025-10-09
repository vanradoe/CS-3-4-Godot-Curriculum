extends npc
class_name enemy

func _on_detection_radius_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_hostile = true
	
func _on_detection_radius_body_exited(body: Node2D) -> void:
		is_hostile = false
