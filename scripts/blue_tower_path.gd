extends Path2D
@export var blue_warrior_scene : PackedScene = preload("res://scene/blue_warrior.tscn")
@export var total_warrior_num : int
@export var warrior_speed : float
@export var spacing : float = 200.0
var total_length : float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	total_length = curve.get_baked_length()
	spawn_warrior()
func spawn_warrior():
	for i in range(total_warrior_num):
		var path_to_follow = PathFollow2D.new()
		path_to_follow.loop = false
		path_to_follow.progress = i * spacing

		path_to_follow.rotates = false
		add_child(path_to_follow)
		var blue_warrior = blue_warrior_scene.instantiate()
		path_to_follow.add_child(blue_warrior)
		
func _process(delta: float) -> void:
	for follow_node in get_children():
		if follow_node is PathFollow2D:
			if follow_node.get_child_count() > 0:
				var warrior = follow_node.get_child(0)
				if warrior.get("current_state") == 0: # 0設計是PATROL
					follow_node.progress += warrior_speed * delta
			if follow_node.progress >= total_length:
				follow_node.progress = 0
		
