extends TileMap


var _is_close :bool = false

func _ready():
	_is_close = false
	Player.set_map_position(Vector2i(1,1))
	pass # Replace with function body.

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
			if _kind == Player.Lever_Off:
				print(_kind)
				self.erase_cell(Tiles.Layer_Tile_Data, _map_pos)
				self.set_cell(Tiles.Layer_Tile_Data,_map_pos,4, Vector2i(1,0))
				var _caller:Callable = Callable(self,'show_door')
				Commons.one_shot_timer(0.3, _caller)

func show_door():
	var _door_map_pos:Vector2i = Vector2i(9,3) # ドアを出す場所
	var _door_tile_data:TileData = Tiles.get_tile_data(self, _door_map_pos)
	print(_door_tile_data)
	if _door_tile_data:
		self.erase_cell(Tiles.Layer_Tile_Data, _door_map_pos)
	self.set_cell(Tiles.Layer_Tile_Data, _door_map_pos, 3, Vector2i(0,0))
	
