extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Main_menu/MarginContainer/CenterContainer/VBoxContainer/Start_button.pressed.connect(_on_start_button_pressed)

func _on_start_button_pressed():
	print("Start button pressed! Changing scene...")
	# Example action: Switch scene
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
