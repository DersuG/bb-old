extends Node



func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit(0)

func _ready():
	$Gameplay/MultiTargetCam.add_target($Gameplay/YSort/Character)
	$Gameplay/MultiTargetCam.add_target($Gameplay/YSort/Player2)
