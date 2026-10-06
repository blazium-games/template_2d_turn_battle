extends RefCounted

var side := "a"
var points_a := 6
var points_b := 6

func act(who: String, kind: String) -> String:
	if who != side:
		return "skipped"
	if kind == "guard":
		_swap_side()
		return "guarded"
	if side == "a":
		points_b -= 2
	else:
		points_a -= 2
	if points_a <= 0 or points_b <= 0:
		return "win"
	_swap_side()
	return "struck"

func _swap_side() -> void:
	side = "b" if side == "a" else "a"

func reset_fight() -> void:
	side = "a"
	points_a = 6
	points_b = 6

var trek := 0

func note_trek() -> int:
	trek += 1
	return trek

func may_fight() -> bool:
	return trek >= 3

func use_vial(who: String) -> String:
	if who != "a":
		return "skipped"
	points_a = mini(points_a + 2, 8)
	return "healed"

func mend(who: String) -> String:
	if who != side:
		return "skipped"
	if side == "a":
		points_a = mini(points_a + 1, 8)
	else:
		points_b = mini(points_b + 1, 8)
	_swap_side()
	return "mended"
