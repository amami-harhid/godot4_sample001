extends Node

const Wall := 'Wall'
const Arrow := 'Arrow'
const Arrow_Right := 'Arrow_Right'
const Arrow_Left := 'Arrow_Left'
const Arrow_Up := 'Arrow_Up'
const Arrow_Down := 'Arrow_Down'
const Dir_Right := Vector2i(1,0)
const Dir_Left := Vector2i(-1,0)
const Dir_Up := Vector2i(0,-1)
const Dir_Down := Vector2i(0,1)

var _player:Sprite2D
var _tilemap:TileMap
func setup_player(_p:Sprite2D):
	_player = _p
	
func setup_tile_map(_t: TileMap):
	_tilemap = _t

# 右に進めるなら右に進む
func move_right():
	if _can_move_right():
		_move(Dir_Right)

# 左に進めるなら左に進む
func move_left():
	if _can_move_left():
		_move(Dir_Left)

# 上に進めるなら上に進む
func move_up():
	if _can_move_up():
		_move(Dir_Up)

# 下に進めるなら下に進む
func move_down():
	if _can_move_down():
		_move(Dir_Down)

# 指定した向きに動く
func _move(_dir:Vector2i):
	var _map_pos:Vector2i = _player.get_meta(Player.Map_Position_Key)
	var _next_map_pos:Vector2i = _map_pos + _dir
	var _local_pos = _tilemap.map_to_local(_next_map_pos)
	_player.position = _local_pos
	_player.set_meta(Player.Map_Position_Key, _next_map_pos)

func set_map_position(_pos:Vector2i):
	if _tilemap :
		var _local_pos = _tilemap.map_to_local(_pos)
		_player.position = _local_pos
	_player.set_meta(Player.Map_Position_Key, _pos)

func change_position_by_map():
	var _map_position:Vector2i = _player.get_meta(Player.Map_Position_Key)
	set_map_position(_map_position)
		
# 右に進めるか
func _can_move_right()->bool:
	var _dir := Dir_Right
	return _can_move(_dir)

# 左に進めるか
func _can_move_left()->bool:
	var _dir := Dir_Left
	return _can_move(_dir)

# 上に進めるか
func _can_move_up()->bool:
	var _dir := Dir_Up
	return _can_move(_dir)

# 下に進めるか
func _can_move_down()->bool:
	var _dir := Dir_Down
	return _can_move(_dir)

# 進めるか
func _can_move(_dir:Vector2i)->bool:
	if _can_escape_tile(_dir):
		return _can_move_to_next_position(_dir)
	else:
		return false
# タイルを抜け出せるか	
func _can_escape_tile(_dir:Vector2i)->bool:
	var _movable := false
	# Playerの現在地( map位置 )
	var _current_position:Vector2i = _tilemap.local_to_map(_player.position)
	var _layer := 0 # タイルマップレイヤーは１枚だけ
	var _tile_data:TileData = _tilemap.get_cell_tile_data(_layer, _current_position)
	if _tile_data :
		# 現在地にタイルがあるとき
		var _c_layer_id := 0 # 先頭のカスタムデータ
		var _kind:String = _get_custom_data(_tile_data, _c_layer_id)
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
	print(_dir)
	var _movable := false
	# Playerの現在地( map位置 )
	var _current_position:Vector2i = _tilemap.local_to_map(_player.position)
	# Playerの次の位置( map位置 )
	var _next_position:Vector2i = _current_position
	_next_position += _dir
	
	# 次の位置にあるタイルを取り出す
	var _tile_data:TileData = _get_tiledata(_next_position)
	if _tile_data:
		# 現在地にタイルがあるとき
		var _c_layer_id := 0 # 先頭のカスタムデータ
		var _kind:String = _get_custom_data(_tile_data, _c_layer_id)
		if _kind:
			if _kind == Wall:
				print('#1')
				# 次の位置が『壁』のとき
				# 『進めない』
				_movable = false
			else:
				print('#2')
				# 次の位置が『壁』でないとき
				# 『進める』
				_movable = true
		else:
			print('#3')
			# 次の位置のタイルにタイル種別がないとき
			# 『進める』
			_movable = true
	else:
		print('#4')
		# 次の位置にタイルがないとき
		# 『進める』
		_movable = true
	return _movable

# 位置を指定してタイルデータを取り出す
func _get_tiledata(_pos:Vector2i)->TileData:
	var _layer := 0 # タイルマップレイヤーは１枚だけ
	return _tilemap.get_cell_tile_data(_layer, _pos)

# カスタムデータを取り出す	
func _get_custom_data(_tiledata:TileData, _custom_layer_id:int)->String:
	return _tiledata.get_custom_data_by_layer_id(_custom_layer_id)
