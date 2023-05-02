extends Node

var view_port_size : Vector2
var main:Node2D

func set_main(_main:Node2D):
	#_level = Game_Undefined_Level
	main = _main

func set_view_port_size(_size:Vector2):
	view_port_size = _size

func get_view_port_size() -> Vector2:
	return view_port_size

# val1に含まれる val2の位置
# 先頭の場合 0
# 含まれない場合は -1
func find_str(val1:String, val2:String)->int:
	if val1 == null || val2 == null:
		return -1
	return val1.find(val2,0)

# 指定した秒数分スリープしたあとに与えたメソッドを実行する
func one_shot_timer(_sec: float, _method: Callable):
	if _sec > 0 :
		var _timer:Timer = Timer.new()
		add_child(_timer)
		_timer.wait_time = _sec
		_timer.one_shot = true
		_timer.start()
		await _timer.timeout # 指定した時間経過するまで停止する
		_timer.queue_free() # タイマーを消す
	_method.call()

func close():
	GameLayer.hide()
	Buttons.hide()
	Messages.hide()

func window_close():
	one_shot_timer(0.5, Callable(self,"close"))
	main.get_tree().quit() # Gameを終わる
