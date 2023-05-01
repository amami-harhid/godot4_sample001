extends Node2D

# ---------------------------------------
# onready.
# ---------------------------------------
# キャンバスレイヤー.
@onready var layer_background : CanvasLayer = $LayerBackground
@onready var layer_games : CanvasLayer = $LayerGames
@onready var layer_player: CanvasLayer = $LayerPlayer
@onready var player:Sprite2D = $LayerPlayer/PlayerSprite2D
@onready var layer_message : CanvasLayer = $LayerMessage
@onready var layer_buttons : CanvasLayer = $LayerButtons

# メッセージラベル.
@onready var label_message : Label = $LayerMessage/LabelMessage
@onready var menu_button : MenuButton = $LayerButtons/MenuButton
# ビューポートサイズ
@onready var view_port_size :Vector2 = self.get_viewport_rect().size

# ---------------------------------------
# 変数.
# ---------------------------------------
# ゲームレベル
#var _level = 1

func _ready():
	Commons.init(self)
	Commons.set_view_port_size(view_port_size)
	Commons.set_layer_background(layer_background)
	Commons.set_layer_games(layer_games)
	Commons.set_layer_message(layer_message)
	Commons.set_layer_buttons(layer_buttons)
	Commons.load_game()
	Player.setup(player)

func _process(delta):
	
	pass

