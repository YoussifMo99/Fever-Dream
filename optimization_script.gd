extends Area3D

@export var Hide: Array[Node3D]
@export var Kill: Array[Node3D]
@export var Show: Array[Node3D]


func _on_body_entered(body):
	print(body, "entered optimization area")
	if body.is_in_group("player"):
		
		for node in Hide:
			node.hide()
			
		for node in Show:
			node.visible = true
			
		for node in Kill:
			if is_instance_valid(node):
				node.queue_free()
