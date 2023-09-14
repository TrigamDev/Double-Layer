extends Node

var nested_scenes = []
var pos: Vector2 = Vector2.ZERO
var facing: PlayerUtil.move_direction = PlayerUtil.move_direction.DOWN

func add_nested(scene: String, position: Vector2, facing: PlayerUtil.move_direction):
	nested_scenes.push_back({ "scene": scene, "pos": position, "facing": facing })

func remove_nested():
	nested_scenes.pop_back()

func get_last_scene():
	return nested_scenes.back()
