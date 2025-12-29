extends Area2D

var collectable : bool = false
enum Type {WARRIOR,SHEEP}
var target : CharacterBody2D = null
@export var type : Type
func _on_body_entered(body: Node2D) -> void:
	if body is Hunter:
		collectable = true
		target = body
		$soul.show()
		match type:
			Type.WARRIOR:
				print("exe")
				$soul.play("warrior")
			Type.SHEEP:
				$soul.play("sheep")
func _on_body_exited(body: Node2D) -> void:
	if body is Hunter:
		collectable = false
		$soul.hide()
		target = null
		
func _process(delta: float) -> void:		
	if collectable:
		if Input.is_action_just_pressed("transition"):
			if target:
				await get_tree().create_timer(0.1).timeout
				match type:
					Type.WARRIOR:
						target.transition("WARRIOR")
					Type.SHEEP:
						target.transition("SHEEP")
			queue_free()
			
		
	
