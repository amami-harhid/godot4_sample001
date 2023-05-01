extends Node2D

# ---------------------------------------
# onready.
# ---------------------------------------
# キャンバスレイヤー.
@onready var game_layer : CanvasLayer = $GameLayer
@onready var message_layer : CanvasLayer = $MessageLayer
@onready var button_layer : CanvasLayer = $ButtonLayer
# メッセージラベル.
@onready var message_label : Label = $MessageLayer/MessageLabel
@onready var menu_button : MenuButton = $ButtonLayer/MenuButton
# ビューポートサイズ
@onready var view_port_size :Vector2 = self.get_viewport_rect().size

# ---------------------------------------
# 変数.
# ---------------------------------------
# ゲームレベル
var _level = 1

func _ready():
	_message_setup()
	_menu_setup()
	_load_level(_level)
	var _caller = Callable(self,"_load_level")
	_sleep(0.1, _caller)

func _message_setup():
	message_layer.visible = true
	message_label.text = ""
	message_label.anchors_preset = Label.PRESET_CENTER
	message_label.size = Vector2(1, message_label.size.y)
	message_label.position = view_port_size / 2
	message_label.add_theme_font_size_override("font_size",80)

func _menu_setup():
	button_layer.visible = true
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

func _process(delta):
	pass

func _menu_click(id):
	if id == 0 : # レベルアップ
		var _caller = Callable(self,"_level_up")
		_sleep(0.5, _caller)
		
	elif id == 1 : # 終了
		# 0.3 秒後に終了する
		#_game_close(0.3)
		var _caller = Callable(self,"_game_close")
		_sleep(0.5, _caller)
		pass

func _sleep(_sec: float, _caller: Callable):
	if _sec > 0 :
		# タイマーで0.5秒待つ
		var _timer:Timer = Timer.new()
		add_child(_timer)
		_timer.wait_time = _sec
		_timer.one_shot = true
		_timer.start()
		await _timer.timeout # 指定した時間経過するまで停止する
		_timer.queue_free() # タイマーを消す
	_caller.call()

func _level_up():
	if _level < 2 :
		_level += 1
	else:
		_level = 1
	_load_level(_level)
		
func _game_close():
	game_layer.visible = false
	message_layer.visible = false
	button_layer.visible = false
	var _caller = Callable(self,"_window_close")
	_sleep(0.3, _caller)

func _window_close():
	get_tree().quit() # Gameを終わる
	

func _load_level(_level:int = 1):
	var _child_count = game_layer.get_child_count()
	print("_child_count=%02d"%_child_count)
	if _child_count > 0:
		# 子ノードがあるとき
		game_layer.hide()
		for _node in game_layer.get_children() :
			# 子ノードを消す
			game_layer.remove_child(_node)
	var _level_path = "res://src/level/level%02d.tscn"%_level
	var _level_res = load(_level_path)
	var _level_obj = _level_res.instantiate()
	game_layer.add_child(_level_obj)
	game_layer.show()
	var _tile_design:TileMap = _level_obj.get_node("./design")
	message_label.text = "レベル%02d クリア"%_level
	
