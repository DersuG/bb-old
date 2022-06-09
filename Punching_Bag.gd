extends StaticBody2D



func _on_Hurtbox_area_entered(area):
	if area.is_in_group("TYPE_HITBOX") and area.is_in_group("PUNCH"):
		print("damaged from punch")
	if area.is_in_group("TYPE_HITBOX") and area.is_in_group("KICK"):
		print("damaged from kick")
