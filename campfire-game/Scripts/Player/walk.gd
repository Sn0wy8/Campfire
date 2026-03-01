extends PlayerState
@export var idle_state: PlayerState
@export var dash_state: PlayerState
@onready var animated_sprite: AnimatedSprite2D = $"../../animations" 
func enter() -> void:
	pass

func process_input(event: InputEvent) -> PlayerState:
	if Input.is_action_just_pressed('dash'):
		return dash_state
	return null

func process_physics(delta: float) -> PlayerState:
	var movement := Input.get_vector("move_left", "move_right","up","down")
	
	parent.velocity = movement * move_speed
	# Move the character
	parent.move_and_slide()
	if movement == Vector2.UP:
		animated_sprite.play("run back")
		print("1")
	if movement == Vector2.DOWN:
		animated_sprite.play("run front")
		print("2")
	if movement == Vector2.LEFT:
		animated_sprite.play("run side")
		animated_sprite.flip_h = false
		print("3")
	if movement == Vector2.RIGHT:
		animated_sprite.play("run side")
		animated_sprite.flip_h = true
		print("4")
	# Transition to idle if not moving
	if parent.velocity == Vector2.ZERO:
		return idle_state

	return null
