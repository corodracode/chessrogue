extends Node2D

var default_position = preload("uid://ceicuvw57ia2g")

@onready var board: Board = $Board

func _ready() -> void:
	for sp: StartingPiece in default_position.starting_pieces:
		var piece := board.add_piece(sp.piece.duplicate(true), sp.starting_position, sp.team)
		if sp.flip_y:
			piece.piece.flip_y_moves()
