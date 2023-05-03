extends LevelBase

# オーバーライド
func _get_first_map_position()->Vector2i:
	var _first_pos:Vector2i = Vector2i(1,2)
	return _first_pos	

# オーバーライド
# ドアを出す場所
func get_door_position()->Vector2i:
	var _door_point:Vector2i = Vector2i(9,3) 
	return _door_point


# オーバーライド
# タイル種別に応じた個別処理
func _change_tile_by_kind(_kind:String, _map_pos:Vector2i):
	if _kind == Player.Lever_Off:
		# レバーを ON にする
		self.erase_cell(Tiles.Layer_Tile_Data, _map_pos)
		self.set_cell(Tiles.Layer_Tile_Data,_map_pos,4, Vector2i(1,0))
		# ドアを出現させる
		var _caller:Callable = Callable(self,'show_door')
		Commons.one_shot_timer(0.3, _caller)
	elif _kind == Player.Lever_Off_1:
		self.erase_cell(Tiles.Layer_Tile_Data, _map_pos)
		self.set_cell(Tiles.Layer_Tile_Data,_map_pos,4, Vector2i(1,0))
		var _caller:Callable = Callable(self,'erace_arrows')
		Commons.one_shot_timer(0.3, _caller)
		

# オーバーライド
# 親クラスの同名メソッドを実行したあとに、続いて『壁』を消す
func show_door():
	super.show_door()
	# 壁を消す
	var _caller:Callable = Callable(self, 'erase_wall')
	Commons.one_shot_timer(0.3, _caller)

# 壁を消す
func erase_wall():
	# 消す場所
	var _erase_pos_arr = [
		Vector2i(9,8),
		]
	for _pos in _erase_pos_arr:
		var _door_tile_data:TileData = Tiles.get_tile_data(self, _pos)
		if _door_tile_data :
			self.erase_cell(Tiles.Layer_Tile_Data, _pos)

# Arrows を消す	
func erace_arrows():
	var _rect:Rect2 = self.get_used_rect()
	for _y in range(_rect.size.y):
		for _x in range(_rect.size.x):
			var _pos :Vector2i = Vector2i(_x,_y)
			var _tile_data:TileData = Tiles.get_tile_data(self, _pos)
			if _tile_data:
				var _kind:String = Tiles.get_tile_data_kind(_tile_data)
				if Commons.find_str(_kind, Player.Arrow) == 0:
					self.erase_cell(Tiles.Layer_Tile_Data, _pos)
				
