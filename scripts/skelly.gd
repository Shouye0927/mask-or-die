extends Area2D

var hunter_inside = false


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Hunter":
		hunter_inside = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Hunter":
		hunter_inside = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
