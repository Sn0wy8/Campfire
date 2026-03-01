class_name HurtBoxEnemy
extends Area2D


signal received_damage(damage: int)


@export var health: Health


func _ready():
	connect("area_entered", _on_area_entered)


func _on_area_entered(hitbox: PlayerHitbox) -> void:
	if hitbox != null:
		print("hit")
		health.health -= hitbox.damage
		received_damage.emit(hitbox.damage)
	if health.health == 0:
		print("die")

func die():
	queue_free()
