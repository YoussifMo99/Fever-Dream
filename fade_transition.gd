extends ColorRect

signal fade_finished

func _ready() -> void:
	self.color = Color(0, 0, 0, 0)

func fade_in() -> void:
	show()
	self.color = Color(0, 0, 0, 0)
	var tween = create_tween()
	tween.tween_property(self, "color", Color(0, 0, 0, 1), 1.0)
	await tween.finished
	emit_signal("fade_finished")

func fade_out() -> void:
	self.color = Color(0, 0, 0, 1)
	var tween = create_tween()
	tween.tween_property(self, "color", Color(0, 0, 0, 0), 1.0)
	await tween.finished
	emit_signal("fade_finished")
