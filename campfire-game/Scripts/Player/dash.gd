extends PlayerState

@export var idle_state: PlayerState
@export var move_state: PlayerState

var dash_timer := 0.0
var dash_direction := Vector2.ZERO

func enter() -> void:
	# If dash is not ready, immediately return to idle/move
	if not parent.can_dash:
		return

	# Start dash
	dash_timer = parent.dash_time
	dash_direction = Input.get_vector("move_left", "move_right", "up", "down")
	if dash_direction == Vector2.ZERO:
		dash_direction = Vector2.RIGHT
	dash_direction = dash_direction.normalized()
	parent.can_dash = false  # trigger cooldown

func process_physics(delta: float) -> PlayerState:
	if dash_timer > 0:
		dash_timer -= delta
		parent.velocity = dash_direction * parent.dash_speed
		parent.move_and_slide()
		return null  # still dashing

	# Dash finished, return to appropriate state
	var movement = Input.get_vector("move_left", "move_right", "up", "down")
	if movement != Vector2.ZERO:
		return move_state
	else:
		return idle_state
