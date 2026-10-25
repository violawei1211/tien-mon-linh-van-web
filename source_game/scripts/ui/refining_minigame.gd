extends Control

signal completed
signal cancelled
signal overheated

# Số món tinh luyện một lần (mỗi món thêm 0,5 giây); strict = Trung phẩm: quá nhiệt là hỏng mẻ.
var _qty: int = 1
var _strict: bool = false
var _overheat_time: float = 0.0

const UI_FONT: Font = preload("res://assets/template/fonts/mali_bold.tres")
const STORE_BACKGROUND: Texture2D = preload("res://assets/boutique/tu_tien_interior.png")
const COMMON_METER_SPEED: float = 2.0

const CATEGORY_PROFILES: Dictionary = {
	"Đan dược": {"hold_seconds": 1.5, "safe_zones": [Vector2(0.31, 0.69)]},
	"Pháp khí": {"hold_seconds": 1.5, "safe_zones": [Vector2(0.39, 0.61)]},
	"Trận đồ": {"hold_seconds": 1.5, "safe_zones": [Vector2(0.16, 0.34), Vector2(0.58, 0.77)]},
	"Phù triện": {"hold_seconds": 3.0, "safe_zones": [Vector2(0.18, 0.35), Vector2(0.59, 0.76)]},
	"Phi xa": {"hold_seconds": 3.0, "safe_zones": [Vector2(0.00, 0.30)]},
	"Linh thú": {"hold_seconds": 3.0, "safe_zones": [Vector2(0.69, 1.00)]},
}

class MeterTrack extends Control:
	var safe_zones: Array = []
	var marker_position: float = 0.0

	func set_profile(zones: Array) -> void:
		safe_zones = zones
		queue_redraw()

	func set_marker(value: float) -> void:
		marker_position = clampf(value, 0.0, 1.0)
		queue_redraw()

	func _draw() -> void:
		if size.x <= 0.0 or size.y <= 0.0:
			return
		var inner := Rect2(Vector2(8.0, 8.0), Vector2(maxf(0.0, size.x - 16.0), maxf(0.0, size.y - 16.0)))
		draw_rect(inner, Color("df6b79"), true)
		for zone in safe_zones:
			var from_x := 8.0 + clampf(float(zone.x), 0.0, 1.0) * inner.size.x
			var to_x := 8.0 + clampf(float(zone.y), 0.0, 1.0) * inner.size.x
			draw_rect(Rect2(from_x, inner.position.y, maxf(0.0, to_x - from_x), inner.size.y), Color("5ab88b"), true)
		draw_rect(Rect2(Vector2(3.0, 3.0), size - Vector2(6.0, 6.0)), Color("285b7a"), false, 3.0, true)
		var marker_x := marker_position * size.x
		draw_line(Vector2(marker_x, 5.0), Vector2(marker_x, size.y - 5.0), Color("fff4d4"), 4.0, true)
		draw_circle(Vector2(marker_x, size.y * 0.5), 15.0, Color("fff4d4"))
		draw_circle(Vector2(marker_x, size.y * 0.5), 10.5, Color("f2a13f"))
		draw_circle(Vector2(marker_x, size.y * 0.5), 4.0, Color("fff9df"))

