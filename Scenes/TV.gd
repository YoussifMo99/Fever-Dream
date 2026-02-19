extends MeshInstance3D

@export var player: CharacterBody3D
@export var video: VideoStreamPlayer
@export var audio: AudioStreamPlayer

func _ready():
	await get_tree().physics_frame
	video.play()
	audio.play()

func _process(_delta):
	
	var x = self.global_position.distance_to(player.global_position)
	audio.volume_db = clamp(remap(x, 0, 13.0, -3.0, -50.0), -80.0, -6.0)

	if video.is_playing() == false:
		_play()

func _play():
	video.play()
	audio.play()
