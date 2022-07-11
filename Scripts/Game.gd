extends Node2D
onready var circleScene = preload("res://Scenes/Circle.tscn")
onready var circleScene2 = preload("res://Scenes/Circle2.tscn")
onready var circleScene3 = preload("res://Scenes/Circle3.tscn")
onready var circleScene4 = preload("res://Scenes/Circle4.tscn")
onready var circleScene5 = preload("res://Scenes/Circle5.tscn")
onready var circleScene6 = preload("res://Scenes/Circle6.tscn")
onready var ballScene = preload("res://Scenes/Ball.tscn")
onready var barScene = preload("res://Scenes/Bar.tscn")
onready var blackHoleScene = preload("res://Scenes/Blackhole.tscn")
onready var top =$Top
onready var progressBar = preload("res://Scenes/ProgressBar.tscn")
var progressBarPosition=Vector2(0,0)
var circle
var bar
var ball
var blackHole
var xCordinate
var yCordinate
var preScene=null
var progBar = null
var circleArray
var progressBarValue
var score=0

#X---190,530
#Y---170,1055
func _ready():
	Engine.set_target_fps(0)
	randomize()
	circleArray = [circleScene,circleScene2,circleScene3,circleScene4,circleScene5,circleScene6]
	var num = randi()%6
	bar = barScene.instance()
	bar.position=$Position2D.position
	add_child(bar)
	ball = ballScene.instance()
	ball.position=Vector2($Position2D.position.x,$Position2D.position.y-100)
	add_child(ball)
	circle = circleArray[num].instance()
	circle.position=Vector2(530,170)
	add_child(circle)
	blackHole = blackHoleScene.instance()
	blackHole.position=Vector2(int(rand_range(160,560)),(ball.position.y+170)/2)
	add_child(blackHole)
	Signals.connect("moveToNextStage",self,"nextStage")
	Signals.connect("timerEnds",self,"removeProgressBar")
	
	
	$Camera2D.position=$Position2D.position
func getProgressBarValue():
	for child in get_children():
		if child.is_in_group("ProgressBar"):
			for kid in get_node(child.name).get_children():
				if kid is TextureProgress:
					progressBarValue=kid.value
func addProgressBar():
	progBar = progressBar.instance()
	progBar.set_position(progressBarPosition)
	add_child(progBar)
func removeProgressBar(status):
	for child in get_children():
		if child.is_in_group("ProgressBar"):
			child.queue_free()
	progBar=null
func score():
	score+=int(round(progressBarValue/3))
func newCircle():
	var num = randi()%6
	preScene=circle
	xCordinate=int(rand_range(180,540))
	yCordinate=circle.position.y-900
	var scene = circleArray[num]
	circle = scene.instance()
	circle.position=Vector2(xCordinate,yCordinate)
	add_child(circle)
	blackHole = blackHoleScene.instance()
	blackHole.position=Vector2(int(rand_range(160,560)),(preScene.position.y+yCordinate)/2)
	add_child(blackHole)
	top.position=Vector2(top.position.x,yCordinate-250)
	$Left.position=Vector2($Left.position.x,(yCordinate+preScene.position.y)/2)
	$Right.position=Vector2($Right.position.x,(yCordinate+preScene.position.y)/2)
	$Bottom.position=Vector2($Bottom.position.x,preScene.position.y+250)
	progressBarPosition.y=top.position.y+60
	if progBar!=null:
		getProgressBarValue()
		score()
		progBar.queue_free()
	addProgressBar()
func nextStage(state):
	if preScene!=null:
		preScene.queue_free()
	preScene=circle
	$Camera2D.position=Vector2($Camera2D.position.x,circle.position.y+50)
	score+=1
	newCircle()
func _process(delta):
	Signals.emit_signal("score",score)
