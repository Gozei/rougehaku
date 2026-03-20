extends Node2D

const VIEW_SIZE := Vector2(640.0, 360.0)

const SKY_TOP := Color("2a2238")
const SKY_BOTTOM := Color("4f4a77")
const SUN_COLOR := Color("e9b889")
const DUNE_BACK := Color("8d7ea8")
const DUNE_MID := Color("b49fc5")
const SAND_LIGHT := Color("e8c19d")
const SAND_DARK := Color("d59e78")
const STONE := Color("66506f")
const STONE_LIGHT := Color("9588b8")
const ACCENT_TEAL := Color("74d7c9")
const ACCENT_PURPLE := Color("8f74d4")
const BANNER := Color("e36d5d")
const BANNER_SHADOW := Color("bc4e50")
const PLANT := Color("53a89a")
const PLANT_SHADOW := Color("3c6f6b")

var time_passed := 0.0
var dust_phase := 0.0


func _ready() -> void:
	queue_redraw()


func _process(delta: float) -> void:
	time_passed += delta
	dust_phase += delta * 16.0
	queue_redraw()


func _draw() -> void:
	_draw_sky()
	_draw_sun()
	_draw_dunes()
	_draw_ruins()
	_draw_ground()
	_draw_props()
	_draw_dust()


func _draw_sky() -> void:
	draw_rect(Rect2(Vector2.ZERO, Vector2(VIEW_SIZE.x, VIEW_SIZE.y * 0.45)), SKY_TOP, true)
	draw_rect(Rect2(Vector2(0.0, VIEW_SIZE.y * 0.45), Vector2(VIEW_SIZE.x, VIEW_SIZE.y * 0.18)), SKY_BOTTOM, true)
	draw_rect(Rect2(Vector2(0.0, VIEW_SIZE.y * 0.63), Vector2(VIEW_SIZE.x, VIEW_SIZE.y * 0.37)), DUNE_BACK.darkened(0.18), true)


func _draw_sun() -> void:
	draw_circle(Vector2(488.0, 78.0), 32.0, SUN_COLOR)
	draw_circle(Vector2(488.0, 78.0), 22.0, SUN_COLOR.lightened(0.12))
	for ring in range(3):
		var radius := 40.0 + ring * 11.0
		draw_arc(Vector2(488.0, 78.0), radius, 0.0, TAU, 40, SUN_COLOR.darkened(0.18), 1.5)


func _draw_dunes() -> void:
	var back_dune := PackedVector2Array([
		Vector2(0.0, 202.0),
		Vector2(72.0, 182.0),
		Vector2(148.0, 194.0),
		Vector2(216.0, 166.0),
		Vector2(316.0, 188.0),
		Vector2(398.0, 152.0),
		Vector2(488.0, 183.0),
		Vector2(640.0, 160.0),
		Vector2(640.0, 260.0),
		Vector2(0.0, 260.0),
	])
	var front_dune := PackedVector2Array([
		Vector2(0.0, 238.0),
		Vector2(92.0, 215.0),
		Vector2(164.0, 229.0),
		Vector2(252.0, 202.0),
		Vector2(330.0, 220.0),
		Vector2(448.0, 196.0),
		Vector2(548.0, 214.0),
		Vector2(640.0, 204.0),
		Vector2(640.0, 300.0),
		Vector2(0.0, 300.0),
	])
	draw_colored_polygon(back_dune, DUNE_BACK)
	draw_colored_polygon(front_dune, DUNE_MID)