class TimerRing extends Control:
	var progress: float = 1.0
	var total_seconds: float = 1.0
	var remaining_seconds: float = 1.0
	var countdown_label: Label

	func configure(total: float) -> void:
		custom_minimum_size = Vector2(148.0, 148.0)
		if countdown_label == null:
			countdown_label = Label.new()
			countdown_label.position = Vector2(6.0, 91.0)
			countdown_label.size = Vector2(136.0, 26.0)
			countdown_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			countdown_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
			countdown_label.add_theme_font_override("font", UI_FONT)
			countdown_label.add_theme_font_size_override("font_size", 12)
			countdown_label.add_theme_color_override("font_color", Color("285b7a"))
			countdown_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
			add_child(countdown_label)
		set_remaining(total, total)

	func set_remaining(remaining: float, total: float) -> void:
		total_seconds = maxf(0.01, total)
		remaining_seconds = clampf(remaining, 0.0, total_seconds)
		progress = remaining_seconds / total_seconds
		if countdown_label != null:
			countdown_label.text = "CÒN %d GIÂY" % ceili(remaining_seconds)
		queue_redraw()

	func _draw() -> void:
		if size.x <= 0.0 or size.y <= 0.0:
			return
		var center := size * 0.5
		var radius := minf(size.x, size.y) * 0.43
		draw_arc(center, radius, 0.0, TAU, 64, Color("c9e8ec"), 9.0, true)
		if progress > 0.0:
			draw_arc(center, radius, -PI * 0.5, -PI * 0.5 + TAU * progress, 64, Color("50b887"), 9.0, true)
		var top_left := center + Vector2(-12.0, -37.0)
		var top_right := center + Vector2(12.0, -37.0)
		var waist := center
		var bottom_left := center + Vector2(-12.0, 20.0)
		var bottom_right := center + Vector2(12.0, 20.0)
		var outline := Color("285b7a")
		var sand := Color("e9a342")
		draw_line(top_left, top_right, outline, 3.0, true)
		draw_line(top_left, waist, outline, 3.0, true)
		draw_line(top_right, waist, outline, 3.0, true)
		draw_line(waist, bottom_left, outline, 3.0, true)
		draw_line(waist, bottom_right, outline, 3.0, true)
		draw_line(bottom_left, bottom_right, outline, 3.0, true)
		draw_colored_polygon(PackedVector2Array([center + Vector2(-7.0, -30.0), center + Vector2(7.0, -30.0), center + Vector2(0.0, -8.0)]), sand)
		draw_colored_polygon(PackedVector2Array([center + Vector2(-8.0, 14.0), center + Vector2(8.0, 14.0), center + Vector2(0.0, 3.0)]), sand)

var _product: Dictionary = {}
var _category: String = "Đan dược"
var _refining_grade: String = "Hạ phẩm"
var _profile: Dictionary = {}
var _duration: float = 2.0
var _remaining: float = 2.0
var _speed: float = COMMON_METER_SPEED
var _safe_zones: Array = []
var _marker_position: float = 0.02
var _marker_direction: float = 1.0
var _holding: bool = false
var _finished: bool = false
var _day_number: int = 1
var _level_number: int = 1
var _store_title: String = "TIÊN MÔN LINH VẬN"

var _track: MeterTrack
var _timer_ring: TimerRing
var _status_label: Label
var _hold_button: Button

static func _profile_category_key(category: String) -> String:
	var normalized: String = category.strip_edges().to_lower()
	if normalized == "đan dược": return "Đan dược"
	if normalized == "pháp khí": return "Pháp khí"
	if normalized == "trận đồ": return "Trận đồ"
	if normalized == "phù triện": return "Phù triện"
	if normalized == "phi xa" or normalized == "phi xa/sí": return "Phi xa"
	if normalized == "linh thú": return "Linh thú"
	return "Đan dược"

static func profile_for_category(category: String) -> Dictionary:
	var key: String = _profile_category_key(category)
	var profile: Dictionary = (CATEGORY_PROFILES[key] as Dictionary).duplicate(true)
	profile["speed"] = COMMON_METER_SPEED
	return profile

func configure(product: Dictionary, day: int = 1, current_level: int = 1, title: String = "TIÊN MÔN LINH VẬN", qty: int = 1, strict: bool = false) -> void:
	_qty = maxi(1, qty)
	_strict = strict
	_product = product.duplicate(true)
	_refining_grade = str(_product.get("refining_grade", _product.get("grade", "Hạ phẩm"))).strip_edges()
	if _refining_grade.is_empty():
		_refining_grade = "Hạ phẩm"
	_category = str(_product.get("refining_category", _product.get("category", "Đan dược"))).strip_edges()
	_profile = profile_for_category(_category)
	_duration = float(_profile.get("hold_seconds", 2.0)) + 0.5 * float(_qty - 1)
	_remaining = _duration
	_speed = COMMON_METER_SPEED
	_safe_zones = _profile.get("safe_zones", [])
	_day_number = maxi(1, day)
	_level_number = maxi(1, current_level)
	_store_title = title.strip_edges() if not title.strip_edges().is_empty() else "TIÊN MÔN LINH VẬN"
	_build_ui()

# Phòng tinh luyện riêng: vạch chạy chậm hơn theo bậc nâng cấp.
func set_ease(tier: int) -> void:
	_speed = COMMON_METER_SPEED * (1.0 - 0.15 * clampi(tier, 0, 3))

