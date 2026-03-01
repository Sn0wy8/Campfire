class_name Player
extends CharacterBody2D

@onready
var animations = $animations
@onready
var state_machine = $state_machine
@onready
var gun = $GunPivot/Gun
@onready
var gun_pivot: Marker2D = $GunPivot
@export
var gun_hold_distance: float

@export var dash_speed := 1000
@export var dash_time := 0.2
@export var dash_cooldown := 1.0

var can_dash := true
var dash_cooldown_timer := 0.0


func _ready() -> void:
	state_machine.init(self)
	add_to_group("player")

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	var mouse_direction := gun_pivot.global_position.direction_to(get_global_mouse_position())
	gun.position = mouse_direction * gun_hold_distance
	gun.scale.y = 1 if mouse_direction.x > 0 else -1
	gun.show_behind_parent = mouse_direction.y < 0
	gun.look_at(get_global_mouse_position())
		# Update dash cooldown
	if not can_dash:
		dash_cooldown_timer += delta
		if dash_cooldown_timer >= dash_cooldown:
			can_dash = true
			dash_cooldown_timer = 0.0

	state_machine.process_frame(delta)


func _on_health_health_depleted() -> void:
	position = GlobalScript.checkpoint_pos
	print("death") 


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
