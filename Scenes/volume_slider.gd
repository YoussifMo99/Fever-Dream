extends HSlider

var config = ConfigFile.new()
const SAVE_PATH = "user://settings.cfg"

func _ready():
	config.load(SAVE_PATH)
	value = config.get_value("settings", "sensitivity", 0.004)
	min_value = 0.001
	max_value = 0.01
	step = 0.0001

func _on_value_changed(val):
	config.set_value("settings", "sensitivity", val)
	config.save(SAVE_PATH)
