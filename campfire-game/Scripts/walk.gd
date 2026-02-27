extends State
@export var idle_state: State
@export var dash_state: State

func enter() -> void:
	pass  # Do not set velocity here

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('dash'):
		return dash_state
	return null

func process_physics(delta: float) -> State:
	var movement := Input.get_vector("move_left", "move_right","up","down")
	parent.velocity = movement * move_speed
	# Move the character
	parent.move_and_slide()

	# Transition to idle if not moving
	if parent.velocity == Vector2.ZERO:
		return idle_state

	return null
