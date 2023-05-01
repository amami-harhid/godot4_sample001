extends Node

var _player : Sprite2D
var _tile_map : TileMap
var _map_position :Vector2i

func setup(_sprite:Sprite2D):
	_player = _sprite
	
func set_tilemap(_t: TileMap):
	_tile_map = _t

func setPosition(_pos:Vector2i):
	var _local_position = _tile_map.map_to_local(_pos)
	_player.position = _local_position 
