extends CharacterBody2D

var last_pos : Vector2

func _ready() -> void:
	last_pos = global_position

func _on_control_by_path(delta:float):
	var current_velocity : Vector2 = (global_position - last_pos) / delta
	flip(current_velocity)
	animation(current_velocity)
	last_pos = global_position

func flip(w_velocity : Vector2):
	if w_velocity.x > 0.1:
		$Sprite2D.flip_h = false
	elif w_velocity.x < -0.1:
		$Sprite2D.flip_h = true
	else:
		return
func animation(w_velocity : Vector2):
	if w_velocity.length() == 0:
		$AnimationPlayer.play("idle")
	else:
		$AnimationPlayer.play("walk")
		
func _physics_process(delta: float) -> void:
	_on_control_by_path(delta)
	
