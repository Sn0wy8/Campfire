extends State

@export
var idle_state: State
@export
var chase_state: State
var velocity 

@onready var nav_agent: NavigationAgent2D = $"../../NavigationAgent2D"
@onready var player = "res://Scene/player.tscn"


func _physics_process(delta: float) -> void:
	var current_position: Vector2 = self.global_transform.origin
	var next_path_position: Vector2 = nav_agent.get_next_path_position()
	var new_velocity: Vector2 = current_position.direction_to(next_path_position)
	nav_agent.velocity = new_velocity
	update_target_position(player.global_transform.origin)

func update_target_position(target_pos: Vector2):
	nav_agent.target_positon = target_pos
	
func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = velocity.move_toward(safe_velocity * move_speed, 12.0)
	move_and_slide()
