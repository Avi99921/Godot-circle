extends CanvasLayer
onready var scoreLabel = get_node("PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Label3")
func _ready():
	Signals.connect("score",self,"showScore")
func showScore(score):
	scoreLabel.text=str(score)
func _on_Restart_pressed():
	get_tree().reload_current_scene()
func _on_Quit_pressed():
	get_tree().quit()
