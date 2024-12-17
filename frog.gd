extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const SPEED = 50
var player: Node2D = null
var chase = false

func _physics_process(delta: float) -> void:
	#Gravity Calculation
	if not is_on_floor():
		velocity.y += gravity * delta
		
	#Pursuit Calculation
	if chase == true:
		var direction = (player.global_position - global_position).normalized()
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
		else:
			get_node("AnimatedSprite2D").flip_h = false
		velocity.x = direction.x * SPEED
	else:
		velocity.x = 0

	move_and_slide()

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		chase = true
		player = body

func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		chase = false
		player = null
