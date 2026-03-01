extends PlayerState

@export
var move_state: PlayerState

func enter() -> void:
	var input_dir = Input.get_vector("up", "down", "move_left", "move_right")
	if input_dir != Vector2.DOWN:
		parent.animations.play("idle front")
		print("1")
	if input_dir != Vector2.UP:
		parent.animations.play("idle back")
		print("2")
	if input_dir != Vector2.RIGHT:
		parent.animations.flip_h
		parent.animations.play("idle side")
		print("3")
	if input_dir != Vector2.LEFT:
		parent.animations.play("run front")
		print("4")

func process_input(event: InputEvent) -> PlayerState:
	var movement := Input.get_vector("move_left", "move_right", "up", "down")
	if movement != Vector2.ZERO:
		return move_state
	return null

func process_physics(delta: float) -> PlayerState:
	parent.move_and_slide()
	return null
