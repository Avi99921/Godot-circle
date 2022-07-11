extends KinematicBody2D
var speed=50
var even
var disabled=false
func _ready():
	even = randi()%20
	randomize()
func _process(delta):
	if even%2==0:
		rotation+=1*delta
	else:
		rotation-=1*delta

func _on_Center_body_entered(body):
	var ball = get_tree().get_root().get_node("./Game/Ball")
	if body is RigidBody2D:
		$Center/Center.disabled=true
		ball.set_gravity_scale(0)
		if !disabled:
			Signals.emit_signal("moveToNextStage",true)
			disabled=true

func _on_Center_body_exited(body):
	var ball = get_tree().get_root().get_node("./Game/Ball")
	if body is RigidBody2D:
		$Center/Center.disabled=false
		ball.set_gravity_scale(1)
