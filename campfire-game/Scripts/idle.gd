extends State

@export
var move_state: State

func enter() -> void:
	pass

func process_input(event: InputEvent) -> State:
	var movement := Input.get_vector("move_left", "move_right", "up", "down")
	if movement != Vector2.ZERO:
		return move_state
	return null

func process_physics(delta: float) -> State:
	parent.move_and_slide()
	return null
