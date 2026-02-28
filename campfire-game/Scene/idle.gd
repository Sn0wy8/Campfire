extends State

@export
var wander_state: State
@export
var chase_state: State

func enter() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
