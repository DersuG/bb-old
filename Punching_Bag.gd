extends StaticBody2D

var floatingtext = preload("res://FloatingText.tscn")

func _on_Hurtbox_area_entered(area):
	if area.is_in_group("TYPE_HITBOX") and area.is_in_group("PUNCH"):
		print("damaged from punch")
		punch_hit()
	if area.is_in_group("TYPE_HITBOX") and area.is_in_group("KICK"):
		print("damaged from kick")

func punch_hit():
	var damage = 10
	var text = floatingtext.instance()
	text.amount = damage
	print(text.amount)
	get_node("Position2D").add_child(text)

func hit(damage: float):
	var text = floatingtext.instance()
	text.amount = damage
	get_node("Position2D").add_child(text)
