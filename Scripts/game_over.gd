extends Node2D





func _on_button_pressed():
	get_tree().reload_current_scene()


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://Cenas/control.tscn")
