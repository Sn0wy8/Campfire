extends CharacterBody2D

@export var speed := 80
@export var health: Health
@onready
var animations = $ratanimations


var enemyhealth
@export var player : Node2D
@export var damage: float

func _ready():
	enemyhealth = health.health

func _physics_process(delta):
	if player == null:
		return	
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

func _on_enemy_hit_box_area_entered(area: Area2D) -> void:
	attack()
	
	
func attack():
	animations.play("rat_attack")



func die():
	queue_free()


func _on_health_health_depleted() -> void:
	die()