func _draw_ruins() -> void:
	var temple_base := Rect2(Vector2(208.0, 135.0), Vector2(214.0, 118.0))
	draw_rect(temple_base, STONE, true)
	draw_rect(Rect2(Vector2(196.0, 248.0), Vector2(238.0, 18.0)), STONE, true)
	draw_rect(Rect2(Vector2(224.0, 120.0), Vector2(182.0, 18.0)), STONE_LIGHT, true)
	draw_rect(Rect2(Vector2(248.0, 104.0), Vector2(134.0, 12.0)), STONE_LIGHT, true)

	for x in [232.0, 274.0, 316.0, 358.0]:
		draw_rect(Rect2(Vector2(x, 150.0), Vector2(18.0, 98.0)), STONE_LIGHT, true)
		draw_rect(Rect2(Vector2(x + 4.0, 154.0), Vector2(10.0, 90.0)), STONE, true)
		draw_rect(Rect2(Vector2(x - 4.0, 146.0), Vector2(26.0, 8.0)), STONE_LIGHT.lightened(0.08), true)

	var door := Rect2(Vector2(292.0, 176.0), Vector2(46.0, 72.0))
	draw_rect(door, STONE.darkened(0.28), true)
	draw_rect(Rect2(Vector2(286.0, 170.0), Vector2(58.0, 8.0)), STONE_LIGHT, true)
	draw_circle(Vector2(315.0, 208.0), 4.0, ACCENT_TEAL)
	draw_rect(Rect2(Vector2(309.0, 188.0), Vector2(12.0, 18.0)), ACCENT_TEAL.darkened(0.25), true)

	var sway := sin(time_passed * 1.8) * 4.0
	_draw_banner(Vector2(228.0, 138.0), 24.0, 46.0, sway)
	_draw_banner(Vector2(378.0, 138.0), 24.0, 46.0, -sway * 0.8)
	_draw_banner(Vector2(305.0, 116.0), 18.0, 38.0, sway * 0.6)

	draw_rect(Rect2(Vector2(180.0, 166.0), Vector2(18.0, 84.0)), STONE, true)
	draw_rect(Rect2(Vector2(430.0, 176.0), Vector2(18.0, 76.0)), STONE, true)
	draw_rect(Rect2(Vector2(170.0, 158.0), Vector2(36.0, 10.0)), STONE_LIGHT, true)
	draw_rect(Rect2(Vector2(422.0, 168.0), Vector2(34.0, 10.0)), STONE_LIGHT, true)
	draw_circle(Vector2(189.0, 154.0), 7.0, ACCENT_PURPLE)
	draw_circle(Vector2(439.0, 165.0), 7.0, ACCENT_TEAL)
	draw_circle(Vector2(189.0, 154.0), 3.0, STONE_LIGHT.lightened(0.2))
	draw_circle(Vector2(439.0, 165.0), 3.0, STONE_LIGHT.lightened(0.2))


func _draw_banner(anchor: Vector2, width: float, height: float, sway: float) -> void:
	draw_rect(Rect2(anchor, Vector2(width, 4.0)), BANNER_SHADOW, true)
	var points := PackedVector2Array([
		anchor + Vector2(2.0, 4.0),
		anchor + Vector2(width - 2.0, 4.0),
		anchor + Vector2(width - 4.0 + sway, height - 4.0),
		anchor + Vector2(width * 0.5 + sway * 0.5, height + 4.0),
		anchor + Vector2(4.0 + sway, height - 2.0),
	])
	draw_colored_polygon(points, BANNER)
	draw_line(anchor + Vector2(width * 0.5, 4.0), anchor + Vector2(width * 0.5 + sway * 0.4, height - 4.0), BANNER_SHADOW, 2.0)


func _draw_ground() -> void:
	draw_rect(Rect2(Vector2(0.0, 260.0), Vector2(VIEW_SIZE.x, 100.0)), SAND_DARK, true)
	draw_rect(Rect2(Vector2(0.0, 286.0), Vector2(VIEW_SIZE.x, 74.0)), SAND_LIGHT, true)

	var path := PackedVector2Array([
		Vector2(232.0, 252.0),
		Vector2(405.0, 252.0),
		Vector2(454.0, 360.0),
		Vector2(180.0, 360.0),
	])
	draw_colored_polygon(path, SAND_LIGHT.lightened(0.08))

	for x in [64.0, 108.0, 152.0, 486.0, 530.0, 574.0]:
		draw_rect(Rect2(Vector2(x, 270.0), Vector2(18.0, 54.0)), STONE_LIGHT, true)
		draw_rect(Rect2(Vector2(x + 4.0, 274.0), Vector2(10.0, 46.0)), STONE, true)


func _draw_props() -> void:
	_draw_cactus(Vector2(108.0, 270.0), 1.0)
	_draw_cactus(Vector2(540.0, 284.0), 0.85)
	_draw_shrub(Vector2(146.0, 315.0), 18.0, ACCENT_TEAL)
	_draw_shrub(Vector2(482.0, 322.0), 16.0, ACCENT_PURPLE)
	_draw_shrub(Vector2(584.0, 336.0), 14.0, ACCENT_TEAL)
	_draw_bones(Vector2(86.0, 336.0))
	_draw_bones(Vector2(518.0, 344.0))
	_draw_sign(Vector2(82.0, 246.0), "RUINS")
	_draw_sign(Vector2(552.0, 256.0), "OASIS")
	_draw_crystals(Vector2(244.0, 330.0))
	_draw_crystals(Vector2(404.0, 324.0))


