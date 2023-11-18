extends CharacterBody2D

const  speed = 100

const faca = preload("res://Cenas/tiroBoss.tscn")

@export var player: Node2D
@onready var navegador = $NavigationAgent2D as NavigationAgent2D
var hp = 50
var dar_dano = false


func _physics_process(_delta: float) -> void:
	var dir = to_local(navegador.get_next_path_position()).normalized()
	if dir.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false	
	velocity = dir * speed
	move_and_slide()


func make_path() -> void:
	navegador.target_position = player.global_position
	

func recebe_dano(dano):
	hp -= dano	
	$AnimationPlayer.play("Dano")
	if hp < 1:
		queue_free()
		get_tree().change_scene_to_file("res://Cenas/Quarto2.tscn")		

func _on_timer_timeout():
	make_path() # Replace with function body.


func _on_area_2d_body_entered(body):
	if body.is_in_group('Player'):
		dar_dano = true
		while dar_dano:
			body.receber_dano(1)
			await get_tree().create_timer(1).timeout  
		
		




func _on_area_2d_body_exited(_body):
	dar_dano = false # Replace with function body.




func _on_atirar_timeout():
	var faca_instancia = faca.instantiate()
	var dir = to_local(navegador.get_next_path_position()).normalized()
	faca_instancia.set_direcao(dir)
	get_parent().add_child(faca_instancia)
	faca_instancia.position = $Marker2D.global_position # Replace with function body.
