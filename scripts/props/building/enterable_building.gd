extends Node2D

@export var indoorsScene: PackedScene
@export var door: Area2D
@export var transition: ColorRect
@export var player: CharacterBody2D

func _ready():
	player.connect("player_interact", _on_player_interact)

func _on_player_interact(collider):
	if (collider == door):
		var scene = get_tree().current_scene.scene_file_path
		PlayerState.add_nested(scene, player.position, player.movement_direction)
		transition.transition_to(indoorsScene)
