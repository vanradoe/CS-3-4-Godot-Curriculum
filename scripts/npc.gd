extends CharacterBody2D
class_name npc

@export var dialogue: Array[String]
@export var speed: int = 200
@export var direction: Vector2 = Vector2.DOWN
@export var health: int = 10
@export var damage: int = 1
@export var ishostile: bool = false
@export var type: String
@export var move_points: Array[Vector2] = []

func _ready():
	pass
	
func _physics_process(_delta):
	pass

func movement():
	pass
