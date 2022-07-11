extends RigidBody2D
onready var gameOver = preload("res://Scenes/GameOver.tscn")
var speed =0.6
var velocity = Vector2()
var dir
var dragging=false
var can_drag=true
func _ready():
	randomize()
	velocity.x= 1
	velocity.y= 0
	set_friction(0)
func _physics_process(delta):
	var colliding = get_colliding_bodies()
	if colliding.size()>0:
		if colliding[0].name=="Bottom":
			var game_over=gameOver.instance()
			add_child(game_over)
			#get_tree().paused=true
	if dragging:
		apply_impulse(Vector2(),dir*2)
		dragging=false
	set_bounce(0.2)
func _input(event):
	if event.is_action_pressed("click"):
		velocity=get_global_mouse_position()
	if event.is_action_released("click"):
		var drag_end=get_global_mouse_position()
		dir=velocity-drag_end
		dragging=true
