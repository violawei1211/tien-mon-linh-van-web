extends PanelContainer

# Bàn phím ảo vẽ trong màn hình game. Ô chữ gõ kiểu Telex (như Unikey/VietKey):
# s sắc · f huyền · r hỏi · x ngã · j nặng · z bỏ dấu · aa â · ee ê · oo ô · aw ă · ow ơ · uw ư · w ư · dd đ.

const KEY_FONT: Font = preload("res://assets/template/fonts/mali_bold.tres")
const ICON_SHIFT: Texture2D = preload("res://assets/boutique/ui_icons/kb_shift.png")
const ICON_SHIFT_ON: Texture2D = preload("res://assets/boutique/ui_icons/kb_shift_on.png")
const ICON_CAPS: Texture2D = preload("res://assets/boutique/ui_icons/kb_caps.png")
const ICON_BACKSPACE: Texture2D = preload("res://assets/boutique/ui_icons/kb_backspace.png")
const ICON_ENTER: Texture2D = preload("res://assets/boutique/ui_icons/kb_enter.png")

const KEY_HEIGHT: = 50
const LETTER_FONT: = 22
const DIGIT_FONT: = 26
const SPECIAL_FONT: = 16

# Nguyên âm gốc -> [không dấu, sắc, huyền, hỏi, ngã, nặng]
const TONES: Dictionary = {
	"a": ["a", "á", "à", "ả", "ã", "ạ"], "ă": ["ă", "ắ", "ằ", "ẳ", "ẵ", "ặ"], "â": ["â", "ấ", "ầ", "ẩ", "ẫ", "ậ"],
	"e": ["e", "é", "è", "ẻ", "ẽ", "ẹ"], "ê": ["ê", "ế", "ề", "ể", "ễ", "ệ"],
	"i": ["i", "í", "ì", "ỉ", "ĩ", "ị"],
	"o": ["o", "ó", "ò", "ỏ", "õ", "ọ"], "ô": ["ô", "ố", "ồ", "ổ", "ỗ", "ộ"], "ơ": ["ơ", "ớ", "ờ", "ở", "ỡ", "ợ"],
	"u": ["u", "ú", "ù", "ủ", "ũ", "ụ"], "ư": ["ư", "ứ", "ừ", "ử", "ữ", "ự"],
	"y": ["y", "ý", "ỳ", "ỷ", "ỹ", "ỵ"],
}
const TONE_KEYS: Dictionary = {"s": 1, "f": 2, "r": 3, "x": 4, "j": 5}
const MARKED_VOWELS: = "ăâêôơư"

var _target: LineEdit
var _numeric: bool = false
var _telex_on: bool = true
var _submit_on_done: bool = false
var _title: String = ""
var _shift: bool = true
var _caps: bool = false
var _last_shift_msec: int = -1000
var _symbols: bool = false
var _replace_on_first_key: bool = false
var _fresh_open: bool = false
var _heading: Label
var _preview: Label
var _keys: VBoxContainer
var _last_pointer_press_msec: int = -1000
var _base_lookup: Dictionary = {}

