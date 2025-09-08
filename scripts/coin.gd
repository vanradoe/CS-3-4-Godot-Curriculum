# This next line allows the color of the coin to update without running the game
@tool

extends Area2D


@export var color: Color


func _process(delta: float) -> void:
	# Set the color of the coin
	$AnimatedSprite2D.material.set_shader_parameter("color", color)
