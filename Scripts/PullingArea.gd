extends Area2D
onready var gameOver = preload("res://Scenes/GameOver.tscn")
onready var animate = $AnimationPlayer2
onready var tween = $Tween
var sprite
var duplicated
func _on_PullingArea_body_entered(body):
	print(body)
	if body is RigidBody2D:
		body.set_gravity_scale(0)
		pull(body)
func pull(target):
	if not target.has_node("Sprite"):
		return
	sprite = target.get_node("Sprite")
	duplicated = sprite.duplicate()
	add_child(duplicated)
	target.queue_free()
	duplicated.global_position = sprite.global_position
	var duration = animate.current_animation_length * animate.playback_speed
	tween.interpolate_property(duplicated,"position",duplicated.position,Vector2.ZERO,duration)
	tween.start()
func _on_Tween_tween_all_completed():
	duplicated.queue_free()
	var game_over=gameOver.instance()
	add_child(game_over)
	
