extends TileMap

class_name LevelBase

# ゲームクリアしてレベルをクローズするときのフラグ
var _is_close :bool = false

func _ready():
	_is_close = false
	Player.set_map_position(_get_first_map_position())
	pass 

func _get_first_map_position()->Vector2i:
	var _first_pos:Vector2i = Vector2i(0,0)
	return _first_pos	

func _process(delta):
	if not _is_close :
		Player.player_move()
		change_tile()
		if Player.is_clear():
			_is_close = true
			var _caller:Callable = Callable(GameLayer,'level_up')
			Commons.one_shot_timer(0.3, _caller)

# タイルを変更する
func change_tile():
	var _map_pos = Player.get_map_position()
	if _map_pos :
		var _tile_data:TileData = Tiles.get_tile_data(self, _map_pos)
		if _tile_data :
			var _kind:String = Tiles.get_tile_data_kind(_tile_data)
			_change_tile_by_kind(_kind, _map_pos)

# タイル種別に応じた個別処理
func _change_tile_by_kind(_kind:String, _map_pos:Vector2i):
	if _kind == Player.Lever_Off:
		self.erase_cell(Tiles.Layer_Tile_Data, _map_pos)
		self.set_cell(Tiles.Layer_Tile_Data,_map_pos,4, Vector2i(1,0))
		var _caller:Callable = Callable(self,'show_door')
		Commons.one_shot_timer(0.3, _caller)

# ドアを出現させる
func show_door():
	var _door_point:Vector2i = get_door_position()
	var _door_tile_data:TileData = Tiles.get_tile_data(self, _door_point)
	if _door_tile_data:
		self.erase_cell(Tiles.Layer_Tile_Data, _door_point)
	var _door_atlas_coord = Vector2i(0,0)
	self.set_cell(Tiles.Layer_Tile_Data, _door_point, 3, _door_atlas_coord)

# ドアを出す場所
func get_door_position()->Vector2i:
	var _door_point:Vector2i = Vector2i(0,0) 
	return _door_point
