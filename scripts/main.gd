extends Node2D
@export var score: int = 0
@export var health: int = 5
var screen_size = DisplayServer.window_get_size()
var rng = RandomNumberGenerator.new()
var bad_dot_start = rng.randi_range(6,12)
const dot = preload("res://scenes/dot.tscn")
const bad_dot = preload("res://scenes/bad_dot.tscn")
var end_sound = load("res://assets/sounds/death_sound.mp3")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#score = 0
	$Score_Display.text = "Score: " + str(score)
	$Health_Display.text = str(health) + " :Health"
	

func create_dot(dot_type) -> void:
	var random_number_x = rng.randi_range(0,screen_size.x)
	var random_number_y = rng.randi_range(0,screen_size.y)
	var new_dot = dot_type.instantiate()
	add_child(new_dot)
	new_dot.position = Vector2(random_number_x,random_number_y)

func update_score(points: int) -> void:
	score += points
	$Score_Display.text = "Score: " + str(score)
	create_dot(dot)
	if score % bad_dot_start == 0:
		create_dot(bad_dot)
	if score == bad_dot_start:
		$Health_Display.show()


func update_health(damage: int) -> void:
	health -= damage
	$Health_Display.text = str(health) + " :Health"

func clear_dots():
	var all_bad_dots = get_tree().get_nodes_in_group("bad_dots")
	var all_dots = get_tree().get_nodes_in_group("dots")
	for bad_dot in all_bad_dots:
		bad_dot.queue_free()
	for dot in all_dots:
		dot.queue_free()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health==0 and is_instance_valid($Player):
		$Player.queue_free()
		$Game_audio_player.stream = end_sound
		$Game_audio_player.play()
		clear_dots()



		
		
