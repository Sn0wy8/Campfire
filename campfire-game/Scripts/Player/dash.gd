extends PlayerState

@export var idle_state: PlayerState
@export var move_state: PlayerState

@export var dash_speed: float = 1000
@export var dash_time: float = 0.2

var dash_timer: float
var dash_direction: Vector2

func enter() -> void:
	dash_timer = dash_time
	
	dash_direction = Input.get_vector("move_left", "move_right", "up", "down")
	
	if dash_direction == Vector2.ZERO:
		dash_direction = Vector2.RIGHT  # fallback direction
	
	dash_direction = dash_direction.normalized()

func process_physics(delta: float) -> PlayerState:
	dash_timer -= delta
	
	parent.velocity = dash_direction * dash_speed
	parent.move_and_slide()
	
	if dash_timer <= 0:
		var movement := Input.get_vector("move_left", "move_right", "up", "down")
		if movement != Vector2.ZERO:
			return move_state
		else:
			return idle_state
	
	return null
