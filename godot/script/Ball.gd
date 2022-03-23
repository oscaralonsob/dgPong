extends KinematicBody2D


export(NodePath) var paddle_player1
export(NodePath) var paddle_player2
onready var pos_player1_score: float = get_node(paddle_player2).global_position.x + 30
onready var pos_player2_score: float = get_node(paddle_player1).global_position.x - 30


const SPEED_BOUNCE_INCREASE: float = 20.0
const SPEED_START: float = 300.0
var spawn_pos: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.ZERO
var speed: float = 300.0


var sound_player = preload("res://scene/SoundPlayer.tscn")
var point_sound = preload("res://sound/pong_point.wav")
var blop_sound = preload("res://sound/pong_blop.wav")


func _ready():
	spawn_pos = global_position
	
	randomize()
	spawn_ball()


func _physics_process(delta):
	process_ball_movement(delta)


func spawn_ball():
	var randomized_direction = 1 if randf() >= 0.5 else -1
	
	speed = SPEED_START
	global_position = spawn_pos
	direction = Vector2(randomized_direction, rand_range(-1, 1)).normalized()


func process_ball_movement(delta):
	var collision_info = move_and_collide(direction * speed * delta)
	if (collision_info != null and collision_info.normal != Vector2.ZERO):
		if (collision_info.normal.x == 0):
			direction.y = collision_info.normal.y
		elif (collision_info.normal.y == 0):
			direction.x = collision_info.normal.x
			direction.y = collision_info.collider.global_position.direction_to(global_position).y
			direction = direction.normalized()
			speed += SPEED_BOUNCE_INCREASE
			
		_play_sound(blop_sound)
	
	if (global_position.x < pos_player2_score):
		EventBus.emit_signal("scored_point_signal", 1)
		spawn_ball()
		_play_sound(point_sound)
	elif (global_position.x > pos_player1_score):
		EventBus.emit_signal("scored_point_signal", 0)
		spawn_ball()
		_play_sound(point_sound)


func _play_sound(sound_stream) -> void:
	var sound = sound_player.instance()
	add_child(sound)
	sound.play_sound(sound_stream)
	
