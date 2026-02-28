extends "res://BaseState.gd"

func enter():
	# Optional: reset velocity when entering chase
	enemy.velocity = Vector2.ZERO

func physics_process(delta):
	if enemy.player == null:
		return

	# 1️⃣ Distance to player
	var distance = enemy.global_position.distance_to(enemy.player.global_position)

	# 2️⃣ Lost the player → go back to wander
	if distance > enemy.detection_range:
		state_machine.change_state("WanderState")
		return

	# 3️⃣ Set target for pathfinding
	enemy.nav_agent.target_position = enemy.player.global_position

	# 4️⃣ Move toward the next path point
	move_toward_player(enemy.chase_speed)

	# 5️⃣ Only attack if really close (ignore nav_agent finished)
	if distance <= enemy.attack_range:
		state_machine.change_state("AttackState")

# ------------------------
# Movement Helper
# ------------------------
func move_toward_player(speed):
	var next_point = enemy.nav_agent.get_next_path_position()
	var direction = (next_point - enemy.global_position).normalized()

	# Only stop if extremely close to next_point
	if (next_point - enemy.global_position).length() < 1.0:
		enemy.velocity = Vector2.ZERO
		return

	enemy.velocity = direction * speed
