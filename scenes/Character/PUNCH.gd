extends Node2D

#onready var character = get_parent().character
var character

onready var hitbox := $Hitbox


func init():
	character = get_parent().character

func validate() -> bool:
	if character.fsm.get_current_node() == "IDLE":
		if character.was_input_down("punch_1"):
			return true
	return false

func start():
	character.add_input("null")
	character.fsm.travel("PUNCH")

# Call via animation every frame that the hitbox should actually hit.
func hit():
	for area in hitbox.get_hit():
		area.get_parent().hit(5, Vector2(20 * character.get_facing_sign(), 0))
