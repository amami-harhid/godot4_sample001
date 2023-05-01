extends Node

var layer_background:CanvasLayer

func setup(_layer:CanvasLayer):
	layer_background = _layer

func hide():
	layer_background.hide()

func show():
	layer_background.show()
