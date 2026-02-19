extends Area3D

@onready var password_ui = $"/root/AllAssets/Player/Password"
@onready var player = $"/root/AllAssets/Player"
@onready var passwordui = $"/root/AllAssets/Player/Password/PASSWORD"

func _on_body_entered(body):
	if body.name == "Player" and passwordui.correct == false:
		password_ui.visible = true
		player.ui_open = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_body_exited(body):
	if body.name == "Player":
		password_ui.visible = false
		player.ui_open = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
