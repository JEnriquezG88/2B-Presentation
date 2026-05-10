extends Node3D

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D

const STEPS = preload("uid://dsenqjrh2affg")

@export var camera : Camera3D = null
@export var walk_speed := 2.0
@export var run_speed := 10.0


func _process(delta: float) -> void:
	var input := Input.get_vector(
		"left_stick_left",
		"left_stick_right",
		"left_stick_up",
		"left_stick_down"
	)

	var run := Input.is_action_pressed("run")
	
	var forward := camera.global_transform.basis.z
	var right := camera.global_transform.basis.x

	var direction := (forward * input.y) + (right * input.x)
	direction.y = 0
	direction = direction.normalized()

	if direction.length() > 0:
		var speed := run_speed if run else walk_speed
		position += direction * speed * delta

		# 🎯 Rotar personaje hacia donde se mueve
		var target_angle := atan2(direction.x, direction.z)
		rotation.y = lerp_angle(rotation.y, target_angle, delta * 10.0)

		if run:
			set_state(false, false, true)
		else:
			set_state(false, true, false)
	else:
		set_state(true, false, false)


func set_state(idle: bool, walk: bool, run: bool) -> void:
	animation_tree.set("parameters/StateMachine/conditions/idle", idle)
	animation_tree.set("parameters/StateMachine/conditions/walk", walk)
	animation_tree.set("parameters/StateMachine/conditions/run", run)


func shot_step_sound() -> void:
	audio_stream_player_3d.stop()
	audio_stream_player_3d.stream = STEPS
	audio_stream_player_3d.play()
