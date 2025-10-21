class_name CompoundMoveSet
extends MoveSet

@export var move_sets: Array[MoveSet]

func get_moves(piece_ui: PieceUI, board: Board):
	var curr_moves: PackedVector2Array
	for ms: MoveSet in move_sets:
		curr_moves.append_array(ms.get_moves(piece_ui, board))
	return curr_moves