func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	set_process(true)

func _process(delta: float) -> void:
	if _finished:
		return
	if _holding:
		if _is_marker_safe():
			_overheat_time = 0.0
			_remaining = maxf(0.0, _remaining - delta)
			_status_label.text = "AN TOÀN · Tiếp tục giữ vạch trong vùng xanh."
		else:
			_status_label.text = "QUÁ NHIỆT · Thả tay, chờ vạch vào vùng xanh."
			if _strict:
				_overheat_time += delta
				if _overheat_time >= 0.25:
					_finished = true
					_holding = false
					_hold_button.disabled = true
					_status_label.text = "QUÁ NHIỆT · Mẻ tinh luyện đã hỏng!"
					overheated.emit()
					return
	else:
		_marker_position += _marker_direction * _speed * delta
		if _marker_position >= 1.0:
			_marker_position = 1.0
			_marker_direction = -1.0
		elif _marker_position <= 0.0:
			_marker_position = 0.0
			_marker_direction = 1.0
	_track.set_marker(_marker_position)
	_timer_ring.set_remaining(_remaining, _duration)
	if _remaining <= 0.0:
		_complete_refining()

func _is_marker_safe() -> bool:
	for zone in _safe_zones:
		if _marker_position >= float(zone.x) and _marker_position <= float(zone.y):
			return true
	return false

