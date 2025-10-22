extends AnimatableBody2D
var is_open = false

func _ready() -> void:
	set_is_open(is_open)

func _on_detection_radius_2_body_entered(_body: Node2D) -> void:
	if _body.name == "Player":
		is_open = true
		set_is_open(is_open)


func _on_detection_radius_2_body_exited(_body: Node2D) -> void:
	if _body.name == "Player":
		if is_open:
			is_open = false 
			set_is_open(is_open)
		pass

@warning_ignore("shadowed_variable")
func set_is_open(is_open: bool) -> void:
	if !is_open:
		$AnimatedSprite2D.frame = 0
		collision_layer = 1
		$LightOccluder2D.visible = false
	if is_open:
		$AnimatedSprite2D.frame = 1
		collision_layer = 0
		$LightOccluder2D.visible = true
