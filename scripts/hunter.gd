extends CharacterBody2D

class_name Hunter
@export var speed: int = 250
var swinging = false
const HIT_FRAME = 3

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox_shape: CollisionShape2D = $hitbox/CollisionShape2D
@onready var hitbox: Area2D = $hitbox

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

func on_zone_entered(zone: Area2D) -> void:
	pass
	
func on_zone_exited(zone: Area2D) -> void:
	pass

func handleInput(delta:float):
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if Input.is_action_just_pressed("mouse_left"):
		swinging = true
	velocity = moveDirection * speed
	
	
func handleHitboxDir():
	if velocity.x < 0 && velocity.y == 0:
		hitbox.rotation_degrees = 180
	elif velocity.x > 0 && velocity.y == 0:
		hitbox.rotation_degrees = 0
	elif velocity.x == 0 && velocity.y < 0:
		hitbox.rotation_degrees = 270
	elif velocity.x == 0 && velocity.y > 0:
		hitbox.rotation_degrees = 90
	elif velocity.x < 0 && velocity.y < 0:
		hitbox.rotation_degrees = 225
	elif velocity.x < 0 && velocity.y > 0:
		hitbox.rotation_degrees = 135
	elif velocity.x > 0 && velocity.y < 0:
		hitbox.rotation_degrees = 315
	elif velocity.x > 0 && velocity.y > 0:
		hitbox.rotation_degrees = 45
	else:
		pass
		
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#animated_sprite_2d.frame_changed.connect(_on_animated_sprite_2d_frame_changed)
	animated_sprite_2d.play("idle")
	hitbox.rotation_degrees = 0
	hitbox_shape.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	handleInput(delta)
	handleHitboxDir()
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


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "hurtBox":
		area.get_parent().apply_knock_back(global_position ,800)
