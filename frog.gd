extends CharacterBody2D

const SPEED = 50
var player
var chase = false

func _physics_process(delta: float) -> void:
	#Gravity Calculation
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	#Pursuit Calculation
	if chase == true:
		player = get_node("../../Player/Player")
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
		elif direction.x < 0:
			get_node("AnimatedSprite2D").flip_h = false
		
		velocity.x = direction.x * SPEED
		
	move_and_slide()

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		chase = true


func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		chase = false
