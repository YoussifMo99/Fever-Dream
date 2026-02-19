extends Area3D

@export var launch_strength: float = 48.0
@export var launch_direction: Vector3 = Vector3.UP

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


	


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		print("jump")
		body.velocity.y = launch_strength
		# Optional: also boost horizontal if you want a directional pad
		# body.velocity += launch_direction.normalized() * launch_strength
