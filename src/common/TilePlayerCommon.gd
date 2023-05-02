extends Node

class_name TilePlayerCommon

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
		move(Dir_Right)

# 左に進めるなら左に進む
func move_left():
	if _can_move_left():
		move(Dir_Left)

# 上に進めるなら上に進む
func move_up():
	if _can_move_up():
		move(Dir_Up)

# 下に進めるなら下に進む
func move_down():
	if _can_move_down():
		move(Dir_Down)

# 指定した向きに動く
func move(_dir:Vector2i):
	# 継承先で動作を記述すること
	pass


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
	# 継承先で動作を記述すること
	return true

# タイルマップが準備済のとき Trueを返す
func tilemap_is_ready()->bool:
	if _tilemap:
		return true
	else:
		return false

func hide():
	_player.hide()

func show():
	_player.show()
