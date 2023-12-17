extends Node

class_name Pipespawner
signal crashed
signal scored

var pipe_scene = preload("res://Scenes/pipes.tscn")
var pipe_speed = -150
@onready var spawn_timer = $Timer

#----------------------------
func _ready():
	spawn_timer.timeout.connect(spawn_pipe)
#-----------------------------------------
func spawn_pipe():
	var pipe = pipe_scene.instantiate() as pipes
	add_child(pipe)
	
	var viewport_rect = get_viewport().get_camera_2d().get_viewport_rect()
	var half_height= viewport_rect.size.y / 2
	pipe.position.x = viewport_rect.end.x
	pipe.position.y = randf_range(viewport_rect.size.y * 0.15 - half_height, viewport_rect.size.y * 0.6 - half_height)
	
	pipe.entered.connect(bird_entered)
	pipe.score.connect(points_scored)
	pipe.set_speed(pipe_speed)
#----------------
func bird_entered():
	crashed.emit()
	stop()
#---------------------
func stop():
	spawn_timer.stop()
	for pipe in get_children().filter(func (child): return child is pipes):
		(pipe as pipes).speed = 0
#-----------------------------
func points_scored():
	scored.emit()
#-----------

func _process(delta):
	pass
