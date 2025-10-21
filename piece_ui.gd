class_name PieceUI
extends Sprite2D

enum Teams {BLACK, WHITE}

signal clicked

@export var piece: Piece
@export var team: Teams
@export var colors := {
	Teams.BLACK: Color(0.48, 0.906, 0.343, 1.0),
	Teams.WHITE: Color(1.0, 0.416, 0.188, 1.0)
}

var board_position: Vector2i
var pieces_taken: Array[Piece]

@onready var area_2d: Area2D = $Area2D

func _ready() -> void:
	if piece:
		texture = piece.icon

func init(piece: Piece, pos: Vector2i, team: Teams):
	self.piece = piece.duplicate(true)
	self.board_position = pos
	self.team = team
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
