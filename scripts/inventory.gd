extends Node
class_name inventory

@export var my_inventory : Array[inventory_item] = []
var selected_item : int = 0
var max_items : int = 5 
var current_item : int = 0

func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("item_up"):
		selected_item -=1
		if selected_item <0:
			selected_item = 0
		print(my_inventory[selected_item].type)
	
	if Input.is_action_just_pressed("item_down"):
		selected_item +=1
		if selected_item > my_inventory.size()-1:
			selected_item = my_inventory.size()-1
		print(my_inventory[selected_item].type)

func display_inventory (_index: int):
	print("the current item is " + my_inventory[current_item].name)
	print("it costs " +str(my_inventory[current_item].cost))

func add_inventory(_new_item:Resource):
	if my_inventory.size() < max_items:
		my_inventory.append(1)
	else: print("the inventory is already full.")
	
func remove_inventory(_item_to_use: Resource):
	pass
	
#func show_wares():
	#print("here is my inventory")
	##for item in inventory:
		##print(item)
	#print(inventory[0])


#print specific inventory
	#print type
	#print quanitity
	#print value
#add to inventory
#remove from inventory
