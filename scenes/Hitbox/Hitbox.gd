extends Area2D

onready var collider := $Collider

func enable():
	monitorable = true

func disable():
	monitorable = false

# Gets list of hurtboxes that are hit this frame:
func get_hit() -> Array:
	var results: Array = []
	for area in get_overlapping_areas():
		if area.is_in_group("TYPE_HURTBOX"):
#			area.get_parent().hit()
			results.append(area)
	return results
