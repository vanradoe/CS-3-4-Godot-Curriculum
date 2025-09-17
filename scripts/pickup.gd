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
			return true
		if _label == "gold":
			_amount = 10
			return true
		if _label == "silver":
			_amount = 15
			return true

	
	elif _type == "potion":
		if _label == "green":
			_amount = 20
			return true
		if _label == "red":
			_amount = 50
			return true
	else:
		return false
