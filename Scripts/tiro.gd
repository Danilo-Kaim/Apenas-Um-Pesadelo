extends Area2D


var speed = 20
var velocidade = Vector2.ZERO
var direcao = Vector2.ZERO


func set_direcao(dir):
	direcao = dir
	if dir.x < 0:
		$Sprite2D.flip_v = true
	else:
		$Sprite2D.flip_v = false	
func _process(_delta):
	velocidade = speed * direcao
	translate(velocidade)





func _on_body_entered(body):
	if body.is_in_group('Player'):
		body.receber_dano(1)
		queue_free()
