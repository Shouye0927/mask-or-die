extends CharacterBody2D

var last_pos : Vector2

enum State {PATROL ,CHASE ,STOP ,RETURN}
var current_state
var myPath : PathFollow2D = null
var target : CharacterBody2D = null
@export var speed : float = 100.0
var knock_back_velocity : Vector2 = Vector2.ZERO
var friction : float = 5 #遞減速率
func _ready() -> void:
	last_pos = global_position
	current_state = State.PATROL

func _return_patrol_velocity(delta:float) -> Vector2:
	var current_velocity : Vector2 = (global_position - last_pos) / delta
	last_pos = global_position
	return current_velocity

func flip():
	if velocity.x > 0.1:
		$Sprite2D.flip_h = false
	elif velocity.x < -0.1:
		$Sprite2D.flip_h = true
	else:
		return
func animation():
	if velocity.length() == 0:
		$AnimationPlayer.play("idle")
	else:
		$AnimationPlayer.play("walk")

func storePath2D():
	myPath = get_parent() as PathFollow2D
	var world = get_tree().current_scene
	var pos = global_position
	get_parent().remove_child(self)
	self.global_position = pos
	world.add_child(self)
	
func apply_knock_back(source_pos : Vector2 ,power : int):
	var push_dir = (global_position - source_pos).normalized()
	knock_back_velocity = push_dir * power
		
func _physics_process(delta: float) -> void:
	knock_back_velocity = knock_back_velocity.lerp(Vector2.ZERO, friction * delta)
	print(knock_back_velocity)
	match current_state:
		State.CHASE:
			velocity = (target.global_position - global_position).normalized() * speed + knock_back_velocity
		State.STOP:
			velocity = Vector2.ZERO + knock_back_velocity
		State.RETURN:
			velocity = (myPath.global_position - global_position).normalized() * speed + knock_back_velocity
			if global_position.distance_to(myPath.global_position) < 5.0:
				backToPath()
		State.PATROL:
			velocity = _return_patrol_velocity(delta)
	
	animation()
	flip()
	
	if current_state != State.PATROL:
		move_and_slide()
	
func backToPath():
	get_parent().remove_child(self)
	myPath.add_child(self)
	current_state = State.PATROL
	global_position = get_parent().global_position

func _on_detection_range_body_entered(body: Node2D) -> void:
	if body is Hunter:
		target = body
		if current_state == State.PATROL:
			storePath2D()
			
			current_state = State.STOP
			$exclamation_label.show()
			await get_tree().create_timer(1).timeout
			$exclamation_label.hide()
			#print("%s execute stop" % self.name)
		if target:
			current_state = State.CHASE
			#print_debug("enter_chase")
		else:
			current_state = State.RETURN


func _on_return_range_body_exited(body: Node2D) -> void:
	if body is Hunter:
		if current_state == State.CHASE:
			#print(current_state)
			#print("exe")
			current_state = State.RETURN
			target = null
