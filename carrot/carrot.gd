extends Area2D




func _on_body_entered(body):
	if body is Player:
		GameManager.carrot_cnt += 1
		queue_free()
