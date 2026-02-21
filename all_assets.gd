extends Node3D

@export var Hide: Array[Node3D]

func _ready():
	for node in Hide:
		node.hide()

	await get_tree().physics_frame
	$IntroAnimation.play("intro")

@export var skip_text: RichTextLabel
@export var ani: AnimationPlayer

func _unhandled_key_input(event):


	if Input.is_action_just_pressed("enter"):
		if $IntroAnimation/Skip.visible == true:
			$IntroAnimation.speed_scale = 100
			$IntroAnimation/LostYeezys.volume_db = -80

	if ani.is_playing():
		skip_text.visible = true

	if !ani.is_playing():
		skip_text.visible = false
