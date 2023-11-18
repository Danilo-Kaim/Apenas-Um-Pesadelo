extends Area2D


@export var prox_fase:PackedScene







func _on_body_entered(body):
	if body.is_in_group('Player'):
		get_tree().change_scene_to_packed(prox_fase)
