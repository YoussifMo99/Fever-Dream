extends CharacterBody3D

var speed
var WALK_SPEED = 10.0
var SPRINT_SPEED = 20.0
var JUMP_VELOCITY = 15.0
var SENSITIVITY = 0.004
var in_water: bool = false
var gravity = 40.0
var mouse_captured := true

# Mouse smoothing fix (web bug)
var last_mouse_delta := Vector2.ZERO
const MAX_DELTA_CHANGE := 100.0
var current_delta
@onready var color_rect: ColorRect = $CanvasLayer/ColorRect
@onready var player: CharacterBody3D = $"."
@onready var camera: Camera3D = $Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	add_to_group("player")
	print("PLAYER READY - Groups: ", get_groups())
	color_rect.visible = false

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		mouse_captured = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		return
	if event is InputEventMouseButton and event.pressed and not mouse_captured:
		mouse_captured = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		return
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
	if in_water:
		velocity.y -= gravity * delta

		if Input.is_action_pressed("jump"):
			velocity.y = lerp(velocity.y, 5.0, 5.0 * delta)

		var direction = Vector3.ZERO

		if Input.is_action_pressed("up"):
			direction -= camera.global_transform.basis.z
		if Input.is_action_pressed("down"):
			direction += camera.global_transform.basis.z
		if Input.is_action_pressed("left"):
			direction -= camera.global_transform.basis.x
		if Input.is_action_pressed("right"):
			direction += camera.global_transform.basis.x

		direction = direction.normalized()
		velocity.x = lerp(velocity.x, direction.x * WALK_SPEED, 5.0 * delta)
		velocity.y = lerp(velocity.y, direction.y * WALK_SPEED, 5.0 * delta)
		velocity.z = lerp(velocity.z, direction.z * WALK_SPEED, 5.0 * delta)

	else:
		# Normal gravity
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


@onready var underwater_sfx: AudioStreamPlayer = $underwater
var fade_tween: Tween

func _on_waterarea_area_entered(area: Area3D) -> void:
	if area.is_in_group("head"):
		print("head entered")
		color_rect.visible = true
		
		if fade_tween: fade_tween.kill()
		underwater_sfx.volume_db = -60
		underwater_sfx.play()
		fade_tween = create_tween()
		fade_tween.tween_property(underwater_sfx, "volume_db", 0.0, 0.4)


func _on_waterarea_area_exited(area):
	if area.is_in_group("head"):
		print("head exited")
		color_rect.visible = false
		
		if fade_tween: fade_tween.kill()
		fade_tween = create_tween()
		fade_tween.tween_property(underwater_sfx, "volume_db", -60.0, 0.4)
		fade_tween.tween_callback(underwater_sfx.stop)
