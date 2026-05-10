extends AnimationTree

var is_button_pressed : bool = false

func _process(delta: float) -> void:
	var new_target_value: float = 0.0
	if is_button_pressed:
		new_target_value = 1.0
	set("parameters/WalkBlend/blend_amount", lerpf(get("parameters/WalkBlend/blend_amount"), new_target_value, 1.0 * delta))
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("forward"):
		is_button_pressed = true
	if event.is_action_released("forward"):
		is_button_pressed = false
