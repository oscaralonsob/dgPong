extends Label


var score_player1: int = 0;
var score_player2: int = 0;


func _ready() -> void:
	EventBus.connect("scored_point_signal", self, "_scored_point")


func _scored_point(player: int) -> void:
	if player == 0:
		score_player1 += 1
	else:
		score_player2 += 1
	
	text = str(score_player1) + " - " + str(score_player2)
