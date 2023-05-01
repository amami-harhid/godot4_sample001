extends Node

const Game_Max_Level:int = 3
const Game_First_Level:int = 1
const Game_Undefined_Level:int = -1

var view_port_size : Vector2
var main:Node2D
var layer_background:CanvasLayer
var layer_games:CanvasLayer
var layer_message:CanvasLayer
var layer_buttons:CanvasLayer
#var label_message:Label
var menu_button:MenuButton

var _level

func init(_main:Node2D):
	_level = Game_Undefined_Level
	main = _main

func set_view_port_size(_size:Vector2):
	view_port_size = _size

func set_layer_background(_layer:CanvasLayer):
	layer_background = _layer
func set_layer_games(_layer:CanvasLayer):
	layer_games = _layer
func set_layer_message(_layer:CanvasLayer):
	Messages.set_layer_message(_layer)
#	layer_message = _layer
#	label_message = layer_message.get_node('LabelMessage')
#	Messages.set_layer_message(_layer)
	#_message_setup()

func set_layer_buttons(_layer:CanvasLayer):
	layer_buttons = _layer
	menu_button = layer_buttons.get_node('MenuButton')
	_menu_setup()

#func __message_setup():
#	layer_message.visible = true
#	label_message.text = ""
#	label_message.anchors_preset = Label.PRESET_CENTER
#	label_message.size = Vector2(1, label_message.size.y)
#	label_message.position = view_port_size / 2
#	label_message.add_theme_font_size_override("font_size",80)

func _menu_setup():
	layer_buttons.visible = true
	menu_button.text = ""
	menu_button.anchors_preset = Label.PRESET_CENTER
	menu_button.size = Vector2(1, menu_button.size.y)
	menu_button.position = Vector2(view_port_size.x / 2, view_port_size.y / 5)
	menu_button.add_theme_font_size_override("font_size", 30)
	menu_button.text = "メニュー"
	var _pop_up:PopupMenu = menu_button.get_popup()
	_load_font(_pop_up)
	var _callable:Callable = Callable(self, "_menu_click")
	_pop_up.connect("id_pressed", _callable)

func _load_font(_pop_up:PopupMenu):
	var fv = FontVariation.new()
	fv.set_base_font(load("res://fonts/NotoSansJP-Regular.ttf"))
	fv.set_variation_embolden(1)
	_pop_up.add_theme_font_override("font",fv)

func _menu_click(id):
	if id == 0 : # レベルアップ
		var _caller = Callable(self,"level_up")
		sleep(0.3, _caller)
		
	elif id == 1 : # 最初から
		_level = Game_Undefined_Level
		var _caller = Callable(self,"level_up")
		sleep(0.3, _caller)
	elif id == 2 : # 終了
		# 0.3 秒後に終了する
		var _caller = Callable(self,"_game_close")
		sleep(0.3, _caller)
		pass
func load_game():
	var _caller = Callable(self, "level_up")
	sleep(0.5, _caller)
	
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
	#label_message.text = "レベル%02d クリア"%_level
	Messages.text("レベル%02d クリア"%_level)
	pass

func sleep(_sec: float, _caller: Callable):
	if _sec > 0 :
		var _timer:Timer = Timer.new()
		add_child(_timer)
		_timer.wait_time = _sec
		_timer.one_shot = true
		_timer.start()
		await _timer.timeout # 指定した時間経過するまで停止する
		_timer.queue_free() # タイマーを消す
	_caller.call()
	
func level_up():
	if _level == Game_Undefined_Level :
		_level = Game_First_Level
	elif _level < Game_Max_Level :
		_level += 1
	else:
		_level = Game_First_Level
	_load_game(_level)

func _game_close():
	layer_games.visible = false
	layer_message.visible = false
	layer_buttons.visible = false
	var _caller = Callable(self,"_window_close")
	sleep(0.3, _caller)

func _window_close():
	main.get_tree().quit() # Gameを終わる
