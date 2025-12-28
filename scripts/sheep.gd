extends CharacterBody2D

class_name Sheep

@export var speed: int = 180
var speed_const = 1000 
const CHANGE_DIR_FRAME:= 0
var prev_velo
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _on_animated_sprite_2d_frame_changed() -> void:
	if animated_sprite_2d.animation != "bounce":
		return
	
	if animated_sprite_2d.frame == CHANGE_DIR_FRAME:
		randomDir()

func randomDir():
	var moveDirection = Vector2.RIGHT.rotated(randf_range(0.0, TAU))
	velocity = moveDirection * speed
	while velocity.length() == 0:
		moveDirection = Vector2.RIGHT.rotated(randf_range(0.0, TAU))
		velocity = moveDirection * speed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.play("bounce")
	randomDir()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	prev_velo = velocity
	#if velocity.length() == 0:
		#animated_sprite_2d.play("idle")
	#else:
	animated_sprite_2d.play("bounce")
	if velocity.x < 0:
		animated_sprite_2d.flip_h = true
	elif velocity.x > 0:
		animated_sprite_2d.flip_h = false
	
	move_and_slide()
