extends PlayerState

@export
var move_state: PlayerState

func enter() -> void:
	pass

func process_input(event: InputEvent) -> PlayerState:
	var movement := Input.get_vector("move_left", "move_right", "up", "down")
	if movement != Vector2.ZERO:
		return move_state
	return null

func process_physics(delta: float) -> PlayerState:
	parent.move_and_slide()
	return null
