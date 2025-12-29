extends Area2D

var hunter_inside = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Hunter":
		hunter_inside = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Hunter":
		hunter_inside = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
