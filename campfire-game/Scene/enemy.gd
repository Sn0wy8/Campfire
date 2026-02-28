extends CharacterBody2D

@export var move_speed: float = 80.0
@export var chase_speed: float = 140.0
@export var detection_range: float = 250.0
@export var attack_range: float = 40.0
@export var wander_radius: float = 150.0

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var state_machine = $StateMachine

var player: Node2D
var spawn_position: Vector2

func _ready():
	spawn_position = global_position
	player = get_tree().get_first_node_in_group("player")
	state_machine.init(self)

func _physics_process(delta):
	state_machine.physics_process(delta)
	move_and_slide()
