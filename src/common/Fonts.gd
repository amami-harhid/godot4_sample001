extends Node

const NicoMoji = "res://fonts/NicoMoji/NicoMoji-Regular.ttf"
func load_font() -> FontVariation:
	var _fv:FontVariation = FontVariation.new()
	var _font = load(NicoMoji)
	_fv.set_base_font(_font)
	_fv.set_variation_embolden(1)
	return _fv 
	
