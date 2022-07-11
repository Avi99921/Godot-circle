extends Node2D
onready var circle_1=$Sprite
onready var circle_2=$Sprite2
func _ready():
	$AnimationPlayer.play("FadeOut")
	yield(get_tree().create_timer(3),"timeout")
	#get_tree().change_scene("res://Scenes/Game.tscn")
func _process(delta):
	circle_1.rotation+=3*delta
	circle_2.rotation-=5*delta


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_Button2_pressed():
	get_tree().change_scene("res://Scenes/HowToPlay.tscn")


func _on_AnimationPlayer_animation_finished(anim_name):
	$ColorRect.queue_free()
