extends Area2D
class_name Spike

# Damage properties
@export var damage_amount: int = 25
@export var damage_cooldown: float = 1.0

# Internal tracking
var can_damage: bool = true

func _ready():
	print("Spike created - deals " + str(damage_amount) + " damage")
	# Connect the collision signal
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# Check if it's the player and we can damage
	if body is Player and can_damage:
		print("Player touched spike! Dealing " + str(damage_amount) + " damage")
		
		# Try to damage the player (will work once they add take_damage method)
		if body.has_method("take_damage"):
			body.take_damage(damage_amount)
		else:
			print("Player doesn't have take_damage() method yet - coming in future lesson!")
		
		# Play the animation of the spikes resetting
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.play()
		
		# Start cooldown to prevent spam damage
		can_damage = false
		get_tree().create_timer(damage_cooldown).timeout.connect(_reset_damage_cooldown)

func _reset_damage_cooldown():
	can_damage = true
	print("Spike is ready to damage again")
