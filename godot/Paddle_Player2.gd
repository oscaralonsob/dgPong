extends KinematicBody2D


const AI_SPEED : float = 280.0;
var body_ball : KinematicBody2D;


func _ready():
	body_ball = get_parent().get_node("Ball")


func _physics_process(delta):
	process_ai_movement(delta)


func process_ai_movement(delta):
	var ai_to_ball_dir = global_position.direction_to(body_ball.global_position)
	ai_to_ball_dir.x = 0
	if (ai_to_ball_dir.y > 0.4 or ai_to_ball_dir.y < 0.4):
		if (ai_to_ball_dir.y > 0):
			ai_to_ball_dir.y = 1
		else:
			ai_to_ball_dir.y = -1
	# warning-ignore:return_value_discarded
	move_and_collide(ai_to_ball_dir * AI_SPEED * delta)
