extends CharacterBody2D
class_name npc

@export var dialogue: Array[String]
@export var inventory: Array[String]
@export var speed: int = 200
@export var direction: Vector2 = Vector2.DOWN
@export var health: int = 10
@export var damage: int = 1
@export var ishostile: bool = false
@export var type: String
@export var move_points: Array[Vector2] = []
@export var drop_item = preload("res://scenes/coin.tscn")
@export var drop_rate: float = 1.0
@export var state = 0

func _ready():
	pass
	
func _process(_delta):
	pass
	
func _drop_item():
	#create a new copy of the prefab object
	var drop = drop_item.instantiate()
	
	#child drop to the parent scene
	get_tree().get_root().add_child(drop)
	
	#set the in game position to the position of the npc
	drop.global_position = position

func movement(_delta):
	if ishostile:
		position = position.move_toward(Vector2)
	else:
		move_points[-8,20]


#CONNECT NPC SPRITE TO SCRIPTS. without having it do the same things as the main player.
