extends Spatial

export var vehicle: PackedScene;


# Called when the node enters the scene tree for the first time.
func _ready():
	_setup_vehicle();

func _setup_vehicle():
	if vehicle == null:
		return;
	var instance := vehicle.instance();
	add_child(instance);
	var camera_follow_object := Spatial.new();
	camera_follow_object.transform = $init_camera_location.transform;
	instance.add_child(camera_follow_object, true);
	GlobalSignalProcessor.signal_camera_follow(instance, camera_follow_object)

