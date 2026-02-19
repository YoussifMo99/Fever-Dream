extends Node2D

var entered_code = []
var circles = []
@onready var passwordui: CanvasLayer = $"/root/AllAssets/Player/Password"
@onready var player: CharacterBody3D = $"/root/AllAssets/Player"
func _ready():
	circles = [
		get_node("VBoxContainer/SCREEN/circle1"),
		get_node("VBoxContainer/SCREEN/circle2"),
		get_node("VBoxContainer/SCREEN/circle3"),
		get_node("VBoxContainer/SCREEN/circle4"),
	]
	
	for circle in circles:
		circle.modulate.a = 0
	
	get_node("VBoxContainer/ROW1/1").pressed.connect(_on_button_pressed.bind(1))
	get_node("VBoxContainer/ROW1/2").pressed.connect(_on_button_pressed.bind(2))
	get_node("VBoxContainer/ROW1/3").pressed.connect(_on_button_pressed.bind(3))
	get_node("VBoxContainer/ROW2/4").pressed.connect(_on_button_pressed.bind(4))
	get_node("VBoxContainer/ROW2/5").pressed.connect(_on_button_pressed.bind(5))
	get_node("VBoxContainer/ROW2/6").pressed.connect(_on_button_pressed.bind(6))
	get_node("VBoxContainer/ROW3/7").pressed.connect(_on_button_pressed.bind(7))
	get_node("VBoxContainer/ROW3/8").pressed.connect(_on_button_pressed.bind(8))
	get_node("VBoxContainer/ROW3/9").pressed.connect(_on_button_pressed.bind(9))
	get_node("VBoxContainer/ROW4/0").pressed.connect(_on_button_pressed.bind(0))
	get_node("VBoxContainer/ROW4/Enter").pressed.connect(_on_enter_pressed)

func _on_button_pressed(value):
	if entered_code.size() < 4:
		entered_code.append(value)
		circles[entered_code.size() - 1].modulate.a = 1
		print(entered_code)

func _on_enter_pressed():
	if entered_code == [1, 2, 3, 4]:
		player.hide_ui(passwordui)
		print("correct!")
	else:
		print("wrong!")
	entered_code.clear()
	for circle in circles:
		circle.modulate.a = 0
