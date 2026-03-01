extends CharacterBody2D

@export var speed := 80
@export var dash_speed := 350
@export var enemy_max_health := 200
@export var bullet_scene : PackedScene
@export var health: Health

var can_shoot := true
var enemyhealth
var can_dash := true

@export var player : Node2D

func _ready():
	enemyhealth = health.health
	$AttackTimer.start()

func _physics_process(delta):
	if player == null:
		return
	
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

	# Dash if close
	if can_dash and global_position.distance_to(player.global_position) < 150:
		dash(direction)
		
	_on_AttackTimer_timeout()
		
func dash(direction):
	can_dash = false
	velocity = direction * dash_speed
	move_and_slide()
	$DashCooldown.start()

func _on_DashCooldown_timeout():
	can_dash = true

func _on_AttackTimer_timeout():
	if not can_shoot:
		return
	can_shoot = false
	shoot_radial()
	$AttackTimer.start()
	await get_tree().create_timer(1.5).timeout
	can_shoot = true

func shoot_radial():
	if player == null:
		return
	
	var bullet_count = 1
	
	var base_direction = (player.global_position - global_position).normalized()
	
	# Spread angle in radians (15 degrees)
	var spread = deg_to_rad(15)
	
	for i in range(bullet_count):
		var bullet = bullet_scene.instantiate()
		bullet.global_position = global_position
		
		if bullet_count == 1:
			bullet.direction = base_direction
		else:
			var offset = spread * (i - (bullet_count - 1) / 2.0)
			bullet.direction = base_direction.rotated(offset)
		
		get_tree().current_scene.add_child(bullet)

func take_damage(amount):
	enemyhealth -= amount

	if enemyhealth <= 0:
		die()

func die():
	queue_free()


func _on_hurt_box_enemy_received_damage(damage: int) -> void:
	if health.health == 0:
		die()