func _ready() -> void:
	for base in TONES:
		var forms: Array = TONES[base]
		for t in range(forms.size()):
			_base_lookup[forms[t]] = [base, t]
	set_anchors_and_offsets_preset(Control.PRESET_BOTTOM_WIDE)
	offset_left = 4
	offset_right = -4
	offset_top = -340
	offset_bottom = -4
	custom_minimum_size = Vector2(0, 336)
	z_index = 1000
	visible = false
	mouse_filter = Control.MOUSE_FILTER_PASS
	focus_mode = Control.FOCUS_NONE
	add_theme_stylebox_override("panel", _panel_style())

	var content := VBoxContainer.new()
	content.add_theme_constant_override("separation", 6)
	content.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(content)

	var header := HBoxContainer.new()
	header.add_theme_constant_override("separation", 6)
	header.mouse_filter = Control.MOUSE_FILTER_IGNORE
	header.visible = false
	content.add_child(header)
	_heading = Label.new()
	_heading.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_heading.add_theme_font_override("font", KEY_FONT)
	_heading.add_theme_font_size_override("font_size", 15)
	_heading.add_theme_color_override("font_color", Color("4e85a6"))
	_heading.mouse_filter = Control.MOUSE_FILTER_IGNORE
	header.add_child(_heading)

	var preview_panel := PanelContainer.new()
	preview_panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	preview_panel.custom_minimum_size = Vector2(0, 40)
	var pst := _key_style(Color("ffffff"), Color("a6d8ee"), 1, 8);pst.content_margin_left = 10;pst.content_margin_right = 10
	preview_panel.add_theme_stylebox_override("panel", pst)
	preview_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	header.add_child(preview_panel)
	_preview = Label.new()
	_preview.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	_preview.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_preview.clip_text = true
	_preview.add_theme_font_override("font", KEY_FONT)
	_preview.add_theme_font_size_override("font_size", 20)
	_preview.add_theme_color_override("font_color", Color("285b7a"))
	_preview.mouse_filter = Control.MOUSE_FILTER_IGNORE
	preview_panel.add_child(_preview)

	_keys = VBoxContainer.new()
	_keys.add_theme_constant_override("separation", 6)
	_keys.mouse_filter = Control.MOUSE_FILTER_IGNORE
	content.add_child(_keys)

func open(field: LineEdit, numeric: bool, submit: bool, title: String) -> void:
	_target = field
	_numeric = numeric
	_submit_on_done = submit
	_title = title
	# Mã sao lưu chỉ gồm chữ không dấu và số: không bật Telex.
	_telex_on = not numeric and not title.begins_with("Mã")
	_shift = not title.begins_with("Mã")
	_caps = title.begins_with("Mã")
	_symbols = false
	_replace_on_first_key = numeric
	_fresh_open = not numeric
	_heading.text = title
	offset_top = -300 if numeric else -248
	custom_minimum_size = Vector2(0, 296 if numeric else 244)
	visible = true
	if numeric:
		field.call_deferred("select_all")
	else:
		field.caret_column = field.text.length()
		# Chạm vào ô sẽ đặt con trỏ theo vị trí chạm; đưa con trỏ về cuối chữ sau cú chạm.
		get_tree().create_timer(0.08).timeout.connect(_caret_to_end.bind(field))
	_update_preview()
	_build_keys()

func _caret_to_end(field: LineEdit) -> void:
	if is_instance_valid(field) and field == _target:
		field.deselect();field.caret_column = field.text.length()

func _input(event: InputEvent) -> void:
	if not visible or not is_instance_valid(_target):
		return
	var position := Vector2.ZERO
	var pressed := false
	if event is InputEventScreenTouch:
		position = event.position
		pressed = event.pressed
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		position = event.position
		pressed = event.pressed
	if not pressed:
		return
	var now := Time.get_ticks_msec()
	if now - _last_pointer_press_msec < 80:
		get_viewport().set_input_as_handled()
		return
	_last_pointer_press_msec = now
	var positions: Array[Vector2] = [position, get_viewport().get_mouse_position()]
	positions.append(get_viewport().get_screen_transform().affine_inverse() * position)
	var buttons := find_children("*", "Button", true, false)
	for point in positions:
		if not get_global_rect().has_point(point):
			continue
		for node in buttons:
			if node is Button and node.visible and node.get_global_rect().has_point(point):
				_on_key_pressed(str(node.get_meta("keyboard_action", "")))
				get_viewport().set_input_as_handled()
				return
		# Chạm vào khoảng trống của bàn phím cũng không lọt xuống giao diện bên dưới.
		get_viewport().set_input_as_handled()
		return

func dismiss_for_focus_exit(field: LineEdit) -> void:
	if _target == field:
		_target = null
		visible = false

