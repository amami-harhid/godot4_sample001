extends TilePlayerCommon

class_name TilePlayer

const Wall := 'Wall'
const Arrow := 'Arrow'
const Arrow_Right := 'Arrow_Right'
const Arrow_Left := 'Arrow_Left'
const Arrow_Up := 'Arrow_Up'
const Arrow_Down := 'Arrow_Down'
const Teleport := 'Teleport'
const Door := 'Door'
const Lever := 'Lever'
const Lever_Off := 'Lever_Off'
const Lever_On := 'Lever_On'
const Lever_Off_1 := 'Lever_Off_1'

# ドアに到達していたら Trueを返す
func is_clear()->bool:
	if _tilemap :		
		var _map_pos:Vector2i = _player.get_meta(Player.Map_Position_Key)
		var _tile_data:TileData = Tiles.get_tile_data(_tilemap, _map_pos)
		if _tile_data :
			var _kind:String = Tiles.get_tile_data_kind(_tile_data)
			if _kind == Door:
				return true
	return false

# 指定した向きに動く
func move(_dir:Vector2i = Vector2i(0,0)):
	if tilemap_is_ready():
		var _map_pos:Vector2i = _player.get_meta(Player.Map_Position_Key)
		var _next_map_pos:Vector2i = _map_pos + _dir
		var _local_pos = _tilemap.map_to_local(_next_map_pos)
		_player.position = _local_pos
		_player.set_meta(Player.Map_Position_Key, _next_map_pos)

func set_map_position(_pos:Vector2i):
	if _tilemap :
		var _local_pos = _tilemap.map_to_local(_pos)
		_player.position = _local_pos
	#Player.set_map_position(_pos)

func change_position_by_map():
	var _map_position:Vector2i = _player.get_meta(Player.Map_Position_Key)
	set_map_position(_map_position)

# 進めるか
func _can_move(_dir:Vector2i)->bool:
	if tilemap_is_ready():
		if _can_escape_tile(_dir):
			return _can_move_to_next_position(_dir)
		else:
			return false
	else:
		return false

# タイルを抜け出せるか	
func _can_escape_tile(_dir:Vector2i)->bool:
	var _movable := false
	# Playerの現在地( map位置 )
	var _current_position:Vector2i = _tilemap.local_to_map(_player.position)
	var _tile_data:TileData = Tiles.get_tile_data(_tilemap, _current_position)
	if _tile_data :
		# 現在地にタイルがあるとき
		var _kind:String = Tiles.get_tile_data_kind(_tile_data)
		if _kind :
			if Commons.find_str(_kind, Arrow) == 0:
				# 矢印の向きと進行方向が同じときには『進める』
				if _kind == Arrow_Right && _dir == Dir_Right:
					_movable = true
				elif _kind == Arrow_Left && _dir == Dir_Left:
					_movable = true
				elif _kind == Arrow_Up && _dir == Dir_Up:
					_movable = true
				elif _kind == Arrow_Down && _dir == Dir_Down:
					_movable = true
			else:
				# 現在地のタイルが『矢印』でないとき
				# 『進める』
				_movable = true
		else:
			# 現在地のタイルにタイル種別がないとき
			# 『進める』
			_movable = true
	else:
		# 現在地にタイルがないとき
		# 『進める』
		_movable = true

	return _movable

# 次の位置のタイルへは進めるか
func _can_move_to_next_position(_dir:Vector2i)->bool:
	var _movable := false
	# Playerの現在地( map位置 )
	var _current_position:Vector2i = _tilemap.local_to_map(_player.position)
	# Playerの次の位置( map位置 )
	var _next_position:Vector2i = _current_position
	_next_position += _dir
	
	# 次の位置にあるタイルを取り出す
	var _tile_data:TileData = Tiles.get_tile_data(_tilemap, _next_position)
	if _tile_data:
		# 次の位置にタイルがあるとき
		var _kind:String = Tiles.get_tile_data_kind(_tile_data)
		if _kind:
			if _kind == Wall:
				# 次の位置が『壁』のとき
				# 『進めない』
				_movable = false
			else:
				# 次の位置が『壁』でないとき
				# 『進める』
				_movable = true
		else:
			# 次の位置のタイルにタイル種別がないとき
			# 『進める』
			_movable = true
	else:
		# 次の位置にタイルがないとき
		# 『進める』
		_movable = true
	return _movable
