extends AudioStreamPlayer2D


func play_sound(sound) -> void:
	set_stream(sound)
	connect("finished", self, "_remove_self")
	play()


func _remove_sef() -> void:
	queue_free()
