extends Node2D

@export var indoorsScene: PackedScene
@export var door: Area2D
@export var transition: ColorRect
@export var player: CharacterBody2D

func _ready():
	player.connect("player_interact", _on_player_interact)

func _on_player_interact(collider):
	print("player interact")
	if (collider == door):
		transition.transition_to(indoorsScene)
