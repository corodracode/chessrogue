class_name OnlyAttackMoveSet
extends MoveSet

func get_moves(piece_ui: PieceUI, board: Board) -> PackedVector2Array:
	var curr_moves: PackedVector2Array
	for move: Vector2i in super(piece_ui, board):
		var p = board.check_position(move)
		if p and p.team != piece_ui.team:
			curr_moves.append(move)
	return curr_moves
