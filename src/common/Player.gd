extends Node

var _player : Sprite2D
var _tile_map : TileMap
var _map_position :Vector2i
const Map_Position_Key := "map_position"

func setup(_sprite:Sprite2D):
	_player = _sprite
	TilePlayer.setup_player(_player)
	TilePlayer.set_map_position(Vector2i(1,1))
	
func set_level_scene(_level_scene: Node2D):
	_tile_map = _level_scene.get_node('game')
	print(_tile_map)
	TilePlayer.setup_tile_map(_tile_map)
	TilePlayer.set_map_position(Vector2i(2,2))
	
func player_move():
	if Input.is_action_just_pressed("ui_up"):
		TilePlayer.move_up()
	elif Input.is_action_just_pressed("ui_right"):
		TilePlayer.move_right()
	elif Input.is_action_just_pressed("ui_left"):
		TilePlayer.move_left()
	elif Input.is_action_just_pressed("ui_down"):
		TilePlayer.move_down()
