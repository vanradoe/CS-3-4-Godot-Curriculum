extends npc
class_name enemy

func _on_detection_radius_body_entered(_body: Node2D) -> void:
	if _body.name == "Player":
		is_hostile = true
	
func _on_detection_radius_body_exited(_body: Node2D) -> void:
		is_hostile = false
