extends "res://BaseState.gd"

func enter():
	set_random_target()

func physics_process(delta):
	if can_see_player():
		state_machine.change_state("ChaseState")
		return
	
	if enemy.nav_agent.is_navigation_finished():
		state_machine.change_state("IdleState")
		return
	
	move(enemy.move_speed)

func set_random_target():
	var offset = Vector2(
		randf_range(-enemy.wander_radius, enemy.wander_radius),
		randf_range(-enemy.wander_radius, enemy.wander_radius)
	)
	
	enemy.nav_agent.target_position = enemy.spawn_position + offset

func move(speed):
	var next_point = enemy.nav_agent.get_next_path_position()
	var direction = (next_point - enemy.global_position).normalized()
	enemy.velocity = direction * speed

func can_see_player():
	return enemy.global_position.distance_to(enemy.player.global_position) <= enemy.detection_range
