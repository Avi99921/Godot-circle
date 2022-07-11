extends Node2D
func _ready():
	pass
func _process(delta):
	$Twirl.rotation-=5*delta
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