func _build_ui() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP

	var backdrop := TextureRect.new()
	backdrop.texture = STORE_BACKGROUND
	backdrop.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	backdrop.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	backdrop.mouse_filter = Control.MOUSE_FILTER_IGNORE
	backdrop.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(backdrop)

	var veil := ColorRect.new()
	veil.color = Color(0.84, 0.93, 0.98, 0.48)
	veil.mouse_filter = Control.MOUSE_FILTER_STOP
	veil.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(veil)

	var center := CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	center.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(center)

	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(510.0, 930.0)
	var panel_style := _style_box(Color("f7fbff"), Color("80c6df"), 4, 30)
	panel_style.shadow_color = Color(0.20, 0.42, 0.55, 0.16)
	panel_style.shadow_size = 8
	panel.add_theme_stylebox_override("panel", panel_style)
	center.add_child(panel)

	var margins := MarginContainer.new()
	for side in ["left", "right"]:
		margins.add_theme_constant_override("margin_%s" % side, 20)
	for side in ["top", "bottom"]:
		margins.add_theme_constant_override("margin_%s" % side, 16)
	panel.add_child(margins)

	var body := VBoxContainer.new()
	body.add_theme_constant_override("separation", 5)
	body.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	body.size_flags_vertical = Control.SIZE_EXPAND_FILL
	margins.add_child(body)

	var header := HBoxContainer.new()
	header.custom_minimum_size = Vector2(0.0, 36.0)
	header.add_theme_constant_override("separation", 8)
	var header_title := _make_label("%s  ·  NGÀY %d" % [_store_title.to_upper(), _day_number], 13, Color("285b7a"))
	header_title.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	header_title.clip_text = true
	header.add_child(header_title)
	header.add_child(_make_badge("LV %d" % _level_number, Color("fff1f7"), Color("e4a0bd"), Color("c65b8c"), 13, Vector2(68.0, 32.0)))
	body.add_child(header)

	var title := _make_label("TINH LUYỆN", 30, Color("285b7a"), HORIZONTAL_ALIGNMENT_CENTER)
	title.custom_minimum_size = Vector2(0.0, 42.0)
	body.add_child(title)

	var grade_center := CenterContainer.new()
	grade_center.custom_minimum_size = Vector2(0.0, 36.0)
	grade_center.mouse_filter = Control.MOUSE_FILTER_IGNORE
	grade_center.add_child(_make_badge(_refining_grade.to_upper(), Color("fff0f6"), Color("e79abb"), Color("c65083"), 16, Vector2(176.0, 34.0)))
	body.add_child(grade_center)

	var product_name := ("%d× " % _qty if _qty > 1 else "") + str(_product.get("name", "Vật phẩm"))
	var item_line := _make_label("%s  ·  %s" % [_category.to_upper(), product_name], 14, Color("36556b"), HORIZONTAL_ALIGNMENT_CENTER)
	item_line.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	item_line.custom_minimum_size = Vector2(0.0, 34.0)
	body.add_child(item_line)

	var hero_frame := PanelContainer.new()
	hero_frame.custom_minimum_size = Vector2(0.0, 170.0)
	hero_frame.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hero_frame.add_theme_stylebox_override("panel", _style_box(Color("eaf6fc"), Color("b3dce9"), 2, 26))
	body.add_child(hero_frame)

	var hero_content := Control.new()
	hero_content.custom_minimum_size = Vector2(0.0, 156.0)
	hero_content.clip_contents = true
	hero_frame.add_child(hero_content)
	var hero_background := TextureRect.new()
	hero_background.texture = STORE_BACKGROUND
	hero_background.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	hero_background.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	hero_background.modulate = Color(0.94, 0.98, 1.0, 0.72)
	hero_background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	hero_background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	hero_content.add_child(hero_background)
	var hero_veil := ColorRect.new()
	hero_veil.color = Color(0.91, 0.97, 1.0, 0.42)
	hero_veil.mouse_filter = Control.MOUSE_FILTER_IGNORE
	hero_veil.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	hero_content.add_child(hero_veil)
	var hero_center := CenterContainer.new()
	hero_center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	hero_center.mouse_filter = Control.MOUSE_FILTER_IGNORE
	hero_content.add_child(hero_center)
	var icon_frame := PanelContainer.new()
	icon_frame.custom_minimum_size = Vector2(150.0, 150.0)
	icon_frame.add_theme_stylebox_override("panel", _style_box(Color("f8fdff"), Color("80c6df"), 3, 75))
	hero_center.add_child(icon_frame)
	var hero_icon := TextureRect.new()
	hero_icon.texture = _load_product_texture()
	hero_icon.custom_minimum_size = Vector2(132.0, 132.0)
	hero_icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	hero_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	hero_icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	icon_frame.add_child(hero_icon)

	var track_frame := PanelContainer.new()
	track_frame.custom_minimum_size = Vector2(0.0, 86.0)
	track_frame.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	track_frame.add_theme_stylebox_override("panel", _style_box(Color("eef9fc"), Color("78bfd8"), 3, 24))
	body.add_child(track_frame)
	var track_margins := MarginContainer.new()
	for side in ["left", "right", "top", "bottom"]:
		track_margins.add_theme_constant_override("margin_%s" % side, 6)
	track_frame.add_child(track_margins)
	_track = MeterTrack.new()
	_track.custom_minimum_size = Vector2(0.0, 58.0)
	_track.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_track.set_profile(_safe_zones)
	_track.set_marker(_marker_position)
	track_margins.add_child(_track)

	var zone_labels := HBoxContainer.new()
	zone_labels.add_theme_constant_override("separation", 5)
	var hot_left := _make_label("QUÁ NHIỆT", 12, Color("c74f69"), HORIZONTAL_ALIGNMENT_LEFT)
	hot_left.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	var safe_label := _make_label("AN TOÀN", 12, Color("378d69"), HORIZONTAL_ALIGNMENT_CENTER)
	safe_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	var hot_right := _make_label("QUÁ NHIỆT", 12, Color("c74f69"), HORIZONTAL_ALIGNMENT_RIGHT)
	hot_right.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	zone_labels.add_child(hot_left)
	zone_labels.add_child(safe_label)
	zone_labels.add_child(hot_right)
	body.add_child(zone_labels)

	var instruction_frame := PanelContainer.new()
	instruction_frame.custom_minimum_size = Vector2(0.0, 44.0)
	instruction_frame.add_theme_stylebox_override("panel", _style_box(Color("f1faff"), Color("a9d8e8"), 2, 22))
	var instruction := _make_label(("GIỮ VÙNG AN TOÀN %s GIÂY" % String.num(_duration, 1).replace(".", ",")) + (" · QUÁ NHIỆT LÀ HỎNG MẺ" if _strict else ""), 15, Color("285b7a"), HORIZONTAL_ALIGNMENT_CENTER)
	instruction_frame.add_child(instruction)
	body.add_child(instruction_frame)

	_hold_button = Button.new()
	_hold_button.text = "CHẠM ĐỂ GIỮ"
	_hold_button.custom_minimum_size = Vector2(0.0, 76.0)
	_hold_button.add_theme_font_override("font", UI_FONT)
	_hold_button.add_theme_font_size_override("font_size", 22)
	_hold_button.add_theme_color_override("font_color", Color("ffffff"))
	_hold_button.add_theme_stylebox_override("normal", _style_box(Color("e98db4"), Color("d979a6"), 3, 28))
	_hold_button.add_theme_stylebox_override("hover", _style_box(Color("dd79a4"), Color("c96493"), 3, 28))
	_hold_button.add_theme_stylebox_override("pressed", _style_box(Color("c96493"), Color("b85383"), 3, 28))
	_hold_button.button_down.connect(_on_hold_button_down)
	_hold_button.button_up.connect(_on_hold_button_up)
	body.add_child(_hold_button)

	_status_label = _make_label("Chạm giữ khi vạch nằm trong vùng xanh.", 12, Color("3f86aa"), HORIZONTAL_ALIGNMENT_CENTER)
	_status_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_status_label.custom_minimum_size = Vector2(0.0, 34.0)
	body.add_child(_status_label)

	var ring_center := CenterContainer.new()
	ring_center.custom_minimum_size = Vector2(0.0, 148.0)
	ring_center.size_flags_vertical = Control.SIZE_EXPAND_FILL
	ring_center.mouse_filter = Control.MOUSE_FILTER_IGNORE
	body.add_child(ring_center)
	_timer_ring = TimerRing.new()
	_timer_ring.configure(_duration)
	ring_center.add_child(_timer_ring)

	var cancel_button := Button.new()
	cancel_button.text = "HỦY"
	cancel_button.custom_minimum_size = Vector2(0.0, 48.0)
	cancel_button.add_theme_font_override("font", UI_FONT)
	cancel_button.add_theme_font_size_override("font_size", 17)
	cancel_button.add_theme_color_override("font_color", Color("285b7a"))
	cancel_button.add_theme_stylebox_override("normal", _style_box(Color("f4fbff"), Color("8bc5e8"), 2, 20))
	cancel_button.add_theme_stylebox_override("hover", _style_box(Color("e5f5ff"), Color("d979a6"), 2, 20))
	cancel_button.pressed.connect(_cancel_refining)
	body.add_child(cancel_button)

