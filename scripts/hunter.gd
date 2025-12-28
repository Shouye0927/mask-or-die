extends CharacterBody2D

class_name Hunter
@export var speed: int = 20
var speed_const = 1000
var swinging = false
const HIT_FRAME = 3

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox_shape: CollisionShape2D = $hitbox/CollisionShape2D

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "swing":
		swinging = false
		animated_sprite_2d.play("idle")
		
func _on_animated_sprite_2d_frame_changed() -> void:
	if animated_sprite_2d.animation != "swing":
		return
		
	if animated_sprite_2d.frame == HIT_FRAME:
		hitbox_shape.disabled = false
	if animated_sprite_2d.frame == HIT_FRAME + 1:
		hitbox_shape.disabled = true


func handleInput(delta:float):
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if Input.is_action_just_pressed("mouse_left"):
		swinging = true
	velocity = moveDirection * speed * speed_const * delta

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#animated_sprite_2d.frame_changed.connect(_on_animated_sprite_2d_frame_changed)
	animated_sprite_2d.play("idle")
	hitbox_shape.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	handleInput(delta)
	if swinging == true:
		animated_sprite_2d.play("swing")
		if velocity.x < 0:
			animated_sprite_2d.flip_h = true
		elif velocity.x > 0:
			animated_sprite_2d.flip_h = false
	else:
		if velocity.length() == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("walk")
			if velocity.x < 0:
				animated_sprite_2d.flip_h = true
			elif velocity.x > 0:
				animated_sprite_2d.flip_h = false

			
	move_and_slide()
