extends Node

var layer_buttons:CanvasLayer
var menu_button:MenuButton
var _view_port_size:Vector2

func setup(_layer:CanvasLayer):
	layer_buttons = _layer
	menu_button = layer_buttons.get_node('MenuButton')
	_menu_setup()

func _menu_setup():
	layer_buttons.visible = true
	menu_button.text = ""
	menu_button.anchors_preset = Label.PRESET_CENTER
	menu_button.size = Vector2(1, menu_button.size.y)
	var _view_port_size = Commons.get_view_port_size()
	menu_button.position = Vector2(_view_port_size.x / 2, _view_port_size.y / 5)
	menu_button.add_theme_font_size_override("font_size", 30)
	menu_button.text = "メニュー"
	var _pop_up:PopupMenu = menu_button.get_popup()
	var _fv = Fonts.load_font()
	_pop_up.add_theme_font_override("font",_fv)

	var _callable:Callable = Callable(self, "_menu_click")
	_pop_up.connect("id_pressed", _callable)

func _menu_click(id):
	if id == 0 : # レベルアップ
		var _caller = Callable(GameLayer,"level_up")
		Commons.sleep(0.3, _caller)
		
	elif id == 1 : # 最初から
		GameLayer.set_level(GameLayer.Game_Undefined_Level)
		var _caller = Callable(GameLayer,"level_up")
		Commons.sleep(0.3, _caller)
	elif id == 2 : # 終了
		# 0.3 秒後に終了する
		var _caller = Callable(Commons,"close")
		Commons.sleep(0.3, _caller)

func hide():
	layer_buttons.hide()

func show():
	layer_buttons.show()
	
