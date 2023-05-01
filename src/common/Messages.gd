extends Node


var layer_message:CanvasLayer
var label_message:Label
var _view_port_size:Vector2

func setup(_layer:CanvasLayer):
	layer_message = _layer
	label_message = layer_message.get_node('LabelMessage')
	_view_port_size = layer_message.get_viewport().get_window().size
	print(_view_port_size)
	_message_setup()

func _message_setup():
	layer_message.visible = true
	label_message.text = ""
	label_message.anchors_preset = Label.PRESET_CENTER
	label_message.size = Vector2(1, label_message.size.y)
	label_message.position = _view_port_size / 2
	label_message.add_theme_font_size_override("font_size",80)

const Game_Clear = "ゲームクリア(%02d)"
func createMessage(_level:int):
	_text(Game_Clear%_level)
	
func _text(_message:String):
	label_message.text = _message

func show():
	layer_message.show()

func hide():
	layer_message.hide()
