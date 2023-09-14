extends Node2D

@export var transition: ColorRect

var intersect = null

func _on_exit_box_entered(_other):
	var pos = PlayerState.get_last_scene().pos
	transition.exit(
		pos.x, pos.y,
		PlayerState.get_last_scene().facing,
		PlayerState.get_last_scene().scene
	)
	PlayerState.remove_nested()
