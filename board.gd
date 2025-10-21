class_name Board
extends TileMapLayer

const PIECEUI = preload("res://piece_ui.tscn")

var pieces: Array[PieceUI]
var selected: PieceUI
var display_moves: Array[Sprite2D]

@onready var position_marker: Sprite2D = $PositionMarker
@onready var markers: Node2D = $Markers
@onready var pieces_container: CanvasGroup = $Pieces

func _physics_process(delta: float) -> void:
	if selected:
		selected.global_position = get_global_mouse_position()
		var cursor_pos = local_to_map(get_local_mouse_position())
		position_marker.position = cursor_pos * 16

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 2:
			cancel()
		if event.pressed and event.button_index == 1 and selected:
			try_to_move(local_to_map(get_local_mouse_position()) - Vector2i.ONE)

func check_position(pos: Vector2i) -> PieceUI:
	for piece_ui: PieceUI in pieces:
		if pos == piece_ui.board_position:
			return piece_ui
	return null

func add_piece(piece: Piece, pos: Vector2i, team: PieceUI.Teams) -> PieceUI:
	if not is_position_valid(pos): return null
	if check_position(pos): return null
	var piece_ui: PieceUI = PIECEUI.instantiate()
	pieces_container.add_child(piece_ui)
	piece_ui.init(piece, pos, team)
	place_piece(piece_ui, pos)
	piece_ui.clicked.connect(on_piece_clicked.bind(piece_ui))
	pieces.append(piece_ui)
	return piece_ui

func on_piece_clicked(piece_ui: PieceUI):
	if selected: return
	position_marker.show()
	selected = piece_ui
	var moves = selected.get_moves(self)
	for i in moves:
		draw_move(i)

func is_position_valid(pos: Vector2i) -> bool:
	if pos.x < 0 or pos.x > 7: return false
	if pos.y < 0 or pos.y > 7: return false
	return true

func place_piece(piece_ui: PieceUI, pos: Vector2i):
	if not is_position_valid(pos): return
	piece_ui.move(pos)
	piece_ui.position = (pos + Vector2i.ONE) * 16 + Vector2i.ONE * 8

func try_to_move(pos: Vector2i):
	var moves = selected.get_moves(self)
	if Vector2(pos) in Array(moves):
		var p = check_position(pos)
		if p: take(p)
		place_piece(selected, pos)
	await get_tree().physics_frame
	cancel.call_deferred()

func take(piece_ui: PieceUI):
	piece_ui.queue_free()
	pieces.erase(piece_ui)

func cancel():
	if not selected: return
	position_marker.hide()
	clear_moves()
	place_piece(selected, selected.board_position)
	selected = null

func draw_move(pos: Vector2i):
	var sprite = Sprite2D.new()
	markers.add_child(sprite)
	display_moves.append(sprite)
	sprite.texture = preload("res://assets/point_display_moves.tres")
	sprite.global_position = Vector2(pos + Vector2i.ONE) * 16 + Vector2.ONE * 8 + global_position

func clear_moves():
	for i in display_moves:
		i.queue_free()
	display_moves.clear()
