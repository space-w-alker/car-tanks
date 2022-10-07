extends Node

signal camera_follow_signal(look_at, initial_camera_transform);

func signal_camera_follow(look_at: Spatial, initial_camera_transform: Spatial):
    emit_signal("camera_follow_signal", look_at, initial_camera_transform);