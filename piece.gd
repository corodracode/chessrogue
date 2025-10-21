class_name Piece
extends Resource

@export var name: String
@export var move_sets: Array[MoveSet]
@export var icon: Texture

func get_moves(piece_ui: PieceUI, board: Board) -> PackedVector2Array:
	var moves: PackedVector2Array
	
	for move_set: MoveSet in move_sets:
		for move: Vector2i in move_set.get_moves(piece_ui, board):
			moves.append(move)
	return moves

func flip_y_moves():
	var new_ms: Array[MoveSet]
	for ms: MoveSet in move_sets:
		new_ms.append(ms.flip_y_moves())
	move_sets = new_ms
