extends Area2D
class_name HealthPotion

# Healing properties
#@export var heal_amount: int = 30
@export var heal_amount = config_potion_type("green")
@export var auto_pickup: bool = true

func config_potion_type(potion_type:String)->int:
	heal_amount = 0
	if potion_type == "green":
		heal_amount = 5
	if potion_type == "red":
		heal_amount = 10
	return heal_amount

func _ready():
	print("Health Potion created - heals " + str(heal_amount) + " HP")
	# Connect the collision signal
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# Check if it's the player
	if body is Player:
		print("Player found health potion!")
		
		# Try to heal the player (will work once they add heal method)
		if body.has_method("heal"):
			body.heal(heal_amount)
			print("Player healed for " + str(heal_amount) + " HP!")
			
			# Remove the potion after use
			if auto_pickup:
				$AnimationPlayer.play("disappear")
		else:
			print("Player doesn't have heal() method yet - coming in Lesson 2!")

func use_potion(player: Player):
	"""Alternative method for manual potion use"""
	if player.has_method("heal"):
		player.heal(heal_amount)
		$AnimationPlayer.play("disappear")
		return true
	return false
