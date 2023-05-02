extends TilePlayer

#class_name PlayerLayer

#var _player : Sprite2D
#var _tile_map : TileMap
var _layer_player:CanvasLayer
var _map_position :Vector2i
const Map_Position_Key := "map_position"
const Frame_Left :int = 0
const Frame_Up :int = 1
const Frame_Right :int = 2
const Frame_Down :int = 3

func setup(_layer:CanvasLayer):
	_layer_player = _layer
	_player = _layer_player.get_node('PlayerSprite2D')
#	TilePlayer.setup_player(_player)
#	set_map_position(Vector2i(2,2))
	_animation_down()
	hide()
	
func set_level_scene(_level_scene: Node2D):
	_tilemap = _level_scene.get_node('game')
#	TilePlayer.setup_tile_map(_tile_map)
#	set_map_position(Vector2i(1,1))
#	TilePlayer.change_position_by_map()
	change_position_by_map()
	
func player_move():
	if Input.is_action_just_pressed("ui_up"):
#		TilePlayer.move_up()
		move_up()
		_animation_up()
	elif Input.is_action_just_pressed("ui_right"):
#		TilePlayer.move_right()
		move_right()
		_animation_right()
	elif Input.is_action_just_pressed("ui_left"):
#		TilePlayer.move_left()
		move_left()
		_animation_left()
	elif Input.is_action_just_pressed("ui_down"):
#		TilePlayer.move_down()
		move_down()
		_animation_down()
	else:
		move()
		
func _animation_up():
	_player.frame_coords.y = Frame_Up
func _animation_right():
	_player.frame_coords.y = Frame_Right
func _animation_left():
	_player.frame_coords.y = Frame_Left
func _animation_down():
	_player.frame_coords.y = Frame_Down

func next_h_frame():
	var _x = (_player.frame_coords.x + 1) % _player.hframes
	_player.frame_coords.x = _x
	

func set_map_position(_p: Vector2i):
	_player.set_meta(Map_Position_Key, _p)
	super.set_map_position(_p)

func get_map_position()->Vector2i:
	return _player.get_meta(Map_Position_Key)
	
func hide():
	_layer_player.hide()

func show():
	_layer_player.show()
