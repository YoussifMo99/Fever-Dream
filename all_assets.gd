extends Node3D

@export var Hide: Array[Node3D]

func _ready():
	for node in Hide:
		node.hide()
