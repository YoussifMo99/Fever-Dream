extends Area3D

var falls:int = 0

@export var player: CharacterBody3D

func _on_body_entered(body):
	falls += 1
	
	
	if falls == 1:
		$AtteptMockery.play("1")
	if falls == 2: 
		$AtteptMockery.play("2")
	player.global_position = global_position

func _unhandled_input(event):
	if Input.is_action_just_pressed("control"):
		player.global_position = global_position
