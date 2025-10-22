class_name Piece
extends Resource

@export var piece_name: String
@export var move_sets: Array[MoveSet]
@export var skills: Array[Skill]
@export var icon: Texture

var is_flipped: bool

func get_moves(piece_ui: PieceUI, board: Board) -> PackedVector2Array:
	var moves: PackedVector2Array
	
	for move_set: MoveSet in move_sets:
		for move: Vector2i in move_set.get_moves(piece_ui, board):
			moves.append(move)
	return moves

func flip_y_moves():
	is_flipped = not is_flipped
	var new_ms: Array[MoveSet]
	for ms: MoveSet in move_sets:
		ms.flip_y_moves()
		new_ms.append(ms)
	move_sets = new_ms
