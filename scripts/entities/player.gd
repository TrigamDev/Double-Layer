extends CharacterBody2D

@export var move_speed = 75
@export var run_speed = 450
@export var acceleration = 3500
@export var interaction_distance = 15

signal player_interact

@export var movement_direction: PlayerUtil.move_direction = PlayerUtil.move_direction.NONE
var movement_state: PlayerUtil.move_state = PlayerUtil.move_state.IDLE

@onready var camera: Camera2D = $Camera
@onready var interact: RayCast2D = $Interact

func _ready():
	await get_tree().create_timer(0.1).timeout
	camera.position_smoothing_enabled = true

func _physics_process(delta):
	calculate_movement(delta)
	# Detect interaction input
	if (Input.is_action_just_pressed("interact")):
		check_interact()

func calculate_movement(delta):
	# Get input
	var direction: Vector2
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	# Funny stuff
	direction = direction.normalized()
	set_animation(direction)
	set_interact_target()
	# Move
	#var movement = move_speed * direction * delta
	velocity = velocity.move_toward(direction * move_speed, acceleration * delta)
	move_and_slide()
	# Calculate movement state
	if (velocity.length() <= 0): movement_state = PlayerUtil.move_state.IDLE
	else: movement_state = PlayerUtil.move_state.WALK

func check_interact():
	if interact.is_colliding():
		var collider = interact.get_collider()
		player_interact.emit(collider)

# Set the animation based on the player's movement
func set_animation(direction: Vector2):
	if (direction.x > 0):
		$Sprites.play("walk_right")
		movement_direction = PlayerUtil.move_direction.RIGHT
	elif (direction.x < 0):
		$Sprites.play("walk_left")
		movement_direction = PlayerUtil.move_direction.LEFT
	elif (direction.y > 0):
		$Sprites.play("walk_down")
		movement_direction = PlayerUtil.move_direction.DOWN
	elif (direction.y < 0):
		$Sprites.play("walk_up")
		movement_direction = PlayerUtil.move_direction.UP
	else: set_idle_anim()

# Choose an idle animaton based on the direction the player is facing
func set_idle_anim():
	if (movement_direction == PlayerUtil.move_direction.UP): $Sprites.play("idle_up")
	elif (movement_direction == PlayerUtil.move_direction.LEFT): $Sprites.play("idle_left")
	elif (movement_direction == PlayerUtil.move_direction.RIGHT): $Sprites.play("idle_right")
	else: $Sprites.play("idle_down")

func set_interact_target():
	if (movement_direction == PlayerUtil.move_direction.UP):
		interact.target_position = Vector2(0, -interaction_distance)
	elif (movement_direction == PlayerUtil.move_direction.LEFT):
		interact.target_position = Vector2(-interaction_distance, 0)
	elif (movement_direction == PlayerUtil.move_direction.RIGHT):
		interact.target_position = Vector2(interaction_distance, 0)
	else: interact.target_position = Vector2(0, interaction_distance)
