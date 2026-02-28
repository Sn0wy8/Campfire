extends "res://BaseState.gd"

func enter():
	enemy.velocity = Vector2.ZERO

func physics_process(delta):
	var distance = enemy.global_position.distance_to(enemy.player.global_position)
	
	if distance > enemy.attack_range:
		state_machine.change_state("ChaseState")
		return
	
	print("Attacking player!")
