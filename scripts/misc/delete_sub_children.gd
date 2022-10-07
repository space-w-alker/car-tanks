tool
extends Node

export(int) var value_to_change_now = 0 setget _remove_all

func _ready():
	_remove_all(0);

func _remove_all(value: int):
	print("Remove triggered")
	if value != 0:
		for i in get_child_count():
			print(i)
			_remove_all_children(get_child(i));
	


func _remove_all_children(node: Spatial):
    for i in node.get_child_count():
        var child = node.get_child(i);
        node.remove_child(child);
        child.free();
		