tool
extends Spatial

export(Array, PackedScene) var hexes: Array;
export(int) var grid_size = 20;
export(int) var scale_multiplier = 5;
export(bool) var can_generate = true;
export(bool) var activate = false setget _activate_now

var is_ready = false;


const GRID_SPACING = 0.86666667

func _activate_now(value: bool):
	if not can_generate:
		activate = value;
		return;
	if value:
		_generate_grid(grid_size/-2, grid_size * GRID_SPACING / -2, grid_size);
		transform = transform.scaled(Vector3(scale_multiplier, scale_multiplier, scale_multiplier));
		transform = transform.translated(Vector3(0, -0.1, 0))
	else:
		for i in get_child_count():
			var children = get_children();
			children[i].queue_free();
			transform = Spatial.new().transform;
	activate = value;


func _ready():
	pass

func _generate_grid(start_x: float = 0, start_z: float = 0, count: int = 20):
	for i in range(count):
		var add = 0.0 if i % 2 == 0 else 0.5;
		_generate_single_row(start_x + add, start_z + (i * GRID_SPACING), count);

func _generate_single_row(start_x: float, start_z: float, count: int = 20):
	for i in range(count):
		var instance = hexes[0].instance();
		add_child(instance);
		instance.global_transform.origin.z = start_z;
		instance.global_transform.origin.x = start_x + (i);
		instance.set_owner(get_tree().edited_scene_root)



