extends Node2D
class_name GameWorld

# Player reference - our main character
@onready var player = $Player

# Test objects for character methods
@onready var spike = $Spike
@onready var health_potion = $HealthPotion

func _ready():
	print("=== GAME WORLD LOADED ===")
	print("Use arrow keys to move the player")
	print("Touch the RED spike to take damage")
	print("Touch the GREEN potion to heal")
	print("Press SPACE for debug info")
	print("========================")

func _unhandled_input(event):
	# Debug commands for testing character systems
	if event.is_action_pressed("ui_select"):  # Space key
		print("=== DEBUG INFO ===")
		if player.has_method("take_damage"):
			print("✅ Player has take_damage() method")
		else:
			print("❌ Player missing take_damage() method")
			
		if player.has_method("heal"):
			print("✅ Player has heal() method")  
		else:
			print("❌ Player missing heal() method")
			
		if player.has_method("level_up"):
			print("✅ Player has level_up() method")
		else:
			print("❌ Player missing level_up() method")
			
		print("==================")

# TODO: Add game management methods here (Future lessons)
# - spawn_enemy()
# - handle_combat()  
# - check_game_over()
