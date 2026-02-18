extends Area3D



func _on_body_entered(body):
	#print("body entered: ", body.name)
	if body.is_in_group("player"):
		#print("player entered")
		body.in_target_area = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		body.in_target_area = false
