extends Sprite2D

@onready var Shadow: Sprite2D = $shadow
@onready var AnimPlayer: AnimationPlayer = $AnimationPlayer
@onready var RayCast:RayCast2D = $RayCast2D

const IS_PLAYER = true

var speed: float = 1200
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position += Vector2(1,0).rotated(rotation) * speed * delta
	Shadow.position = Vector2(-2, 2).rotated(-rotation)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "remove":
		queue_free()


func _on_distance_timer_timeout() -> void:
	AnimPlayer.play("remove")
