extends ColorRect

@export var scene: PackedScene
@onready var anim: AnimationPlayer = $AnimationPlayer

func _ready():
	anim.play("fade")

func transition_to(nextScene:= scene):
	anim.play_backwards("fade")
	await anim.animation_finished
	get_tree().change_scene_to_packed(nextScene)
