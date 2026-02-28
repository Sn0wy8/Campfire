extends PlayerState
@export var idle_state: PlayerState
@export var dash_state: PlayerState

func enter() -> void:
	pass  # Do not set velocity here

func process_input(event: InputEvent) -> PlayerState:
	if Input.is_action_just_pressed('dash'):
		return dash_state
	return null

func process_physics(delta: float) -> PlayerState:
	var movement := Input.get_vector("move_left", "move_right","up","down")
	parent.velocity = movement * move_speed
	# Move the character
	parent.move_and_slide()

	# Transition to idle if not moving
	if parent.velocity == Vector2.ZERO:
		return idle_state

	return null
