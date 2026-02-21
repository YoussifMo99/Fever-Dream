extends Node2D

@onready var fadetransitioncanvas: CanvasLayer = $fadetransition
@onready var tick: AudioStreamPlayer2D = $buttonmanager/Tick004
@onready var fadetransition: ColorRect = $fadetransition/fade_transition

var start_scene = preload("res://Scenes/all_assets.tscn")
var options_scene = preload("res://Scenes/UI.tscn")

func _on_start_pressed() -> void:
	tick.play()
	fadetransitioncanvas.show()
	fadetransition.fade_in()
	await fadetransition.fade_finished
	get_tree().change_scene_to_packed(start_scene)

func _on_options_pressed() -> void:
	tick.play()
	fadetransitioncanvas.show()
	fadetransition.fade_in()
	await fadetransition.fade_finished
	get_tree().change_scene_to_packed(options_scene)
