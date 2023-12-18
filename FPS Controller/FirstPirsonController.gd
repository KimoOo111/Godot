extends CharacterBody3D

@export_category("Player Movement")
@export var speed: float = 5.0
@export var jump_velocity = 4.5
@export var gravity: float = 10

@export_category("Camera Paramters")
@export var sensetivity: float = 0.001

@onready var Camera = $Camera3D

func _ready():
	# Hide Mouse
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	handle_escap()
	move_and_fall(delta)

func move_and_fall(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	var input_dir = Input.get_vector("left", "right", "forwrd", "backwrd")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	move_and_slide()

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * sensetivity)
		Camera.rotate_x(-event.relative.y * sensetivity)
		Camera.rotation.x = clamp(Camera.rotation.x, deg_to_rad(-60), deg_to_rad(90))

func handle_escap():
	# Toggle Mouse With escap Button
	if Input.is_action_just_pressed("esc"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
