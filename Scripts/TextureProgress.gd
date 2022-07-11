extends Control
onready var progressBar = $TextureProgress
onready var timer = $Timer
var is_timer_active=true
func _ready():
	progressBar.value=100
	timer.start(0.05)

func _on_Timer_timeout():
	progressBar.value-=1
	timer.start(0.05)
func _process(delta):
	if progressBar.value==0 and is_timer_active:
		is_timer_active=false
		Signals.emit_signal("timerEnds",true)
		
