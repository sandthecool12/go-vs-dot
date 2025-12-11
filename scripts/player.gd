extends Node2D

var speed = 400
var screen_size = DisplayServer.window_get_size()
var painful_sound

var rng = RandomNumberGenerator.new()

var is_playing_special_animation = false





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	painful_sound = load("res://assets/sounds/hit_sound_1.mp3")
	$Player_sprite.play("down")
	
func play_hit_sound():
	$Player_sounds.stream = painful_sound
	$Player_sounds.play()
	painful_sound = load("res://assets/sounds/hit_sound_"+str(rng.randi_range(1,4))+".mp3")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	#var player_size = $Player_sprite.texture.get_size()
	var border = screen_size #- Vector2i(player_size.x/20, player_size.y/20)
	if Input.is_action_pressed("move_up") and not is_playing_special_animation:
		velocity.y -= 1*speed
		$Player_sprite.play("up")
	if Input.is_action_pressed("move_down") and not is_playing_special_animation:
		velocity.y += 1*speed
		$Player_sprite.play("down")
	if Input.is_action_pressed("move_left") and not is_playing_special_animation:
		velocity.x -= 1*speed
		$Player_sprite.play("left")
	if Input.is_action_pressed("move_right") and not is_playing_special_animation:
		velocity.x += 1*speed
		$Player_sprite.play("right")
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	position = position.clamp(Vector2.ZERO+Vector2(25,25), border)
	
	
func play_damage_animation():
	is_playing_special_animation = true
	$Player_sprite.play("damage")
	



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("dots"):
		body.queue_free()
		get_parent().update_score(1)
		if get_parent().score % 5 == 0:
			speed *= 1.1
	if body.is_in_group("bad_dots"):
		play_hit_sound()
		play_damage_animation()
		body.queue_free()
		get_parent().update_health(1)
		speed *=.9
		
		
	


	
		


func _on_player_sprite_animation_finished() -> void:
	if $Player_sprite.animation == 'damage':
		is_playing_special_animation = false
