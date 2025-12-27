extends CharacterBody2D

func _physics_process(delta: float) -> void:pass

func _draw() -> void:
	if OS.is_debug_build():
		draw_rect(Rect2(Vector2(10,10),Vector2(100,100)),Color.CORNFLOWER_BLUE)
