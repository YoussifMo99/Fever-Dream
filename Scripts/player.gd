extends CharacterBody3D

var speed
const WALK_SPEED = 10.0
const SPRINT_SPEED = 20.0
const JUMP_VELOCITY = 15
const SENSITIVITY = 0.004

var gravity = 40
var mouse_captured := true

# Mouse smoothing fix (web bug)
var last_mouse_delta := Vector2.ZERO
const MAX_DELTA_CHANGE := 100.0
var current_delta

@onready var player: CharacterBody3D = $"."
@onready var camera: Camera3D = $Camera3D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	add_to_group("player")
	print("PLAYER READY - Groups: ", get_groups())


func _unhandled_input(event):

	# Toggle with Escape
	if event.is_action_pressed("ui_cancel"): # Escape by default
		mouse_captured = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		return

	# Click to recapture
	if event is InputEventMouseButton and event.pressed and not mouse_captured:
		mouse_captured = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		return

	# Only rotate camera if captured
	if mouse_captured and event is InputEventMouseMotion:
		current_delta = event.relative
		var delta_change = current_delta - last_mouse_delta

		if delta_change.length() > MAX_DELTA_CHANGE:
			return

		last_mouse_delta = current_delta

		player.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))


func _physics_process(delta):

	# Gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Sprint
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED

	# Movement
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, 0.0, delta * 7.0)
			velocity.z = lerp(velocity.z, 0.0, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)

	move_and_slide()
