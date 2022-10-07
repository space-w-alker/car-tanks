tool
extends Control

export(NodePath) var generate_button;

signal generate_clicked
signal clear_all
signal select_hexagon

var hold: bool;
var is_visible: bool;


var count:int = 0;
var x_select:int = 0;
var y_select:int = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_generate_button_pressed():
	emit_signal("generate_clicked")


func _on_clear_all_pressed():
	emit_signal("clear_all")


func _on_SpinBox_value_changed(value:float):
	count = value;


func _on_x_select_value_changed(value:float):
	x_select = (value as int) % count;
	emit_signal("select_hexagon")


func _on_y_select_value_changed(value:float):
	y_select = (value as int) % count;
	emit_signal("select_hexagon")


func _on_hold_toggled(button_pressed:bool):
	hold = button_pressed;


func _on_visible_toggle_toggled(button_pressed:bool):
	is_visible = button_pressed;
