extends Area3D


@export var player: CharacterBody3D

func _on_body_entered(body):
	player.global_position = global_position
