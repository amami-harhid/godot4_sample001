extends LevelBase

# オーバーライド
func _get_first_map_position()->Vector2i:
	var _first_pos:Vector2i = Vector2i(2,2)
	return _first_pos	

# オーバーライド
# タイル種別に応じた個別処理
func _change_tile_by_kind(_kind:String, _map_pos:Vector2i):
	if _kind == Player.Lever_Off:
		print(_kind)
		self.erase_cell(Tiles.Layer_Tile_Data, _map_pos)
		self.set_cell(Tiles.Layer_Tile_Data,_map_pos,4, Vector2i(1,0))
		var _caller:Callable = Callable(self,'show_door')
		Commons.one_shot_timer(0.3, _caller)

# オーバーライド
# ドアを出す場所
func get_door_position()->Vector2i:
	var _door_point:Vector2i = Vector2i(9,3) 
	return _door_point
