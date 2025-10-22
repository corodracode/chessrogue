extends Skill

@export var starting_ms: MoveSet

var affected_piece: Piece

func setup(piece_ui: PieceUI, board: Board) -> void:
	affected_piece = piece_ui.piece
	affected_piece.move_sets.append(starting_ms)
	piece_ui.moved_to.connect(remove_starting_ms.unbind(1), Object.ConnectFlags.CONNECT_ONE_SHOT)

func remove_starting_ms():
	print("%s removed" % skill_name)
	affected_piece.move_sets.erase(starting_ms)
