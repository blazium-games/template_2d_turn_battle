extends AutoworkTest

const Rules = preload("res://scripts/rules.gd")

func test_turn_order_and_skip() -> void:
	var rules = Rules.new()
	assert_eq(rules.act("b", "strike"), "skipped", "not their turn")
	assert_eq(rules.act("a", "guard"), "guarded", "guard swaps")
	assert_eq(rules.side, "b", "now b")

func test_win() -> void:
	var rules = Rules.new()
	var last := ""
	for _i in 6:
		last = rules.act(rules.side, "strike")
	assert_eq(last, "win", "points gone")

func test_fight_gate_and_mend() -> void:
	var rules = Rules.new()
	assert_false(rules.may_fight(), "too early")
	rules.note_trek()
	rules.note_trek()
	rules.note_trek()
	assert_true(rules.may_fight(), "third step")
	assert_eq(rules.mend("b"), "skipped", "other side")
	assert_eq(rules.mend("a"), "mended", "own side")
	assert_eq(rules.points_a, 7, "healed")
	assert_true(load("res://scenes/fight.tscn") != null, "fight loads")

func test_use_vial() -> void:
	var rules = Rules.new()
	assert_eq(rules.use_vial("b"), "skipped", "other side")
	assert_eq(rules.use_vial("a"), "healed", "your side")
	assert_eq(rules.points_a, 8, "healed once")
