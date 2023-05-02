extends Node

var layer_games:CanvasLayer
const Game_Max_Level:int = 3
const Game_First_Level:int = 2
const Game_Undefined_Level:int = -1

var _level:int

func setup(_layer: CanvasLayer):
	layer_games = _layer
	_level = Game_Undefined_Level
	Buttons.hide()
	Messages.hide()
	hide()
	
func set_level(_l : int):
	_level = _l

func clear_level():
	Buttons.show()
	Messages.show()

func load_game():
	var _caller = Callable(self, "level_up")
	Commons.one_shot_timer(0.5, _caller)

func level_up():
	Buttons.hide()
	Messages.hide()
	Player.hide()
	hide()
	
	if _level == Game_Undefined_Level :
		_level = Game_First_Level
	elif _level < Game_Max_Level :
		_level += 1
	else:
		_level = Game_First_Level
	_load_game(_level)

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
	Player.set_level_scene(_level_obj)
	Player.show()
	var _tile_design:TileMap = _level_obj.get_node("./game")
	Messages.createMessage(_level)
	show()

func hide():
	layer_games.hide()

func show():
	layer_games.show()

func game_close():
	hide()
	Messages.hide()
	Buttons.hide()
	Commons.window_close()

