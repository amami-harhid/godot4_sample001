extends Node

var layer_games:CanvasLayer

func setup(_layer: CanvasLayer):
	layer_games = _layer

func _load_game(_level:int):
	var _child_count = layer_games.get_child_count()
	if _child_count > 0:
		# 子ノードがあるとき
		layer_games.hide()
		for _node in layer_games.get_children() :
			# 子ノードを消す
			layer_games.remove_child(_node)
	var _level_path = "res://src/level/level%02d.tscn"%_level
	var _level_res = load(_level_path)
	var _level_obj = _level_res.instantiate()
	layer_games.add_child(_level_obj)
	layer_games.show()
	var _tile_design:TileMap = _level_obj.get_node("./design")
	Messages.text("レベル%02d クリア"%_level)
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
