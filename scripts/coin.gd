# This next line allows the color of the coin to update without running the game
# It can mostly be ignored, but it must be the first line of the script
@tool

extends Area2D
class_name Coin


@export var color: Color
@export var coin_value: int = 5
@export var auto_pickup: bool = true

func _ready():
	print("Coin created - worth 1 Gold" + str(coin_value) + " Gold")
	# Connect the collision signal
	body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	# Check if it's the player
	if body is Player:
		print("Player found 1 Gold!") 

#func spend_coin (player: Player):
	#"""Alternative method for manual coin use"""
	#if player.has_method("spend"):
		#player.spend(spend_amount)
		#$AnimationPlayer.play("disappear")
		#return true
	#return false


func _process(delta: float) -> void:
	# Set the color of the coin
	$AnimatedSprite2D.material.set_shader_parameter("color", color)
