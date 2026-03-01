extends PlayerState
@onready var animated_sprite: AnimatedSprite2D = $"../../animations" 
@export
var move_state: PlayerState
func enter() -> void:
	animated_sprite.play("idle front")
func process_input(event: InputEvent) -> PlayerState:
	var movement := Input.get_vector("move_left", "move_right", "up", "down")
	if movement != Vector2.ZERO:
		return move_state
	return null

func process_physics(delta: float) -> PlayerState:
	parent.move_and_slide()
	return null
