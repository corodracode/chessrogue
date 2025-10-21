class_name MoveSet
extends Resource

@export var moves: PackedVector2Array

func get_moves(piece_ui: PieceUI, board: Board):
	var tr = Transform2D(0, piece_ui.board_position)
	var aux = Array(tr * moves).filter(board.is_position_valid)
	var res = []
	for move in aux:
		if not board.is_position_valid(move): continue
		var p := board.check_position(move)
		if p and p.team == piece_ui.team: continue
		res.append(move)
	return PackedVector2Array(res)

func flip_y_moves():
	moves = Transform2D.FLIP_Y * moves
	print(moves)