func _panel_style() -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color("e6f3fb")
	style.border_color = Color("78b9dc")
	style.set_border_width_all(2)
	style.set_corner_radius_all(16)
	style.content_margin_left = 6
	style.content_margin_right = 6
	style.content_margin_top = 8
	style.content_margin_bottom = 8
	return style

func _key_style(background: Color, border: Color, border_width: int, radius: int) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = background
	style.border_color = border
	style.set_border_width_all(border_width)
	style.set_corner_radius_all(radius)
	style.content_margin_left = 1
	style.content_margin_right = 1
	style.content_margin_top = 1
	style.content_margin_bottom = 1
	return style

func _make_button(label: String, action: String, font_size: int = LETTER_FONT, special: bool = false) -> Button:
	var button := Button.new()
	button.text = label
	button.focus_mode = Control.FOCUS_NONE
	button.mouse_filter = Control.MOUSE_FILTER_STOP
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.custom_minimum_size = Vector2(0, KEY_HEIGHT)
	button.set_meta("no_font_scale", true)
	button.add_theme_font_override("font", KEY_FONT)
	button.add_theme_font_size_override("font_size", font_size)
	button.add_theme_color_override("font_color", Color("285b7a"))
	button.add_theme_color_override("font_hover_color", Color("163c56"))
	button.add_theme_color_override("font_pressed_color", Color("163c56"))
	var bg := Color("d7ebf7") if special else Color("fbfdff")
	button.add_theme_stylebox_override("normal", _key_style(bg, Color("a6d8ee"), 1, 8))
	button.add_theme_stylebox_override("hover", _key_style(bg, Color("78b9dc"), 1, 8))
	button.add_theme_stylebox_override("pressed", _key_style(Color("bfe0f3"), Color("5ca4ca"), 1, 8))
	button.add_theme_stylebox_override("focus", _key_style(bg, Color("a6d8ee"), 1, 8))
	button.set_meta("keyboard_action", action)
	button.pressed.connect(_on_key_pressed.bind(action))
	return button

func _icon_button(icon: Texture2D, action: String) -> Button:
	var b := _make_button("", action, SPECIAL_FONT, true)
	b.icon = icon
	b.expand_icon = true
	b.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
	b.add_theme_constant_override("icon_max_width", 26)
	return b

func _build_keys() -> void:
	if not is_instance_valid(_keys):
		return
	for child in _keys.get_children():
		child.queue_free()
	if _numeric:
		_add_row(["1", "2", "3"])
		_add_row(["4", "5", "6"])
		_add_row(["7", "8", "9"])
		_add_row(["CLR", "0", "DEL"])
		_add_row(["XONG"])
		return
	if _symbols:
		_add_row(_letters("1234567890"))
		_add_row(["@", "#", "$", "%", "&", "-", "+", "(", ")"])
		_add_row(["!", "_", "/", ":", ";", "'", "?", "\"", "DEL"])
		_add_row(["ABC", ",", "SPACE", ".", "XONG"])
	else:
		_add_row(_letters("qwertyuiop"))
		_add_row(_letters("asdfghjkl"), 0.5)
		_add_row(["SHIFT", "z", "x", "c", "v", "b", "n", "m", "DEL"])
		_add_row(["123", ",", "SPACE", ".", "XONG"])

func _letters(value: String) -> Array:
	var result: Array = []
	for index in range(value.length()):
		result.append(value.substr(index, 1))
	return result