func _load_product_texture() -> Texture2D:
	var image_path := str(_product.get("image", ""))
	if image_path.is_empty():
		return null
	return load(image_path) as Texture2D

func _make_badge(text: String, background: Color, border: Color, text_color: Color, font_size: int, minimum_size: Vector2) -> PanelContainer:
	var badge := PanelContainer.new()
	badge.custom_minimum_size = minimum_size
	badge.add_theme_stylebox_override("panel", _style_box(background, border, 2, int(minimum_size.y * 0.5)))
	var label := _make_label(text, font_size, text_color, HORIZONTAL_ALIGNMENT_CENTER)
	badge.add_child(label)
	return badge

func _make_label(text: String, font_size: int, color: Color, alignment: HorizontalAlignment = HORIZONTAL_ALIGNMENT_LEFT) -> Label:
	var label := Label.new()
	label.text = text
	label.add_theme_font_override("font", UI_FONT)
	label.add_theme_font_size_override("font_size", font_size)
	label.add_theme_color_override("font_color", color)
	label.horizontal_alignment = alignment
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	return label

func _style_box(background: Color, border: Color, border_width: int, radius: int) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = background
	style.border_color = border
	style.set_border_width_all(border_width)
	style.set_corner_radius_all(radius)
	style.content_margin_left = 10.0
	style.content_margin_right = 10.0
	style.content_margin_top = 6.0
	style.content_margin_bottom = 6.0
	return style

func _on_hold_button_down() -> void:
	if _finished:
		return
	_holding = true
	if not _is_marker_safe():
		_status_label.text = "QUÁ NHIỆT · Thả tay, chờ vạch vào vùng xanh."

func _on_hold_button_up() -> void:
	_holding = false
	if not _finished:
		_status_label.text = "Chạm giữ khi vạch nằm trong vùng xanh."

func _complete_refining() -> void:
	if _finished:
		return
	_finished = true
	_holding = false
	_hold_button.disabled = true
	_status_label.text = "Tinh luyện thành công!"
	completed.emit()

func _cancel_refining() -> void:
	if _finished:
		return
	_finished = true
	cancelled.emit()
