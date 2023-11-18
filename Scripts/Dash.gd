extends Node2D

@onready var timer = $duration

const dash_delay = 1
var can_dash = true
	
func start_dash(dur):
	timer.wait_time = dur
	timer.start()

func is_dashing():
	return !timer.is_stopped()

func end_dash():
	can_dash = false
	await get_tree().create_timer(dash_delay).timeout 
	can_dash = true


func _on_duration_timeout():
	end_dash()# Replace with function body.