func _add_row(keys: Array, side_pad: float = 0.0) -> void:
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 4)
	row.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_keys.add_child(row)
	if side_pad > 0.0:
		var pad := Control.new();pad.size_flags_horizontal = Control.SIZE_EXPAND_FILL;pad.size_flags_stretch_ratio = side_pad;pad.mouse_filter = Control.MOUSE_FILTER_IGNORE;row.add_child(pad)
	for item in keys:
		var key := str(item)
		var button: Button
		match key:
			"SHIFT":
				button = _icon_button(ICON_CAPS if _caps else (ICON_SHIFT_ON if _shift else ICON_SHIFT), key)
				button.size_flags_stretch_ratio = 1.5
			"DEL":
				button = _icon_button(ICON_BACKSPACE, key)
				button.size_flags_stretch_ratio = 1.5
			"XONG":
				if _numeric:
					button = _make_button("XONG", key, 18, true)
				else:
					button = _icon_button(ICON_ENTER, key)
				button.size_flags_stretch_ratio = 1.6
			"SPACE":
				button = _make_button("Tiếng Việt" if _telex_on else "", key, SPECIAL_FONT)
				button.add_theme_color_override("font_color", Color("8aaabd"))
				button.size_flags_stretch_ratio = 4.2
			"123", "ABC":
				button = _make_button("?123" if key == "123" else "ABC", key, SPECIAL_FONT, true)
				button.size_flags_stretch_ratio = 1.5
			"CLR":
				button = _make_button("Xóa hết", key, SPECIAL_FONT, true)
			_:
				var label := key
				if not _numeric and _is_ascii_letter(key) and (_shift or _caps):
					label = key.to_upper()
				button = _make_button(label, key, DIGIT_FONT if _numeric else LETTER_FONT)
		row.add_child(button)
	if side_pad > 0.0:
		var pad2 := Control.new();pad2.size_flags_horizontal = Control.SIZE_EXPAND_FILL;pad2.size_flags_stretch_ratio = side_pad;pad2.mouse_filter = Control.MOUSE_FILTER_IGNORE;row.add_child(pad2)

func _is_ascii_letter(key: String) -> bool:
	return key.length() == 1 and "abcdefghijklmnopqrstuvwxyz".contains(key)

func _on_key_pressed(key: String) -> void:
	if not is_instance_valid(_target):
		return
	if _fresh_open:
		_fresh_open = false
		_target.deselect();_target.caret_column = _target.text.length()
	match key:
		"XONG":
			_finish()
			return
		"DEL":
			_delete_backward()
		"CLR":
			_replace_text(0, _target.text.length(), "")
		"SHIFT":
			var now := Time.get_ticks_msec()
			if _caps:
				_caps = false;_shift = false
			elif _shift and now - _last_shift_msec < 450:
				_caps = true
			else:
				_shift = not _shift
			_last_shift_msec = now
			_build_keys()
		"123":
			_symbols = true
			_build_keys()
		"ABC":
			_symbols = false
			_build_keys()
		"SPACE":
			_insert(" ")
		_:
			if not _numeric and _is_ascii_letter(key):
				var upper := _shift or _caps
				var value := key.to_upper() if upper else key
				var was_shift := _shift
				if _shift and not _caps: _shift = false
				if _telex_on: _type_telex(value)
				else: _insert(value)
				if was_shift != _shift: _build_keys()
				_update_preview()
				return
			_insert(key)
	_update_preview()

# ---------- Telex ----------
func _is_word_char(ch: String) -> bool:
	if ch.is_empty(): return false
	var l := ch.to_lower()
	return _is_ascii_letter(l) or _base_lookup.has(l) or l == "đ"

func _type_telex(ch: String) -> void:
	if _target.has_selection():
		_replace_text(_target.get_selection_from_column(), _target.get_selection_to_column(), "")
	var caret := _target.caret_column
	var text := _target.text
	var start := caret
	while start > 0 and _is_word_char(text.substr(start - 1, 1)):
		start -= 1
	var word := text.substr(start, caret - start)
	var result := _telex(word, ch)
	_replace_text(start, caret, result)

func _decompose(word: String) -> Array:
	# Trả về [chữ gốc (giữ hoa/thường, bỏ dấu thanh), dấu thanh]
	var base := ""
	var tone := 0
	for ch in word:
		var l: String = ch.to_lower()
		if _base_lookup.has(l):
			var info: Array = _base_lookup[l]
			var b: String = info[0]
			if int(info[1]) > 0 and tone == 0: tone = int(info[1])
			base += b.to_upper() if ch != l else b
		else:
			base += ch
	return [base, tone]