func _draw_cactus(base: Vector2, scale: float) -> void:
	var body_color := PLANT
	var shade := PLANT_SHADOW
	draw_rect(Rect2(base + Vector2(-6.0, -46.0) * scale, Vector2(12.0, 46.0) * scale), body_color, true)
	draw_rect(Rect2(base + Vector2(-18.0, -30.0) * scale, Vector2(8.0, 22.0) * scale), body_color, true)
	draw_rect(Rect2(base + Vector2(10.0, -24.0) * scale, Vector2(8.0, 18.0) * scale), body_color, true)
	draw_rect(Rect2(base + Vector2(-4.0, -46.0) * scale, Vector2(4.0, 46.0) * scale), shade, true)
	draw_circle(base + Vector2(0.0, -46.0) * scale, 6.0 * scale, body_color)
	draw_circle(base + Vector2(-14.0, -30.0) * scale, 4.0 * scale, body_color)
	draw_circle(base + Vector2(14.0, -24.0) * scale, 4.0 * scale, body_color)
	draw_circle(base + Vector2(0.0, -46.0) * scale, 2.5 * scale, ACCENT_TEAL.lightened(0.18))


func _draw_shrub(center: Vector2, radius: float, color: Color) -> void:
	draw_circle(center + Vector2(-radius * 0.7, 0.0), radius * 0.65, color.darkened(0.15))
	draw_circle(center + Vector2(radius * 0.7, 0.0), radius * 0.65, color.darkened(0.15))
	draw_circle(center + Vector2(0.0, -radius * 0.4), radius * 0.8, color)
	draw_circle(center + Vector2(0.0, radius * 0.15), radius * 0.9, color)


func _draw_bones(origin: Vector2) -> void:
	draw_circle(origin, 6.0, SAND_LIGHT.lightened(0.12))
	draw_circle(origin + Vector2(16.0, 0.0), 6.0, SAND_LIGHT.lightened(0.12))
	draw_rect(Rect2(origin + Vector2(0.0, -3.0), Vector2(16.0, 6.0)), SAND_LIGHT.lightened(0.12), true)
	draw_circle(origin + Vector2(28.0, -4.0), 4.0, SAND_LIGHT.lightened(0.12))
	draw_circle(origin + Vector2(40.0, -4.0), 4.0, SAND_LIGHT.lightened(0.12))
	draw_rect(Rect2(origin + Vector2(28.0, -6.0), Vector2(12.0, 4.0)), SAND_LIGHT.lightened(0.12), true)


func _draw_sign(position: Vector2, text: String) -> void:
	draw_rect(Rect2(position, Vector2(4.0, 38.0)), STONE, true)
	draw_rect(Rect2(position + Vector2(-18.0, -4.0), Vector2(40.0, 18.0)), STONE_LIGHT, true)
	draw_rect(Rect2(position + Vector2(-14.0, 0.0), Vector2(32.0, 10.0)), BANNER, true)
	var font := ThemeDB.fallback_font
	if font != null:
		draw_string(font, position + Vector2(-12.0, 8.0), text, HORIZONTAL_ALIGNMENT_LEFT, 30.0, 10, STONE.darkened(0.3))


func _draw_crystals(center: Vector2) -> void:
	var crystal_color := ACCENT_TEAL if int(center.x) % 2 == 0 else ACCENT_PURPLE
	var left := PackedVector2Array([
		center + Vector2(-10.0, 8.0),
		center + Vector2(-4.0, -12.0),
		center + Vector2(2.0, 8.0),
	])
	var right := PackedVector2Array([
		center + Vector2(4.0, 10.0),
		center + Vector2(10.0, -8.0),
		center + Vector2(16.0, 10.0),
	])
	draw_colored_polygon(left, crystal_color)
	draw_colored_polygon(right, crystal_color.lightened(0.1))


func _draw_dust() -> void:
	for i in range(7):
		var fi := float(i)
		var x := fmod(40.0 + dust_phase * (10.0 + fi * 2.0) + fi * 96.0, VIEW_SIZE.x + 48.0) - 24.0
		var y := 298.0 + sin(time_passed * 1.2 + fi) * 10.0 + fi * 7.0
		draw_circle(Vector2(x, y), 2.0 + fmod(fi, 3.0), SAND_LIGHT.lightened(0.18))
