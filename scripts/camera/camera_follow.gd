extends Camera

var look_at_target :Spatial = null;
var camera_follow_object :Spatial = null;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	if look_at_target:
		global_transform.origin = global_transform.origin.linear_interpolate(camera_follow_object.global_transform.origin, 2 * delta);
		look_at(look_at_target.global_transform.origin, Vector3.UP);
		

func _init():
	GlobalSignalProcessor.connect("camera_follow_signal", self, "_handle_camera_reset");

func _handle_camera_reset(look_at_arg: Spatial, cam_follow_arg: Spatial):
	look_at_target = look_at_arg;
	camera_follow_object = cam_follow_arg;
	global_transform = camera_follow_object.global_transform;

