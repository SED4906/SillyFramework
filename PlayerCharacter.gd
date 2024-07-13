class_name PlayerCharacter extends CharacterBody3D

@export var is_enabled: bool = true
@export var is_active: bool = false

var alive = true
var respawn_wave_timer = 0.0
var death_time = 0.0

var bits = 0

var last_position = Vector3.ZERO

func _enter_tree() -> void:
	add_to_group(&"PlayerCharacters")

func _exit_tree() -> void:
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func respawn(where):
	position = where
	alive = true

func die():
	alive = false
	death_time = ceil(respawn_wave_timer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	respawn_wave_timer += delta
	if not alive and respawn_wave_timer >= death_time + 1.0:
		respawn(get_tree().get_first_node_in_group(&"PlayerRespawnPoints").find_respawn_point(self))
		
	if alive and is_on_floor():
		last_position = position

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func input_handler():
	if not (alive and is_active): return
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_a", "move_d", "move_w", "move_s")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var camera = get_tree().get_first_node_in_group(&"Camera")
	direction = direction.rotated(Vector3.UP,camera.rotation.y)
	if direction and is_active:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	input_handler()

	move_and_slide()

func get_last_position():
	return last_position
