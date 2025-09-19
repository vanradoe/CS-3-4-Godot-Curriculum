extends Area2D
class_name pickup

@export var amount: int
@export var type: String
@export var sound: AudioEffectFilter
@export var label: String

func _ready():
	body_entered.connect(_on_body_entered)
	config_Pickup (amount, type, label)
	
func _on_body_entered(body):
	if body.name == "Player":
		body.collect_pickup(amount,type)
		#play sound effect
		
func config_Pickup(_amount:int,_label:String,_type:String) -> bool:
	if _type == "coin":
		if _label == "copper":
			_amount = 5
			print("copper coin found! +5 coins.")
			return true
		elif _label == "gold":
			_amount = 10
			print("gold coin found! +10 coins.")
			return true
		elif _label == "silver":
			_amount = 15
			print("silver coin found! +15 coins.")
			return true
		else:
			return false
			
	elif _type == "potion":
		if _label == "green":
			_amount = 20
			print("green potion found! +20 health.")
			return true
		elif _label == "red":
			_amount = 50
			print("red potion found! +50 health.")
			return true
		else: 
			return false
	else:
		return false
