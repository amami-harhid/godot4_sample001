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
	Commons.set_main(self)
	Commons.set_view_port_size(view_port_size)
	Background.setup(layer_background)
	Messages.setup(layer_message)
	Buttons.setup(layer_buttons)
	GameLayer.setup(layer_games)
	GameLayer.load_game()
	Player.setup(player)

func _process(delta):
	Player.player_move()
	pass

