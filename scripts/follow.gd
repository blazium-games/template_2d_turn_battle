extends Node2D

const Rules = preload("res://scripts/rules.gd")
var rules = Rules.new()

func _ready() -> void:
	$SheetLens.make_current()
	rules.use_vial("a")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("primary"):
		rules.act(rules.side, "strike")
	elif event.is_action_pressed("leap"):
		rules.act(rules.side, "guard")
	elif event.is_action_pressed("stride_east"):
		rules.mend(rules.side)
	_paint()

func _paint() -> void:
	$FighterA.color = Color(0.9, 0.3, 0.3) if rules.points_a > 0 else Color(0.3, 0.3, 0.3)
	$FighterB.color = Color(0.3, 0.4, 0.9) if rules.points_b > 0 else Color(0.3, 0.3, 0.3)
