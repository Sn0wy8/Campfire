extends "res://BaseState.gd"

func enter():
	enemy.velocity = Vector2.ZERO

func physics_process(delta):
	if can_see_player():
		state_machine.change_state("ChaseState")

func can_see_player():
	return enemy.global_position.distance_to(enemy.player.global_position) <= enemy.detection_range
