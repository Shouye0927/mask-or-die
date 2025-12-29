extends Node2D

@onready var press: Label = $press

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = create_tween().set_loops()
	tween.tween_property(press, "modulate:a", 0.3, 0.8)
	tween.tween_property(press, "modulate:a", 1.0, 0.8)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if event is InputEventKey or event is InputEventMouseButton or event is InputEventJoypadButton:
		if event.pressed:
			start_game()
			
func start_game():
	get_tree().change_scene_to_file("res://scene/world.tscn")
