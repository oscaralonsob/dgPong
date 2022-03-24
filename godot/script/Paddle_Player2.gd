extends KinematicBody2D


const SPEED: float = 280.0
var body_ball: KinematicBody2D
var ia_controlled: bool = true


func _ready():
	body_ball = get_parent().get_node("Ball")


# Handle user input
func _input(event):
	if Input.is_action_just_pressed("ui_select"):
		ia_controlled = !ia_controlled


func process_player_movement(delta):
	if (Input.is_action_pressed("ui_up_2")):
		# warning-ignore:return_value_discarded
		move_and_collide(Vector2.UP * SPEED * delta)
	elif (Input.is_action_pressed("ui_down_2")):
		# warning-ignore:return_value_discarded
		move_and_collide(Vector2.DOWN * SPEED * delta)


func _physics_process(delta):
	if ia_controlled:
		process_ai_movement(delta)
	else:
		process_player_movement(delta)


func process_ai_movement(delta):
	var ai_to_ball_dir = global_position.direction_to(body_ball.global_position)
	ai_to_ball_dir.x = 0
	if (ai_to_ball_dir.y > 0.4 or ai_to_ball_dir.y < 0.4):
		if (ai_to_ball_dir.y > 0):
			ai_to_ball_dir.y = 1
		else:
			ai_to_ball_dir.y = -1
	# warning-ignore:return_value_discarded
	move_and_collide(ai_to_ball_dir * SPEED * delta)
