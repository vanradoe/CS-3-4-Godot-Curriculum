# This next line allows the color of the coin to update without running the game
# It can mostly be ignored, but it must be the first line of the script
@tool

extends Area2D
class_name Coin


@export var color: Color
@export var coin_value: int = 50
@export var auto_pickup: bool = true

func _ready():
	print("Coin created - worth " + str(coin_value) + " Gold")
	# Connect the collision signal
	body_entered.connect(_on_body_entered)



func _on_body_entered(body):
	# Check if it's the player
	if body is Player:
		print("Player found " + str(coin_value) + " Gold!") 
		
		if body.has_method("collect"):
			body.collect(coin_value)
			print("Player used " + str(coin_value) + " Gold!")
			
			# Remove the potion after use
			if auto_pickup:
				$AnimationPlayer.play("disappear")
		else:
			print("Player doesn't have collect() method yet - coming soon!")

func collect_coin (player: Player):
	"""Alternative method for manual coin use"""
	if player.has_method("collect"):
		player.collect(coin_value)
		$AnimationPlayer.play("disappear")
		return true
	return false


func _process(delta: float) -> void:
	# Set the color of the coin
	$AnimatedSprite2D.material.set_shader_parameter("color", color)
