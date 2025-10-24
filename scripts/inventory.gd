extends Node
class_name inventory
var selected_item
var max_inventory = 5

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


func show_wares():
	print("here is my inventory")
	#for item in inventory:
		#print(item)
	print(inventory[0])

#print specific inventory
	#print type
	#print quanitity
	#print value
#add to inventory
#remove from inventory
