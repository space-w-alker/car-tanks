tool
extends EditorPlugin

var dock:Control;

const GRID_SPACING = 0.86666667

const blocks_meshes_floder = "res://assets/hexagon-terrain-blocks/";
const block := preload("res://addons/terrain_generator/scenes/hexagon_block.tscn")

func _select_hex():
	var selection = get_editor_interface().get_selection();
	var root = get_editor_interface().get_edited_scene_root();
	if not dock.hold: selection.clear()
	get_editor_interface().edit_node(root.get_child(dock.x_select * dock.count + dock.y_select))
	selection.add_node(root.get_child(dock.x_select * dock.count + dock.y_select))

func _generate_grid(parent, start_x: float = 0, start_z: float = 0, count: int = 20):
	for i in range(count):
		var add = 0.0 if i % 2 == 0 else 0.5;
		_generate_single_row(parent, start_x + add, start_z + (i * GRID_SPACING), count);

func _generate_single_row(parent, start_x: float, start_z: float, count: int = 20):
	for i in range(count):
		var instance: Spatial = block.instance();
		parent.add_child(instance);
		instance.global_transform.origin.z = start_z;
		instance.global_transform.origin.x = start_x + (i);
		instance.set_owner(parent)
		instance.visible = dock.is_visible;

func _generate_terrain():
	print("Generate!!!")
	var root = get_editor_interface().get_edited_scene_root();
	_generate_grid(root, dock.count/-2, dock.count * GRID_SPACING / -2, dock.count);

func _clear_generated_terrain():
	var root = get_editor_interface().get_edited_scene_root();
	for i in root.get_child_count():
		root.get_child(i).queue_free();



func _enter_tree():
	print("Something went wrong!");
	dock = ResourceLoader.load("res://addons/terrain_generator/dock.tscn").instance()
	add_control_to_dock(DOCK_SLOT_LEFT_UL, dock);
	dock.connect("generate_clicked", self, "_generate_terrain")
	dock.connect("clear_all", self, "_clear_generated_terrain")
	dock.connect("select_hexagon" , self, "_select_hex")


func _exit_tree():
	print("___Exiting Tree___")
	remove_control_from_docks(dock);
	dock.queue_free();
