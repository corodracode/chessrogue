class_name RunningMoveSet
extends MoveSet

@export var offset: Vector2i
@export var max_distance: int = 100
@export var is_blocked_by_same_team: bool = true
@export var is_blocked_by_other_team: bool = true


func get_moves(piece_ui: PieceUI, board: Board):
	var distance: int
	var running_moves: PackedVector2Array
	var new_move: Vector2i = piece_ui.board_position + offset
	var is_valid := can_move(piece_ui, board, new_move)
	while is_valid:
		running_moves.append(new_move)
		
		var p := board.check_position(new_move)
		if p and p.team != piece_ui.team: break
		
		distance += 1
		if distance >= max_distance: break
		
		new_move = new_move + offset
		is_valid = can_move(piece_ui, board, new_move)
	running_moves.append_array(moves)
	return running_moves

func flip_y_moves():
	offset = Vector2i(Transform2D.FLIP_Y * Vector2(offset))
	super()

func can_move(piece_ui: PieceUI, board: Board, pos: Vector2i) -> bool:
	var is_valid := board.is_position_valid(pos)
	var p := board.check_position(pos)
	var is_piece_same_team: bool = (p and p.team == piece_ui.team)
	var is_piece_other_team: bool = (p and p.team != piece_ui.team)
	var is_blocked = is_piece_other_team and is_blocked_by_other_team \
			and not can_take_other \
			or is_piece_same_team and is_blocked_by_same_team \
			and not can_take_self
	return is_valid and not is_blocked
