extends Node2D

export(NodePath) var character_path
onready var character = get_node(character_path)



func _ready() -> void:
	for move in get_children():
		move.init()

func validate_moves():
	for child_idx in get_child_count():
		var move = get_child(child_idx)
		
		if move.validate():
			move.start()
