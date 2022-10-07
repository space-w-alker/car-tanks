tool
extends Spatial

export(bool) var has_path = false; 
export(int) var hexagon_index = 0 setget _set_index;
export(int) var path_index = 0 setget _set_path_index;

export(Array, PackedScene) var all_files: Array = [];

var is_ready = false;


# Called when the node enters the scene tree for the first time.
func _ready():
	is_ready = true;
	print("Started")
	_remove_all_children(self);
	print("Got this farr")
	_create_and_add_child('block', self)
	_create_and_add_child('path', self)
	_set_index(hexagon_index);
	_set_path_index(path_index);

func _set_index(index: int):
	if (is_ready):
		_remove_all_children($block);
		var instance :Spatial = all_files[index % all_files.size()].instance();
		_add_child(instance, $block)
	hexagon_index = index;

func _set_path_index(index: int):
	if (has_path && is_ready):
		_remove_all_children($path);
		var instance :Spatial = all_files[index % all_files.size()].instance();
		_add_child(instance, $path)
	path_index = index;

func _remove_all_children(node: Spatial):
	for i in node.get_child_count():
		var child = node.get_child(i);
		node.remove_child(child);
		child.queue_free();

func _create_and_add_child(name: String, parent: Spatial = null) -> Spatial:
	var node = Spatial.new();
	node.name = name;
	_add_child(node, parent)
	return node;

func _add_child(child: Spatial, parent: Spatial = null):
	print(child.name);
	var p :Spatial = self if parent == null else parent;
	p.add_child(child);
	# child.set_owner(get_tree().edited_scene_root);
