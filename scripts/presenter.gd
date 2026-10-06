extends Node2D

const Rules = preload("res://scripts/rules.gd")
var rules = Rules.new()
var steps := 0
var fighting := false

@onready var fighter_a: ColorRect = $FighterA
@onready var fighter_b: ColorRect = $FighterB

func _ready() -> void:
	$SheetLens.make_current()
	fighter_a.visible = false
	fighter_b.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("stride_north"):
		rules.note_trek()
		if rules.may_fight():
			_go("res://scenes/fight.tscn")

func _show(outcome: String) -> void:
	fighter_a.color = Color(0.9, 0.3, 0.3) if rules.points_a > 0 else Color(0.3, 0.3, 0.3)
	fighter_b.color = Color(0.3, 0.4, 0.9) if rules.points_b > 0 else Color(0.3, 0.3, 0.3)
	if outcome == "win":
		fighter_a.visible = rules.points_a > 0
		fighter_b.visible = rules.points_b > 0

func _go(next_path: String) -> void:
	get_tree().change_scene_to_file(next_path)
