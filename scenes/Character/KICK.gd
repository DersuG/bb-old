extends Node2D

var character

onready var hitbox := $Hitbox


func init():
	character = get_parent().character

func validate() -> bool:
	if character.fsm.get_current_node() == "IDLE":
		if character.was_input_down("kick"):
			return true
	return false

func start():
	character.add_input("null")
	character.fsm.travel("KICK")

func _physics_process(delta: float) -> void:
	for area in hitbox.get_overlapping_areas():
		if area.is_in_group("TYPE_HURTBOX"):
			area.get_parent().hit()