func _is_vowel(ch: String) -> bool:
	return TONES.has(ch.to_lower())

func _tone_position(base: String) -> int:
	var lower := base.to_lower()
	var idx: Array[int] = []
	for i in range(lower.length()):
		if _is_vowel(lower[i]): idx.append(i)
	if idx.is_empty(): return -1
	# "qu", "gi" đứng đầu: u/i là phụ âm
	if lower.begins_with("qu") and idx.size() > 1 and idx[0] == 1: idx.remove_at(0)
	elif lower.begins_with("gi") and idx.size() > 1 and idx[0] == 1: idx.remove_at(0)
	# Lấy cụm nguyên âm cuối cùng
	var cluster: Array[int] = [idx[idx.size() - 1]]
	var k := idx.size() - 2
	while k >= 0 and idx[k] == cluster[0] - 1:
		cluster.push_front(idx[k]);k -= 1
	for i in range(cluster.size() - 1, -1, -1):
		if MARKED_VOWELS.contains(lower[cluster[i]]):
			if lower[cluster[i]] == "ư" and i + 1 < cluster.size() and lower[cluster[i + 1]] == "ơ": return cluster[i + 1]
			return cluster[i]
	if cluster.size() == 1: return cluster[0]
	if cluster.size() >= 3: return cluster[1]
	var ends_word := cluster[1] == lower.length() - 1
	return cluster[0] if ends_word else cluster[1]

func _with_tone(base: String, tone: int) -> String:
	if tone == 0: return base
	var pos := _tone_position(base)
	if pos < 0: return base
	var ch := base[pos]
	var l := ch.to_lower()
	var toned: String = TONES[l][tone]
	if ch != l: toned = toned.to_upper()
	return base.substr(0, pos) + toned + base.substr(pos + 1)

func _set_char(s: String, pos: int, lower_ch: String) -> String:
	var orig := s[pos]
	var c := lower_ch.to_upper() if orig != orig.to_lower() else lower_ch
	return s.substr(0, pos) + c + s.substr(pos + 1)

func _last_cluster_range(lower: String) -> Array:
	var i := lower.length() - 1
	while i >= 0 and not _is_vowel(lower[i]): i -= 1
	if i < 0: return [-1, -1]
	var e := i
	while i >= 0 and _is_vowel(lower[i]): i -= 1
	return [i + 1, e]

func _last_cluster_find(lower: String, targets: String) -> int:
	# Tìm nguyên âm trong cụm nguyên âm cuối (tính từ cuối từ) thuộc tập targets
	var i := lower.length() - 1
	while i >= 0 and not _is_vowel(lower[i]): i -= 1
	while i >= 0 and _is_vowel(lower[i]):
		if targets.contains(lower[i]): return i
		i -= 1
	return -1

