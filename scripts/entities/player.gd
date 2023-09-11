extends CharacterBody2D

@export var move_speed = 300
@export var run_speed = 450
@export var acceleration = 3500


enum move_state {
	IDLE, WALK, RUN, ROLL
}
enum move_direction {
	UP, DOWN, LEFT, RIGHT, NONE
}
var movement_direction = move_direction.NONE
var movement_state: move_state = move_state.IDLE

func _physics_process(delta):
	#self.global_position.x = round(self.global_position.x)
	#self.global_position.y = round(self.global_position.y)
	# Get input
	var direction: Vector2
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	# Funny stuff
	direction = direction.normalized()
	set_animation(direction)
	# Move
	#var movement = move_speed * direction * delta
	velocity = velocity.move_toward(direction * move_speed, acceleration * delta)
	move_and_slide()
	# Calculate movement state
	if (velocity.length() <= 0): movement_state = move_state.IDLE
	else: movement_state = move_state.WALK

func set_animation(direction: Vector2):
	if (direction.x > 0):
		$Sprites.play("walk_right")
		movement_direction = move_direction.RIGHT
	elif (direction.x < 0):
		$Sprites.play("walk_left")
		movement_direction = move_direction.LEFT
	elif (direction.y > 0):
		$Sprites.play("walk_down")
		movement_direction = move_direction.DOWN
	elif (direction.y < 0):
		$Sprites.play("walk_up")
		movement_direction = move_direction.UP
	else: set_idle_anim()

func set_idle_anim():
	if (movement_direction == move_direction.UP):
		$Sprites.play("idle_up")
	elif (movement_direction == move_direction.LEFT):
		$Sprites.play("idle_left")
	elif (movement_direction == move_direction.RIGHT):
		$Sprites.play("idle_right")
	else: $Sprites.play("idle_down")
