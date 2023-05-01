extends Node


var layer_message:CanvasLayer
var label_message:Label
var _view_port_size:Vector2

func set_layer_message(_layer:CanvasLayer):
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

func text(_message:String):
	label_message.text = _message
