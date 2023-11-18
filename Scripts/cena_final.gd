extends Node2D



func _ready():
	Dialogic.start("res://Timelines/timeline.dtl")
	
func _process(delta):
	if Dialogic.current_timeline == null:
		menu()


func menu():
	get_tree().change_scene_to_file("res://Cenas/control.tscn")

