extends StaticBody2D



func _on_Hurtbox_area_entered(area):
	if area.is_in_group("TYPE_HITBOX"):
		print("damaged")
