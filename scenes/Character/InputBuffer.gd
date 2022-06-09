extends Label



export(NodePath) var player_path
onready var player = get_node(player_path)

func _process(delta: float) -> void:
	var txt := ""
	
	var count := 0
	for input_data in player.input_buffer:
		count += 1
		txt += str(input_data)
		
		if count < player.input_buffer.size():
			txt += '\n'
	
	text = txt
