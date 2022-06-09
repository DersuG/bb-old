extends KinematicBody2D



onready var fsm: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
onready var animator := $Animator
onready var flip := $Flip
onready var moveset := $Flip/Moveset

var is_facing_right := true
var is_collider_facing_right := true

const INPUTS := [
	"left",
	"right",
	"up",
	"down",
	"punch",
	"kick"
]
var input_buffer := [] # Stores the inputs for the last 10 frames.
const INPUT_BUFFER_LENGTH := 10
var input_consumed := false
var null_input_timer_max := 12 # Frames before a null input is registered.
var null_input_timer := 0

var frame := 0

func _ready() -> void:
	init_input_buffer()

func _physics_process(delta: float) -> void:
	frame += 1
	
	poll_inputs()
	
	#null_input_timer -= 1
	if null_input_timer <= 0:
		input_buffer.clear()
		init_input_buffer()
	
	var movement_vec := Vector2.ZERO
	if fsm.get_current_node() == "IDLE":
		if Input.is_action_pressed("left"):
			movement_vec += Vector2.LEFT
		if Input.is_action_pressed("right"):
			movement_vec += Vector2.RIGHT
		if Input.is_action_pressed("up"):
			movement_vec += Vector2.UP
		if Input.is_action_pressed("down"):
			movement_vec += Vector2.DOWN
	movement_vec = movement_vec.normalized()
	
	if is_facing_right:
		flip.scale.x = 1
		if not is_collider_facing_right:
			$Collider.position.x *= -1
			is_collider_facing_right = true
	else:
		flip.scale.x = -1
		if is_collider_facing_right:
			$Collider.position.x *= -1
			is_collider_facing_right = false
	
	move_and_slide(movement_vec * 350)
	
	
	moveset.validate_moves()
	
	if fsm.get_current_node() == "IDLE":
		if was_input_down("punch"):
			add_input("null")
			fsm.travel("PUNCH")
	
	if fsm.get_current_node() == "PUNCH":
		if was_input_down("punch"):
			add_input("null")
			fsm.travel("DOUBLE_PUNCH")
	
	if fsm.get_current_node() == "DOUBLE_PUNCH":
		if was_input_down("punch"):
			add_input("null")
			fsm.travel("TRIPLE_PUNCH")


func poll_inputs():
	var can_be_none := false
	var has_input := false
	for input in INPUTS:
		if Input.is_action_just_pressed(input):
			has_input = true
			if input_buffer[0] != input:
				add_input(input)
				input_consumed = false
				null_input_timer = null_input_timer_max
		
		if Input.is_action_pressed(input):
			has_input = true
		
		if Input.is_action_just_released(input):
			can_be_none = true
	
	if can_be_none and not has_input:
		if input_buffer[0] != "none":
			add_input("none")
			input_consumed = false
			null_input_timer = null_input_timer_max

func init_input_buffer() -> void:
	for i in range(INPUT_BUFFER_LENGTH):
		input_buffer.append("null")

func add_input(input: String):
	if input_buffer.size() <= 0 or input_buffer[0] != input:
		input_buffer.push_front(input)
	while input_buffer.size() > INPUT_BUFFER_LENGTH:
		input_buffer.pop_back()

func was_input_down(input: String) -> bool:
	if input_buffer.size() > 0:
		if input_buffer[0] == input: return true
		if input_buffer[0] == "none":
			if input_buffer[1] == input: return true
	return false
