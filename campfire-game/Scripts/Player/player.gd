class_name Player
extends CharacterBody2D

@onready
var state_machine = $state_machine
@onready
var gun = $GunPivot/Gun
@onready
var gun_pivot: Marker2D = $GunPivot
@export
var gun_hold_distance: float

func _ready() -> void:
    state_machine.init(self)
    add_to_group("Player")

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

    state_machine.process_frame(delta)
