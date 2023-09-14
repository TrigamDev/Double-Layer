extends Node2D

@export var player: CharacterBody2D
@export var interaction_area: Area2D
@export var outdoors_scene: PackedScene
@export var transition: ColorRect

var intersect = null

func _on_exit_box_entered(other):
	if (other == player):
		print("swap back")
		transition.transition_to(outdoors_scene)
