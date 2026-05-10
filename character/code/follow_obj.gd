extends Node3D
class_name FollowNode

@export var target : Node3D = null
@export var offset : Vector3 = Vector3.ZERO

@export var follow_velocity : float = 5.0
@export var rotation_velocity : float = 5.0
@export var relative_rotate : bool = false


func _ready() -> void:
	global_position = get_desired_position()


func _process(delta: float) -> void:
	var desired_position := get_desired_position()
	
	global_position = global_position.lerp(desired_position, follow_velocity * delta)
	
	if relative_rotate:
		var target_y := target.global_rotation.y
		rotation.y = lerp_angle(rotation.y, target_y, rotation_velocity * delta)


func get_desired_position() -> Vector3:
	return target.global_transform.origin + target.global_transform.basis * offset
