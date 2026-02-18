extends Area3D

var player_inside: bool = false
var player: CharacterBody3D = null


# Water values
const WATER_GRAVITY = 4.0
const WATER_WALK_SPEED = 7.0
const WATER_SPRINT_SPEED = 10.0
const WATER_JUMP_VELOCITY = 4.0

# Default values
const DEFAULT_GRAVITY = 40.0
const DEFAULT_WALK_SPEED = 10.0
const DEFAULT_SPRINT_SPEED = 20.0
const DEFAULT_JUMP_VELOCITY = 15.0


func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _on_body_entered(body: Node3D):
	if body.is_in_group("player"):
		player_inside = true
		player = body
		player.in_water = true


func _on_body_exited(body: Node3D):
	if body.is_in_group("player"):
		player_inside = false
		player.in_water = false
		player.velocity = Vector3.ZERO
		player.gravity = DEFAULT_GRAVITY
		player.WALK_SPEED = DEFAULT_WALK_SPEED
		player.SPRINT_SPEED = DEFAULT_SPRINT_SPEED
		player.JUMP_VELOCITY = DEFAULT_JUMP_VELOCITY
		player = null
		

func _process(delta):
	if player_inside and player and is_instance_valid(player):
		player.gravity = lerp(player.gravity, WATER_GRAVITY, 2.0 * delta)
		player.WALK_SPEED = lerp(player.WALK_SPEED, WATER_WALK_SPEED, 2.0 * delta)
		player.SPRINT_SPEED = lerp(player.SPRINT_SPEED, WATER_SPRINT_SPEED, 2.0 * delta)
		player.JUMP_VELOCITY = lerp(player.JUMP_VELOCITY, WATER_JUMP_VELOCITY, 2.0 * delta)
		player.velocity *= 0.98
	else:
		if player and is_instance_valid(player):
			player.gravity = lerp(player.gravity, DEFAULT_GRAVITY, 50.0 * delta)
			player.WALK_SPEED = lerp(player.WALK_SPEED, DEFAULT_WALK_SPEED, 50.0 * delta)
			player.SPRINT_SPEED = lerp(player.SPRINT_SPEED, DEFAULT_SPRINT_SPEED, 50.0 * delta)
			player.JUMP_VELOCITY = lerp(player.JUMP_VELOCITY, DEFAULT_JUMP_VELOCITY, 50.0 * delta)



		
