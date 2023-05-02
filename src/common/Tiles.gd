extends Node

const Layer_Tile_Data : int = 0 # タイルマップにレイアーは１個だけ
const Layer_Data_Kind : int = 0 # タイル種別は先頭のデータレイヤー

func get_tile_data(_tile_map:TileMap, _pos:Vector2i)->TileData:
	return _tile_map.get_cell_tile_data(Layer_Data_Kind,_pos)

func get_tile_data_kind(_tile_data:TileData)->String:
	return _tile_data.get_custom_data_by_layer_id(Layer_Data_Kind)
