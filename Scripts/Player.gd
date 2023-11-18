extends CharacterBody2D

const move_speed = 300
const tiro_delay = 5
const dash_speed = 800
const dash_duration = 0.2
const dash_cooldown = 2
const faca = preload("res://Cenas/tiro.tscn")

@onready var dash = $Dash
@onready var animator = $AnimationPlayer
@onready var atk = $Atk
var can_tiro = true
var hp = 3
var vida = Label.new()

func _ready():
	add_child(vida)
	
	vida.text = str(hp)
	vida.position.x = 20
	vida.position.y = -62
	



func _process(_delta):
	vida.text = str(hp)
	if Input.is_action_just_pressed("dash") && dash.can_dash && !dash.is_dashing():
		dash.start_dash(dash_duration)
	var speed = dash_speed if dash.is_dashing() else move_speed
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	input_vector.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")	
	velocity =  speed * input_vector
	if input_vector.x == 1:
		$AnimatedSprite2D.flip_h = false
		atk.position.x = 50
		$Marker2D.position.x = 50
	elif input_vector.x == -1:
		$AnimatedSprite2D.flip_h = true
		atk.position.x = -50
		$Marker2D.position.x = -50
	
	if Input.is_action_just_pressed("Atk"):
		animator.play("Atk")
	if Input.is_action_just_pressed("Especial") && can_tiro:
		var faca_instancia = faca.instantiate()
		$Atirar.start()
		if sign($Marker2D.position.x) == 1:
			faca_instancia.set_direcao(1)
		else:	
			faca_instancia.set_direcao(-1)
		get_parent().add_child(faca_instancia)
		faca_instancia.position = $Marker2D.global_position	
	move_and_slide()






func end_tiro():
	can_tiro = false
	await get_tree().create_timer(tiro_delay).timeout 
	can_tiro = true


func _on_atirar_timeout():
	end_tiro() # Replace with function body.

func receber_dano(dano):
	hp -= dano
	$AnimationPlayer.play("Dano")
	$Ai.play()
	if  hp < 1:
		get_tree().reload_current_scene()
			
		
		
		
	

func _on_atk_body_entered(body):
	if body.is_in_group('enemy'):
		body.recebe_dano(10)
