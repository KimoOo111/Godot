extends Camera3D

@export_category("Camera Paramters")
@export var sensetivity: float = 0.001

@onready var Camera = $Camera3D


func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * sensetivity)
		Camera.rotate_x(-event.relative.y * sensetivity)
		Camera.rotation.x = clamp(Camera.rotation.x, deg_to_rad(-60), deg_to_rad(90))
