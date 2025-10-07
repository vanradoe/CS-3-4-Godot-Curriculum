extends Node


var game_world: GameWorld = null
@export var playermaxHealth : int = 5
@export var playerhealth : int = playermaxHealth


func _ready() -> void:
	game_world = get_tree().current_scene
