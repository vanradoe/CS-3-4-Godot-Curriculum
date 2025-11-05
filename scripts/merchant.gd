extends npc
class_name merchant

var open = true
var buyer = true
var barter_amount: float = 0.9
var refusal = false
var sleeping = false
var steal = false
var greeting = "welcome to my shop."
var selected_item = 0



	
func _on_detection_radius_body_entered(_body: Node2D) -> void:
	super._on_detection_radius_body_entered(_body)
	show_wares()
	
func show_wares():
	print("Hello. I have these items: ")
	
