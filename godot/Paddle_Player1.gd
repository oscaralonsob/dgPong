extends KinematicBody2D


const PLAYER_SPEED : float = 280.0;


func _physics_process(delta):
	process_player_movement(delta)


func process_player_movement(delta):
	if (Input.is_action_pressed("ui_up")):
		# warning-ignore:return_value_discarded
		move_and_collide(Vector2.UP * PLAYER_SPEED * delta)
	elif (Input.is_action_pressed("ui_down")):
		# warning-ignore:return_value_discarded
		move_and_collide(Vector2.DOWN * PLAYER_SPEED * delta)
