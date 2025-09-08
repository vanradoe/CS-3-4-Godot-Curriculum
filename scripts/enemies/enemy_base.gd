extends StaticBody2D

@onready var sprite: Sprite2D = $Sprite2D


@export var move_speed: float = 5

var player: CharacterBody2D = null


func _ready() -> void:
	player = Global.game_world.player
	

func _process(delta: float) -> void:
	pass
	# MOVE TWOARD PLAYER
