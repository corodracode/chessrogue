class_name PieceUI
extends Sprite2D

enum Teams {BLACK, WHITE}

signal clicked
signal moved_to(pos: Vector2i)
signal took_piece(piece: PieceUI)
signal taken_by(piece: PieceUI)

@export var piece: Piece
@export var team: Teams
@export var colors := {
	Teams.BLACK: Color(0.48, 0.906, 0.343, 1.0),
	Teams.WHITE: Color(1.0, 0.416, 0.188, 1.0)
}

var board_position: Vector2i
var pieces_taken: Array[Piece]
var moves_done: Array[Vector2i]

@onready var area_2d: Area2D = $Area2D

func _ready() -> void:
	if piece:
		texture = piece.icon

func init(piece: Piece, pos: Vector2i, team: Teams, board: Board):
	self.piece = piece
	self.board_position = pos
	self.team = team
	for skill: Skill in piece.skills:
		skill.setup(self, board)
	texture = piece.icon
	self_modulate = colors.get(team)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			clicked.emit()

func get_moves(board: Board):
	return piece.get_moves(self, board)

func take_piece(piece_ui: PieceUI):
	pieces_taken.append(piece_ui)

func move(pos: Vector2i):
	if pos != board_position:
		moves_done.append(board_position)
		moved_to.emit(pos)
	board_position = pos
