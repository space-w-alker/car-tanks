extends BaseVehicle

const STEER_SPEED = 1.5
const STEER_LIMIT = 0.5

var steer_target = 0

export var engine_force_value = 80
export var reverse: bool = false;


func _ready():
	pass

func _process(delta):
	_process_inputs(delta)


func _process_inputs(delta: float):
	steer_target = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")
	steer_target *= STEER_LIMIT
	steering = move_toward(steering, steer_target, STEER_SPEED * delta);

	if Input.is_action_pressed("ui_up"):
		engine_force = -engine_force_value * (-1 if reverse else 1);
		brake = 0;
	elif Input.is_action_pressed("ui_down"):
		engine_force = 10 * (-1 if reverse else 1);
		brake = 0;
	else:
		engine_force = 0;
		brake = 2;
