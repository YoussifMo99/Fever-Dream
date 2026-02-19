extends MeshInstance3D

@export var player: CharacterBody3D
@export var video: VideoStreamPlayer

func _process(_delta):
	
	var x = self.global_position.distance_to(player.global_position)

	video.volume_db = clamp(remap(x, 0, 13.0, -3.0, -50.0), -80.0, -6.0)
