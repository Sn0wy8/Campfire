class_name HurtBox
extends Area2D


signal received_damage(damage: int)


@export var health: Health


func _ready():
	connect("area_entered", _on_area_entered)


func _on_area_entered(enemy_hit_box: EnemyHitbox) -> void:
	if enemy_hit_box != null:
		health.health -= enemy_hit_box.damage
		received_damage.emit(enemy_hit_box.damage)
