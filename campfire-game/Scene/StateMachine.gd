extends Node

var current_state: Node
var enemy

func init(enemy_ref):
	enemy = enemy_ref
	
	for child in get_children():
		child.enemy = enemy
		child.state_machine = self
	
	change_state("IdleState")

func change_state(state_name: String):
	if current_state:
		current_state.exit()
	
	print("Switching to: ", state_name)  # ADD THIS
	
	current_state = get_node(state_name)
	current_state.enter()

func physics_process(delta):
	if current_state:
		current_state.physics_process(delta)
