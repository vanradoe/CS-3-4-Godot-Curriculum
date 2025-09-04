extends CharacterBody2D
class_name Player

# Movement - Controls how fast the player moves
@export var move_speed: float = 200.0

# TODO: Add health properties here (Lesson 1)
# TODO: Add character identity properties here (Lesson 1)  
# TODO: Add combat stats here (Lesson 1)

func _ready():
	print("Player is ready!")
	# TODO: Add detailed character info display (Lesson 1)

func _physics_process(delta):
	handle_movement()

func handle_movement():
	# Get input direction from arrow keys
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right") 
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	# Normalize diagonal movement to prevent speed boost
	if direction.length() > 0:
		direction = direction.normalized()
	
	# Apply movement using Godot's built-in physics
	velocity = direction * move_speed
	move_and_slide()

# TODO: Add character methods here (Lesson 2)
# - take_damage()
# - heal()
# - level_up()
# - attack()
