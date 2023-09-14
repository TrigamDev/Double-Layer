extends Node

enum move_state {
	IDLE, WALK, RUN, ROLL
}
enum move_direction {
	UP, DOWN, LEFT, RIGHT, NONE
}

func get_opposite_direction(direction: move_direction):
	if (direction == move_direction.UP): return move_direction.DOWN
	elif (direction == move_direction.DOWN): return move_direction.UP
	elif (direction == move_direction.RIGHT): return move_direction.LEFT
	elif (direction == move_direction.LEFT): return move_direction.RIGHT
	else: return move_direction.NONE
