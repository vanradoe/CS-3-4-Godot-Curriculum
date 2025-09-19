extends CharacterBody2D
class_name Player


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Movement - Controls how fast the player moves
@export var move_speed: float = 200.0
@export var type: String


var facing: Vector2 = Vector2.ZERO

@export var MAX_HEALTH : int = 10
@export var health : int = MAX_HEALTH
@export var coins : int = 0 

# TODO: Add character identity properties here (Lesson 1)  
# TODO: Add combat stats here (Lesson 1)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit(0)


func _ready():
	print("Player is ready!")
	# TODO: Add detailed character info display (Lesson 1)

func _physics_process(_delta):
	handle_movement()

func handle_movement():
	# Get input direction from arrow keys
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	handle_sprite(direction)
	
	# Normalize diagonal movement to prevent speed boost
	if direction.length() > 0:
		direction = direction.normalized()
	
	# Apply movement using Godot's built-in physics
	velocity = direction * move_speed
	move_and_slide()

# BAD QUICK CODE MAYBE CHANGE
func handle_sprite(direction: Vector2) -> void:
	var prefix: String = "walk"
	if direction == Vector2.ZERO:
		prefix = "idle"
	else:
		facing = direction
	
	if facing.y > 0:
		animated_sprite.play(prefix + "_forward")
	elif facing.y < 0:
		animated_sprite.play(prefix + "_backward")
	elif facing.x < 0:
		animated_sprite.play(prefix + "_side")
		animated_sprite.flip_h = true
	elif facing.x > 0:
		animated_sprite.play(prefix + "_side")
		animated_sprite.flip_h = false
		
func collect_pickup(_amount:int,_type:String) -> bool:
	if _type == "coin":
		coins += _amount
		return true
			
	elif _type == "potion":
		health += _amount
		return true
	else:
		return false


# TODO: Add character methods here (Lesson 2)
# - take_damage()
# - heal()
# - level_up()
# - attack()
