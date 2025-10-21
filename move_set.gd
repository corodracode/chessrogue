class_name MoveSet
extends Resource

@export var moves: PackedVector2Array
@export var can_take_other: bool = true
@export var can_take_self: bool = false

func get_moves(piece_ui: PieceUI, board: Board):
	var tr = Transform2D(0, piece_ui.board_position)
	var aux = Array(tr * moves).filter(board.is_position_valid)
	var res = []
	for move in aux:
		if not board.is_position_valid(move): continue
		var p := board.check_position(move)
		if p and p.team == piece_ui.team and not can_take_self: continue
		if p and p.team != piece_ui.team and not can_take_other: continue
		res.append(move)
	return PackedVector2Array(res)

func flip_y_moves():
	moves = Transform2D.FLIP_Y * moves