func _telex(word: String, ch: String) -> String:
	var k := ch.to_lower()
	var parts := _decompose(word)
	var base: String = parts[0]
	var tone: int = parts[1]
	var lower := base.to_lower()
	var has_vowel := false
	for c in lower:
		if _is_vowel(c): has_vowel = true;break
	# Dấu thanh
	if TONE_KEYS.has(k) and has_vowel:
		var t: int = TONE_KEYS[k]
		if tone == t: return base + ch
		return _with_tone(base, t)
	if k == "z" and has_vowel and tone > 0:
		return base
	# Dấu mũ / trăng / móc
	if k in ["a", "e", "o"]:
		var hat: String = {"a": "â", "e": "ê", "o": "ô"}[k]
		var hat_pos := _last_cluster_find(lower, hat)
		if hat_pos >= 0:
			return _with_tone(_set_char(base, hat_pos, k), tone) + ch
		var plain := _last_cluster_find(lower, k + ("ă" if k == "a" else ("ơ" if k == "o" else "")))
		if plain >= 0:
			return _with_tone(_set_char(base, plain, hat), tone)
	if k == "w":
		var r := _last_cluster_range(lower)
		if r[0] >= 0:
			var seg := lower.substr(r[0], r[1] - r[0] + 1)
			var uo := seg.rfind("uo")
			if uo >= 0:
				return _with_tone(_set_char(_set_char(base, r[0] + uo, "ư"), r[0] + uo + 1, "ơ"), tone)
			var half := seg.rfind("ưo")
			if half < 0: half = seg.rfind("uơ")
			if half >= 0:
				return _with_tone(_set_char(_set_char(base, r[0] + half, "ư"), r[0] + half + 1, "ơ"), tone)
			var q := _last_cluster_find(lower, "ăơư")
			if q >= 0:
				var back: String = {"ă": "a", "ơ": "o", "ư": "u"}[lower[q]]
				var restored := _set_char(base, q, back)
				if lower.substr(r[0], r[1] - r[0] + 1).contains("ươ"):
					restored = _set_char(_set_char(base, r[0] + seg.find("ươ"), "u"), r[0] + seg.find("ươ") + 1, "o")
				return _with_tone(restored, tone) + ch
			var p := _last_cluster_find(lower, "aou")
			if p >= 0:
				var m: String = {"a": "ă", "o": "ơ", "u": "ư"}[lower[p]]
				return _with_tone(_set_char(base, p, m), tone)
		return _with_tone(base, tone) + ("Ư" if ch != k else "ư")
	if k == "d" and lower.length() > 0:
		if lower[0] == "d":
			return _with_tone(_set_char(base, 0, "đ"), tone)
		if lower[0] == "đ":
			return _with_tone(_set_char(base, 0, "d"), tone) + ch
	# Chữ thường: thêm vào rồi đặt lại dấu thanh cho đúng vị trí
	return _with_tone(base + ch, tone)

# ---------- Nhập / xóa ----------
func _insert(value: String) -> void:
	if not is_instance_valid(_target):
		return
	if _numeric:
		var digits := ""
		for character in value:
			if character >= "0" and character <= "9":
				digits += character
		value = digits
	if value.is_empty():
		_update_preview()
		return
	if _numeric and _replace_on_first_key:
		_replace_on_first_key = false
		_replace_text(0, _target.text.length(), value)
		return
	var start := _target.caret_column
	var end := start
	if _target.has_selection():
		start = _target.get_selection_from_column()
		end = _target.get_selection_to_column()
	_replace_text(start, end, value)

func _delete_backward() -> void:
	if not is_instance_valid(_target):
		return
	_replace_on_first_key = false
	var start := _target.caret_column
	var end := start
	if _target.has_selection():
		start = _target.get_selection_from_column()
		end = _target.get_selection_to_column()
	elif start > 0:
		start -= 1
	if start != end:
		_replace_text(start, end, "")

func _replace_text(start: int, end: int, value: String) -> void:
	if not is_instance_valid(_target):
		return
	var old_text := _target.text
	start = clampi(start, 0, old_text.length())
	end = clampi(end, start, old_text.length())
	var left := old_text.substr(0, start)
	var right := old_text.substr(end)
	if _target.max_length > 0:
		var room := maxi(0, _target.max_length - left.length() - right.length())
		value = value.substr(0, room)
	_target.text = left + value + right
	_target.caret_column = left.length() + value.length()
	_target.deselect()
	_target.text_changed.emit(_target.text)
	_update_preview()

func _update_preview() -> void:
	if is_instance_valid(_preview) and is_instance_valid(_target):
		_preview.text = _target.text

func _finish() -> void:
	if not is_instance_valid(_target):
		visible = false
		return
	var field := _target
	var submit := _submit_on_done
	_target = null
	visible = false
	if submit:
		field.text_submitted.emit(field.text)
	field.release_focus()
