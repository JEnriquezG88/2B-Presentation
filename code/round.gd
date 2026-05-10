extends Node3D

@export var rotation_velocity : float = 0.1
@onready var camera_v: Node3D = $CameraV
@onready var camera_h: Node3D = $"."
@onready var camera_3d: Camera3D = $CameraV/Camera3D

var max_camera_zoom : float = 15.0
var min_camera_zoom : float = 8.505

func _process(delta: float) -> void:
	var z := camera_3d.position.z

	if Input.is_action_pressed("zoom_in"):
		z -= delta * 2

	if Input.is_action_pressed("zoom_out"):
		z += delta * 2

	camera_3d.position.z = clamp(z, min_camera_zoom, max_camera_zoom)
	
	var input := Input.get_vector(
		"right_stick_left",
		"right_stick_right",
		"right_stick_up",
		"right_stick_down"
	)

	camera_h.rotation.y -= input.x * rotation_velocity * delta

	camera_v.rotation.x -= input.y * rotation_velocity * delta
