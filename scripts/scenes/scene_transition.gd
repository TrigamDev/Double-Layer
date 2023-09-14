extends ColorRect

@export var scene: PackedScene
@onready var anim: AnimationPlayer = $AnimationPlayer

func _ready():
	anim.play("fade")

func transition_to(nextScene:= scene):
	anim.play_backwards("fade")
	await anim.animation_finished
	get_tree().change_scene_to_packed(nextScene)

func exit(posX: float, posY: float, facing: PlayerUtil.move_direction, nextScenePath: String):
	anim.play_backwards("fade")
	await anim.animation_finished
	PlayerState.pos = Vector2(posX, posY)
	PlayerState.remove_nested()
	PlayerState.facing = PlayerUtil.get_opposite_direction(facing)
	await get_tree().change_scene_to_file(nextScenePath)
