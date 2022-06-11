extends KinematicBody2D

var floatingtext = preload("res://FloatingText.tscn")

var air_height := 0.0		# Height above the ground. Positive is up.
var ground_height := 0.0	# Y coordinate of the ground.
var knockback := Vector2.ZERO

var health = 60



func _physics_process(delta: float) -> void:
	
#	air_height -= 500.0 * delta
#
#	if air_height <= 0:
#		ground_height = position.y
#		air_height = 0.0
#	position.y = ground_height + air_height
#	position += knockback
	knockback *= max(0, 1.0 - 20.0 * delta) # Knockback decreases by a percentage over time.
	move_and_collide(knockback)

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

func hit(damage: float, kb: Vector2 = Vector2.ZERO):
	var text = floatingtext.instance()
	text.amount = damage
	health -= damage
	$AnimationPlayer.play("Hit")
	text.global_position = get_node("Position2D").global_position
	get_parent().add_child(text)
	knockback += kb
	if health <= 0:
		$AnimationPlayer.play("dead")
