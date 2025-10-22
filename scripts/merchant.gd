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


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("item_up"):
		selected_item -=1
		if selected_item <0:
			selected_item = 0
		print(inventory[selected_item])
	
	if Input.is_action_just_pressed("item_down"):
		selected_item +=1
		if selected_item >inventory.size()-1:
			selected_item = inventory.size()-1
		print(inventory[selected_item])


func show_wares():
	print("here is my inventory")
	#for item in inventory:
		#print(item)
	print(inventory[0])
	
func _on_detection_radius_body_entered(_body: Node2D) -> void:
	super._on_detection_radius_body_entered(_body)
	show_wares()
	
