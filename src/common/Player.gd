extends Node

var _player : Sprite2D
var _tile_map : TileMap
var _map_position :Vector2i

func setup(_sprite:Sprite2D):
	_player = _sprite
	_map_position = Vector2i(0,0)
	
func set_level_scene(_level_scene: Node2D):
	print(_level_scene)
	_tile_map = _level_scene.get_child(1)

func setPosition(_pos:Vector2i):
	var _local_position = _tile_map.map_to_local(_pos)
	_player.position = _local_position
	
func player_move():
	if Input.is_action_just_pressed("ui_up"):
		_map_position += Vector2i(0,-1)
		setPosition(_map_position)
	elif Input.is_action_just_pressed("ui_right"):
		_map_position += Vector2i(1,0)
		setPosition(_map_position)
	elif Input.is_action_just_pressed("ui_left"):
		_map_position += Vector2i(-1,0)
		setPosition(_map_position)
	elif Input.is_action_just_pressed("ui_down"):
		_map_position += Vector2i(0,1)
		setPosition(_map_position)
		pass
	
