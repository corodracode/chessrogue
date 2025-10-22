class_name CompoundMoveSet
extends MoveSet

@export var move_sets: Array[MoveSet]

func get_moves(piece_ui: PieceUI, board: Board) -> PackedVector2Array:
	var curr_moves: PackedVector2Array
	for ms: MoveSet in move_sets:
		curr_moves.append_array(ms.get_moves(piece_ui, board))
	curr_moves.append_array(super(piece_ui, board))
	return curr_moves

func flip_y_moves():
	super()
	for move_set: MoveSet in move_sets:
		move_set.flip_y_moves()
