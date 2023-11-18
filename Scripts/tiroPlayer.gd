extends Area2D


var speed = 20
var velocidade = Vector2.ZERO
var direcao = 1


func set_direcao(dir):
	direcao = dir
	if dir == 1:
		$Sprite2D.flip_v = false
	else:
		$Sprite2D.flip_v = true	
func _process(_delta):
	velocidade.x = speed * direcao
	translate(velocidade)





func _on_body_entered(body):
	if body.is_in_group('enemy'):
		body.recebe_dano(5)
		queue_free()
