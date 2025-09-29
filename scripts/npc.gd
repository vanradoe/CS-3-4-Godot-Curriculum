extends CharacterBody2D
class_name npc
@onready var player: Player = $"../Player"

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
@export var current_point = 0

func _ready():
	pass
	
func _physics_process(_delta):
	movement(_delta)
	
func _drop_item():
	#create a new copy of the prefab object
	var drop = drop_item.instantiate()
	
	#child drop to the parent scene
	get_tree().get_root().add_child(drop)
	
	#set the in game position to the position of the npc
	drop.global_position = position

func movement(_delta):
	var target
	if !ishostile:
		target = move_points[current_point]
		
	else: target = player.position
	
	var target_direction = position.direction_to(target)
	velocity = target_direction*speed
	if position.distance_to(target)<6:
		current_point+=1
		if current_point > move_points.size()-1:
			current_point = 0
	
	move_and_slide()
