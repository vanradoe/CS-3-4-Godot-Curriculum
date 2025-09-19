# This next line allows the color of the coin to update without running the game
# It can mostly be ignored, but it must be the first line of the script
@tool

extends pickup
class_name coin

func _on_body_entered(body):
	super._on_body_entered(body)
	
		
		
