extends CharacterBody2D
class_name Player
@onready var attack_box: Area2D = $attack_box

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var move_speed: float = 200
@export var coins : int = 0
@export var potions : int = 0

var facing: Vector2 = Vector2.ZERO


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
		attack_box.position = Vector2(0,35)
	elif facing.y < 0:
		animated_sprite.play(prefix + "_backward")
		attack_box.position = Vector2(0,-35)
	elif facing.x < 0:
		animated_sprite.play(prefix + "_side")
		animated_sprite.flip_h = true
		attack_box.position = Vector2(-25,0)
	elif facing.x > 0:
		animated_sprite.play(prefix + "_side")
		animated_sprite.flip_h = false
		attack_box.position = Vector2(25,0)

func collect_pickup(_type : String, _amount : int):
	if _type == "coin":
		coins += _amount
		print("Coins: " + str(coins))
	elif _type == "health_potion":
		potions += _amount
		print("Potion Amount: " + str(potions))
		

# TODO: Add character methods here (Lesson 2)

# - level_up()
# - attack()

func die():
	print("You died!")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit(0)
