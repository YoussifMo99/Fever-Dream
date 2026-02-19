extends Area3D

@onready var nuclearportal: Portal3D = $"../nuclearportal"
@onready var player = $"../../Player"

func _ready() -> void:
	nuclearportal.deactivate()
func _on_body_entered(body) -> void:
	if body.is_in_group("player"):
		player.orbs += 1
		print(player.orbs)
		if player.orbs<4:
			queue_free()
func _process(delta: float) -> void:
	if player.orbs >= 4:
		nuclearportal.activate()
		queue_free()
