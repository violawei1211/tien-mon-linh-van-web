extends Control

const STORE_BG: = preload("res://assets/boutique/tu_tien_interior.png")
const CURRENCY_ICON: = preload("res://assets/boutique/ui_icons/icon_linh_thach.png")
const REFINING_MINIGAME_SCRIPT: Script = preload("res://scripts/ui/refining_minigame.gd")
const UI_FONT_REGULAR: = preload("res://assets/template/fonts/mali_bold.tres")
const UI_FONT_MEDIUM: = preload("res://assets/template/fonts/mali_bold.tres")
const IN_GAME_KEYBOARD_SCRIPT: Script = preload("res://scripts/ui/in_game_keyboard.gd")
const LEVEL_SIGN_TEXTURES: Array[Texture2D] = [
	preload("res://assets/boutique/level_signs/level_01.png"), preload("res://assets/boutique/level_signs/level_02.png"),
	preload("res://assets/boutique/level_signs/level_03.png"), preload("res://assets/boutique/level_signs/level_04.png"),
	preload("res://assets/boutique/level_signs/level_05.png"), preload("res://assets/boutique/level_signs/level_06.png"),
	preload("res://assets/boutique/level_signs/level_07.png"), preload("res://assets/boutique/level_signs/level_08.png"),
	preload("res://assets/boutique/level_signs/level_09.png"), preload("res://assets/boutique/level_signs/level_10.png"),
	preload("res://assets/boutique/level_signs/level_11.png"), preload("res://assets/boutique/level_signs/level_12.png"),
]
const CHARACTER_PORTRAITS: Array[Texture2D] = [
	preload("res://assets/boutique/characters/character_01.png"),
	preload("res://assets/boutique/characters/character_02.png"),
	preload("res://assets/boutique/characters/character_03.png"),
	preload("res://assets/boutique/characters/character_04.png"),
	preload("res://assets/boutique/characters/character_05.png"),
	preload("res://assets/boutique/characters/character_06.png"),
	preload("res://assets/boutique/characters/character_07.png"),
	preload("res://assets/boutique/characters/character_08.png"),
	preload("res://assets/boutique/characters/character_09.png"),
	preload("res://assets/boutique/characters/character_10.png"),
	preload("res://assets/boutique/characters/character_11.png"),
	preload("res://assets/boutique/characters/character_12.png"),
	preload("res://assets/boutique/characters/character_13.png"),
	preload("res://assets/boutique/characters/character_14.png"),
	preload("res://assets/boutique/characters/character_15.png"),
	preload("res://assets/boutique/characters/character_16.png"),
	preload("res://assets/boutique/characters/character_17.png"),
	preload("res://assets/boutique/characters/character_18.png"),
	preload("res://assets/boutique/characters/character_19.png"),
	preload("res://assets/boutique/characters/character_20.png"),
	preload("res://assets/boutique/characters/character_21.png"),
	preload("res://assets/boutique/characters/character_22.png"),
	preload("res://assets/boutique/characters/character_23.png"),
	preload("res://assets/boutique/characters/character_24.png"),
	preload("res://assets/boutique/characters/character_25.png"),
	preload("res://assets/boutique/characters/character_26.png"),
	preload("res://assets/boutique/characters/character_27.png"),
	preload("res://assets/boutique/characters/character_28.png"),
	preload("res://assets/boutique/characters/character_29.png"),
	preload("res://assets/boutique/characters/character_30.png"),
	preload("res://assets/boutique/characters/character_31.png"),
	preload("res://assets/boutique/characters/character_32.png"),
	preload("res://assets/boutique/characters/character_33.png"),
	preload("res://assets/boutique/characters/character_34.png"),
	preload("res://assets/boutique/characters/character_35.png"),
	preload("res://assets/boutique/characters/character_36.png"),
	preload("res://assets/boutique/characters/character_37.png"),
	preload("res://assets/boutique/characters/character_38.png"),
	preload("res://assets/boutique/characters/character_39.png"),
	preload("res://assets/boutique/characters/character_40.png"),
	preload("res://assets/boutique/characters/character_41.png"),
	preload("res://assets/boutique/characters/character_42.png"),
	preload("res://assets/boutique/characters/character_43.png"),
	preload("res://assets/boutique/characters/character_44.png"),
	preload("res://assets/boutique/characters/character_45.png"),
	preload("res://assets/boutique/characters/character_46.png"),
	preload("res://assets/boutique/characters/character_47.png"),
	preload("res://assets/boutique/characters/character_48.png"),
	preload("res://assets/boutique/characters/character_49.png"),
	preload("res://assets/boutique/characters/character_50.png"),
	preload("res://assets/boutique/characters/character_51.png"),
	preload("res://assets/boutique/characters/character_52.png"),
	preload("res://assets/boutique/characters/character_53.png"),
]

const GAME_START_MINUTES: = 8 * 60
const GAME_END_MINUTES: = 21 * 60
const MINUTES_PER_SECOND: = 780.0 / 210.0
const DAILY_RENT: = 120
const STARTING_MONEY: = 3500
const DEFAULT_PRODUCT_UNLOCK_COST: = 20000
const PRODUCT_UNLOCK_SAVE_PATH: = "user://premium_medicines.cfg"
const TOTAL_SHELVES: = 24
const NORMAL_SHELVES: = 12
const FIRST_SHELVES: = 6
const FIRST_LOCKED_SHELF_COST: = 12000
const NORMAL_PATIENCE_SECONDS: = 35.0
const VIP_PATIENCE_SECONDS: = 30.0
const WRONG_SIZE_PATIENCE_PENALTY: = 5.0
const WRONG_ITEM_PATIENCE_PENALTY: = 5.0
const CUSTOMER_SPAWN_SECONDS: = 5.0
const MAX_ORDER_QUANTITY: = 300
const STAFF_SIZE_ERROR_CHANCE: = 0.1
const DEFAULT_OUTDATED_DAYS: = 3
const CLOTHING_OUTDATED_DAYS: = 5
const ACCESSORY_OUTDATED_DAYS: = 3
const SIZE_REQUIRED_CATEGORIES: = ["Đầm", "Quần áo", "Đồ nam"]
const TOTAL_CHARACTER_COUNT: = 53
const LEVEL_XP_THRESHOLDS: = [0, 400, 800, 1300, 1900, 2600, 3400, 4300, 8300, 10400, 16600, 21000]
# Số linh thạch phải đang có để lên level tương ứng (chỉ số = level - 1).
const LEVEL_MONEY_REQUIREMENTS: = [0, 0, 6000, 9000, 17000, 30000, 50000, 100000, 300000, 1200000, 6000000, 36000000]
var _money_block_toast_level: = 0

var products: Array[Dictionary] = []
# Nguyên liệu tinh luyện (config/refining_recipes.json): công thức theo tên sản phẩm, giá và kho nguyên liệu.
var refining_recipes: Dictionary = {}
var material_stock: Dictionary = {}
var material_names: Array = []
var material_images: Dictionary = {}
var market_sort_mode: int = 0
var setup_heading_label: Label
var shelves: Array[Dictionary] = []
var queue: Array[Dictionary] = []
var customer_reviews: Array[Dictionary] = []
var staff_errors: Array[Dictionary] = []
var customer_roster: Array[Dictionary] = []
var character_data: Array[Dictionary] = []
var review_bank: Array[Dictionary] = []
var staff: Dictionary = {"cashier": false, "restocker": false, "manager": false}
# Ngày bắt đầu thuê của từng người (dùng cho đệ tử mới nhập môn)
var staff_hired_day: Dictionary = {}
var staff_owned: Dictionary = {"cashier": false, "restocker": false, "manager": false}

var running: = false
var paused: = false
var game_minutes: = float(GAME_START_MINUTES)
var spawn_clock: = 0.0
var vip_clock: = 20.0
var money: = STARTING_MONEY
var paid_product_unlocks: Dictionary = {}
var xp: = 0
var level: = 1
var level_xp: = 0
var total_xp: = 0
var successful_orders: = 0
var walked_out: = 0
var tips: = 0
# Các khoản linh thạch bị trừ trong ngày (hiện ở Chưởng bộ): [{"label": String, "amount": int}]
var expenses_today: Array = []
var store_tips: = 0
# Doanh thu bán hàng trong ngày (tổng giá bán các món đã thanh toán)
var revenue_today: = 0
var best_seller: = "Chưa có"
var selected_product: = -1
var day_number: = 1
var vip_count_today: = 0
var vip_limit_today: = 1
var normal_customer_count: = 0
var daily_wages: = 0
var daily_imports: Array[Dictionary] = []
var daily_statistics: Array[Dictionary] = []
var sold_today: Dictionary = {}
var staff_work_clock: = 0.0
var staff_error_serial: = 0
var customer_order_serial: = 0
var active_close_tab: = "adjustments"
var pre_game_adjustment: = false
var first_purchase_guidance_pending: = true
var store_name: = "TIÊN MÔN LINH VẬN"
var active_refining_minigame: Control
var pending_refining_delivery: Dictionary = {}
var paused_before_refining: bool = false

var background: TextureRect
var top_bar: PanelContainer
var time_label: Label
var money_label: PanelContainer
var xp_label: Label
var queue_label: Label
var review_hud_row: HBoxContainer
var level_label: Label
var title_label: Label
var mode_label: Label
var store_content: HBoxContainer
var main_scroll: ScrollContainer
var main_content: VBoxContainer
var customer_card: PanelContainer
var customer_info_column: VBoxContainer
var customer_portrait_frame: PanelContainer
var level_sign_display: TextureRect
var displayed_level_sign_level: int = -1
var customer_patience_label: Label
var customer_delivery_label: Label
var customer_avatar_control: Control
var displayed_customer_order_id: = -2
var displayed_delivery_signature: = ""
var displayed_running_state: = false
var toast_label: Label
var start_button: Button
var pause_button: Button
var pause_menu_panel: PanelContainer
var pause_menu_toggle_button: Button
var pause_menu_end_button: Button
var setup_button: Button
var next_day_button: Button
var report_overlay: ColorRect
var report_panel: PanelContainer
var report_text: PanelContainer
var store_name_prompt_overlay: ColorRect
var store_name_field: LineEdit
var close_content: VBoxContainer
var close_scroll: ScrollContainer
var _setup_touch_index: int = -1
var _setup_touch_start: Vector2 = Vector2.ZERO
var _setup_touch_last: Vector2 = Vector2.ZERO
var _setup_touch_dragging: bool = false
const SETUP_TOUCH_SCROLL_DEADZONE: float = 10.0
var cash_player: AudioStreamPlayer
var door_player: AudioStreamPlayer

func _ready() -> void :
	products = _load_products()
	_capture_base_costs()
	_load_refining_recipes()
	_load_paid_product_unlock_states()
	review_bank = _load_reviews()
	character_data = _load_characters()
	customer_roster = _make_customer_roster()
	_shelf_setup()
	_build_ui()
	var save_phase: String = _load_game()
	if save_phase == "closed":
		# Đã đóng ca trước khi thoát: mở lại bảng cuối ca của ngày đó.
		running = true
		_end_day()
	elif save_phase == "pre_shift":
		_open_pre_game_adjustments()
		call_deferred("_tut_event", "named")
	else:
		_open_pre_game_adjustments()
		_show_store_name_prompt()
	_update_level_sign_force()
	_update_ui()
	var autosave: = Timer.new();autosave.wait_time = 2.0;autosave.autostart = true;autosave.timeout.connect(_autosave_tick);add_child(autosave)

func _paid_product_unlock_key(product_index: int) -> String:
	var product_id: int = int(products[product_index].get("id", product_index + 1))
	return "product_%d" % product_id

func _product_unlock_cost(product_index: int) -> int:
	if product_index < 0 or product_index >= products.size(): return 0
	return maxi(0, int(products[product_index].get("paid_unlock_cost", DEFAULT_PRODUCT_UNLOCK_COST)))

func _is_paid_product_unlocked(product_index: int) -> bool:
	if product_index < 0 or product_index >= products.size(): return false
	if not bool(products[product_index].get("requires_paid_unlock", false)): return true
	return bool(paid_product_unlocks.get(_paid_product_unlock_key(product_index), false))

func _load_paid_product_unlock_states() -> void:
	var saved_state: = ConfigFile.new()
	if saved_state.load(PRODUCT_UNLOCK_SAVE_PATH) != OK: return
	var legacy_group_unlocked: bool = bool(saved_state.get_value("unlocks", "premium_medicines", false))
	var has_legacy_group_state: bool = saved_state.has_section_key("unlocks", "premium_medicines")
	for i in range(products.size()):
		if not bool(products[i].get("requires_paid_unlock", false)): continue
		var key: String = _paid_product_unlock_key(i)
		var inherit_legacy_unlock: bool = legacy_group_unlocked and bool(products[i].get("legacy_unlock_migration", false))
		paid_product_unlocks[key] = bool(saved_state.get_value("unlocks", key, inherit_legacy_unlock))
	if has_legacy_group_state:
		saved_state.erase_section_key("unlocks", "premium_medicines")
		for i in range(products.size()):
			if bool(products[i].get("requires_paid_unlock", false)):
				var key: String = _paid_product_unlock_key(i)
				saved_state.set_value("unlocks", key, bool(paid_product_unlocks.get(key, false)))
		var migration_error: Error = saved_state.save(PRODUCT_UNLOCK_SAVE_PATH)
		if migration_error != OK: push_warning("Không thể chuyển dữ liệu mở khóa cũ: %s" % error_string(migration_error))

func _save_paid_product_unlock_states() -> void:
	var saved_state: = ConfigFile.new()
	if FileAccess.file_exists(PRODUCT_UNLOCK_SAVE_PATH):
		var load_error: Error = saved_state.load(PRODUCT_UNLOCK_SAVE_PATH)
		if load_error != OK:
			push_warning("Không thể đọc dữ liệu mở khóa đã lưu: %s" % error_string(load_error))
			return
	for i in range(products.size()):
		if bool(products[i].get("requires_paid_unlock", false)):
			var key: String = _paid_product_unlock_key(i)
			saved_state.set_value("unlocks", key, bool(paid_product_unlocks.get(key, false)))
	if saved_state.has_section_key("unlocks", "premium_medicines"):
		saved_state.erase_section_key("unlocks", "premium_medicines")
	var error: Error = saved_state.save(PRODUCT_UNLOCK_SAVE_PATH)
	if error != OK: push_warning("Không thể lưu trạng thái mở khóa từng đan dược: %s" % error_string(error))

func _show_product_unlock_hint(product_index: int) -> void:
	if product_index < 0 or product_index >= products.size():
		_show_toast("Sản phẩm này chưa được mở khóa.")
		return
	var product: Dictionary = products[product_index]
	var required_level: int = int(product.get("unlock_level", 1))
	if level < required_level:
		if bool(product.get("requires_paid_unlock", false)) and not _is_paid_product_unlocked(product_index):
			var required_cost: int = _product_unlock_cost(product_index)
			var required_cost_text: String = "20.000" if required_cost == 20000 else str(required_cost)
			_show_toast("Mở ở level %d. Đạt level này rồi mới có thể trả %s LT để mở riêng %s." % [required_level, required_cost_text, product["name"]])
		else:
			_show_toast("Sản phẩm này mở ở level %d." % required_level)
		return
	if bool(product.get("requires_paid_unlock", false)) and not _is_paid_product_unlocked(product_index):
		var cost: int = _product_unlock_cost(product_index)
		var cost_text: String = "20.000" if cost == 20000 else str(cost)
		_show_toast("Mở khóa riêng %s · %s LT." % [product["name"], cost_text])
	else:
		_show_toast("Sản phẩm này đã mở khóa.")

func _input(event: InputEvent) -> void:
	if not is_instance_valid(close_scroll) or not close_scroll.is_visible_in_tree():
		_setup_touch_index = -1
		_setup_touch_dragging = false
		return
	if is_instance_valid(store_name_prompt_overlay) and store_name_prompt_overlay.is_visible_in_tree():
		return
	if event is InputEventScreenTouch:
		if event.pressed:
			if _setup_touch_index < 0 and close_scroll.get_global_rect().has_point(event.position):
				_setup_touch_index = event.index
				_setup_touch_start = event.position
				_setup_touch_last = event.position
				_setup_touch_dragging = false
		elif event.index == _setup_touch_index:
			if _setup_touch_dragging:
				get_viewport().set_input_as_handled()
			_setup_touch_index = -1
			_setup_touch_dragging = false
	elif event is InputEventScreenDrag and event.index == _setup_touch_index:
		var movement: Vector2 = event.position - _setup_touch_start
		if not _setup_touch_dragging:
			if absf(movement.x) >= SETUP_TOUCH_SCROLL_DEADZONE and absf(movement.x) > absf(movement.y):
				_setup_touch_index = -1
				return
			if absf(movement.y) < SETUP_TOUCH_SCROLL_DEADZONE or absf(movement.y) <= absf(movement.x):
				return
			_setup_touch_dragging = true
		var delta_y: int = roundi(event.position.y - _setup_touch_last.y)
		if delta_y != 0:
			close_scroll.scroll_vertical -= delta_y
		_setup_touch_last = event.position
		get_viewport().set_input_as_handled()

func _exit_tree() -> void :


	if is_instance_valid(cash_player):
		cash_player.stop()
		cash_player.stream = null
	if is_instance_valid(door_player):
		door_player.stop()
		door_player.stream = null

func _process(delta: float) -> void :
	if not running:
		return
	if paused:
		# Chống kẹt tạm dừng: chỉ giữ tạm dừng khi người chơi tự bấm hoặc đang có bảng/mini game mở.
		if not manual_pause and not _modal_open():
			paused = false;_set_pause_glyph(false)
		_update_ui()
		return
	game_minutes += delta * MINUTES_PER_SECOND
	spawn_clock += delta
	vip_clock -= delta
	for customer in queue:
		customer["patience"] = maxf(0.0, float(customer["patience"]) - delta)
	_cond_tick(delta)
	if spawn_clock >= CUSTOMER_SPAWN_SECONDS / (1.0 + _arrival_bonus()) and queue.size() < _queue_cap():
		spawn_clock = 0.0
		if _customer_arrival_allowed():
			queue.append(_new_customer(false))
			_play_door()
	if vip_clock <= 0.0 and vip_count_today < vip_limit_today and queue.size() < _queue_cap():
		vip_clock = 55.0
		if _customer_arrival_allowed():
			vip_count_today += 1
			queue.append(_new_customer(true))
			_sfx("vip")
			_show_toast("VIP vừa vào cửa — chỉ còn %d lượt VIP hôm nay." % (vip_limit_today - vip_count_today))
	for i in range(queue.size() - 1, -1, -1):
		if float(queue[i]["patience"]) <= 0.0:
			_add_review(queue[i], randi_range(1, 3), "Khách bỏ về vì phải chờ quá lâu.")
			walked_out += 1
			_sfx("leave")
			queue.remove_at(i)
	if _staff_can_work() and not queue.is_empty():
		staff_work_clock += delta
		if staff_work_clock >= _staff_serve_interval():
			staff_work_clock = 0.0
			_staff_serve_next_item()
	_incidents_tick()
	var close_early: = float(incident_state.get("close_early_at", 0.0))
	_night_tick()
	if game_minutes >= _shift_end_minutes() or (close_early > 0.0 and game_minutes >= close_early):
		_end_day()
	_update_ui()

func _shelf_setup() -> void :
	if not shelves.is_empty():
		for shelf in shelves:
			if shelf["unlocked"]:
				shelf["stock"] = maxi(0, int(shelf["stock"] if int(shelf["product"]) >= 0 else 0))
			shelf["stock_ages"] = _normalize_stock_ages(shelf.get("stock_ages", []), int(shelf["stock"]))
		return
	shelves.clear()
	for i in range(TOTAL_SHELVES): shelves.append(_shelf_default(i))

func _build_ui() -> void :
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	_load_settings()
	get_tree().node_added.connect(_font_scale_node)
	if DisplayServer.get_name() != "headless":
		_setup_sfx()
		_setup_music()
	background = TextureRect.new()
	background.texture = STORE_BG
	background.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	background.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(background)
	var wash: = ColorRect.new()
	wash.color = Color(0.78, 0.92, 1.0, 0.24)
	wash.mouse_filter = Control.MOUSE_FILTER_IGNORE
	wash.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(wash)
	top_bar = PanelContainer.new()
	top_bar.position = Vector2(14, 14)
	top_bar.size = Vector2(512, 145)
	top_bar.add_theme_stylebox_override("panel", _box(Color("f7fbff"), Color("8bc5e8"), 3, 20))
	add_child(top_bar)
	var margin: = MarginContainer.new()
	for side in ["left", "right", "top", "bottom"]: margin.add_theme_constant_override("margin_%s" % side, 12)
	top_bar.add_child(margin)
	var top_v: = VBoxContainer.new();top_v.add_theme_constant_override("separation", 4);margin.add_child(top_v)
	var top_row: = HBoxContainer.new();top_v.add_child(top_row)
	title_label = _label("%s  -  NGÀY 1" % store_name, 24, Color("285b7a"), true);title_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL;title_label.set_meta("no_font_scale", true);top_row.add_child(title_label)
	level_label = _label("LV 1", 18, Color("d979a6"), true);level_label.set_meta("no_font_scale", true);top_row.add_child(level_label)
	var stats: = HBoxContainer.new();stats.add_theme_constant_override("separation", 12);top_v.add_child(stats)
	time_label = _label("08:00", 16, Color("24495f"), true);stats.add_child(time_label)
	xp_label = _label("XP 0/100", 16, Color("3f86aa"), true);stats.add_child(xp_label)
	queue_label = _label("0 KHÁCH", 16, Color("3f86aa"), true);stats.add_child(queue_label)
	review_hud_row = _review_hud_row();top_v.add_child(review_hud_row)
	var money_row: = HBoxContainer.new();money_row.add_theme_constant_override("separation", 6);top_v.add_child(money_row)
	pause_button = _button("", 9, true);pause_button.custom_minimum_size = Vector2(56, 28);pause_button.tooltip_text = "Tạm dừng / tiếp tục ca";_build_pause_glyph();pause_button.disabled = true;pause_button.pressed.connect(_open_pause_menu);money_row.add_child(pause_button)
	var settings_button: = _gear_button();settings_button.custom_minimum_size = Vector2(40, 28);settings_button.pressed.connect(_open_settings_panel);money_row.add_child(settings_button)
	var money_spacer: Control = Control.new();money_spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL;money_row.add_child(money_spacer)
	money_label = _currency_badge(STARTING_MONEY, 21, Color("e5aa28"), true);money_row.add_child(money_label)
	pause_menu_panel = PanelContainer.new();pause_menu_panel.position = Vector2(292, 148);pause_menu_panel.size = Vector2(220, 172);pause_menu_panel.custom_minimum_size = Vector2(220, 172);pause_menu_panel.z_index = 50;pause_menu_panel.visible = false;pause_menu_panel.mouse_filter = Control.MOUSE_FILTER_STOP;pause_menu_panel.add_theme_stylebox_override("panel", _box(Color("f7fbff"), Color("8bc5e8"), 3, 12));add_child(pause_menu_panel)
	var pause_menu_box: = VBoxContainer.new();pause_menu_box.add_theme_constant_override("separation", 5);pause_menu_panel.add_child(pause_menu_box)
	pause_menu_toggle_button = _button("TIẾP TỤC CA", 10);pause_menu_toggle_button.custom_minimum_size = Vector2(0, 42);pause_menu_toggle_button.pressed.connect(_on_pause_menu_toggle_pressed);pause_menu_box.add_child(pause_menu_toggle_button)
	pause_menu_end_button = _button("ĐÓNG TIÊN MÔN / KẾT THÚC CA", 10);pause_menu_end_button.custom_minimum_size = Vector2(0, 56);pause_menu_end_button.pressed.connect(_on_pause_menu_end_pressed);pause_menu_box.add_child(pause_menu_end_button)
	var pause_reset_button: = _button("CHƠI LẠI TỪ ĐẦU", 10);pause_reset_button.custom_minimum_size = Vector2(0, 38);pause_reset_button.add_theme_stylebox_override("normal", _box(Color("fde6ef"), Color("e8a3c3"), 2, 14));pause_reset_button.add_theme_color_override("font_color", Color("c9558b"));pause_reset_button.pressed.connect(_on_pause_menu_reset_pressed);pause_menu_box.add_child(pause_reset_button)
	mode_label = _label("Bố trí tiên môn", 16, Color("285b7a"));mode_label.position = Vector2(20, 132);mode_label.size = Vector2(500, 28);add_child(mode_label)


	store_content = HBoxContainer.new();store_content.position = Vector2(20, 206);store_content.size = Vector2(500, 254);store_content.add_theme_constant_override("separation", 10);add_child(store_content)
	customer_portrait_frame = PanelContainer.new();customer_portrait_frame.custom_minimum_size = Vector2(190, 254);customer_portrait_frame.size_flags_vertical = Control.SIZE_EXPAND_FILL;customer_portrait_frame.clip_contents = true
	var portrait_frame_style: = _box(Color(0, 0, 0, 0), Color(0, 0, 0, 0), 0, 0)
	portrait_frame_style.content_margin_left = 0;portrait_frame_style.content_margin_right = 0;portrait_frame_style.content_margin_top = 0;portrait_frame_style.content_margin_bottom = 0
	customer_portrait_frame.add_theme_stylebox_override("panel", portrait_frame_style);store_content.add_child(customer_portrait_frame)
	customer_info_column = VBoxContainer.new();customer_info_column.custom_minimum_size = Vector2(0, 254);customer_info_column.size_flags_horizontal = Control.SIZE_EXPAND_FILL;customer_info_column.size_flags_vertical = Control.SIZE_FILL;customer_info_column.add_theme_constant_override("separation", -2);store_content.add_child(customer_info_column)
	customer_card = PanelContainer.new();customer_card.add_theme_stylebox_override("panel", _box(Color("d8e5ee"), Color("8bc5e8"), 2, 14));customer_card.custom_minimum_size = Vector2(0, 132);customer_card.size_flags_horizontal = Control.SIZE_EXPAND_FILL;customer_card.size_flags_vertical = Control.SIZE_SHRINK_BEGIN;customer_card.clip_contents = true;customer_info_column.add_child(customer_card)
	var level_sign_holder: = HBoxContainer.new();level_sign_holder.alignment = BoxContainer.ALIGNMENT_CENTER;level_sign_holder.custom_minimum_size = Vector2(0, 122);level_sign_holder.size_flags_horizontal = Control.SIZE_EXPAND_FILL;level_sign_holder.size_flags_vertical = Control.SIZE_SHRINK_BEGIN;level_sign_holder.mouse_filter = Control.MOUSE_FILTER_IGNORE;customer_info_column.add_child(level_sign_holder)
	level_sign_display = TextureRect.new();level_sign_display.custom_minimum_size = Vector2(112, 118);level_sign_display.expand_mode = TextureRect.EXPAND_IGNORE_SIZE;level_sign_display.stretch_mode = TextureRect.STRETCH_SCALE;level_sign_display.size_flags_vertical = Control.SIZE_SHRINK_BEGIN;level_sign_display.mouse_filter = Control.MOUSE_FILTER_IGNORE;level_sign_holder.add_child(level_sign_display);_update_level_sign()




	main_scroll = ScrollContainer.new();main_scroll.position = Vector2(0, 460);main_scroll.size = Vector2(540, 540);main_scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED;main_scroll.add_theme_stylebox_override("panel", _box(Color("f4faff"), Color("9fd3ec"), 2, 18));add_child(main_scroll)
	main_content = VBoxContainer.new();main_content.size_flags_horizontal = Control.SIZE_EXPAND_FILL;main_content.add_theme_constant_override("separation", 8);main_scroll.add_child(main_content)
	toast_label = _label("", 12, Color("ffffff"));toast_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;toast_label.position = Vector2(50, 168);toast_label.size = Vector2(440, 30);toast_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;toast_label.mouse_filter = Control.MOUSE_FILTER_IGNORE;toast_label.add_theme_stylebox_override("normal", _box(Color("285b7a"), Color("285b7a"), 0, 16));toast_label.modulate.a = 0.0;add_child(toast_label)
	setup_button = _button("BỐ TRÍ TIÊN MÔN", 13);setup_button.position = Vector2(20, 286);setup_button.size = Vector2(500, 42);setup_button.visible = false;setup_button.pressed.connect(_open_pre_game_adjustments);add_child(setup_button)
	start_button = _button("MỞ TIÊN MÔN / TIẾP TỤC CA", 16);start_button.position = Vector2(20, 350);start_button.size = Vector2(340, 52);start_button.pressed.connect(_toggle_run);add_child(start_button)

func _show_store() -> void :
	mode_label.text = ""
	_clear_main();shelf_stock_labels.clear();shelf_expire_marks.clear()
	for sec in SHELF_SECTIONS:
		var a: int = sec[1];var b: int = mini(int(sec[2]), shelves.size())
		if str(sec[0]) != "":
			var any_open: = false
			for i in range(a, b):
				if bool(shelves[i]["unlocked"]): any_open = true
			if not any_open: continue
			var hd: = _label(str(sec[0]), 12, Color(sec[3]));hd.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;main_content.add_child(hd)
		var grid_center: = CenterContainer.new();grid_center.size_flags_horizontal = Control.SIZE_EXPAND_FILL;main_content.add_child(grid_center)
		var grid: = GridContainer.new();grid.columns = 3;grid.size_flags_horizontal = Control.SIZE_SHRINK_CENTER;grid.add_theme_constant_override("h_separation", 2);grid.add_theme_constant_override("v_separation", 6);grid_center.add_child(grid)
		for i in range(a, b): grid.add_child(_shelf_card(i, shelves[i], false))
	_update_cards()


func _product_refining_grade(product: Dictionary) -> String:
	var grade: String = str(product.get("refining_grade", product.get("grade", "Hạ phẩm"))).strip_edges()
	return grade if not grade.is_empty() else "Hạ phẩm"


func _product_requires_refining(product: Dictionary) -> bool:
	if product.has("requires_refining"):
		return bool(product.get("requires_refining", false))
	return _product_refining_grade(product) in ["Trung phẩm", "Thượng phẩm"]


func _product_spoilage_label(product: Dictionary) -> String:
	var label: String = str(product.get("spoilage_label", "")).strip_edges()
	if not label.is_empty():
		return label
	var days: int = int(product.get("outdated_days", DEFAULT_OUTDATED_DAYS))
	return "Vĩnh viễn" if days >= 999999 else "%d ngày" % maxi(1, days)


func _show_inventory() -> void :
	mode_label.text = "THÂU MUA  ·  VẬT PHẨM"
	_clear_main()
	main_content.add_child(_label("Chọn sản phẩm đã mở khóa trong kho để thâu mua hoặc bày lên linh các", 13, Color("285b7a")))
	for i in range(products.size()):
		if bool(products[i].get("requires_paid_unlock", false)) and not _is_paid_product_unlocked(i): continue
		var p: = products[i]
		var row: = HBoxContainer.new();row.custom_minimum_size = Vector2(0, 96);row.add_theme_constant_override("separation", 8)
		row.add_child(_product_icon(i, Vector2(78, 84)))
		var size_text: = " · Size S/M/L" if _product_requires_size(p) else ""
		var element_text: String = str(p.get("element", "")).strip_edges()
		var element_segment: String = " · Hệ %s" % element_text if not element_text.is_empty() else ""
		var text_value: String = "%s · %s%s\nLV %d%s\n%s · Bán %d LT\nThâu %d LT · kho %d · Tiêu tán linh · %s" % [p["name"], p["category"], size_text, p["unlock_level"], element_segment, _product_refining_grade(p), p["price"], p["cost"], p["stock"], _product_spoilage_label(p)]
		var text: = _label(text_value, 11, Color("36556b"));text.size_flags_horizontal = Control.SIZE_EXPAND_FILL;text.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;row.custom_minimum_size = Vector2(0, 84);row.add_child(text)
		var description: String = str(p.get("description", ""))
		if not description.is_empty(): text.text += "\n" + description
		var action: = _button("BÀY" if int(p["stock"]) > 0 else ("XEM GIÁ & KỆ" if int(p["unlock_level"]) <= level else "LV %d" % p["unlock_level"]), 11);action.custom_minimum_size = Vector2(100, 54);action.disabled = not _is_product_available(i) or bool(p["incoming"]) or int(p["stock"]) <= 0;action.pressed.connect(_select_or_order.bind(i));row.add_child(action);main_content.add_child(row)

func _is_product_available(product_id: int) -> bool:
	if product_id < 0 or product_id >= products.size(): return false
	var product: Dictionary = products[product_id]
	if int(product.get("unlock_level", 99)) > level: return false
	if not _is_paid_product_unlocked(product_id): return false
	return true

func _clear_main() -> void :
	for child in main_content.get_children(): child.queue_free()

func _shelf_card_inner(index: int, shelf: Dictionary, closing: bool) -> VBoxContainer:
	var card_width: int = 150 if closing else 170
	var card_height: int = 108 if closing else 169
	var card: = VBoxContainer.new();card.custom_minimum_size = Vector2(card_width, card_height);card.alignment = BoxContainer.ALIGNMENT_BEGIN;card.add_theme_constant_override("separation", 2)
	var title: = _label(_shelf_title(index), 12, Color("285b7a"));title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;card.add_child(title)
	if not bool(shelf["unlocked"]):
		var need_lv: = int(shelf.get("level", 1))
		var locked: = _button(("KHÓA\nCần level %d" % need_lv) if level < need_lv else ("KHÓA\nMở: %s LT" % _fmt_thousands(int(shelf["unlock_cost"]))), 11);locked.custom_minimum_size = Vector2(card_width, 82)
		if closing: locked.pressed.connect(_unlock_shelf.bind(index));locked.disabled = money < int(shelf["unlock_cost"]) or level < need_lv
		else: locked.disabled = true
		card.add_child(locked);return card
	var product_id: = int(shelf["product"])
	var choices: = _shelf_choice_menu(index)
	if product_id < 0:
		var empty: = _button("+", 24);empty.custom_minimum_size = Vector2(58, 58)
		if closing:
			empty.add_theme_stylebox_override("normal", _box(Color("f7fbff"), Color("8bc5e8"), 2, 29));empty.add_theme_stylebox_override("hover", _box(Color("e8f5ff"), Color("d979a6"), 3, 29));empty.add_theme_stylebox_override("pressed", _box(Color("c7e8ff"), Color("d979a6"), 3, 29))
		else:
			var empty_frame: = _box(Color(0, 0, 0, 0), Color("d4a72c"), 3, 29)
			for state in ["normal", "hover", "pressed", "disabled", "focus"]: empty.add_theme_stylebox_override(state, empty_frame)
		var plus_row: = HBoxContainer.new();plus_row.alignment = BoxContainer.ALIGNMENT_CENTER;plus_row.add_child(empty)
		if closing: empty.pressed.connect(_toggle_shelf_choices.bind(choices))
		else: empty.disabled = true
		card.add_child(plus_row); var empty_label: = _label("THÊM SẢN PHẨM", 9, Color("285b7a"));empty_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;card.add_child(empty_label);card.add_child(choices);return card
	if closing:
		var product_row: = HBoxContainer.new();product_row.alignment = BoxContainer.ALIGNMENT_CENTER;product_row.add_theme_constant_override("separation", 4);product_row.add_child(_product_icon(product_id, Vector2(104, 88)))
		var stock_badge: = PanelContainer.new();stock_badge.custom_minimum_size = Vector2(28, 28);stock_badge.size = Vector2(28, 28);stock_badge.size_flags_horizontal = Control.SIZE_SHRINK_CENTER;stock_badge.size_flags_vertical = Control.SIZE_SHRINK_CENTER;stock_badge.mouse_filter = Control.MOUSE_FILTER_IGNORE
		var stock_frame: = _box(Color("fffaf0"), Color("8bc5e8"), 2, 14);stock_frame.content_margin_left = 0;stock_frame.content_margin_right = 0;stock_frame.content_margin_top = 0;stock_frame.content_margin_bottom = 0;stock_badge.add_theme_stylebox_override("panel", stock_frame)
		var stock_label: = _label(str(shelf["stock"]), 9, Color("285b7a"));stock_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;stock_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER;stock_badge.add_child(stock_label)
		var badge_col: = VBoxContainer.new();badge_col.add_theme_constant_override("separation", 3);badge_col.size_flags_vertical = Control.SIZE_SHRINK_CENTER;badge_col.mouse_filter = Control.MOUSE_FILTER_IGNORE
		badge_col.add_child(stock_badge);var expire_mark: = _expire_badge(_expiring_count(shelf, product_id), false);expire_mark.size_flags_horizontal = Control.SIZE_SHRINK_CENTER;badge_col.add_child(expire_mark)
		product_row.add_child(badge_col);card.add_child(product_row)
		var item: = _button(str(products[product_id]["name"]), 10);item.custom_minimum_size = Vector2(card_width - 16, 26);item.size_flags_horizontal = Control.SIZE_SHRINK_CENTER;var item_box: = _box(Color("f7fbff"), Color("a6d8ee"), 1, 10);item_box.content_margin_top = 2;item_box.content_margin_bottom = 2;item_box.content_margin_left = 6;item_box.content_margin_right = 6;item.add_theme_stylebox_override("normal", item_box);item.add_theme_stylebox_override("focus", item_box);item.pressed.connect(_toggle_shelf_choices.bind(choices));card.add_child(item)
		card.add_child(_price_controls(product_id));card.add_child(choices)
	else:
		var product_button: = Button.new()
		product_button.custom_minimum_size = Vector2(120, 120);product_button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER;product_button.disabled = int(shelf["stock"]) <= 0
		var product_frame: = _box(Color(0, 0, 0, 0), Color("d4a72c"), 3, 14)
		for state in ["normal", "hover", "pressed", "disabled", "focus"]: product_button.add_theme_stylebox_override(state, product_frame)
		var product_art: = TextureRect.new();product_art.texture = load(str(products[product_id]["image"]));product_art.expand_mode = TextureRect.EXPAND_IGNORE_SIZE;product_art.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED;product_art.mouse_filter = Control.MOUSE_FILTER_IGNORE
		product_art.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT);product_art.offset_left = 3;product_art.offset_top = 3;product_art.offset_right = -3;product_art.offset_bottom = -3;product_art.modulate = Color(1, 1, 1, 0.72) if product_button.disabled else Color(1, 1, 1, 1)
		var product_cell: = Control.new();product_cell.custom_minimum_size = Vector2(120, 120);product_cell.size_flags_horizontal = Control.SIZE_SHRINK_CENTER;product_cell.clip_contents = false;card.add_child(product_cell)
		product_button.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT);product_cell.add_child(product_button);product_button.add_child(product_art)
		var stock_badge: = PanelContainer.new();stock_badge.position = Vector2(92, -2);stock_badge.custom_minimum_size = Vector2(30, 30);stock_badge.size = Vector2(30, 30);stock_badge.mouse_filter = Control.MOUSE_FILTER_IGNORE
		var stock_frame: = _box(Color("fffaf0"), Color("d4a72c"), 2, 15);stock_frame.content_margin_left = 0;stock_frame.content_margin_right = 0;stock_frame.content_margin_top = 0;stock_frame.content_margin_bottom = 0;stock_badge.add_theme_stylebox_override("panel", stock_frame)
		var stock_label: = _label(str(shelf["stock"]), 9, Color("285b7a"));stock_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;stock_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER;stock_badge.add_child(stock_label);product_cell.add_child(stock_badge)
		shelf_stock_labels[index] = stock_label
		var store_expire: = _expire_badge(_expiring_count(shelf, product_id), true);store_expire.position = Vector2(92, 31);product_cell.add_child(store_expire)
		shelf_expire_marks[index] = store_expire
		var item: = _label(str(products[product_id]["name"]), 10, Color("36556b"));item.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;item.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;item.custom_minimum_size = Vector2(card_width, 0);item.size_flags_horizontal = Control.SIZE_FILL;card.add_child(item)
		if products[product_id].has("sizes"):
			var size_menu: = HBoxContainer.new();size_menu.visible = false;size_menu.alignment = BoxContainer.ALIGNMENT_CENTER;size_menu.add_theme_constant_override("separation", 4)
			for size in products[product_id]["sizes"]:
				var size_button: = _button(str(size), 10);size_button.custom_minimum_size = Vector2(40, 28);size_button.pressed.connect(_deliver_shelf_item.bind(index, product_id, str(size), product_button, size_menu));size_menu.add_child(size_button)
			card.add_child(size_menu);product_button.pressed.connect(_open_delivery_size_menu.bind(index, size_menu))
		else:
			product_button.pressed.connect(_deliver_shelf_item.bind(index, product_id, "", product_button, null))
	return card

func _shelf_choice_menu(shelf_index: int) -> VBoxContainer:
	var choices: = VBoxContainer.new();choices.name = "ShelfProductChoices";choices.visible = false;choices.add_theme_constant_override("separation", 2)
	# Chỉ hiện món đang có trong kho.
	for product_id in range(products.size()):
		if _is_product_available(product_id) and int(products[product_id].get("stock", 0)) > 0 and not _is_top(product_id):
			var choice: = _button("%s · kho %d" % [products[product_id]["name"], products[product_id]["stock"]], 10);choice.custom_minimum_size = Vector2(0, 28);choice.pressed.connect(_choose_product_for_shelf.bind(product_id, shelf_index, choices));choices.add_child(choice)
	if choices.get_child_count() == 0:
		var empty_note: = _label("Kho trống · hãy thâu mua trước", 10, Color("6a8ca0"));empty_note.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;empty_note.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;choices.add_child(empty_note)
	return choices

func _toggle_shelf_choices(choices: VBoxContainer) -> void :
	choices.visible = not choices.visible

func _choose_product_for_shelf(product_id: int, shelf_index: int, choices: VBoxContainer) -> void :
	if product_id < 0 or product_id >= products.size(): return
	if not _is_product_available(product_id): _show_product_unlock_hint(product_id);return
	selected_product = product_id;_place_selected(shelf_index)
	if is_instance_valid(choices): choices.visible = false

func _manual_input_style() -> StyleBoxFlat:
	var st: = _box(Color("f7fbff"), Color("a6d8ee"), 1, 8);st.content_margin_top = 0;st.content_margin_bottom = 0;st.content_margin_left = 2;st.content_margin_right = 2;return st

func _price_controls(index: int) -> HBoxContainer:
	var controls: = HBoxContainer.new();controls.alignment = BoxContainer.ALIGNMENT_CENTER
	var step_normal: = _box(Color("f7fbff"), Color("a6d8ee"), 2, 14);step_normal.content_margin_left = 0;step_normal.content_margin_right = 0;step_normal.content_margin_top = 0;step_normal.content_margin_bottom = 0
	var step_hover: = _box(Color("f1a8c6"), Color("d979a6"), 3, 14);step_hover.content_margin_left = 0;step_hover.content_margin_right = 0;step_hover.content_margin_top = 0;step_hover.content_margin_bottom = 0
	var step_pressed: = _box(Color("c7e8ff"), Color("d979a6"), 3, 14);step_pressed.content_margin_left = 0;step_pressed.content_margin_right = 0;step_pressed.content_margin_top = 0;step_pressed.content_margin_bottom = 0
	var down: = _button("-", 12);down.custom_minimum_size = Vector2(28, 24);down.add_theme_stylebox_override("normal", step_normal);down.add_theme_stylebox_override("hover", step_hover);down.add_theme_stylebox_override("pressed", step_pressed);down.add_theme_stylebox_override("disabled", step_normal);down.add_theme_stylebox_override("focus", step_normal);down.pressed.connect(_adjust_price.bind(index, -10));controls.add_child(down)
	var price: = LineEdit.new();price.text = str(int(products[index]["price"]));if not price_fields.has(index): price_fields[index] = []
	price_fields[index].append(price);price.add_theme_color_override("font_color", _price_color(index, int(products[index]["price"])));price.text_changed.connect(_recolor_price_field.bind(index, price));price.custom_minimum_size = Vector2(46, 22);price.alignment = HORIZONTAL_ALIGNMENT_CENTER;price.max_length = 6;price.add_theme_font_override("font", UI_FONT_REGULAR);price.add_theme_font_size_override("font_size", 14);price.add_theme_color_override("font_color", _price_color(index, int(products[index]["price"])));price.add_theme_color_override("caret_color", Color("d979a6"));price.add_theme_stylebox_override("normal", _manual_input_style());price.add_theme_stylebox_override("hover", _manual_input_style());price.add_theme_stylebox_override("focus", _manual_input_style());price.tooltip_text = "Nhập giá bán";price.text_submitted.connect(_set_price_from_text.bind(index, price).unbind(1));price.focus_exited.connect(_commit_price_input.bind(index, price));_mobile_input(price, true, true, "Giá bán (LT)");controls.add_child(price); var currency: = _label("LT", 11, Color("4e85a6"));currency.add_theme_font_override("font", UI_FONT_REGULAR);controls.add_child(currency)
	var up: = _button("+", 12);up.custom_minimum_size = Vector2(28, 24);up.add_theme_stylebox_override("normal", step_normal);up.add_theme_stylebox_override("hover", step_hover);up.add_theme_stylebox_override("pressed", step_pressed);up.add_theme_stylebox_override("disabled", step_normal);up.add_theme_stylebox_override("focus", step_normal);up.pressed.connect(_adjust_price.bind(index, 10));controls.add_child(up)
	return controls

func _commit_price_input(index: int, field: LineEdit) -> void :
	if index < 0 or index >= products.size() or not is_instance_valid(field): return
	var raw: = field.text.strip_edges()
	var value: = maxi(1, int(raw) if raw.is_valid_int() else int(products[index]["price"]))
	products[index]["price"] = value
	field.text = str(value)

func _set_price_from_text(index: int, field: LineEdit) -> void :
	if index < 0 or index >= products.size() or not is_instance_valid(field): return
	var raw: = field.text.strip_edges();products[index]["price"] = maxi(1, int(raw) if raw.is_valid_int() else int(products[index]["price"]));_refresh_price_tab()

func _adjust_price(index: int, amount: int) -> void :
	products[index]["price"] = maxi(1, int(products[index]["price"]) + amount);_refresh_price_tab()

func _refresh_price_tab() -> void :
	# Chỉ cập nhật ô giá / thẻ liên quan, không dựng lại cả danh sách.
	for idx in price_fields.keys():
		for field in price_fields[idx]:
			if is_instance_valid(field):
				if not field.has_focus(): field.text = str(int(products[idx]["price"]))
				field.add_theme_color_override("font_color", _price_color(idx, int(products[idx]["price"])))
	if active_close_tab == "imports":
		for idx in range(products.size()):
			if import_card_nodes.has(idx): _refresh_import_card(idx)
	_touch_tab_sig()

func _order_controls(index: int) -> HBoxContainer:
	var controls: = HBoxContainer.new();controls.alignment = BoxContainer.ALIGNMENT_CENTER
	var product: Dictionary = products[index]
	var quantity: = clampi(int(product.get("order_quantity", 0)), 0, MAX_ORDER_QUANTITY)
	var step_normal: = _box(Color("f7fbff"), Color("a6d8ee"), 2, 14);step_normal.content_margin_left = 0;step_normal.content_margin_right = 0;step_normal.content_margin_top = 0;step_normal.content_margin_bottom = 0
	var step_hover: = _box(Color("f1a8c6"), Color("d979a6"), 3, 14);step_hover.content_margin_left = 0;step_hover.content_margin_right = 0;step_hover.content_margin_top = 0;step_hover.content_margin_bottom = 0
	var step_pressed: = _box(Color("c7e8ff"), Color("d979a6"), 3, 14);step_pressed.content_margin_left = 0;step_pressed.content_margin_right = 0;step_pressed.content_margin_top = 0;step_pressed.content_margin_bottom = 0
	var down: = _button("-", 11);down.custom_minimum_size = Vector2(28, 24);down.add_theme_stylebox_override("normal", step_normal);down.add_theme_stylebox_override("hover", step_hover);down.add_theme_stylebox_override("pressed", step_pressed);down.add_theme_stylebox_override("disabled", step_normal);down.add_theme_stylebox_override("focus", step_normal);down.pressed.connect(_adjust_order_quantity.bind(index, -5));controls.add_child(down)
	var amount: = LineEdit.new();amount.text = str(quantity);amount.custom_minimum_size = Vector2(42, 27);amount.alignment = HORIZONTAL_ALIGNMENT_CENTER;amount.add_theme_font_override("font", UI_FONT_REGULAR);amount.add_theme_font_size_override("font_size", 13);amount.add_theme_color_override("font_color", Color("285b7a"));amount.add_theme_stylebox_override("normal", _manual_input_style());amount.add_theme_stylebox_override("hover", _manual_input_style());amount.add_theme_stylebox_override("focus", _manual_input_style());amount.max_length = 3;amount.placeholder_text = "0";amount.tooltip_text = "Nhập số lượng";amount.text_submitted.connect(_set_order_quantity_from_text.bind(index, amount).unbind(1));amount.focus_exited.connect(_commit_order_quantity_input.bind(index, amount));_mobile_input(amount, true, true, "Số lượng thâu mua");controls.add_child(amount)
	var up: = _button("+", 11);up.custom_minimum_size = Vector2(28, 24);up.add_theme_stylebox_override("normal", step_normal);up.add_theme_stylebox_override("hover", step_hover);up.add_theme_stylebox_override("pressed", step_pressed);up.add_theme_stylebox_override("disabled", step_normal);up.add_theme_stylebox_override("focus", step_normal);up.pressed.connect(_adjust_order_quantity.bind(index, 5));controls.add_child(up)
	var order: = _button("THÂU", 10);order.custom_minimum_size = Vector2(54, 30);order.add_theme_stylebox_override("normal", step_normal);order.add_theme_stylebox_override("hover", step_hover);order.add_theme_stylebox_override("pressed", step_pressed);order.add_theme_stylebox_override("focus", step_normal);order.autowrap_mode = TextServer.AUTOWRAP_OFF;order.disabled = bool(product.get("incoming", false)) or not _is_product_available(index) or quantity <= 0;order.tooltip_text = "Thâu mua %d món, tổng %d LT" % [quantity, quantity * int(product["cost"])];order.pressed.connect(_order_product.bind(index));controls.add_child(order)
	return controls

func _commit_order_quantity_input(index: int, field: LineEdit) -> void :
	if index < 0 or index >= products.size() or not is_instance_valid(field): return
	var product: Dictionary = products[index]
	var value: = int(field.text.strip_edges()) if field.text.strip_edges().is_valid_int() else int(product.get("order_quantity", 0))
	var current: = clampi(int(product.get("order_quantity", 0)), 0, MAX_ORDER_QUANTITY)
	_adjust_order_quantity(index, clampi(value, 0, MAX_ORDER_QUANTITY) - current, false)
	field.text = str(clampi(int(product.get("order_quantity", 0)), 0, MAX_ORDER_QUANTITY))

func _set_order_quantity_from_text(index: int, field: LineEdit) -> void :
	if index < 0 or index >= products.size() or not is_instance_valid(field): return
	var product: Dictionary = products[index]
	var value: = int(field.text.strip_edges()) if field.text.strip_edges().is_valid_int() else int(product.get("order_quantity", 0))
	var current: = clampi(int(product.get("order_quantity", 0)), 0, MAX_ORDER_QUANTITY)
	_adjust_order_quantity(index, clampi(value, 0, MAX_ORDER_QUANTITY) - current, true)

func _adjust_order_quantity(index: int, delta: int, refresh_ui: bool = true) -> void :
	if not _is_product_available(index): return
	var product: Dictionary = products[index]
	var current: = clampi(int(product.get("order_quantity", 0)), 0, MAX_ORDER_QUANTITY)
	var next: = clampi(current + delta, 0, MAX_ORDER_QUANTITY)
	if bool(product.get("incoming", false)):
		var cost_delta: = (next - current) * int(product["cost"])
		if cost_delta > 0 and money < cost_delta:
			_show_toast("Chưa đủ tiền tăng lô thâu mua %s." % product["name"]);return
		money -= cost_delta
		if cost_delta != 0: _log_expense("Thâu mua %s (chỉnh lô)" % product["name"], cost_delta)
		product["incoming_quantity"] = next
		if next <= 0:
			product["incoming"] = false;product["incoming_quantity"] = 0;product["ready_at"] = 0
			for order_index in range(daily_imports.size() - 1, -1, -1):
				if int(daily_imports[order_index]["product_id"]) == index: daily_imports.remove_at(order_index)
		else:
			for order in daily_imports:
				if int(order["product_id"]) == index:
					order["quantity"] = next;order["cost"] = next * int(product["cost"]);break
		product["order_quantity"] = next
		_show_toast("Đã chỉnh %s còn x%d, LT thâu mua cập nhật %d LT." % [product["name"], next, next * int(product["cost"])])
	else:
		product["order_quantity"] = next
	if refresh_ui:
		_update_money_display();_refresh_import_card(index)
	else:
		_update_money_display()
		_update_ui()
	_update_import_summary()

func _update_import_summary() -> void :
	if next_day_button != null:
		next_day_button.text = _import_summary_text()

func _planned_import_total() -> int:
	var total: = 0
	for product in products:
		total += clampi(int(product.get("order_quantity", 0)), 0, MAX_ORDER_QUANTITY) * int(product["cost"])
	return total

func _import_summary_text() -> String:
	var total: = 0
	for product in products:
		total += clampi(int(product.get("order_quantity", 0)), 0, MAX_ORDER_QUANTITY) * int(product["cost"])
	return "LINH THẠCH THÂU MUA DỰ TÍNH: %d LT\nBấm để nhận lương và chơi ngày mới" % total

func _toggle_run() -> void :
	if running:
		return
	running = true
	paused = false
	manual_pause = false
	start_button.visible = false
	pause_button.disabled = false
	_set_pause_glyph(false)
	pause_menu_panel.visible = false
	setup_button.visible = false
	_show_toast("Ca đã mở cửa — khách thường chờ %ds, VIP chờ %ds." % [int(NORMAL_PATIENCE_SECONDS), int(VIP_PATIENCE_SECONDS)])
	# Mở cửa là có khách ngay, không chờ lượt đầu.
	if queue.is_empty() and not _shelf_product_ids().is_empty():
		queue.append(_new_customer(false));_play_door()
	spawn_clock = 0.0
	call_deferred("_tut_event", "opened")
	_show_store()

func _open_pause_menu() -> void :
	if not running:
		return
	move_child(pause_menu_panel, get_child_count() - 1)
	if not paused:
		paused = true
		_set_pause_glyph(true)
		_show_toast("Đã tạm dừng ca — thời gian và độ kiên nhẫn được giữ nguyên.")
	manual_pause = true
	pause_menu_toggle_button.text = "TIẾP TỤC CA"
	pause_menu_panel.visible = not pause_menu_panel.visible

func _on_pause_menu_toggle_pressed() -> void :
	pause_menu_panel.visible = false
	_toggle_pause()

func _on_pause_menu_end_pressed() -> void :
	pause_menu_panel.visible = false
	_end_day()

func _toggle_pause() -> void :
	if not running:
		return
	pause_menu_panel.visible = false
	paused = not paused
	manual_pause = paused
	_set_pause_glyph(paused)
	_show_toast("Đã tạm dừng ca — thời gian và độ kiên nhẫn được giữ nguyên." if paused else "Ca đã tiếp tục.")

func _checkout(by_staff: bool = false) -> void :
	if queue.is_empty(): return
	var customer: Dictionary = queue[0]
	if not _all_customer_items_delivered(customer) or int(customer.get("delivery_animations_pending", 0)) > 0:
		_show_toast("Cần giao đủ món và chọn đúng size trước khi thanh toán.")
		return
	customer = queue.pop_front()
	var revenue: = 0
	var srcs: Array = customer.get("src", [])
	var cprices: Array = customer.get("cprice", [])
	var has_combo: = false
	for item_k in range(customer["items"].size()):
		var product_id: int = int(customer["items"][item_k])
		var p: = products[int(product_id)]
		var price_each: = float(p["price"])
		var src_kind: String = str(srcs[item_k]) if item_k < srcs.size() else ""
		if src_kind == "consign":
			revenue += int(round(float(cprices[item_k]) * CONSIGN_COMMISSION))
			_stat_add("consign_sold")
			continue
		if src_kind == "vip": price_each *= VIP_SHELF_BONUS
		if src_kind == "combo": price_each *= COMBO_BONUS;has_combo = true
		price_each *= _ext8_price_mult(product_id, customer)
		if _up("beast_yard") >= 3 and _cat(int(product_id)) == "linh thú": price_each *= 1.2
		if _tr("fish_tank") and str(p["name"]) == "Trứng Nguyệt Quang Ngư": price_each *= 1.5
		if int(product_id) == festival_featured and not _festival_today().is_empty(): price_each *= FESTIVAL_PRICE_BONUS
		revenue += int(round(price_each))
	best_seller = products[int(customer["items"][0])]["name"]
	revenue_today += revenue
	for sold_product_id in customer["items"]:
		var sold_key: = str(int(sold_product_id))
		sold_today[sold_key] = int(sold_today.get(sold_key, 0)) + 1
	var tip: = int(round(float(revenue) * 0.05 * _tip_multiplier(customer)))
	var cond_result: = _cond_result(customer)
	if cond_result == 1: tip *= 2
	_fake_goods_check(customer)
	_ext8_after_checkout(customer, by_staff)
	if bool(customer["vip"]): vip_served_today += 1
	if _staff_can_work():
		tips += tip
		_log_expense("Tip nhân viên", tip)
		money += revenue - tip
	else:
		store_tips += tip
		money += revenue + tip
	_sfx("sell")
	_stat_add("sold", customer["items"].size());_stat_add("orders");_stat_add("revenue", revenue);_stat_add("tips", tip)
	if bool(customer["vip"]): _stat_add("vip")
	for spid in customer["items"]: _stat_add("sold_" + _cat(int(spid)))
	_incident_after_checkout(customer["items"])
	xp += 20 if bool(customer["vip"]) else 10
	successful_orders += 1
	var stars: = 5 if not by_staff else randi_range(3, 5)
	var max_patience: = VIP_PATIENCE_SECONDS if bool(customer["vip"]) else NORMAL_PATIENCE_SECONDS
	if _has("barker") and float(customer.get("patience", max_patience)) < max_patience * 0.5 and randf() < 0.5: stars = maxi(1, stars - 1)
	if _has("beauty") and randf() < 0.15: stars = maxi(1, stars - 1)
	stars = _review_bonus(stars, bool(customer["vip"]))
	if has_combo: stars = mini(5, stars + 1)
	if cond_result == -1: stars = mini(stars, 2)
	if cond_result == 1: call_deferred("_show_toast", "Đáp ứng yêu cầu đặc biệt của khách: tip gấp đôi!")
	elif cond_result == -1: call_deferred("_show_toast", "Không đáp ứng yêu cầu đặc biệt: khách chỉ cho 2 sao.")
	var review_text: = "Dịch vụ tuyệt vời, set hàng rất hợp gu!" if stars >= 4 else "Phục vụ còn hơi lúng túng, cần cải thiện."
	_add_review(customer, stars, review_text)
	if stars >= 5: _stat_add("five_star")
	_ach_check()
	var tip_note: = "tip nhân viên %d LT" % tip if _staff_can_work() else "tip cửa hàng +%d LT" % tip
	_show_toast("Đã bán %d món · nhận %d LT · %s." % [customer["items"].size(), revenue - tip if _staff_can_work() else revenue + tip, tip_note])
	_check_level()
	_show_store()
	if not by_staff: call_deferred("_tut_event", "sold")

func _defer_customer() -> void :
	if queue.is_empty() or not running:
		return
	var customer: Dictionary = queue.pop_front()
	walked_out += 1
	_sfx("leave")
	_add_review(customer, randi_range(1, 2), "Xin hẹn lần sau — khách đã bị bỏ qua để phục vụ người tiếp theo.")
	_show_toast("Đã hẹn %s lần sau. Khách kế tiếp được phục vụ; đánh giá bị giảm." % customer["name"])
	_show_store()
	_update_ui()

func _consume_one(product_id: int) -> void :
	for shelf in shelves:
		if int(shelf["product"]) == product_id and int(shelf["stock"]) > 0:
			_consume_stock_unit(shelf)
			if int(shelf["stock"]) == 0: shelf["product"] = -1
			return
	if int(products[product_id]["stock"]) > 0: _consume_stock_unit(products[product_id])

func _normalize_stock_ages(value: Variant, quantity: int) -> Array[int]:
	var ages: Array[int] = []
	if value is Array:
		for age in value: ages.append(maxi(0, int(age)))
	while ages.size() < quantity: ages.append(0)
	while ages.size() > quantity: ages.pop_back()
	return ages

func _consume_stock_unit(container: Dictionary) -> bool:
	var quantity: = int(container.get("stock", 0))
	if quantity <= 0: return false
	var ages: = _normalize_stock_ages(container.get("stock_ages", []), quantity)
	ages.sort()
	ages.reverse()
	ages.pop_front()
	container["stock"] = quantity - 1
	container["stock_ages"] = ages
	return true

# Vật phẩm đang bày trên kệ: hàng mới thâu được cộng thẳng lên kệ đó. Trả về số kệ (1..n), 0 nếu không có kệ nào bày món này.
func _push_stock_to_existing_shelf(product_id: int) -> int:
	for i in range(shelves.size()):
		var shelf: Dictionary = shelves[i]
		if bool(shelf.get("unlocked", false)) and int(shelf.get("product", -1)) == product_id:
			var moved: = _take_inventory_units(product_id, int(products[product_id].get("stock", 0)))
			if moved.is_empty(): return 0
			var ages: = _normalize_stock_ages(shelf.get("stock_ages", []), int(shelf.get("stock", 0)))
			ages.append_array(moved)
			shelf["stock_ages"] = ages
			shelf["stock"] = ages.size()
			return i + 1
	return 0

func _take_inventory_units(product_id: int, quantity: int) -> Array[int]:
	var product: Dictionary = products[product_id]
	var ages: = _normalize_stock_ages(product.get("stock_ages", []), int(product.get("stock", 0)))
	ages.sort()
	ages.reverse()
	var moved: Array[int] = []
	for i in range(mini(quantity, ages.size())): moved.append(ages.pop_front())
	product["stock"] = int(product.get("stock", 0)) - moved.size()
	product["stock_ages"] = ages
	return moved

func _return_shelf_stock_to_inventory(shelf: Dictionary) -> void :
	var product_id: = int(shelf.get("product", -1))
	if product_id >= 0 and int(shelf.get("stock", 0)) > 0:
		var product: Dictionary = products[product_id]
		var product_ages: = _normalize_stock_ages(product.get("stock_ages", []), int(product.get("stock", 0)))
		product_ages.append_array(_normalize_stock_ages(shelf.get("stock_ages", []), int(shelf.get("stock", 0))))
		product["stock_ages"] = product_ages
		product["stock"] = product_ages.size()
	shelf["product"] = -1
	shelf["stock"] = 0
	shelf["stock_ages"] = []

func _age_and_expire_stock(container: Dictionary, outdated_days: int) -> int:
	# Hạn tính từ hôm sau ngày mua: mua cuối ngày 10, hạn 2 ngày -> bán được ngày 11 và 12, sang ngày 13 mới tiêu tán.
	var ages: = _normalize_stock_ages(container.get("stock_ages", []), int(container.get("stock", 0)))
	var fresh_ages: Array[int] = []
	var expired: = 0
	for age in ages:
		var new_age: = age + 1
		if new_age > outdated_days: expired += 1
		else: fresh_ages.append(new_age)
	container["stock_ages"] = fresh_ages
	container["stock"] = fresh_ages.size()
	return expired

func _age_outdated_stock() -> void :
	var notices: Array[String] = []
	for product_id in range(products.size()):
		var product: Dictionary = products[product_id]
		if bool(product.get("permanent_stock", false)):
			continue
		var outdated_days: = maxi(1, int(product.get("outdated_days", DEFAULT_OUTDATED_DAYS)))
		if _has("beastkeeper") and _cat(product_id) == "linh thú": outdated_days += 1
		if _up("beast_yard") >= 2 and _cat(product_id) == "linh thú": outdated_days += 2
		var expired: = _age_and_expire_stock(product, outdated_days + int([0, 1, 2, 4][_up("vault")]))
		for shelf in shelves:
			if int(shelf.get("product", -1)) == product_id:
				expired += _age_and_expire_stock(shelf, outdated_days)
				if int(shelf["stock"]) <= 0: shelf["product"] = -1
			if expired > 0: notices.append("%s x%d" % [product["name"], expired])
	if not notices.is_empty(): _show_toast("Tiêu tán linh, đã bỏ khỏi kho và kệ: " + ", ".join(notices))

func _order_product(index: int) -> void :
	var p: = products[index]
	if bool(p.get("requires_paid_unlock", false)) and not _is_paid_product_unlocked(index): _show_product_unlock_hint(index);return
	if bool(p["incoming"]): return
	if int(p["unlock_level"]) > level: _show_toast("Mẫu này mở ở level %d." % p["unlock_level"]);return
	var quantity: = clampi(int(p.get("order_quantity", 0)), 0, MAX_ORDER_QUANTITY)
	if quantity <= 0: _show_toast("Hãy tăng số lượng thâu mua trước khi đặt %s." % p["name"]);return
	var room: = _warehouse_cap() - _warehouse_used()
	if room <= 0: _show_toast("Linh khố đã đầy (%d/%d món). Bày hàng lên kệ hoặc nâng cấp Linh khố trận pháp." % [_warehouse_used(), _warehouse_cap()]);return
	if quantity > room:
		quantity = room;_show_toast("Linh khố chỉ còn chỗ cho %d món, chỉ thâu %d." % [room, room])
	var total_cost: = int(p["cost"]) * quantity
	var discount: = 1.0
	if _has("merchant"): discount -= 0.10
	if _has("escort") and quantity >= 50: discount -= 0.05
	total_cost = maxi(1, int(round(total_cost * discount))) if discount < 1.0 else total_cost
	if money < total_cost: _show_toast("Chưa đủ LT thâu mua %s x%d." % [p["name"], quantity]);return

	money -= total_cost
	_log_expense("Thâu mua %s" % p["name"], total_cost)
	_sfx("coin")
	call_deferred("_tut_event", "ordered")
	_update_money_display()
	var stock: = int(p.get("stock", 0))
	var ages: = _normalize_stock_ages(p.get("stock_ages", []), stock)
	for _i in range(quantity): ages.append(0)
	p["stock"] = stock + quantity;p["stock_ages"] = ages;p["incoming"] = false;p["incoming_quantity"] = 0;p["ready_at"] = 0;p["order_quantity"] = 0
	daily_imports.append({"product_id": index, "quantity": quantity, "delivered": quantity, "cost": total_cost})
	var robbed: = _incident_robbery(index, quantity)
	if robbed > 0:
		robbed = _take_inventory_units(index, robbed).size()
		_log_goods_loss("cướp đường thương", index, robbed)
		_incident_push("ĐƯỜNG THƯƠNG BỊ CƯỚP", "Đoàn thương chở lô %s x%d bị cướp giữa đường, mất %d món." % [p["name"], quantity, robbed])
	var shelf_no: = _push_stock_to_existing_shelf(index)
	if shelf_no > 0:
		_show_toast("Đã thâu mua %s x%d, cộng thẳng lên kệ %d, trừ %d LT." % [p["name"], quantity, shelf_no, total_cost])
	else:
		_show_toast("Đã thâu mua %s x%d vào linh khố, trừ %d LT." % [p["name"], quantity, total_cost])
	if close_content != null and active_close_tab == "imports":
		_refresh_import_card(index)
	elif close_content != null:
		_show_import_adjustments()
	else:
		_show_inventory()
	_update_ui()

func _select_or_order(index: int) -> void :
	if not _is_product_available(index): return
	if int(products[index]["stock"]) > 0: selected_product = index;_show_toast("Đã chọn %s · vào điều chỉnh sau khi đóng cửa để chọn kệ." % products[index]["name"]);return
	_order_product(index)

func _select_shelf_product(index: int) -> void :
	selected_product = int(shelves[index]["product"]);_show_toast("Đã chọn %s để đổi vị trí." % products[selected_product]["name"])

func _place_selected(index: int) -> void :
	if selected_product >= 0 and _is_top(selected_product):
		_show_toast("Hàng Thượng phẩm không bán cho khách thường, chỉ bán qua Đấu giá.");selected_product = -1;return
	if selected_product < 0: _show_toast("Hãy chọn sản phẩm trong tab Nhập hàng trước.");return
	if not _is_product_available(selected_product): _show_product_unlock_hint(selected_product);return
	if not shelves[index]["unlocked"]: return
	if int(products[selected_product]["stock"]) <= 0: _show_toast("Sản phẩm này chưa có trong kho.");return
	for shelf in shelves:
		if int(shelf["product"]) == selected_product: _return_shelf_stock_to_inventory(shelf)
	if int(shelves[index]["product"]) >= 0: _return_shelf_stock_to_inventory(shelves[index])
	var moved: = _take_inventory_units(selected_product, int(products[selected_product]["stock"]))
	if moved.is_empty(): _show_toast("Sản phẩm này chưa có trong kho.");return
	shelves[index]["product"] = selected_product;shelves[index]["stock_ages"] = moved;shelves[index]["stock"] = moved.size();selected_product = -1;call_deferred("_tut_event", "placed")
	if close_content != null: _show_shelf_adjustments()

func _unlock_shelf(index: int) -> void :
	if running or shelves[index]["unlocked"]: return
	var cost: = int(shelves[index]["unlock_cost"])
	if level < int(shelves[index].get("level", 1)): _show_toast("Cần level %d để mở %s." % [int(shelves[index]["level"]), _shelf_title(index)]);return
	if money < cost: _show_toast("Cần %d LT để mở %s." % [cost, _shelf_title(index)]);return
	money -= cost;_sfx("unlock");_log_expense("Mở %s" % _shelf_title(index), cost);shelves[index]["unlocked"] = true;_show_toast("Đã mở %s." % _shelf_title(index))
	var kind: = str(shelves[index].get("kind", ""))
	if kind != "": _guide_once("g_shelf_" + kind)
	if kind == "consign": _consign_make_offer(shelves[index])
	_show_shelf_adjustments()

func _update_cards() -> void :
	# Số tồn trên kệ cập nhật ngay sau mỗi lần giao.
	for idx in shelf_stock_labels.keys():
		var sl: Variant = shelf_stock_labels[idx]
		if is_instance_valid(sl) and int(idx) < shelves.size(): sl.text = str(int(shelves[int(idx)]["stock"]))
	for idx in shelf_expire_marks.keys():
		var em: Variant = shelf_expire_marks[idx]
		if is_instance_valid(em) and int(idx) < shelves.size():
			var lbl: Label = em.get_node_or_null("Count")
			if lbl: lbl.text = str(_expiring_count(shelves[int(idx)], int(shelves[int(idx)]["product"])))
	if queue.is_empty():
		customer_avatar_control = null
		store_content.move_child(customer_portrait_frame, 0)
		if displayed_customer_order_id != -1:
			for child in customer_card.get_children(): child.queue_free()
			for child in customer_portrait_frame.get_children(): child.queue_free()
			var open_message: = _label("Cửa đang mở · khách sẽ tự vào xem kệ", 14, Color("285b7a"));open_message.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;open_message.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;open_message.vertical_alignment = VERTICAL_ALIGNMENT_CENTER;customer_card.add_child(open_message)
			customer_patience_label = null
			customer_delivery_label = null
			displayed_customer_order_id = -1
			displayed_delivery_signature = ""
			displayed_running_state = running
		return
	var customer: Dictionary = queue[0]
	var delivery_signature: = ""
	for delivered in customer.get("delivered_items", []): delivery_signature += "1" if bool(delivered) else "0"
	var order_id: = int(customer["order_id"])
	if order_id == displayed_customer_order_id and delivery_signature == displayed_delivery_signature and running == displayed_running_state:
		if customer_patience_label: customer_patience_label.text = "Kiên nhẫn %ds" % int(customer["patience"])
		if customer_delivery_label: customer_delivery_label.text = _delivery_status_text(customer)
		return
	var portrait_screen_side: String = str(customer.get("screen_side", "left"))
	store_content.move_child(customer_portrait_frame, 1 if portrait_screen_side == "right" else 0)
	for child in customer_card.get_children(): child.queue_free()
	for child in customer_portrait_frame.get_children(): child.queue_free()
	displayed_customer_order_id = order_id
	displayed_delivery_signature = delivery_signature
	displayed_running_state = running
	var content: = VBoxContainer.new();content.add_theme_constant_override("separation", 2);content.size_flags_vertical = Control.SIZE_EXPAND_FILL;customer_card.add_child(content)
	var portrait_margin: = MarginContainer.new()
	for side in ["left", "right"]: portrait_margin.add_theme_constant_override("margin_%s" % side, 3)
	portrait_margin.add_theme_constant_override("margin_top", 0);portrait_margin.add_theme_constant_override("margin_bottom", 0)
	portrait_margin.size_flags_horizontal = Control.SIZE_EXPAND_FILL;portrait_margin.size_flags_vertical = Control.SIZE_EXPAND_FILL;customer_portrait_frame.add_child(portrait_margin)
	portrait_margin.clip_contents = true
	var customer_avatar: = _customer_icon(int(customer["avatar"]), Vector2(183, 237));customer_avatar.size_flags_horizontal = Control.SIZE_EXPAND_FILL;customer_avatar.size_flags_vertical = Control.SIZE_SHRINK_END;portrait_margin.add_child(customer_avatar)
	customer_avatar_control = customer_avatar
	var details: = VBoxContainer.new();details.size_flags_horizontal = Control.SIZE_EXPAND_FILL;content.add_child(details)
	var customer_name_label: = _label("%s%s%s" % ["VIP · " if customer["vip"] else "", "Hội viên · " if bool(customer.get("member", false)) else "", customer["name"]], 15, Color("285b7a"), true);customer_name_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;details.add_child(customer_name_label)
	var customer_request_label: = _label("Yêu cầu: %s" % _customer_items_text(customer), 11, Color("36556b"));customer_request_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;details.add_child(customer_request_label)
	if str(customer.get("cond", "")) != "":
		var cond_label: = _label(_cond_text(customer), 10, Color("c0702a") if bool(customer.get("cond_ok", true)) else Color("d64545"));cond_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;details.add_child(cond_label)
	var status_row: = HBoxContainer.new();status_row.add_theme_constant_override("separation", 12);details.add_child(status_row)
	customer_delivery_label = _label(_delivery_status_text(customer), 10, Color("285b7a"));status_row.add_child(customer_delivery_label)
	customer_patience_label = _label("Kiên nhẫn %ds" % int(customer["patience"]), 11, Color("d979a6"));status_row.add_child(customer_patience_label)
	# Nút hẹn lần sau nằm gọn ở góc dưới khung yêu cầu của khách.
	var spacer: = Control.new();spacer.size_flags_vertical = Control.SIZE_EXPAND_FILL;spacer.mouse_filter = Control.MOUSE_FILTER_IGNORE;content.add_child(spacer)
	var defer_row: = HBoxContainer.new();defer_row.alignment = BoxContainer.ALIGNMENT_END;content.add_child(defer_row)
	var defer_button: = _button("HẸN LẦN SAU", 6);defer_button.tooltip_text = "Bỏ qua khách hiện tại để phục vụ khách phía sau; đánh giá sẽ giảm.";defer_button.custom_minimum_size = Vector2(0, 21);defer_button.autowrap_mode = TextServer.AUTOWRAP_OFF
	var dst: = _box(Color("f7fbff"), Color("a6d8ee"), 1, 8);dst.content_margin_left = 8;dst.content_margin_right = 8;dst.content_margin_top = 1;dst.content_margin_bottom = 1
	defer_button.add_theme_stylebox_override("normal", dst);defer_button.add_theme_stylebox_override("hover", dst);defer_button.add_theme_stylebox_override("focus", dst)
	defer_button.disabled = not running;defer_button.pressed.connect(_defer_customer);defer_row.add_child(defer_button)

func _delivery_status_text(customer: Dictionary) -> String:
	var delivered_count: = 0
	for delivered in customer.get("delivered_items", []):
		if bool(delivered): delivered_count += 1
	return "Đã giao %d món" % delivered_count

func _open_delivery_size_menu(shelf_index: int, submenu: Control) -> void :
	if shelf_index < 0 or shelf_index >= shelves.size(): return
	var product_id: = int(shelves[shelf_index]["product"])
	if product_id < 0 or int(shelves[shelf_index]["stock"]) <= 0: return
	submenu.visible = not submenu.visible

func _first_undelivered_order_item(customer: Dictionary, product_id: int) -> int:
	var delivered_items: Array = customer.get("delivered_items", [])
	for item_index in range(customer["items"].size()):
		if int(customer["items"][item_index]) == product_id and item_index < delivered_items.size() and not bool(delivered_items[item_index]):
			return item_index
	return -1

func _deliver_shelf_item(shelf_index: int, product_id: int, selected_size: String, source_button: Control = null, size_menu: Control = null, by_staff: bool = false, skip_refining: bool = false) -> void :
	if not running and not by_staff:
		_show_toast("Mở cửa ca trước rồi chọn size để giao hàng.");return
	if queue.is_empty():
		_show_toast("Chưa có khách đang chờ.");return
	if shelf_index < 0 or shelf_index >= shelves.size(): return
	if int(shelves[shelf_index]["product"]) != product_id or int(shelves[shelf_index]["stock"]) <= 0: return
	var customer: Dictionary = queue[0]
	if str(shelves[shelf_index].get("kind", "")) == "vip" and not bool(customer.get("vip", false)):
		if not by_staff: _show_toast("Kệ VIP Bảo Các chỉ bán cho khách VIP.")
		return
	var item_index: = _first_undelivered_order_item(customer, product_id)
	if item_index < 0:
		if not by_staff:
			customer["patience"] = maxf(0.0, float(customer["patience"]) - WRONG_ITEM_PATIENCE_PENALTY)
			_sfx("wrong")
			# Giao sai món: món đó bị mất (trừ 1 khỏi kệ), ghi chi phí theo giá thâu.
			_consume_stock_unit(shelves[shelf_index])
			_log_expense("Bán nhầm %s" % products[product_id]["name"], int(products[product_id].get("cost", 0)))
			_incident_after_wrong_delivery(product_id)
			if str(customer.get("cond", "")) == "careful" and bool(customer.get("cond_ok", true)):
				customer["cond_ok"] = false;displayed_delivery_signature = ""
			_show_toast("Sai món! Khách không cần %s · mất 1 %s · kiên nhẫn −%ds." % [products[product_id]["name"], products[product_id]["name"], int(WRONG_ITEM_PATIENCE_PENALTY)])
			if int(shelves[shelf_index]["stock"]) <= 0:
				shelves[shelf_index]["product"] = -1
				_show_store()
			_update_cards()
		else:
			_show_toast("Khách hiện không yêu cầu %s." % products[product_id]["name"])
		return
	var product: Dictionary = products[product_id]
	if _product_requires_size(product):
		var requested_size: = str(customer.get("item_sizes", [])[item_index])
		if selected_size != requested_size:
			customer["patience"] = maxf(0.0, float(customer["patience"]) - WRONG_SIZE_PATIENCE_PENALTY)
			_sfx("wrong")
			_show_toast("Sai size! Khách chờ ít hơn 5 giây. Yêu cầu size %s." % requested_size)
			_update_cards()
			return
	else:
		selected_size = ""
	if not by_staff and not skip_refining and _product_requires_refining(product):
		_open_refining_minigame(shelf_index, product_id, selected_size, source_button, size_menu, by_staff)
		return
	var delivered_items: Array = customer.get("delivered_items", [])
	delivered_items[item_index] = true
	customer["delivered_items"] = delivered_items
	var item_sizes: Array = customer.get("item_sizes", [])
	while item_sizes.size() < customer["items"].size(): item_sizes.append("")
	item_sizes[item_index] = selected_size
	customer["item_sizes"] = item_sizes
	customer["served_by_staff"] = by_staff
	_set_item_src(customer, item_index, str(shelves[shelf_index].get("kind", "")), 0)
	customer["delivery_animations_pending"] = int(customer.get("delivery_animations_pending", 0)) + 1
	if size_menu != null: size_menu.visible = false
	_consume_stock_unit(shelves[shelf_index])
	if not by_staff: _sfx("deliver")
	var shelf_empty: = int(shelves[shelf_index]["stock"]) <= 0
	_update_cards()
	if source_button != null and is_instance_valid(source_button) and customer_avatar_control != null and is_instance_valid(customer_avatar_control):
		_animate_product_delivery(product_id, source_button, customer_avatar_control, int(customer["order_id"]))
	else:
		_delivery_animation_completed(int(customer["order_id"]))
	if shelf_empty:
		shelves[shelf_index]["product"] = -1
		_show_store()

func _open_refining_minigame(shelf_index: int, product_id: int, selected_size: String, source_button: Control, size_menu: Control, by_staff: bool) -> void:
	if is_instance_valid(active_refining_minigame):
		return
	if product_id < 0 or product_id >= products.size():
		return
	var missing_materials: Array[String] = _missing_refining_materials(product_id)
	if not missing_materials.is_empty():
		call_deferred("_tut_event", "missing_mats")
		_sfx("wrong")
		_show_toast("Không đủ nguyên liệu để tinh luyện %s · Thiếu: %s. Hãy mua thêm ở Thương Hội trước khi mở ca." % [products[product_id]["name"], ", ".join(missing_materials)])
		return
	# Tinh luyện gộp: khách cần X món này thì tinh luyện một lần cho cả X món (mỗi món thêm 0,5 giây).
	var qty: = _refine_batch_size(shelf_index, product_id)
	var auto: = _staff_auto_refine(product_id)
	if auto != 0 and not _has("alchemist") and _incident_refiner_quit(product_id):
		return
	if auto != 0:
		for _k in range(qty): _consume_refining_materials(product_id)
		if auto < 0:
			_sfx("wrong")
			_show_toast("Tiểu Hỏa tinh luyện hỏng mẻ %s, mất nguyên liệu." % products[product_id]["name"])
			return
		if _has("alchemist") and not queue.is_empty(): queue[0]["patience"] = maxf(0.0, float(queue[0]["patience"]) - 5.0)
		_sfx("refine")
		_show_toast("%s đã tinh luyện xong %d %s." % ["Cát sư phụ" if _has("alchemist") else "Tiểu Hỏa", qty, products[product_id]["name"]])
		for k in range(qty): _deliver_shelf_item(shelf_index, product_id, selected_size, source_button if k == 0 else null, size_menu, by_staff, true)
		return
	pending_refining_delivery = {
		"shelf_index": shelf_index,
		"product_id": product_id,
		"selected_size": selected_size,
		"source_button": source_button,
		"size_menu": size_menu,
		"by_staff": by_staff,
		"qty": qty,
	}
	paused_before_refining = paused
	paused = true
	if is_instance_valid(pause_button):
		_set_pause_glyph(true)
	var minigame: Control = REFINING_MINIGAME_SCRIPT.new()
	minigame.z_index = 200
	minigame.configure(products[product_id], day_number, level, store_name, qty, _product_refining_grade(products[product_id]) == "Trung phẩm")
	minigame.set_ease(_up("refine_room"))
	call_deferred("_tut_event", "minigame")
	minigame.completed.connect(_on_refining_minigame_completed)
	minigame.cancelled.connect(_on_refining_minigame_cancelled)
	minigame.overheated.connect(_on_refining_minigame_overheated)
	active_refining_minigame = minigame
	add_child(minigame)

func _on_refining_minigame_completed() -> void:
	var delivery: Dictionary = pending_refining_delivery.duplicate()
	pending_refining_delivery.clear()
	_close_refining_minigame()
	if delivery.is_empty():
		return
	var shelf_index: int = int(delivery.get("shelf_index", -1))
	var product_id: int = int(delivery.get("product_id", -1))
	var selected_size: String = str(delivery.get("selected_size", ""))
	var source_button: Control = delivery.get("source_button")
	var size_menu: Control = delivery.get("size_menu")
	var by_staff: bool = bool(delivery.get("by_staff", false))
	var item_name: String = str(products[product_id].get("name", "Vật phẩm")) if product_id >= 0 and product_id < products.size() else "Vật phẩm"
	var qty: int = maxi(1, int(delivery.get("qty", 1)))
	if product_id >= 0 and product_id < products.size():
		for _k in range(qty): _consume_refining_materials(product_id)
	_sfx("refine")
	_ach_refine_ok()
	_show_toast("Tinh luyện thành công · %d %s sẵn sàng giao." % [qty, item_name])
	for k in range(qty): _deliver_shelf_item(shelf_index, product_id, selected_size, source_button if k == 0 else null, size_menu, by_staff, true)

func _on_refining_minigame_cancelled() -> void:
	var product_id: int = int(pending_refining_delivery.get("product_id", -1))
	var item_name: String = str(products[product_id].get("name", "Vật phẩm")) if product_id >= 0 and product_id < products.size() else "Vật phẩm"
	pending_refining_delivery.clear()
	_close_refining_minigame()
	_show_toast("Đã hủy Tinh Luyện · %s chưa giao, kho không đổi." % item_name)

func _close_refining_minigame() -> void:
	var minigame: Control = active_refining_minigame
	active_refining_minigame = null
	if is_instance_valid(minigame):
		minigame.queue_free()
	paused = paused_before_refining
	if is_instance_valid(pause_button):
		_set_pause_glyph(paused)

func _staff_serve_next_item() -> void :
	if queue.is_empty(): return
	var customer: Dictionary = queue[0]
	var delivered_items: Array = customer.get("delivered_items", [])
	for item_index in range(customer["items"].size()):
		if item_index >= delivered_items.size() or bool(delivered_items[item_index]): continue
		var product_id: = int(customer["items"][item_index])
		for shelf_index in range(shelves.size()):
			if int(shelves[shelf_index]["product"]) != product_id or int(shelves[shelf_index]["stock"]) <= 0: continue
			var chosen_size: = ""
			if _product_requires_size(products[product_id]):
				var target_size: = str(customer.get("item_sizes", [])[item_index])
				chosen_size = target_size
				if randf() < STAFF_SIZE_ERROR_CHANCE:
					var alternatives: Array = products[product_id]["sizes"].duplicate()
					alternatives.erase(target_size)
					if not alternatives.is_empty(): chosen_size = str(alternatives.pick_random())
			if _staff_quick_is_fastest() and randf() < 0.10:
				# Tiểu nhị nhanh nhảu giao nhầm: mất món đó
				_consume_stock_unit(shelves[shelf_index])
				if int(shelves[shelf_index]["stock"]) <= 0: shelves[shelf_index]["product"] = -1
				_log_expense("Bán nhầm %s" % products[product_id]["name"], int(products[product_id].get("cost", 0)))
				_show_toast("Tiểu Lục vội quá giao nhầm, mất 1 %s." % products[product_id]["name"])
				_incident_after_wrong_delivery(product_id)
				_show_store()
				return
			_deliver_shelf_item(shelf_index, product_id, chosen_size, null, null, true)
			return

func _product_requires_size(product: Dictionary) -> bool:
	return str(product.get("category", "")) in SIZE_REQUIRED_CATEGORIES

func _animate_product_delivery(product_id: int, source: Control, customer_avatar: Control, order_id: int) -> void :
	var root_inverse: = get_global_transform_with_canvas().affine_inverse()
	var start_position: Vector2 = root_inverse * source.get_global_rect().get_center()
	var target_position: Vector2 = root_inverse * customer_avatar.get_global_rect().get_center()
	var product_icon: = TextureRect.new()
	product_icon.texture = load(str(products[product_id]["image"]))
	product_icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	product_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	product_icon.size = Vector2(48, 48)
	product_icon.position = start_position - product_icon.size / 2.0
	product_icon.pivot_offset = product_icon.size / 2.0
	product_icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	product_icon.z_index = 100
	add_child(product_icon)
	var arc_position: = (start_position + target_position) / 2.0 + Vector2(0, -34)
	var tween: = create_tween()
	tween.tween_property(product_icon, "scale", Vector2(1.3, 1.3), 0.12).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(product_icon, "position", arc_position - product_icon.size / 2.0, 0.18).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(product_icon, "position", target_position - product_icon.size / 2.0, 0.22).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(product_icon, "scale", Vector2(0.72, 0.72), 0.22)
	tween.tween_property(product_icon, "modulate:a", 0.0, 0.08)
	tween.tween_callback(product_icon.queue_free)
	tween.tween_callback(_delivery_animation_completed.bind(order_id))

func _delivery_animation_completed(order_id: int) -> void :
	if queue.is_empty() or int(queue[0].get("order_id", -1)) != order_id:
		return
	var customer: Dictionary = queue[0]
	customer["delivery_animations_pending"] = maxi(0, int(customer.get("delivery_animations_pending", 0)) - 1)
	if _all_customer_items_delivered(customer) and int(customer["delivery_animations_pending"]) == 0:
		_checkout(bool(customer.get("served_by_staff", false)))

func _all_customer_items_delivered(customer: Dictionary) -> bool:
	var delivered_items: Array = customer.get("delivered_items", [])
	if delivered_items.is_empty():
		return false
	for delivered in delivered_items:
		if not bool(delivered):
			return false
	return true

func _setup_panel_header() -> HBoxContainer:
	var header: HBoxContainer = HBoxContainer.new()
	header.custom_minimum_size = Vector2(0, 46)
	header.add_theme_constant_override("separation", 6)
	var heading: Label = _label("BỐ TRÍ TIÊN MÔN", 19, Color("285b7a"))
	setup_heading_label = heading
	heading.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	heading.set_meta("no_font_scale", true);heading.clip_text = true;heading.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS;heading.custom_minimum_size.x = 60
	header.add_child(heading)
	var archive_button: = _button("LƯU TRỮ", 9);archive_button.autowrap_mode = TextServer.AUTOWRAP_OFF;archive_button.custom_minimum_size = Vector2(66, 30);archive_button.size_flags_vertical = Control.SIZE_SHRINK_CENTER;var setup_settings_button: = _gear_button();setup_settings_button.size_flags_vertical = Control.SIZE_SHRINK_CENTER;setup_settings_button.pressed.connect(_open_settings_panel);header.add_child(setup_settings_button);archive_button.pressed.connect(_open_archive_panel);header.add_child(archive_button)
	report_text = _currency_badge(money, 18, Color("e5aa28"))
	report_text.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	header.add_child(report_text)
	return header

func _open_pre_game_adjustments() -> void :
	if running or report_overlay != null:
		return
	day_closed_panel = false
	report_overlay = ColorRect.new()
	report_overlay.color = Color(0.08, 0.22, 0.34, 0.48)
	report_overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	report_overlay.z_index = 10
	add_child(report_overlay)
	report_panel = PanelContainer.new()
	report_panel.position = Vector2(6, 70)
	report_panel.size = Vector2(528, 827)
	report_panel.z_index = 11
	report_panel.add_theme_stylebox_override("panel", _box(Color("f7fbff"), Color("8bc5e8"), 4, 24))
	report_overlay.add_child(report_panel)
	var margin: = MarginContainer.new()
	for side in ["left", "right", "top", "bottom"]:
		margin.add_theme_constant_override("margin_%s" % side, 16)
	report_panel.add_child(margin)
	var box: = VBoxContainer.new();box.add_theme_constant_override("separation", 5);margin.add_child(box)
	box.add_child(_setup_panel_header())
	var setup_tabs: = HBoxContainer.new()
	var import_tab: = _button("THÂU MUA", 11);import_tab.size_flags_horizontal = Control.SIZE_EXPAND_FILL;import_tab.pressed.connect(_show_import_adjustments);setup_tabs.add_child(import_tab);tab_button_refs.clear();tab_button_refs["imports"] = import_tab
	var shelf_tab: = _button("LINH CÁC", 11);shelf_tab.size_flags_horizontal = Control.SIZE_EXPAND_FILL;shelf_tab.pressed.connect(_show_shelf_adjustments);setup_tabs.add_child(shelf_tab);tab_button_refs["shelves"] = shelf_tab
	var market_tab: = _button("THƯƠNG HỘI", 11);market_tab.size_flags_horizontal = Control.SIZE_EXPAND_FILL;market_tab.pressed.connect(_show_market);setup_tabs.add_child(market_tab);tab_button_refs["market"] = market_tab
	box.add_child(setup_tabs)
	tab_pages.clear();tab_sigs.clear();tab_scroll.clear();close_scroll = ScrollContainer.new();close_scroll.custom_minimum_size = Vector2(0, 560);close_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL;close_scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED;box.add_child(close_scroll);close_content = VBoxContainer.new();close_content.size_flags_horizontal = Control.SIZE_EXPAND_FILL;close_content.mouse_filter = Control.MOUSE_FILTER_PASS;close_content.child_entered_tree.connect(_set_scroll_tree_mouse_filter_pass);close_content.add_theme_constant_override("separation", 6);close_scroll.add_child(close_content)
	var begin_button: = _button("LƯU ĐIỀU CHỈNH · MỞ CA", 13);begin_button.custom_minimum_size = Vector2(0, 54);begin_button.pressed.connect(_dismiss_setup_and_start);box.add_child(begin_button);begin_button_ref = begin_button
	_show_import_adjustments()


func _show_store_name_prompt() -> void :
	store_name_prompt_overlay = ColorRect.new()
	store_name_prompt_overlay.color = Color(0.08, 0.22, 0.34, 0.72)
	store_name_prompt_overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	store_name_prompt_overlay.z_index = 100
	store_name_prompt_overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	add_child(store_name_prompt_overlay)
	var panel: = PanelContainer.new()
	panel.position = Vector2(28, 290)
	panel.size = Vector2(484, 286)
	panel.add_theme_stylebox_override("panel", _box(Color("f7fbff"), Color("8bc5e8"), 4, 24))
	store_name_prompt_overlay.add_child(panel)
	var margin: = MarginContainer.new()
	for side in ["left", "right", "top", "bottom"]: margin.add_theme_constant_override("margin_%s" % side, 18)
	panel.add_child(margin)
	var box: = VBoxContainer.new()
	box.add_theme_constant_override("separation", 10)
	margin.add_child(box)
	var heading: = _label("ĐẶT TÊN TIÊN MÔN", 22, Color("285b7a"))
	heading.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	box.add_child(heading)
	var hint: = _label("Tên sẽ hiển thị trên bảng điều khiển của tiên môn.", 11, Color("6a8ca0"))
	hint.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hint.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	box.add_child(hint)
	store_name_field = LineEdit.new()
	store_name_field.text = "TIÊN MÔN LINH VẬN"
	store_name_field.placeholder_text = "Nhập tên tiên môn"
	store_name_field.max_length = 28
	store_name_field.alignment = HORIZONTAL_ALIGNMENT_CENTER
	store_name_field.custom_minimum_size = Vector2(0, 46)
	store_name_field.add_theme_font_override("font", UI_FONT_REGULAR)
	store_name_field.add_theme_font_size_override("font_size", 20)
	store_name_field.add_theme_color_override("font_color", Color("285b7a"))
	store_name_field.add_theme_stylebox_override("normal", _manual_input_style())
	store_name_field.add_theme_stylebox_override("focus", _manual_input_style())
	store_name_field.text_submitted.connect(_confirm_store_name)
	_mobile_input(store_name_field, false, false, "Tên tiên môn")
	box.add_child(store_name_field)
	var confirm: = _button("BẮT ĐẦU VỚI TÊN NÀY", 13)
	confirm.custom_minimum_size = Vector2(0, 46)
	confirm.pressed.connect(_confirm_store_name)
	box.add_child(confirm)
	var restore_entry: = _button("ĐÃ CÓ MÃ SAO LƯU? KHÔI PHỤC TIẾN TRÌNH", 10)
	restore_entry.custom_minimum_size = Vector2(0, 36)
	restore_entry.pressed.connect(_open_archive_panel.bind(true))
	box.add_child(restore_entry)
	store_name_field.grab_focus()
	store_name_field.select_all()

func _confirm_store_name(_submitted_text: String = "") -> void :
	if not is_instance_valid(store_name_field): return
	var entered: = store_name_field.text.strip_edges()
	if entered.is_empty():
		store_name_field.placeholder_text = "Hãy nhập tên tiên môn trước khi bắt đầu"
		store_name_field.grab_focus()
		return
	store_name = entered
	if is_instance_valid(store_name_prompt_overlay):
		store_name_prompt_overlay.queue_free()
	store_name_prompt_overlay = null
	_update_ui()
	_save_game()
	_tut_event("named")

func _dismiss_setup_and_start() -> void :
	if report_overlay != null:
		report_overlay.queue_free()
		report_overlay = null
	pre_game_adjustment = false
	close_content = null
	setup_button.disabled = true
	_toggle_run()

func _end_day() -> void :
	if not running: return
	_incident_end_day_ledger()
	_staff_end_day()
	_upgrades_end_day()
	_ach_end_day()
	_tax_end_day()
	_daihoi_end_day()
	_ext8_end_day()
	incident_state["close_early_at"] = 0.0;incident_state["shift_event"] = ""
	day_closed_panel = true
	_make_forecast()
	call_deferred("_show_day_summary_popup")
	_sfx("endday")
	call_deferred("_tut_event", "end_day")
	call_deferred("_save_game")
	pre_game_adjustment = false
	running = false;paused = false;start_button.text = "MỞ TIÊN MÔN / TIẾP TỤC CA";start_button.visible = true;pause_button.disabled = true;_set_pause_glyph(false);pause_menu_panel.visible = false;setup_button.visible = true;setup_button.disabled = false;_generate_staff_errors();report_overlay = ColorRect.new();report_overlay.color = Color(0.08, 0.22, 0.34, 0.48);report_overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT);report_overlay.z_index = 10;add_child(report_overlay)
	report_panel = PanelContainer.new();report_panel.position = Vector2(6, 16);report_panel.size = Vector2(528, get_viewport().get_visible_rect().size.y - 32.0);report_panel.z_index = 11;report_panel.add_theme_stylebox_override("panel", _box(Color("f7fbff"), Color("8bc5e8"), 4, 24));report_overlay.add_child(report_panel)
	var margin: = MarginContainer.new()
	for side in ["left", "right", "top", "bottom"]:
		margin.add_theme_constant_override("margin_%s" % side, 16)
	report_panel.add_child(margin)
	var box: = VBoxContainer.new();box.add_theme_constant_override("separation", 5);margin.add_child(box)
	box.add_child(_setup_panel_header())
	var tabs: = GridContainer.new();tabs.columns = 3;tabs.add_theme_constant_override("h_separation", 4);tabs.add_theme_constant_override("v_separation", 4)
	tab_styles.clear()
	for pair in [["THÂU MUA", "imports"], ["LINH CÁC", "shelves"], ["CHIÊU MỘ", "staff"], ["THƯƠNG HỘI", "market"], ["TRUYỀN TIN", "remote"], ["TU SỬA", "upgrade"], ["CHƯỞNG BỘ", "statistics"], ["DANH VỌNG", "reviews"], ["THÀNH TỰU", "achieve"], ["THÁM HIỂM", "explore"], ["ĐẤU GIÁ", "auction"]]:
		var key: String = pair[1]
		var b: = Button.new();b.text = "";tab_button_refs[key] = b;b.custom_minimum_size = Vector2(0, 38);b.size_flags_horizontal = Control.SIZE_EXPAND_FILL;b.pressed.connect(_set_close_tab.bind(key));b.focus_mode = Control.FOCUS_NONE
		var off: = StyleBoxTexture.new();off.texture = load("res://assets/boutique/ui_tabs/tab_%s.png" % key)
		var on: = StyleBoxTexture.new();on.texture = load("res://assets/boutique/ui_tabs/tab_%s_on.png" % key)
		tab_styles[key] = [off, on]
		for st in ["normal", "hover", "disabled", "focus"]: b.add_theme_stylebox_override(st, off)
		b.add_theme_stylebox_override("pressed", on)
		var tab_label: = _label(pair[0], 9, Color("3b2a20"));tab_label.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT);tab_label.anchor_left = TAB_TEXT_START.get(key, 0.37);tab_label.offset_left = 0;tab_label.offset_right = -10;tab_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;tab_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER;tab_label.autowrap_mode = TextServer.AUTOWRAP_OFF;tab_label.clip_text = false;tab_label.mouse_filter = Control.MOUSE_FILTER_IGNORE;b.add_child(tab_label)
		tabs.add_child(b)
	box.add_child(tabs)
	tab_pages.clear();tab_sigs.clear();tab_scroll.clear();close_scroll = ScrollContainer.new();close_scroll.custom_minimum_size = Vector2(0, 520);close_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL;close_scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED;box.add_child(close_scroll);close_content = VBoxContainer.new();close_content.size_flags_horizontal = Control.SIZE_EXPAND_FILL;close_content.mouse_filter = Control.MOUSE_FILTER_PASS;close_content.child_entered_tree.connect(_set_scroll_tree_mouse_filter_pass);close_content.add_theme_constant_override("separation", 6);close_scroll.add_child(close_content)
	next_day_button = _button(_import_summary_text(), 11);next_day_button.custom_minimum_size = Vector2(0, 84);next_day_button.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;next_day_button.pressed.connect(_new_day);box.add_child(next_day_button)
	_show_shelf_adjustments()

func _set_close_tab(tab: String) -> void :
	active_close_tab = tab
	if tab == "imports": _show_import_adjustments()
	elif tab == "shelves": _show_shelf_adjustments()
	elif tab == "staff": _show_staff()
	elif tab == "statistics": _show_statistics()
	elif tab == "reviews": _show_reviews()
	elif tab == "market": _show_market()
	elif tab == "remote": _show_remote();_guide_once("g_remote")
	elif tab == "upgrade": _show_upgrades();_guide_once("g_upgrade")
	elif tab == "explore": _show_explore();_guide_once("g_explore")
	elif tab == "auction": _show_auction();_guide_once("g_auction")
	elif tab == "achieve": _show_achievements()
	else: _show_adjustments()

func _set_scroll_tree_mouse_filter_pass(node: Node) -> void:
	if node is Control:
		node.mouse_filter = Control.MOUSE_FILTER_PASS
	for child in node.get_children():
		_set_scroll_tree_mouse_filter_pass(child)

func _show_adjustments() -> void :
	_show_shelf_adjustments()

func _show_import_adjustments() -> void :
	if pre_game_adjustment and is_instance_valid(report_text):
		_set_currency_badge(report_text, money, 18, Color("e5aa28"))
	active_close_tab = "imports"
	call_deferred("_tut_check_refining")
	if _use_tab_page("imports"): return
	close_content.add_child(_section_heading("res://assets/boutique/ui_icons/icon_store.png", "THÂU MUA", 16))
	_market_block()
	close_content.add_child(_label("LINH KHỐ: %d/%d món" % [_warehouse_used(), _warehouse_cap()], 12, Color("c0583f") if _warehouse_used() >= _warehouse_cap() else Color("285b7a")))
	var import_note: Label = _label("Giá thâu mua và số lượng theo lô", 10, Color("6a8ca0"));import_note.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;import_note.size_flags_horizontal = Control.SIZE_EXPAND_FILL;close_content.add_child(import_note)
	if false and first_purchase_guidance_pending:
		var guidance: PanelContainer = PanelContainer.new()
		guidance.custom_minimum_size = Vector2(0, 44)
		guidance.add_theme_stylebox_override("panel", _box(Color("fffaf0"), Color("d9b76e"), 2, 12))
		var guidance_label: Label = _label("Trước khi bắt đầu mở cửa bán hàng phải thâu mua vật phẩm", 11, Color("285b7a"))
		guidance_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		guidance_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		guidance_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		guidance.add_child(guidance_label)
		close_content.add_child(guidance)
		first_purchase_guidance_pending = false
	# Vật phẩm đã mở luôn nằm trên, giữ thứ tự ban đầu; vật phẩm chưa mở xếp sau.
	var order: Array[int] = []
	for i in range(products.size()):
		if _is_product_available(i): order.append(i)
	for i in range(products.size()):
		if not _is_product_available(i): order.append(i)
	for i in order:
		if bool(products[i].get("requires_paid_unlock", false)) and not _is_paid_product_unlocked(i):
			close_content.add_child(_paid_product_unlock_card(i))
		else:
			close_content.add_child(_import_product_card(i))

func _import_product_card(index: int) -> PanelContainer:
	var p: Dictionary = products[index]
	var rarity: = str(p.get("rarity", "Luxury"))
	var accent: = Color("7eb9d8")
	if rarity.to_lower() == "rare": accent = Color("4f9ed0")
	if rarity.to_lower() == "iconic": accent = Color("d979a6")
	var card: = PanelContainer.new();card.custom_minimum_size = Vector2(0, 142);card.add_theme_stylebox_override("panel", _box(Color("f4faff"), accent, 2, 16))
	import_card_nodes[index] = card
	var pad: = MarginContainer.new()
	for side in ["left", "right", "top", "bottom"]:
		pad.add_theme_constant_override("margin_%s" % side, 8)
	card.add_child(pad)
	var body: = VBoxContainer.new();body.add_theme_constant_override("separation", 4);pad.add_child(body)
	var head: = HBoxContainer.new();head.add_theme_constant_override("separation", 8);body.add_child(head)
	var big_icon: = _product_icon(index, Vector2(96, 96));big_icon.size_flags_vertical = Control.SIZE_SHRINK_CENTER;head.add_child(big_icon)
	var info: = VBoxContainer.new();info.size_flags_horizontal = Control.SIZE_EXPAND_FILL;info.add_theme_constant_override("separation", 2);head.add_child(info)
	var title: = _label(str(p["name"]), 12, Color("36556b"));title.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;info.add_child(title)
	var description: String = str(p.get("description", ""))
	if not description.is_empty():
		var description_label: = _label(description, 9, Color("4e85a6"));description_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;info.add_child(description_label)
	var element_text: String = str(p.get("element", "")).strip_edges()
	var element_segment: String = " · Hệ %s" % element_text if not element_text.is_empty() else ""
	var meta: = _label("%s · %s · Level %d%s%s" % [str(p.get("category", "Vật phẩm")).to_upper(), _product_refining_grade(p).to_upper(), int(p["unlock_level"]), element_segment, " · Size S/M/L" if _product_requires_size(p) else ""], 9, accent);info.add_child(meta)
	var price: = _label("Bán %d LT   ·   Thâu %d LT   ·   Kho %d" % [int(p["price"]), int(p["cost"]), int(p["stock"])], 10, Color("285b7a"));info.add_child(price)
	var shelf_life: = _label("Tiêu tán linh · %s" % _product_spoilage_label(p), 9, Color("4e85a6"));info.add_child(shelf_life)
	var recipe_text: String = _recipe_summary(index)
	if not recipe_text.is_empty():
		var recipe_label: = _label("Nguyên liệu tinh luyện: %s" % recipe_text, 9, Color("b07a1e"));recipe_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;info.add_child(recipe_label)
	var order_row: = HBoxContainer.new();order_row.add_theme_constant_override("separation", 6);info.add_child(order_row)
	var order_title: = _label("THÂU MUA THEO LÔ", 9, accent);order_title.custom_minimum_size = Vector2(62, 30);order_title.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;order_title.size_flags_horizontal = Control.SIZE_EXPAND_FILL;order_row.add_child(order_title)
	var controls: = _order_controls(index);controls.size_flags_horizontal = Control.SIZE_SHRINK_END;order_row.add_child(controls)
	return card

func _paid_product_unlock_card(index: int) -> PanelContainer:
	var p: Dictionary = products[index]
	var cost: int = _product_unlock_cost(index)
	var cost_text: String = "20.000" if cost == 20000 else str(cost)
	var required_level: int = int(p.get("unlock_level", 1))
	var level_locked: bool = level < required_level
	var rarity: String = str(p.get("rarity", "Luxury"))
	var accent: Color = Color("7eb9d8")
	if rarity.to_lower() == "rare": accent = Color("4f9ed0")
	if rarity.to_lower() == "iconic": accent = Color("d979a6")
	var card: = PanelContainer.new()
	card.custom_minimum_size = Vector2(0, 142)
	card.add_theme_stylebox_override("panel", _box(Color("f4faff"), accent, 2, 16))
	var pad: = MarginContainer.new()
	for side in ["left", "right", "top", "bottom"]: pad.add_theme_constant_override("margin_%s" % side, 8)
	card.add_child(pad)
	var body: = VBoxContainer.new();body.add_theme_constant_override("separation", 5);pad.add_child(body)
	var head: = HBoxContainer.new();head.add_theme_constant_override("separation", 8);body.add_child(head)
	head.add_child(_product_icon(index, Vector2(58, 58)))
	var info: = VBoxContainer.new();info.size_flags_horizontal = Control.SIZE_EXPAND_FILL;head.add_child(info)
	var title: = _label("%s · ĐANG KHÓA" % p["name"], 12, accent);title.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;info.add_child(title)
	var locked_element: String = str(p.get("element", "")).strip_edges()
	var locked_meta: = _label("%s · %s · Level %d%s" % [str(p.get("category", "Vật phẩm")).to_upper(), _product_refining_grade(p).to_upper(), int(p.get("unlock_level", 1)), " · Hệ %s" % locked_element if not locked_element.is_empty() else ""], 9, accent);locked_meta.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;info.add_child(locked_meta)
	var detail_text: String = "Mở riêng quyền nhập, bày kệ và bán món này.\nPhí mở khóa một lần: %s LT." % cost_text
	if level_locked:
		detail_text = "Mở ở Level %d. Đạt cấp này trước, sau đó mới có thể trả phí mở riêng %s LT." % [required_level, cost_text]
	var detail: = _label(detail_text, 9, Color("4e6d80"));detail.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;info.add_child(detail)
	var button_text: String = "MỞ Ở LEVEL %d" % required_level if level_locked else "MỞ KHÓA RIÊNG · %s LT" % cost_text
	var unlock: = _button(button_text, 10);unlock.custom_minimum_size = Vector2(0, 32);unlock.disabled = level_locked or money < cost
	unlock.tooltip_text = "Đạt Level %d trước khi mở riêng %s." % [required_level, p["name"]] if level_locked else "Chỉ mở khóa %s; quyền này được lưu trên thiết bị/trình duyệt." % p["name"]
	unlock.pressed.connect(_unlock_paid_product.bind(index));body.add_child(unlock)
	return card

func _unlock_paid_product(index: int) -> void:
	if index < 0 or index >= products.size(): return
	var p: Dictionary = products[index]
	if not bool(p.get("requires_paid_unlock", false)) or _is_paid_product_unlocked(index): return
	var required_level: int = int(p.get("unlock_level", 1))
	if level < required_level:
		_show_product_unlock_hint(index)
		return
	var cost: int = _product_unlock_cost(index)
	if money < cost:
		var cost_text: String = "20.000" if cost == 20000 else str(cost)
		_show_toast("Chưa đủ LT. Cần %s LT để mở riêng %s." % [cost_text, p["name"]]);return
	money -= cost
	_log_expense("Mở khóa %s" % p["name"], cost)
	var unlock_key: String = _paid_product_unlock_key(index)
	paid_product_unlocks[unlock_key] = true
	_save_paid_product_unlock_states()
	call_deferred("_tut_check_refining")
	_update_money_display()
	var cost_label: String = "20.000" if cost == 20000 else str(cost)
	_sfx("unlock")
	_show_toast("Đã mở khóa riêng %s · trừ %s LT." % [p["name"], cost_label])
	if close_content != null: _show_import_adjustments()
	_update_ui()

func _show_shelf_adjustments() -> void :
	if pre_game_adjustment and is_instance_valid(report_text):
		_set_currency_badge(report_text, money, 18, Color("e5aa28"))
	active_close_tab = "shelves"
	call_deferred("_tut_event", "tab_shelves")
	if _use_tab_page("shelves"): return
	close_content.add_child(_section_heading("res://assets/boutique/ui_icons/icon_shelf.png", "LINH CÁC · Chọn sản phẩm đã mở để bày lên từng kệ. · Quản lý giá bán", 12))
	close_content.add_child(_shelf_legend())
	_plan_block()
	for sec in SHELF_SECTIONS:
		var a: int = sec[1];var b: int = mini(int(sec[2]), shelves.size())
		if str(sec[0]) != "":
			close_content.add_child(_label(str(sec[0]), 13, Color(sec[3])))
			close_content.add_child(_wl(str(sec[4]), 10, Color("6a8ca0")))
		var grid: = GridContainer.new();grid.columns = 3;grid.add_theme_constant_override("h_separation", 6);grid.add_theme_constant_override("v_separation", 10);grid.size_flags_horizontal = Control.SIZE_SHRINK_CENTER;close_content.add_child(grid)
		for i in range(a, b): grid.add_child(_shelf_card(i, shelves[i], true))

func _choose_for_shelf(index: int) -> void :
	if not _is_product_available(index):
		_show_product_unlock_hint(index);return
	selected_product = index;_show_toast("Đã chọn %s · bấm vào kệ muốn bày." % products[index]["name"]);_show_shelf_adjustments()

func _show_staff() -> void :
	active_close_tab = "staff"
	if _use_tab_page("staff"): return
	close_content.add_child(_section_heading("res://assets/boutique/ui_icons/icon_staff.png", "CHIÊU MỘ · Linh thạch thưởng thuộc về nhân viên. Lương trừ khi bắt đầu ngày mới.", 12))
	var hired_label: = _label("ĐANG THUÊ %d/%d TẠP DỊCH" % [_active_staff_count(), MAX_ACTIVE_STAFF], 12, Color("c9558b"));hired_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;hired_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL;close_content.add_child(hired_label)
	call_deferred("_wrap_close_labels")
	for role in STAFF_ORDER:
		var info: Dictionary = STAFF_ROLES[role]
		var locked: = level < int(info.get("level", 1))
		var card: = PanelContainer.new();card.add_theme_stylebox_override("panel", _box(Color("f4faff") if not bool(staff.get(role, false)) else Color("eaf7ee"), Color("a6d8ee") if not bool(staff.get(role, false)) else Color("6cbf8b"), 2, 12))
		var row: = HBoxContainer.new();row.add_theme_constant_override("separation", 8);card.add_child(row)
		row.add_child(_staff_icon(str(info["portrait"]), Vector2(64, 64)))
		var txt: = VBoxContainer.new();txt.size_flags_horizontal = Control.SIZE_EXPAND_FILL;txt.add_theme_constant_override("separation", 1);row.add_child(txt)
		var head: = _label("%s · %s" % [info["title"], info["name"]], 12, Color("285b7a"));head.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;txt.add_child(head)
		var pro: = _label("Ưu: %s" % info["pro"], 10, Color("2e8a57"));pro.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;txt.add_child(pro)
		var con: = _label("Khuyết: %s" % info["con"], 10, Color("c0583f"));con.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;txt.add_child(con)
		var wage_text: = "Lương %s LT/ngày" % _fmt_thousands(int(info["wage"]))
		if locked: wage_text += " · mở ở level %d" % int(info["level"])
		txt.add_child(_label(wage_text, 10, Color("4e85a6")))
		var owned: = bool(staff_owned.get(role, false))
		var action_text: = "Cho nghỉ" if bool(staff.get(role, false)) else ("Tuyển lại\nMiễn phí" if owned else "Tuyển\n%s LT" % _fmt_thousands(int(info["hire"])))
		var b: = _button(action_text, 9);b.custom_minimum_size = Vector2(92, 54)
		if bool(staff.get(role, false)): b.pressed.connect(_dismiss_staff.bind(role))
		else:
			b.disabled = locked or _active_staff_count() >= MAX_ACTIVE_STAFF or (not owned and money < int(info["hire"]))
			b.pressed.connect(_hire_staff.bind(role, int(info["hire"])))
		row.add_child(b);close_content.add_child(card)
	if staff_errors.is_empty(): close_content.add_child(_label("Hôm nay không ghi nhận lỗi nhân viên.", 12, Color("3f86aa")))
	else:
		close_content.add_child(_label("LỖI TRONG NGÀY · quản lý chọn mức trừ tips hoặc bỏ qua", 13, Color("d979a6")))
		for error in staff_errors:
			var row: = HBoxContainer.new(); var t: = _label("%s\nẢnh hưởng đánh giá: -%d sao" % [error["text"], error["stars_lost"]], 11, Color("36556b"));t.size_flags_horizontal = Control.SIZE_EXPAND_FILL;row.add_child(t)
			for pct in [20, 50, 80, 0]: var b: = _button("BỎ QUA" if pct == 0 else "-%d%%" % pct, 9);b.pressed.connect(_resolve_staff_error.bind(error["id"], pct));row.add_child(b)
			close_content.add_child(row)

var stat_mode: String = "day"
var stat_pos: int = -1

func _record_daily_statistics() -> void :
	if sold_today.is_empty() and successful_orders == 0 and walked_out == 0 and expenses_today.is_empty() and revenue_today == 0:
		return
	daily_statistics.append({"day": day_number, "orders": successful_orders, "walked_out": walked_out, "sold": sold_today.duplicate(true), "expenses": expenses_today.duplicate(true), "store_tips": store_tips, "revenue": revenue_today, "staff_tips": tips, "forecast": _forecast_result_today()})
	_stat_prune()
	stat_pos = -1

func _stat_prune() -> void:
	# Giữ tối đa 5 tháng (mỗi tháng 30 ngày) gần nhất.
	var cur_month: = int((day_number - 1) / 30)
	var keep: Array = []
	for r in daily_statistics:
		if int((int(r["day"]) - 1) / 30) >= cur_month - 4: keep.append(r)
	daily_statistics.clear()
	for r in keep: daily_statistics.append(r)

func _sort_stat_product_rows(a: Dictionary, b: Dictionary) -> bool:
	return int(a["quantity"]) > int(b["quantity"])

func _show_statistics() -> void :
	if close_content == null:
		return
	active_close_tab = "statistics"
	if _use_tab_page("statistics"): return
	call_deferred("_wrap_close_labels");close_content.add_child(_section_heading("res://assets/boutique/ui_icons/icon_statistics.png", "CHƯỞNG BỘ · SỔ SÁCH BÁN HÀNG", 13))
	if not forecast_next.is_empty() and int(forecast_next.get("day", 0)) == day_number + 1:
		close_content.add_child(_label("TIN NGÀY MAI · %s" % _forecast_headline(forecast_next), 12, Color("c9558b")))
	# Chọn kiểu xem: ngày / tuần / tháng
	var modes: = HBoxContainer.new();modes.add_theme_constant_override("separation", 6)
	for m in [["NGÀY", "day"], ["TUẦN", "week"], ["THÁNG", "month"]]:
		var mb: = _button(str(m[0]), 11);mb.custom_minimum_size = Vector2(0, 34);mb.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		if stat_mode == str(m[1]):
			var on: = _box(Color("c7e8ff"), Color("d979a6"), 3, 12)
			for st in ["normal", "hover", "pressed", "focus"]: mb.add_theme_stylebox_override(st, on)
		mb.pressed.connect(_stat_set_mode.bind(str(m[1])));modes.add_child(mb)
	close_content.add_child(modes)
	var periods: = _stat_periods(stat_mode)
	if periods.is_empty():
		close_content.add_child(_label("Chưa có dữ liệu bán hàng. Thống kê sẽ lưu sau khi kết thúc ngày.", 12, Color("6a8ca0")));return
	var pos: = stat_pos
	if pos < 0 or pos >= periods.size(): pos = periods.size() - 1
	stat_pos = pos
	# Thanh tua tới lui
	if periods.size() > 1:
		var nav: = HBoxContainer.new();nav.add_theme_constant_override("separation", 6);nav.alignment = BoxContainer.ALIGNMENT_CENTER
		var prev: = _button("<", 14);prev.custom_minimum_size = Vector2(64, 34);prev.disabled = pos <= 0;prev.pressed.connect(_stat_step.bind(-1));nav.add_child(prev)
		var where: = _label("%d / %d" % [pos + 1, periods.size()], 11, Color("285b7a"));where.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;where.custom_minimum_size = Vector2(90, 0);nav.add_child(where)
		var nxt: = _button(">", 14);nxt.custom_minimum_size = Vector2(64, 34);nxt.disabled = pos >= periods.size() - 1;nxt.pressed.connect(_stat_step.bind(1));nav.add_child(nxt)
		var latest: = _button("MỚI NHẤT", 10);latest.custom_minimum_size = Vector2(120, 34);latest.disabled = pos >= periods.size() - 1;latest.pressed.connect(_stat_jump.bind(periods.size() - 1));nav.add_child(latest)
		close_content.add_child(nav)
		var slider: = HSlider.new();slider.min_value = 0;slider.max_value = periods.size() - 1;slider.step = 1;slider.value = pos;slider.custom_minimum_size = Vector2(0, 26);slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		slider.value_changed.connect(_stat_slider_preview.bind(where, periods))
		slider.drag_ended.connect(_stat_slider_done.bind(slider))
		close_content.add_child(slider)
	var period: Dictionary = periods[pos]
	if stat_mode == "day": _stat_render_day(period["records"][0])
	else: _stat_render_group(period)
	close_content.add_child(_wl("Sổ sách giữ tối đa 5 tháng gần nhất (mỗi tháng 30 ngày), dữ liệu cũ hơn tự xóa.", 9, Color("8aa4b4")))

func _stat_all_records() -> Array:
	var records: Array = daily_statistics.duplicate(true)
	if not sold_today.is_empty() or successful_orders > 0 or walked_out > 0 or not expenses_today.is_empty():
		records.append({"day": day_number, "orders": successful_orders, "walked_out": walked_out, "sold": sold_today.duplicate(true), "expenses": expenses_today.duplicate(true), "store_tips": store_tips, "revenue": revenue_today, "staff_tips": tips, "forecast": _forecast_result_today(), "current": true})
	return records

func _stat_periods(mode: String) -> Array:
	var records: = _stat_all_records()
	var out: Array = []
	if mode == "day":
		for r in records: out.append({"records": [r]})
		return out
	var span: = 7 if mode == "week" else 30
	var groups: Dictionary = {};var order: Array = []
	for r in records:
		var k: = int((int(r["day"]) - 1) / span)
		if not groups.has(k): groups[k] = [];order.append(k)
		groups[k].append(r)
	order.sort()
	for k in order: out.append({"key": int(k), "span": span, "records": groups[k]})
	return out

func _stat_set_mode(mode: String) -> void:
	stat_mode = mode;stat_pos = -1
	tab_sigs.erase("statistics");_show_statistics()

func _stat_step(d: int) -> void:
	stat_pos = maxi(0, stat_pos + d)
	tab_sigs.erase("statistics");_show_statistics()

func _stat_jump(p: int) -> void:
	stat_pos = p
	tab_sigs.erase("statistics");_show_statistics()

func _stat_slider_preview(v: float, where: Label, periods: Array) -> void:
	if is_instance_valid(where): where.text = "%d / %d" % [int(v) + 1, periods.size()]

func _stat_slider_done(_changed: bool, slider: HSlider) -> void:
	if not is_instance_valid(slider): return
	call_deferred("_stat_jump", int(slider.value))

func _stat_render_day(record: Dictionary) -> void:
	var title: = "NGÀY %d%s · %d đơn · %d khách bỏ về / hẹn lần sau" % [int(record["day"]), " (ĐANG DIỄN RA)" if bool(record.get("current", false)) else "", int(record["orders"]), int(record["walked_out"])]
	close_content.add_child(_label(title, 12, Color("285b7a")))
	_stat_product_lines(record["sold"])
	_add_forecast_line(record.get("forecast", {}))
	_add_expense_lines(record.get("expenses", []))
	if int(record.get("store_tips", 0)) > 0:
		close_content.add_child(_label("  TIP KHÁCH THƯỞNG CỬA HÀNG · +%s LT" % _fmt_thousands(int(record["store_tips"])), 11, Color("378d69")))
	_add_profit_line(record)

func _stat_product_lines(sold: Dictionary) -> void:
	var product_rows: Array[Dictionary] = []
	for product_key in sold.keys():
		product_rows.append({"name": products[int(product_key)]["name"], "quantity": int(sold[product_key])})
	product_rows.sort_custom(Callable(self, "_sort_stat_product_rows"))
	if product_rows.is_empty():
		close_content.add_child(_label("  Chưa bán sản phẩm nào.", 11, Color("6a8ca0")))
	for rank in range(product_rows.size()):
		var row: Dictionary = product_rows[rank]
		close_content.add_child(_label("  %d. %s · bán %d sản phẩm" % [rank + 1, row["name"], int(row["quantity"])], 11, Color("36556b")))

func _stat_render_group(period: Dictionary) -> void:
	var span: = int(period["span"]);var k: = int(period["key"])
	var first_day: = k * span + 1;var last_day: = first_day + span - 1
	var recs: Array = period["records"]
	var orders: = 0;var walked: = 0;var revenue: = 0;var store_t: = 0
	var sold: Dictionary = {};var expenses: Array = []
	var best_day: = -1;var best_profit: = -2147483647;var worst_day: = -1;var worst_profit: = 2147483647
	for r in recs:
		orders += int(r["orders"]);walked += int(r["walked_out"]);revenue += int(r.get("revenue", 0));store_t += int(r.get("store_tips", 0))
		for pk in r["sold"].keys(): sold[pk] = int(sold.get(pk, 0)) + int(r["sold"][pk])
		expenses.append_array(r.get("expenses", []))
		var pr: = _record_profit(r)
		if pr > best_profit: best_profit = pr;best_day = int(r["day"])
		if pr < worst_profit: worst_profit = pr;worst_day = int(r["day"])
	var pname: = ("TUẦN %d" if span == 7 else "THÁNG %d") % (k + 1)
	close_content.add_child(_label("%s · NGÀY %d–%d" % [pname, first_day, last_day], 13, Color("285b7a")))
	close_content.add_child(_label("  %d ngày có số liệu · %d đơn · %d khách bỏ về / hẹn lần sau" % [recs.size(), orders, walked], 11, Color("36556b")))
	var agg: = {"revenue": revenue, "store_tips": store_t, "expenses": expenses}
	var total_profit: = _record_profit(agg)
	close_content.add_child(_label("  Trung bình mỗi ngày: doanh thu %s LT · lời %s LT" % [_fmt_thousands(int(revenue / maxi(1, recs.size()))), _fmt_thousands(int(total_profit / maxi(1, recs.size())))], 11, Color("36556b")))
	if best_day >= 0: close_content.add_child(_label("  Ngày lời nhất: ngày %d (%s LT) · ngày kém nhất: ngày %d (%s LT)" % [best_day, _fmt_thousands(best_profit), worst_day, _fmt_thousands(worst_profit)], 11, Color("8a6bb0")))
	close_content.add_child(_label("SẢN PHẨM ĐÃ BÁN", 12, Color("c9558b")))
	_stat_product_lines(sold)
	_add_expense_lines(expenses)
	for c in close_content.get_children():
		if c is Label and (c as Label).text.strip_edges().begins_with("BỊ TRỪ TRONG NGÀY"): (c as Label).text = (c as Label).text.replace("TRONG NGÀY", "TRONG TUẦN" if span == 7 else "TRONG THÁNG")
	if store_t > 0: close_content.add_child(_label("  TIP KHÁCH THƯỞNG CỬA HÀNG · +%s LT" % _fmt_thousands(store_t), 11, Color("378d69")))
	_add_profit_line(agg)

func _show_reviews() -> void :
	call_deferred("_wrap_close_labels")
	active_close_tab = "reviews"
	if _use_tab_page("reviews"): return
	close_content.add_child(_section_heading("res://assets/boutique/ui_icons/icon_reviews.png", "DANH VỌNG · Nhận xét của từng khách trong ngày.", 12))
	close_content.add_child(_review_summary())
	_fame_block()
	_charity_block()
	if customer_reviews.is_empty(): close_content.add_child(_label("Chưa có đánh giá.", 13, Color("6a8ca0")))
	for review in customer_reviews:
		var row: = HBoxContainer.new();row.add_child(_customer_icon(int(review["avatar"]), Vector2(42, 42))); var t: = _label("%s - %s\n%s\n%s" % [review["name"], "*".repeat(int(review["stars"])), review["text"], _customer_items_text(review)], 11, Color("36556b"));t.size_flags_horizontal = Control.SIZE_EXPAND_FILL;row.add_child(t);close_content.add_child(row)

func _review_summary() -> VBoxContainer:
	var summary: = VBoxContainer.new()
	summary.add_theme_constant_override("separation", 2)
	var counts: Array[int] = [0, 0, 0, 0, 0]
	var total_stars: = 0
	for review in customer_reviews:
		var stars: = clampi(int(review.get("stars", 0)), 1, 5)
		counts[stars - 1] += 1
		total_stars += stars
	var total_reviews: = customer_reviews.size()
	var average: = float(total_stars) / float(total_reviews) if total_reviews > 0 else 0.0
	summary.add_child(_label("TỔNG HỢP: %d lượt · Trung bình %.1f/5 sao" % [total_reviews, average], 12, Color("d979a6")))
	var visual_stars: = HBoxContainer.new()
	visual_stars.add_theme_constant_override("separation", 2)
	var filled_stars: = clampi(roundi(average), 0, 5)
	for star_index in range(5):
		var star_icon: = TextureRect.new()
		star_icon.texture = load("res://assets/boutique/ui_icons/star_yellow.png" if star_index < filled_stars else "res://assets/boutique/ui_icons/star_white.png")
		star_icon.custom_minimum_size = Vector2(20, 20);star_icon.size = Vector2(20, 20);star_icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE;star_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED;star_icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
		visual_stars.add_child(star_icon)
	summary.add_child(visual_stars)
	for stars in range(5, 0, -1):
		var count: = counts[stars - 1]
		var ratio: = (float(count) * 100.0 / float(total_reviews)) if total_reviews > 0 else 0.0
		summary.add_child(_label("%d sao  ·  %d lượt  ·  %.1f%%" % [stars, count, ratio], 11, Color("36556b")))
	return summary

func _hire_staff(role: String, hiring_cost: int = 0) -> void :
	if bool(staff.get(role, false)): return
	if _active_staff_count() >= MAX_ACTIVE_STAFF: _show_toast("Đã đủ %d tạp dịch. Cho một người nghỉ trước khi tuyển thêm." % MAX_ACTIVE_STAFF);return
	if not bool(staff_owned.get(role, false)):
		if money < hiring_cost: _show_toast("Cần %d LT để tuyển nhân viên này." % hiring_cost);return
		money -= hiring_cost
		_log_expense("Tuyển nhân viên", hiring_cost)
		staff_owned[role] = true
	staff[role] = true
	if not staff_hired_day.has(role): staff_hired_day[role] = day_number
	_sfx("unlock");_show_staff();_update_ui();_show_toast("Đã tuyển %s · %s." % [STAFF_ROLES[role]["title"], STAFF_ROLES[role]["name"]])

func _dismiss_staff(role: String) -> void :
	if not bool(staff.get(role, false)): return
	staff[role] = false
	_show_staff();_show_toast("Đã cho nhân viên nghỉ. Có thể tuyển lại miễn phí.")

func _resolve_staff_error(error_id: int, percent: int) -> void :
	for error in staff_errors:
		if int(error["id"]) == error_id:
			var withheld: = int(round(float(tips) * float(percent) / 100.0))
			error["resolved"] = true;error["penalty"] = percent;tips = maxi(0, tips - withheld);money += withheld
			break
	_show_staff()

func _generate_staff_errors() -> void :
	staff_errors.clear()
	if not _staff_can_work(): return
	var count: = randi_range(1, 2)
	var errors: = ["Thái độ với khách chưa tốt", "Tính lộn tiền", "Lấy nhầm sản phẩm"]
	for i in range(count): staff_error_serial += 1;staff_errors.append({"id": staff_error_serial, "text": errors.pick_random(), "stars_lost": randi_range(2, 3), "resolved": false, "penalty": 0})
	for error in staff_errors:
		if not customer_reviews.is_empty():
			var review_index: = randi_range(0, customer_reviews.size() - 1)
			customer_reviews[review_index]["stars"] = maxi(1, int(customer_reviews[review_index]["stars"]) - int(error["stars_lost"]))

func _staff_can_work() -> bool:
	return _staff_serve_interval() > 0.0

func _new_day() -> void :
	day_closed_panel = false
	_apply_forecast_for_new_day()
	_sfx("newday")
	if report_overlay: report_overlay.queue_free();report_overlay = null
	_record_daily_statistics()
	_age_outdated_stock()
	var wages: = 0
	for role in STAFF_ORDER:
		if bool(staff.get(role, false)): wages += int(STAFF_ROLES[role]["wage"])
	manual_pause = false
	daily_wages = wages;money -= wages + _daily_rent();day_number += 1;expenses_today.clear();_log_expense("Tiền thuê mặt bằng", _daily_rent());_log_expense("Lương nhân viên", wages);game_minutes = GAME_START_MINUTES;successful_orders = 0;walked_out = 0;tips = 0;store_tips = 0;revenue_today = 0;best_seller = "Chưa có";vip_count_today = 0;vip_limit_today = randi_range(1, 2);vip_clock = 20.0;spawn_clock = 0.0;staff_work_clock = 0.0;daily_imports.clear();sold_today.clear();customer_reviews.clear();staff_errors.clear();queue.clear();_shelf_setup();_save_game("pre_shift");running = true;paused = false;start_button.visible = false;setup_button.visible = false;pause_menu_panel.visible = false;pause_button.disabled = false;_set_pause_glyph(false);
	_market_new_day()
	_remote_new_day()
	_explore_new_day()
	_auction_new_day()
	_festival_new_day()
	_tax_new_day()
	_special_shelves_new_day()
	_daihoi_new_day()
	_ext8_new_day()
	_invest_new_day()
	_trader_new_day()
	_letter_new_day()
	_incidents_new_day()
	_staff_new_day()
	_upgrades_new_day()
	if not _shelf_product_ids().is_empty():
		queue.append(_new_customer(false));_play_door()
	_show_store();_update_ui()

func _reset_import_plans() -> void :
	for product in products:
		if not bool(product.get("incoming", false)): product["order_quantity"] = 0

func _play_door() -> void :
	_sfx("door")

func _update_money_display() -> void :
	if is_instance_valid(money_label):
		_set_currency_badge(money_label, money, 21, Color("e5aa28"), true)
	if is_instance_valid(report_text):
		_set_currency_badge(report_text, money, 18, Color("e5aa28"))

func _review_hud_row() -> HBoxContainer:
	var row: = HBoxContainer.new()
	row.name = "ReviewHudRow"
	row.add_theme_constant_override("separation", 4)
	return row

func _refresh_review_hud() -> void :
	if not is_instance_valid(review_hud_row): return
	for child in review_hud_row.get_children(): child.queue_free()
	var total_reviews: = customer_reviews.size()
	var total_stars: = 0
	for review in customer_reviews: total_stars += clampi(int(review.get("stars", 0)), 1, 5)
	var average: = float(total_stars) / float(total_reviews) if total_reviews > 0 else 0.0
	var review_text: = _label("DANH VỌNG %d lượt · %.1f/5" % [total_reviews, average], 13, Color("d979a6"), true)
	review_text.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	review_hud_row.add_child(review_text)
	var filled_stars: = clampi(roundi(average), 0, 5)
	for star_index in range(5):
		var star_icon: = TextureRect.new()
		star_icon.texture = load("res://assets/boutique/ui_icons/star_yellow.png" if star_index < filled_stars else "res://assets/boutique/ui_icons/star_white.png")
		star_icon.custom_minimum_size = Vector2(16, 16);star_icon.size = Vector2(16, 16);star_icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE;star_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED;star_icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
		review_hud_row.add_child(star_icon)

func _update_ui() -> void :
	if time_label == null: return
	var total: = int(game_minutes);time_label.text = "%02d:%02d" % [int(total / 60), total % 60];_set_currency_badge(money_label, money, 21, Color("e5aa28"), true);xp_label.text = "XP %s" % _xp_progress_text();queue_label.text = "%d KHÁCH" % queue.size();level_label.text = "LV %d" % level;title_label.text = "%s  -  NGÀY %d" % [store_name, day_number];_refresh_review_hud();_update_cards()
	for p in products:
		if bool(p["incoming"]) and Time.get_ticks_msec() >= int(p["ready_at"]):
			p["incoming"] = false
			var quantity: = maxi(1, int(p.get("incoming_quantity", 1)))
			p["incoming_quantity"] = 0
			var previous_stock: = int(p["stock"])
			p["stock"] = previous_stock + quantity
			var ages: = _normalize_stock_ages(p.get("stock_ages", []), previous_stock)
			for _i in range(quantity): ages.append(0)
			p["stock_ages"] = ages
			for order in daily_imports:
				if int(order["product_id"]) == int(p["id"]) - 1:
					order["delivered"] = int(order.get("delivered", 0)) + quantity
					break
			_show_toast("Hàng về kho: %s x%d." % [p["name"], quantity])
		if bool(staff["restocker"]) or bool(staff["manager"]): _auto_restock(p)
	_update_import_summary()

func _auto_restock(product: Dictionary) -> void :
	if int(product["stock"]) <= 0:
		return
	for shelf in shelves:
		if shelf["unlocked"] and int(shelf["product"]) < 0 and str(shelf.get("kind", "")) == "" and not _is_top(int(product["id"]) - 1):
			var product_id: = int(product["id"]) - 1
			var moved: = _take_inventory_units(product_id, int(product["stock"]))
			if moved.is_empty(): return
			shelf["product"] = int(product["id"]) - 1
			shelf["stock_ages"] = moved
			shelf["stock"] = moved.size()
			return

func _check_level() -> void :
	call_deferred("_tut_check_refining")
	var previous_level: = level
	total_xp += xp
	xp = 0
	while level < LEVEL_XP_THRESHOLDS.size() and total_xp >= int(LEVEL_XP_THRESHOLDS[level]):
		if money < int(LEVEL_MONEY_REQUIREMENTS[level]):
			if _money_block_toast_level != level + 1:
				_money_block_toast_level = level + 1
				_show_toast("Đủ XP lên Level %d · cần có %s LT trong kho." % [level + 1, _fmt_thousands(int(LEVEL_MONEY_REQUIREMENTS[level]))])
			break
		level += 1
	level_xp = total_xp - int(LEVEL_XP_THRESHOLDS[level - 1])
	if level > previous_level:
		call_deferred("_show_level_unlocks", previous_level, level)
		_sfx("levelup")
		_show_toast("LÊN LEVEL %d · tiên môn tiếp tục phát triển!" % level)
		_update_level_sign()

func _update_level_sign() -> void:
	if not is_instance_valid(level_sign_display) or displayed_level_sign_level == level:
		return
	var sign_index: int = clampi(level - 1, 0, LEVEL_SIGN_TEXTURES.size() - 1)
	level_sign_display.texture = LEVEL_SIGN_TEXTURES[sign_index]
	# Ảnh nền riêng theo cấp (assets/boutique/backgrounds/bg_level_XX.jpg); cấp chưa có ảnh dùng nền tiên môn mặc định.
	var bg_path: String = "res://assets/boutique/backgrounds/bg_level_%02d.jpg" % (sign_index + 1)
	if is_instance_valid(background):
		background.texture = load(bg_path) if ResourceLoader.exists(bg_path) else STORE_BG
	# Giữ tỉ lệ ảnh và neo mép trên (đầu dây) sát đáy khung thông tin khách.
	var tex_size: Vector2 = level_sign_display.texture.get_size()
	var sign_size: = Vector2(112, 118)
	if tex_size.x > 0 and tex_size.y > 0:
		var fit: float = minf(112.0 / tex_size.x, 118.0 / tex_size.y)
		sign_size = Vector2(round(tex_size.x * fit), round(tex_size.y * fit))
	level_sign_display.custom_minimum_size = sign_size
	displayed_level_sign_level = level

func _xp_progress_text() -> String:
	if level >= LEVEL_XP_THRESHOLDS.size():
		return "MAX · %d XP" % total_xp
	var current_threshold: = int(LEVEL_XP_THRESHOLDS[level - 1])
	var next_threshold: = int(LEVEL_XP_THRESHOLDS[level])
	if total_xp >= next_threshold and money < int(LEVEL_MONEY_REQUIREMENTS[level]):
		return "Cần %s LT" % _fmt_thousands(int(LEVEL_MONEY_REQUIREMENTS[level]))
	return "%d/%d" % [total_xp - current_threshold, next_threshold - current_threshold]


func _has_overpriced_products() -> bool:
	for product in products:
		var threshold: = int(product.get("overprice_threshold", 0))
		if threshold > 0 and int(product.get("price", 0)) >= threshold: return true
	return false

func _customer_arrival_allowed() -> bool:
	if _shelf_product_ids().is_empty(): return false
	if bool(incident_state.get("sign_lost", false)) and randf() < 0.15: return false
	return not _has_overpriced_products() or randf() < 0.8

func _new_customer(vip: bool) -> Dictionary:
	var eligible: = _shelf_product_ids(vip)
	var zone: = ""
	var combo_shelf: = -1
	var items: Array[int] = []
	if vip and vip_zone_left > 0:
		var vz: = _vip_shelf_ids()
		if not vz.is_empty(): eligible = vz;vip_zone_left -= 1;zone = "vip"
	if not vip and randf() < COMBO_CUSTOMER_CHANCE:
		var cs: Array[int] = []
		for i in range(shelves.size()):
			if str(shelves[i].get("kind", "")) == "combo" and bool(shelves[i]["unlocked"]) and int(shelves[i].get("cstock", 0)) > 0: cs.append(i)
		if not cs.is_empty():
			combo_shelf = cs.pick_random()
			for pid in shelves[combo_shelf]["combo"]: items.append(int(pid))
	if eligible.is_empty():
		eligible = _consign_ids()
		if eligible.is_empty(): eligible = _shelf_product_ids(true);vip = true
	var item_count: = 0 if combo_shelf >= 0 else (randi_range(4, 7) if vip else randi_range(1, 3))
	var boosted: int = int(today_boost.get("product", -1)) if bool(today_boost.get("real", false)) else -1
	for i in range(item_count):
		# Ngày có sự kiện thật: món được báo chiếm khoảng 75% lượt chọn món, các món khác ít xuất hiện hơn hẳn.
		if boosted >= 0 and eligible.has(boosted) and randf() < FORECAST_BOOST_SHARE: items.append(boosted)
		elif festival_featured >= 0 and eligible.has(festival_featured) and randf() < 0.5: items.append(festival_featured)
		elif not _weather_favored(eligible).is_empty() and randf() < 0.35: items.append(_weather_favored(eligible).pick_random())
		else:
			var pick: int = eligible.pick_random()
			var rival: Dictionary = incident_state.get("rival", {})
			if not rival.is_empty() and pick == int(rival.get("product", -1)) and int(products[pick]["price"]) > int(rival.get("price", 0)) and eligible.size() > 1 and randf() < 0.7:
				for _t in range(12):
					if pick != int(rival["product"]): break
					pick = eligible.pick_random()
			items.append(pick)
	if combo_shelf < 0 and zone == "":
		var cons: = _consign_ids()
		if not cons.is_empty() and randf() < CONSIGN_CUSTOMER_CHANCE: items[randi_range(0, items.size() - 1)] = cons.pick_random()
	var item_sizes: Array[String] = []
	var delivered_items: Array[bool] = []
	for product_id in items:
		var product: Dictionary = products[product_id]
		item_sizes.append(str(product["sizes"].pick_random()) if _product_requires_size(product) else "")
		delivered_items.append(false)
	var character_index: = randi_range(0, customer_roster.size() - 1)
	if not members.is_empty() and randf() < 0.3: character_index = clampi(int(members.keys().pick_random()), 0, customer_roster.size() - 1)
	var character: Dictionary = customer_roster[character_index]
	var customer_name: = str(character.get("name", "Khách"))
	customer_order_serial += 1
	return {"order_id": customer_order_serial, "name": customer_name, "product": items[0], "items": items, "item_sizes": item_sizes, "delivered_items": delivered_items, "delivery_animations_pending": 0, "patience": ((VIP_PATIENCE_SECONDS + (10.0 if _has("vip_host") else 0.0)) if vip else NORMAL_PATIENCE_SECONDS) + _patience_bonus(vip) + (5.0 if members.has(str(character_index)) else 0.0), "avatar": character["avatar"], "gender": character["gender"], "age_group": character["age_group"], "screen_side": str(character.get("screen_side", "left")), "vip": vip, "character_id": character_index, "zone": zone, "combo_shelf": combo_shelf, "src": [], "cprice": [], "cond": (COND_KINDS.pick_random() if combo_shelf < 0 and day_number > 2 and randf() < COND_CHANCE else ""), "cond_ok": true, "front_time": 0.0, "member": members.has(str(character_index))}

func _shelf_product_ids(include_vip: bool = true) -> Array[int]:
	var ids: Array[int] = []
	for shelf in shelves:
		if not include_vip and str(shelf.get("kind", "")) == "vip": continue
		var product_id: = int(shelf["product"])
		if product_id >= 0 and _is_top(product_id): continue
		if bool(shelf["unlocked"]) and _is_product_available(product_id) and not ids.has(product_id): ids.append(product_id)
	return ids

func _add_review(customer: Dictionary, stars: int, text: String) -> void :
	# Ưu tiên câu nói về đúng món khách vừa mua (cùng số sao); không có thì dùng câu chung về cách phục vụ.
	var chosen_text: = text
	var bought: Dictionary = {}
	for pid in customer.get("items", []): bought[str(products[int(pid)]["name"])] = true
	var product_match: Array[Dictionary] = []
	var general: Array[Dictionary] = []
	for review in review_bank:
		if int(review.get("stars", 0)) != stars: continue
		var prod: = str(review.get("product", ""))
		if prod.is_empty(): general.append(review)
		elif bought.has(prod): product_match.append(review)
	if not product_match.is_empty(): chosen_text = product_match.pick_random()["text"]
	elif not general.is_empty(): chosen_text = general.pick_random()["text"]
	customer_reviews.append({"name": customer["name"], "avatar": customer["avatar"], "stars": stars, "text": chosen_text, "items": customer["items"], "item_sizes": customer.get("item_sizes", [])})

func _items_text(items: Array) -> String:
	var names: Array[String] = []
	for product_id in items: names.append(products[int(product_id)]["name"])
	return ", ".join(names)

func _customer_items_text(customer: Dictionary, include_sizes: bool = true) -> String:
	# Gộp món trùng: "2× Ích Khí Đan" thay vì lặp tên.
	var order: Array[String] = []
	var counts: Dictionary = {}
	var item_sizes: Array = customer.get("item_sizes", [])
	for item_index in range(customer["items"].size()):
		var product_id: = int(customer["items"][item_index])
		var item_name: = str(products[product_id]["name"])
		if include_sizes and item_index < item_sizes.size() and not str(item_sizes[item_index]).is_empty():
			item_name += " (size " + str(item_sizes[item_index]) + ")"
		if not counts.has(item_name): order.append(item_name);counts[item_name] = 0
		counts[item_name] = int(counts[item_name]) + 1
	var names: Array[String] = []
	for item_name in order: names.append("%d× %s" % [int(counts[item_name]), item_name])
	return ", ".join(names)

func _vip_min_items() -> int: return 4
func _vip_max_items() -> int: return 7

func _load_products() -> Array[Dictionary]:
	var parsed = JSON.parse_string(FileAccess.get_file_as_string("res://config/products.json"))
	var result: Array[Dictionary] = []
	for item in parsed:
		if _product_requires_size(item) and not item.has("sizes"): item["sizes"] = ["S", "M", "L"]
		item["outdated_days"] = _product_outdated_days(item)
		item["order_quantity"] = clampi(int(item.get("order_quantity", 0)), 0, MAX_ORDER_QUANTITY)
		for int_key in ["id", "price", "cost", "stock", "unlock_level", "paid_unlock_cost", "overprice_threshold", "seconds"]:
			if item.has(int_key): item[int_key] = int(item[int_key])
		item["incoming_quantity"] = maxi(0, int(item.get("incoming_quantity", 0)))
		item["stock_ages"] = _normalize_stock_ages(item.get("stock_ages", []), int(item.get("stock", 0)))
		result.append(item)
	return result

func _product_outdated_days(product: Dictionary) -> int:
	if bool(product.get("permanent_stock", false)):
		return 999999
	var category: = str(product.get("category", ""))
	if category in ["Đầm", "Quần áo", "Đồ nam"]:
		return CLOTHING_OUTDATED_DAYS
	if category in ["Phụ kiện", "Túi xách", "Kính mát"]:
		return ACCESSORY_OUTDATED_DAYS
	return maxi(1, int(product.get("outdated_days", DEFAULT_OUTDATED_DAYS)))

func _load_reviews() -> Array[Dictionary]:
	var parsed = JSON.parse_string(FileAccess.get_file_as_string("res://config/reviews.json"))
	var result: Array[Dictionary] = []
	for item in parsed: result.append(item)
	return result

func _load_characters() -> Array[Dictionary]:
	var parsed = JSON.parse_string(FileAccess.get_file_as_string("res://config/characters.json"))
	var result: Array[Dictionary] = []
	if parsed is Array:
		for item in parsed:
			if item is Dictionary: result.append(item)
	return result

func _make_customer_roster() -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	var character_count: int = mini(TOTAL_CHARACTER_COUNT, character_data.size())
	for i in range(character_count):
		var data: Dictionary = character_data[i]
		result.append({
			"id": i,
			"name": str(data.get("name", "Khách")),
			"gender": str(data.get("gender", "unspecified")),
			"age_group": str(data.get("age_group", "cultivator")),
			"screen_side": str(data.get("screen_side", "left")),
			"avatar": i,
		})
	return result

func _product_icon(index: int, size: Vector2) -> TextureRect:
	var t: = TextureRect.new();t.expand_mode = TextureRect.EXPAND_IGNORE_SIZE;t.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED;t.custom_minimum_size = size;t.mouse_filter = Control.MOUSE_FILTER_IGNORE
	if index >= 0 and index < products.size(): t.texture = load(products[index]["image"])
	return t

func _section_heading(path: String, text: String, size: int) -> HBoxContainer:
	var heading: = HBoxContainer.new()
	heading.add_theme_constant_override("separation", 6)
	var icon: = TextureRect.new();icon.texture = load(path);icon.custom_minimum_size = Vector2(24, 24);icon.size = Vector2(24, 24);icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE;icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED;icon.mouse_filter = Control.MOUSE_FILTER_IGNORE;heading.add_child(icon)
	var heading_text: = _label(text, size, Color("285b7a"));heading_text.size_flags_horizontal = Control.SIZE_EXPAND_FILL;heading_text.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;heading_text.custom_minimum_size = Vector2(0, size + 18);heading.add_child(heading_text)
	return heading

func _staff_icon(path: String, size: Vector2) -> TextureRect:
	var icon: = TextureRect.new()
	icon.texture = load(path)
	icon.custom_minimum_size = size
	icon.size = size
	icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	return icon

func _customer_icon(index: int, size: Vector2) -> TextureRect:
	var t: = TextureRect.new();t.expand_mode = TextureRect.EXPAND_IGNORE_SIZE;t.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED;t.custom_minimum_size = size;t.size = size;t.mouse_filter = Control.MOUSE_FILTER_IGNORE
	if index >= 0 and index < CHARACTER_PORTRAITS.size(): t.texture = CHARACTER_PORTRAITS[index]
	return t

func _currency_badge(amount: int, size: int = 21, color: Color = Color("e5aa28"), preserve_size: bool = false) -> PanelContainer:
	var badge: = PanelContainer.new()
	badge.name = "CurrencyBadge"
	var pill: StyleBoxFlat = StyleBoxFlat.new()
	pill.bg_color = Color("f7fbff")
	pill.border_color = Color("a6d8ee")
	pill.set_border_width_all(2)
	pill.set_corner_radius_all(16)
	pill.content_margin_left = 12
	pill.content_margin_right = 14
	pill.content_margin_top = 0
	pill.content_margin_bottom = 0
	badge.add_theme_stylebox_override("panel", pill)
	var contents: HBoxContainer = HBoxContainer.new()
	contents.name = "CurrencyContents"
	contents.alignment = BoxContainer.ALIGNMENT_END
	contents.add_theme_constant_override("separation", 4)
	badge.add_child(contents)
	_set_currency_badge(badge, amount, size, color, preserve_size)
	return badge
func _set_currency_badge(badge: PanelContainer, amount: int, size: int = 21, color: Color = Color("e5aa28"), preserve_size: bool = false) -> void :
	if not is_instance_valid(badge): return
	var contents: HBoxContainer = badge.get_node_or_null("CurrencyContents") as HBoxContainer
	if contents == null:
		contents = HBoxContainer.new()
		contents.name = "CurrencyContents"
		contents.alignment = BoxContainer.ALIGNMENT_END
		contents.add_theme_constant_override("separation", 4)
		badge.add_child(contents)
	for child in contents.get_children(): child.queue_free()
	# Viền gọn: chiều cao pill bám theo cỡ chữ, icon linh thạch cao hơn pill và tràn nhẹ trên/dưới.
	var pill_h: float = float(size + 9)
	var icon_h: float = float(size * 2)
	var icon_w: float = round(icon_h * 0.51)
	contents.add_theme_constant_override("separation", 12)
	var icon_holder: = Control.new()
	icon_holder.custom_minimum_size = Vector2(icon_w, pill_h)
	icon_holder.mouse_filter = Control.MOUSE_FILTER_IGNORE
	contents.add_child(icon_holder)
	var icon: = TextureRect.new()
	icon.texture = CURRENCY_ICON
	icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	icon.position = Vector2(0, (pill_h - icon_h) / 2.0)
	icon.size = Vector2(icon_w, icon_h)
	icon_holder.add_child(icon)
	var value: = _label(str(amount), size, color, preserve_size)
	value.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	contents.add_child(value)
func _label(text: String, size: int, color: Color, preserve_size: bool = false) -> Label:
	var l: = Label.new();l.text = text;l.add_theme_font_override("font", UI_FONT_REGULAR);l.add_theme_font_size_override("font_size", size + (1 if preserve_size else 4));l.add_theme_color_override("font_color", color);l.vertical_alignment = VERTICAL_ALIGNMENT_CENTER;return l

func _button(text: String, size: int, preserve_size: bool = false) -> Button:
	var b: = Button.new();b.text = text;b.add_theme_font_override("font", UI_FONT_MEDIUM);b.add_theme_font_size_override("font_size", size + (1 if preserve_size else 4));b.add_theme_color_override("font_color", Color("285b7a"));b.add_theme_color_override("font_hover_color", Color("ffffff"));b.add_theme_stylebox_override("normal", _box(Color("f7fbff"), Color("a6d8ee"), 2, 14));b.add_theme_stylebox_override("hover", _box(Color("f1a8c6"), Color("d979a6"), 3, 14));b.add_theme_stylebox_override("pressed", _box(Color("c7e8ff"), Color("d979a6"), 3, 14));b.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;return b

func _box(bg: Color, border: Color, width: int, radius: int) -> StyleBoxFlat:
	var s: = StyleBoxFlat.new();s.bg_color = bg;s.border_color = border;s.set_border_width_all(width);s.set_corner_radius_all(radius);s.content_margin_left = 10;s.content_margin_right = 10;s.content_margin_top = 6;s.content_margin_bottom = 6;return s

func _show_toast(text: String) -> void :
	if toast_label == null: return
	# Khung thông báo co theo nội dung (tối đa 440px), luôn nằm giữa màn hình.
	toast_label.text = text
	var font: Font = toast_label.get_theme_font("font")
	var fsize: int = toast_label.get_theme_font_size("font_size")
	var text_w: float = font.get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1, fsize).x if font != null else 440.0
	var box_w: float = clampf(text_w + 28.0, 120.0, 440.0)
	toast_label.size = Vector2(box_w, 26);toast_label.position.x = (540.0 - box_w) / 2.0
	toast_label.size.y = maxf(26.0, toast_label.get_minimum_size().y + 4.0);toast_label.modulate.a = 1.0; var tween: = create_tween();tween.tween_interval(2.4);tween.tween_property(toast_label, "modulate:a", 0.0, 0.4)


func _wrap_close_labels() -> void:
	if not is_instance_valid(close_content):
		return
	_wrap_labels_in(close_content)

func _wrap_labels_in(node: Node) -> void:
	for child in node.get_children():
		if child is Label:
			var l: Label = child
			if l.autowrap_mode == TextServer.AUTOWRAP_OFF:
				l.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
				l.size_flags_horizontal = Control.SIZE_EXPAND_FILL
				l.custom_minimum_size.x = 0
		_wrap_labels_in(child)


# ---------- Nguyên liệu tinh luyện ----------
func _load_refining_recipes() -> void:
	refining_recipes.clear();material_names.clear()
	if not FileAccess.file_exists("res://config/refining_recipes.json"): return
	var parsed = JSON.parse_string(FileAccess.get_file_as_string("res://config/refining_recipes.json"))
	if typeof(parsed) != TYPE_DICTIONARY: return
	var mats: Dictionary = parsed.get("materials", {})
	for material_name in mats.keys():
		material_names.append(str(material_name))
		var image_path: String = str(mats[material_name].get("image", ""))
		if not image_path.is_empty() and ResourceLoader.exists(image_path): material_images[str(material_name)] = image_path
		if not material_stock.has(str(material_name)): material_stock[str(material_name)] = 0
	var recipes: Dictionary = parsed.get("recipes", {})
	for product_name in recipes.keys():
		refining_recipes[str(product_name)] = recipes[product_name]

func _recipe_for(product_id: int) -> Array:
	if product_id < 0 or product_id >= products.size(): return []
	if not _product_requires_refining(products[product_id]): return []
	return refining_recipes.get(str(products[product_id]["name"]), [])

func _recipe_summary(product_id: int) -> String:
	var parts: PackedStringArray = []
	for entry in _recipe_for(product_id):
		parts.append("%s ×%d" % [str(entry["name"]), int(entry["qty"])])
	return " + ".join(parts)

func _missing_refining_materials(product_id: int) -> Array[String]:
	var missing: Array[String] = []
	for entry in _recipe_for(product_id):
		var material_name: String = str(entry["name"])
		var have: int = int(material_stock.get(material_name, 0))
		var need: int = int(entry["qty"])
		if have < need:
			missing.append("%s (cần %d, còn %d)" % [material_name, need, have])
	return missing

func _consume_refining_materials(product_id: int) -> void:
	for entry in _recipe_for(product_id):
		var material_name: String = str(entry["name"])
		var used: = int(entry["qty"]) if _up("refine_room") < 3 else int(ceil(int(entry["qty"]) * 0.7))
		material_stock[material_name] = maxi(0, int(material_stock.get(material_name, 0)) - used)

func _buy_material(material_name: String, amount: int) -> void:
	# Giá không hiển thị trước: mỗi lần bấm MUA, chợ ra một giá ngẫu nhiên.
	var unit_price: int = _roll_material_price()
	if _has("merchant"): unit_price = int(round(unit_price * 0.9))
	var total: int = unit_price * amount
	if money < total:
		_sfx("wrong")
		_show_market_popup("KHÔNG ĐỦ LINH THẠCH", "Lần này %s có giá %s linh thạch.\nBạn chỉ còn %s linh thạch." % [material_name, _fmt_thousands(total), _fmt_thousands(money)])
		return
	money -= total
	_log_expense("Mua nguyên liệu %s" % material_name, total)
	_sfx("coin")
	if _incident_market_scam():
		_update_money_display();_update_ui()
		_incident_push("CHỢ ĐEN LỪA ĐẢO", "Bạn trả %s LT cho %s, mang về mới biết là nguyên liệu giả, linh khí bằng không.\nMất trắng số tiền này." % [_fmt_thousands(total), material_name])
		_log_expense("Sự cố: mua phải %s giả" % material_name, 0)
		return
	material_stock[material_name] = int(material_stock.get(material_name, 0)) + amount
	_update_money_display()
	if close_content != null and active_close_tab == "market":
		_refresh_market_card(material_name)
	_update_ui()
	_show_market_popup("ĐÃ MUA", "Bạn đã mua %s với giá %s linh thạch." % [material_name, _fmt_thousands(total)])

# ---------- Thương Hội · Chợ Thành Trì ----------
const MARKET_SORT_NAMES: Array[String] = ["Tên A → Z", "Có trong kho trước"]

func _show_market() -> void:
	if close_content == null: return
	active_close_tab = "market"
	call_deferred("_tut_event", "tab_market")
	if _use_tab_page("market"): return
	if is_instance_valid(setup_heading_label): setup_heading_label.text = "THƯƠNG HỘI"
	_update_money_display()
	_invest_block()
	var title: = _label("CHỢ THÀNH TRÌ", 20, Color("285b7a"));close_content.add_child(title)
	var note: = _label("Nguyên liệu tinh luyện · giá mỗi lần mua do chợ quyết định, giá ngẫu nhiên từ 4.500 - 850.000 Linh thạch, bấm MUA để mua 1 phần. Món Trung/Thượng phẩm cần đủ nguyên liệu mới vào được Tinh Luyện.", 9, Color("6a8ca0"));note.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;note.size_flags_horizontal = Control.SIZE_EXPAND_FILL;close_content.add_child(note)
	var names: Array = material_names.duplicate()
	match market_sort_mode:
		0: names.sort_custom(func(a, b): return str(a) < str(b))
		1: names.sort_custom(func(a, b): return int(material_stock.get(a, 0)) > int(material_stock.get(b, 0)) or (int(material_stock.get(a, 0)) == int(material_stock.get(b, 0)) and str(a) < str(b)))
	var grid: = GridContainer.new();grid.columns = 4;grid.add_theme_constant_override("h_separation", 6);grid.add_theme_constant_override("v_separation", 8);grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL;close_content.add_child(grid)
	for i in range(names.size()):
		grid.add_child(_market_stall_card(i + 1, str(names[i])))
	var footer: = PanelContainer.new();footer.add_theme_stylebox_override("panel", _box(Color("f7fbff"), Color("a6d8ee"), 2, 16));close_content.add_child(footer)
	var footer_pad: = MarginContainer.new()
	for side in ["left", "right", "top", "bottom"]: footer_pad.add_theme_constant_override("margin_%s" % side, 8)
	footer.add_child(footer_pad)
	var row: = HBoxContainer.new();row.add_theme_constant_override("separation", 12);footer_pad.add_child(row)
	var sort_button: = _button("SẮP XẾP · %s" % MARKET_SORT_NAMES[market_sort_mode], 10);sort_button.custom_minimum_size = Vector2(0, 42);sort_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	sort_button.add_theme_stylebox_override("normal", _box(Color("dff0fb"), Color("8bc5e8"), 2, 14));sort_button.pressed.connect(_cycle_market_sort);row.add_child(sort_button)
	var leave_button: = _button("RỜI CHỢ", 11);leave_button.custom_minimum_size = Vector2(0, 42);leave_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	leave_button.add_theme_stylebox_override("normal", _box(Color("fde6ef"), Color("e8a3c3"), 2, 14));leave_button.add_theme_color_override("font_color", Color("c9558b"));leave_button.pressed.connect(_leave_market);row.add_child(leave_button)

func _market_stall_card(number: int, material_name: String) -> PanelContainer:
	var have: int = int(material_stock.get(material_name, 0))
	var card: = PanelContainer.new();card.size_flags_horizontal = Control.SIZE_EXPAND_FILL;market_card_nodes[material_name] = card;card.set_meta("market_number", number)
	var style: = _box(Color("f7fbff"), Color("b9def2"), 2, 14);style.content_margin_left = 4;style.content_margin_right = 4;style.content_margin_top = 4;style.content_margin_bottom = 6
	card.add_theme_stylebox_override("panel", style)
	var body: = VBoxContainer.new();body.add_theme_constant_override("separation", 3);card.add_child(body)
	var art_holder: = Control.new();art_holder.custom_minimum_size = Vector2(0, 98);art_holder.size_flags_horizontal = Control.SIZE_EXPAND_FILL;art_holder.mouse_filter = Control.MOUSE_FILTER_IGNORE;body.add_child(art_holder)
	# Ảnh nguyên liệu (từ file Docs); nguyên liệu chưa có ảnh dùng ảnh sạp.
	var art_path: String = str(material_images.get(material_name, "res://assets/boutique/market/stall_default.png"))
	if material_images.has(material_name):
		var art_bg: = Panel.new();art_bg.add_theme_stylebox_override("panel", _box(Color("e9f4fb"), Color("e9f4fb"), 0, 10));art_bg.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT);art_bg.mouse_filter = Control.MOUSE_FILTER_IGNORE;art_holder.add_child(art_bg)
	var art: = TextureRect.new();art.texture = load(art_path)
	art.expand_mode = TextureRect.EXPAND_IGNORE_SIZE;art.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED;art.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT);art.mouse_filter = Control.MOUSE_FILTER_IGNORE;art_holder.add_child(art)
	if material_images.has(material_name): art.offset_left = 8;art.offset_right = -8;art.offset_top = 8;art.offset_bottom = -6
	var badge: = PanelContainer.new();var badge_style: = _box(Color("f7fbff"), Color("a6d8ee"), 2, 11);badge_style.content_margin_left = 5;badge_style.content_margin_right = 5;badge_style.content_margin_top = 0;badge_style.content_margin_bottom = 0
	badge.add_theme_stylebox_override("panel", badge_style);badge.position = Vector2(0, 0);badge.mouse_filter = Control.MOUSE_FILTER_IGNORE;art_holder.add_child(badge)
	var badge_label: = _label("%02d" % number, 9, Color("285b7a"));badge_label.mouse_filter = Control.MOUSE_FILTER_IGNORE;badge.add_child(badge_label)
	var name_label: = _label(material_name, 8, Color("285b7a"));name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;name_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL;name_label.custom_minimum_size = Vector2(0, 30);body.add_child(name_label)
	var info: = _label("Kho %d" % have, 8, Color("d979a6"));info.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;info.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;info.size_flags_horizontal = Control.SIZE_EXPAND_FILL;body.add_child(info)
	var buy: = _button("MUA", 10);buy.custom_minimum_size = Vector2(0, 28);buy.autowrap_mode = TextServer.AUTOWRAP_OFF
	buy.add_theme_stylebox_override("normal", _box(Color("ec9fc0"), Color("d979a6"), 2, 14));buy.add_theme_stylebox_override("hover", _box(Color("e58ab2"), Color("c9558b"), 2, 14));buy.add_theme_stylebox_override("pressed", _box(Color("d979a6"), Color("c9558b"), 2, 14));buy.add_theme_stylebox_override("disabled", _box(Color("e6d9df"), Color("d6c3cc"), 2, 14))
	buy.add_theme_color_override("font_color", Color("ffffff"));buy.add_theme_color_override("font_hover_color", Color("ffffff"));buy.add_theme_color_override("font_pressed_color", Color("ffffff"));buy.add_theme_color_override("font_disabled_color", Color("b98fa3"))
	buy.disabled = money < 4500
	buy.tooltip_text = "Dùng cho: %s" % _material_used_by_text(material_name)
	buy.pressed.connect(_buy_material.bind(material_name, 1));body.add_child(buy)
	return card

func _material_used_by_text(material_name: String) -> String:
	var parts: PackedStringArray = []
	for i in range(products.size()):
		for entry in _recipe_for(i):
			if str(entry["name"]) == material_name:
				parts.append("%s ×%d" % [str(products[i]["name"]), int(entry["qty"])])
	return ", ".join(parts)

func _cycle_market_sort() -> void:
	market_sort_mode = (market_sort_mode + 1) % MARKET_SORT_NAMES.size()
	_show_toast("Sắp xếp chợ: %s." % MARKET_SORT_NAMES[market_sort_mode])
	_show_market()

func _leave_market() -> void:
	_show_import_adjustments()


# Giá ngẫu nhiên 4.500 – 850.000 LT: 55% trong 500k–850k, 30% trong 100k–<500k, 15% dưới 100k. Làm tròn 500 LT.
func _roll_material_price() -> int:
	var roll: float = randf()
	var low: int = 4500
	var high: int = 99500
	if roll < 0.55:
		low = 500000; high = 850000
	elif roll < 0.85:
		low = 100000; high = 499500
	return int(randi_range(low / 500, high / 500)) * 500

func _fmt_thousands(value: int) -> String:
	var digits: String = str(absi(value))
	var out: String = ""
	while digits.length() > 3:
		out = "." + digits.substr(digits.length() - 3) + out
		digits = digits.substr(0, digits.length() - 3)
	return ("-" if value < 0 else "") + digits + out


var market_popup: Control

func _show_market_popup(title_text: String, body_text: String, extra_lines: PackedStringArray = PackedStringArray(), extra_colors: Array = []) -> void:
	if title_text in ["ĐÃ MUA", "TIN TỨC THÀNH TRÌ"]: _sfx("pop")
	if is_instance_valid(market_popup): market_popup.queue_free()
	var dim: = ColorRect.new();dim.color = Color(0.08, 0.22, 0.34, 0.45);dim.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT);dim.z_index = 300;dim.mouse_filter = Control.MOUSE_FILTER_STOP;add_child(dim)
	market_popup = dim
	var panel: = PanelContainer.new();panel.position = Vector2(40, 380);panel.size = Vector2(460, 0);panel.custom_minimum_size = Vector2(460, 0)
	panel.modulate.a = 0.0;_center_incident_panel(panel)
	var style: = _box(Color("f7fbff"), Color("8bc5e8"), 4, 20);style.content_margin_left = 22;style.content_margin_right = 22;style.content_margin_top = 18;style.content_margin_bottom = 18
	panel.add_theme_stylebox_override("panel", style);dim.add_child(panel)
	var box: = VBoxContainer.new();box.add_theme_constant_override("separation", 12);panel.add_child(box)
	var title: = _label(title_text, 20, Color("285b7a"));title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;box.add_child(title)
	var body: = _label(body_text, 13, Color("36556b"));body.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;body.size_flags_horizontal = Control.SIZE_EXPAND_FILL;box.add_child(body)
	if not extra_lines.is_empty():
		var list: = VBoxContainer.new();list.add_theme_constant_override("separation", 4);box.add_child(list)
		for li in range(extra_lines.size()):
			var c: Color = extra_colors[li] if li < extra_colors.size() else Color("36556b")
			var ll: = _label(extra_lines[li], 13, c);ll.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;ll.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;ll.size_flags_horizontal = Control.SIZE_EXPAND_FILL;list.add_child(ll)
	var ok: = _button("ĐÓNG", 13);ok.custom_minimum_size = Vector2(0, 44);ok.pressed.connect(func(): if is_instance_valid(dim): dim.queue_free());box.add_child(ok)


# ---------- Lưu game ----------
# Lưu ở các điểm an toàn giữa các ca: lúc bố trí đầu ngày ("pre_shift") và lúc đã đóng ca ("closed").
# Đang trong ca thì không lưu; nếu thoát giữa ca, lần sau vào lại từ đầu ca đó.
const GAME_SAVE_PATH: = "user://tien_mon_linh_van_save.json"
const GAME_SAVE_VERSION: = 1
const PRODUCT_SAVE_KEYS: = ["stock", "stock_ages", "incoming", "incoming_quantity", "ready_at", "order_quantity", "price"]
var _last_save_text: String = ""
# true khi đang ở bảng cuối ca (đã đóng ca, chưa sang ngày mới)
var day_closed_panel: bool = false

func _current_save_phase() -> String:
	if running: return ""
	if is_instance_valid(store_name_prompt_overlay): return ""
	if day_closed_panel and report_overlay != null: return "closed"
	return "pre_shift"

func _autosave_tick() -> void:
	_save_game()

func _save_game(force_phase: String = "") -> void:
	if _archive_resetting: return
	var phase: String = force_phase if not force_phase.is_empty() else _current_save_phase()
	if phase.is_empty(): return
	var product_state: Array = []
	for p in products:
		var row: Dictionary = {}
		for key in PRODUCT_SAVE_KEYS:
			if p.has(key): row[key] = p[key]
		product_state.append(row)
	var data: Dictionary = {
		"version": GAME_SAVE_VERSION, "phase": phase, "store_name": store_name, "day_number": day_number,
		"money": money, "xp": xp, "level": level, "level_xp": level_xp, "total_xp": total_xp,
		"successful_orders": successful_orders, "walked_out": walked_out, "tips": tips, "store_tips": store_tips, "revenue_today": revenue_today, "incidents": incident_state, "tax": tax_state, "ext": {"market": market_idx, "contracts": contracts, "dh_titles": daihoi_titles, "dh_boost": daihoi_boost_until, "ext8": {"golden": golden, "night_plan": night_plan, "members": members, "visits": member_visits, "promo_until": promo_until, "promo_cd": promo_cd, "promo_scandal": promo_scandal, "buzz": buzz, "w_today": weather_today, "w_tom": weather_tomorrow, "invest": investments, "inv_offers": invest_offers, "charity_day": charity_day}}, "stats": stats, "ach_claimed": ach_claimed, "ach_notified": ach_notified, "festival_featured": festival_featured, "auction": {"lots": auction_lots, "serial": auction_serial}, "explore": {"list": expeditions, "adv": adv_state, "serial": explore_serial, "ancient": ancient_window}, "shop": {"up": shop_up, "owned": treasures_owned, "placed": treasures_placed}, "remote": {"offers": remote_offers, "active": remote_active, "ship": remote_shipments, "rep": sect_rep, "serial": remote_serial},
		"best_seller": best_seller, "daily_wages": daily_wages, "expenses_today": expenses_today, "tutorial_done": tut_done.keys(), "forecast_next": forecast_next, "today_boost": today_boost, "vip_limit_today": vip_limit_today,
		"first_purchase_guidance_pending": first_purchase_guidance_pending,
		"products": product_state, "shelves": shelves, "staff": staff, "staff_owned": staff_owned, "staff_hired_day": staff_hired_day,
		"customer_reviews": customer_reviews, "daily_statistics": daily_statistics, "daily_imports": daily_imports,
		"sold_today": sold_today, "material_stock": material_stock,
	}
	var text: String = JSON.stringify(data)
	if text == _last_save_text: return
	var file: = FileAccess.open(GAME_SAVE_PATH, FileAccess.WRITE)
	if file == null:
		push_warning("Không thể lưu game: %s" % error_string(FileAccess.get_open_error()))
		return
	file.store_string(text);file.close()
	_last_save_text = text

func _json_ints(value: Variant) -> Variant:
	# JSON đọc số thành float; trả lại int cho số nguyên.
	if value is float and is_equal_approx(value, round(value)): return int(value)
	if value is Array:
		var out: Array = []
		for item in value: out.append(_json_ints(item))
		return out
	if value is Dictionary:
		var out_d: Dictionary = {}
		for k in value.keys(): out_d[k] = _json_ints(value[k])
		return out_d
	return value

func _load_game() -> String:
	if not FileAccess.file_exists(GAME_SAVE_PATH): return ""
	var parsed: Variant = JSON.parse_string(FileAccess.get_file_as_string(GAME_SAVE_PATH))
	if not parsed is Dictionary: return ""
	var d: Dictionary = _json_ints(parsed)
	if int(d.get("version", 0)) != GAME_SAVE_VERSION: return ""
	store_name = str(d.get("store_name", store_name));day_number = int(d.get("day_number", 1))
	money = int(d.get("money", money));xp = int(d.get("xp", 0));level = int(d.get("level", 1));level_xp = int(d.get("level_xp", 0));total_xp = int(d.get("total_xp", 0))
	tax_state = d.get("tax", {});var ext: Dictionary = d.get("ext", {});market_idx = ext.get("market", {});contracts = ext.get("contracts", {});daihoi_titles = int(ext.get("dh_titles", 0));daihoi_boost_until = int(ext.get("dh_boost", 0));_ext8_load(ext.get("ext8", {}));stats = d.get("stats", {});ach_claimed = d.get("ach_claimed", {});ach_notified = d.get("ach_notified", {});successful_orders = int(d.get("successful_orders", 0));walked_out = int(d.get("walked_out", 0));tips = int(d.get("tips", 0));store_tips = int(d.get("store_tips", 0));revenue_today = int(d.get("revenue_today", 0))
	festival_featured = int(d.get("festival_featured", -1))
	var au_d: Variant = d.get("auction", null)
	if au_d is Dictionary:
		auction_lots = au_d.get("lots", []);auction_serial = int(au_d.get("serial", 0))
	var ex_d: Variant = d.get("explore", null)
	if ex_d is Dictionary:
		expeditions = ex_d.get("list", []);adv_state = ex_d.get("adv", {});explore_serial = int(ex_d.get("serial", 0));ancient_window = ex_d.get("ancient", [])
	var shop_d: Variant = d.get("shop", null)
	if shop_d is Dictionary:
		shop_up = shop_d.get("up", {});treasures_owned = shop_d.get("owned", []);treasures_placed = shop_d.get("placed", [])
	var rem: Variant = d.get("remote", null)
	if rem is Dictionary:
		remote_offers = rem.get("offers", []);remote_active = rem.get("active", []);remote_shipments = rem.get("ship", []);sect_rep = rem.get("rep", {});remote_serial = int(rem.get("serial", 0))
	var inc: Variant = d.get("incidents", null)
	if inc is Dictionary:
		for k in inc.keys(): incident_state[k] = inc[k]
	if bool(incident_state.get("sign_lost", false)) and is_instance_valid(level_sign_display): level_sign_display.visible = false
	best_seller = str(d.get("best_seller", best_seller));daily_wages = int(d.get("daily_wages", 0));vip_limit_today = int(d.get("vip_limit_today", 1))
	first_purchase_guidance_pending = bool(d.get("first_purchase_guidance_pending", false))
	var product_state: Array = d.get("products", [])
	for i in range(mini(product_state.size(), products.size())):
		var row: Dictionary = product_state[i]
		for key in row.keys(): products[i][key] = row[key]
	var saved_shelves: Array = d.get("shelves", [])
	if not saved_shelves.is_empty():
		_migrate_shelves(saved_shelves)
		_shelf_setup()
		for sh in shelves:
			if int(sh.get("product", -1)) >= 0 and _is_top(int(sh["product"])): _return_shelf_stock_to_inventory(sh)
	for key in d.get("staff", {}).keys(): staff[key] = bool(d["staff"][key])
	for key in d.get("staff_owned", {}).keys(): staff_owned[key] = bool(d["staff_owned"][key])
	for key in d.get("staff_hired_day", {}).keys(): staff_hired_day[key] = int(d["staff_hired_day"][key])
	customer_reviews.clear()
	for r in d.get("customer_reviews", []): customer_reviews.append(r)
	daily_statistics.clear()
	for r in d.get("daily_statistics", []): daily_statistics.append(r)
	daily_imports.clear()
	for r in d.get("daily_imports", []): daily_imports.append(r)
	sold_today = d.get("sold_today", {})
	expenses_today.clear()
	for e in d.get("expenses_today", []): expenses_today.append(e)
	tut_done.clear()
	for k in d.get("tutorial_done", []): tut_done[str(k)] = true
	forecast_next = d.get("forecast_next", {})
	today_boost = d.get("today_boost", {})
	if day_number > 1:
		for k in TUT_CORE: tut_done[k] = true
	for key in d.get("material_stock", {}).keys(): material_stock[str(key)] = int(d["material_stock"][key])
	return str(d.get("phase", "pre_shift"))

func _update_level_sign_force() -> void:
	displayed_level_sign_level = -1
	_update_level_sign()


# Nút tạm dừng dạng biểu tượng: 2 vạch song song (đang chạy) / tam giác (đang dừng).
var pause_bar_a: ColorRect
var pause_bar_b: ColorRect
var pause_play_icon: Polygon2D

func _build_pause_glyph() -> void:
	var glyph_color: = Color("285b7a")
	pause_bar_a = ColorRect.new();pause_bar_a.color = glyph_color;pause_bar_a.size = Vector2(4, 13);pause_bar_a.mouse_filter = Control.MOUSE_FILTER_IGNORE;pause_button.add_child(pause_bar_a)
	pause_bar_b = ColorRect.new();pause_bar_b.color = glyph_color;pause_bar_b.size = Vector2(4, 13);pause_bar_b.mouse_filter = Control.MOUSE_FILTER_IGNORE;pause_button.add_child(pause_bar_b)
	pause_play_icon = Polygon2D.new();pause_play_icon.color = glyph_color;pause_play_icon.polygon = PackedVector2Array([Vector2(0, 0), Vector2(11, 6.5), Vector2(0, 13)]);pause_button.add_child(pause_play_icon)
	pause_button.resized.connect(_layout_pause_glyph)
	_layout_pause_glyph()
	_set_pause_glyph(false)

func _layout_pause_glyph() -> void:
	if not is_instance_valid(pause_button) or not is_instance_valid(pause_bar_a): return
	var c: Vector2 = pause_button.size / 2.0
	pause_bar_a.position = Vector2(c.x - 6, c.y - 6.5)
	pause_bar_b.position = Vector2(c.x + 2, c.y - 6.5)
	pause_play_icon.position = Vector2(c.x - 4, c.y - 6.5)

func _set_pause_glyph(is_paused: bool) -> void:
	if not is_instance_valid(pause_bar_a): return
	pause_button.text = ""
	pause_bar_a.visible = not is_paused
	pause_bar_b.visible = not is_paused
	pause_play_icon.visible = is_paused


# ---------- Tăng tốc bảng Bố trí: giữ trang của từng tab, chỉ cập nhật phần thay đổi ----------
var tab_pages: Dictionary = {}
var shelf_stock_labels: Dictionary = {}
var shelf_expire_marks: Dictionary = {}
var tab_sigs: Dictionary = {}
var tab_scroll: Dictionary = {}
var import_card_nodes: Dictionary = {}
var price_fields: Dictionary = {}
var market_card_nodes: Dictionary = {}

func _data_sig() -> int:
	var parts: Array = [forecast_next, money, level, day_number, running, pre_game_adjustment, market_sort_mode, first_purchase_guidance_pending, staff, staff_owned, material_stock, paid_product_unlocks, customer_reviews.size(), daily_statistics.size(), staff_errors.size(), selected_product, remote_offers.size(), remote_active.size(), remote_shipments.size(), sect_rep, shop_up, treasures_owned, treasures_placed, expeditions.size(), adv_state, auction_lots.size(), ach_claimed.size(), ach_notified.size(), str(tax_state).hash(), str(contracts).hash(), str(market_idx).hash(), str(golden).hash(), night_plan, members.size(), promo_until, investments.size(), invest_offers.size(), charity_day]
	for p in products: parts.append([p.get("stock", 0), p.get("price", 0), p.get("order_quantity", 0), p.get("incoming", false), p.get("incoming_quantity", 0)])
	for sh in shelves: parts.append([sh.get("product", -1), sh.get("stock", 0), sh.get("unlocked", false), sh.get("cstock", 0), sh.get("cpid", -1), sh.get("combo", []), sh.get("offer", {}).size()])
	return str(parts).hash()

func _touch_tab_sig() -> void:
	if tab_pages.has(active_close_tab): tab_sigs[active_close_tab] = _data_sig()

func _use_tab_page(tab: String) -> bool:
	_refresh_tab_highlight(tab)
	# Trả true nếu trang của tab còn đúng dữ liệu -> chỉ hiện lại, không dựng mới.
	if not is_instance_valid(close_scroll): return false
	if is_instance_valid(setup_heading_label): setup_heading_label.text = "THƯƠNG HỘI" if tab == "market" else "BỐ TRÍ TIÊN MÔN"
	var current: Node = close_scroll.get_child(0) if close_scroll.get_child_count() > 0 else null
	for key in tab_pages.keys():
		if tab_pages[key] == current: tab_scroll[key] = close_scroll.scroll_vertical
	var cached: Variant = tab_pages.get(tab, null)
	if current != cached or cached == null: _sfx("tab")
	if cached != null and is_instance_valid(cached) and int(tab_sigs.get(tab, 0)) == _data_sig():
		if current != cached:
			if current != null:
				close_scroll.remove_child(current)
				if not tab_pages.values().has(current): current.queue_free()
			close_scroll.add_child(cached)
		close_content = cached
		close_scroll.set_deferred("scroll_vertical", int(tab_scroll.get(tab, 0)))
		return true
	if cached != null and is_instance_valid(cached):
		if cached.get_parent() == close_scroll: close_scroll.remove_child(cached)
		cached.queue_free()
	if current != null and current != cached and current.get_parent() == close_scroll:
		close_scroll.remove_child(current)
		if not tab_pages.values().has(current): current.queue_free()
	var page: = VBoxContainer.new();page.size_flags_horizontal = Control.SIZE_EXPAND_FILL;page.mouse_filter = Control.MOUSE_FILTER_PASS
	page.child_entered_tree.connect(_set_scroll_tree_mouse_filter_pass);page.add_theme_constant_override("separation", 6)
	close_scroll.add_child(page)
	close_content = page
	tab_pages[tab] = page
	if tab == "imports": import_card_nodes.clear()
	if tab == "market": market_card_nodes.clear()
	price_fields.clear()
	close_scroll.set_deferred("scroll_vertical", 0)
	call_deferred("_store_tab_sig", tab)
	return false

func _store_tab_sig(tab: String) -> void:
	if tab_pages.has(tab): tab_sigs[tab] = _data_sig()

func _swap_card(old_card: Control, new_card: Control) -> void:
	var parent: Node = old_card.get_parent()
	if parent == null: return
	var pos: int = old_card.get_index()
	parent.add_child(new_card);parent.move_child(new_card, pos)
	parent.remove_child(old_card);old_card.queue_free()

func _refresh_import_card(index: int) -> void:
	var old: Variant = import_card_nodes.get(index, null)
	if old == null or not is_instance_valid(old) or active_close_tab != "imports":
		_show_import_adjustments();return
	var p: Dictionary = products[index]
	var fresh: Control = _paid_product_unlock_card(index) if bool(p.get("requires_paid_unlock", false)) and not _is_paid_product_unlocked(index) else _import_product_card(index)
	import_card_nodes[index] = fresh
	_swap_card(old, fresh)
	_touch_tab_sig()

func _refresh_market_card(material_name: String) -> void:
	var old: Variant = market_card_nodes.get(material_name, null)
	if old == null or not is_instance_valid(old):
		_show_market();return
	var fresh: = _market_stall_card(int(old.get_meta("market_number", 1)), material_name)
	_swap_card(old, fresh)
	for other in market_card_nodes.values():
		if is_instance_valid(other) and other != fresh:
			for b in other.find_children("*", "Button", true, false):
				if b.text == "MUA": b.disabled = money < 4500
	_touch_tab_sig()


# ---------- Chi tiêu trong ngày ----------
func _log_expense(label: String, amount: int) -> void:
	if amount == 0: return
	expenses_today.append({"label": label, "amount": amount})

func _add_expense_lines(expenses: Array) -> void:
	if expenses.is_empty():
		close_content.add_child(_label("  Chưa bị trừ linh thạch khoản nào.", 11, Color("6a8ca0")))
		return
	var total: int = 0
	for e in expenses: total += int(e.get("amount", 0))
	close_content.add_child(_label("  BỊ TRỪ TRONG NGÀY · tổng %s LT" % _fmt_thousands(total), 11, Color("d979a6")))
	for g in _group_expenses(expenses):
		var sign: String = "−" if int(g["amount"]) >= 0 else "+"
		var l: = _label("    %s%s · %s%s LT" % [g["label"], g["note"], sign, _fmt_thousands(absi(int(g["amount"])))], 11, Color("36556b"));l.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;close_content.add_child(l)

# Gộp các khoản cùng loại thành một dòng: bán nhầm, quá nhiệt, bồi thường giao nhầm, thâu mua...
func _expense_group_key(label: String) -> Array:
	if label.begins_with("Bán nhầm "): return ["Bán nhầm", label.substr(9)]
	if label.begins_with("Sự cố: quá nhiệt "):
		var rest: = label.substr(17)
		var k: = rest.find(" (kèm")
		var core: = rest.substr(0, k) if k >= 0 else rest
		var sp: = core.find(" ")
		if sp > 0 and core.substr(0, sp).is_valid_int(): return ["Sự cố: quá nhiệt khi tinh luyện", core.substr(sp + 1), int(core.substr(0, sp))]
		return ["Sự cố: quá nhiệt khi tinh luyện", core]
	if label.begins_with("Sự cố: bồi thường khách vì giao nhầm "): return ["Sự cố: bồi thường khách vì giao nhầm", label.substr(37)]
	if label.begins_with("Sự cố: khách thử "): return ["Sự cố: bồi thường phi xa đâm cột", ""]
	if label.begins_with("Mất hàng: "):
		var r2: = label.substr(10)
		var x: = r2.rfind(" x")
		return [label, ""] if x < 0 else [label, ""]
	return [label, ""]

func _group_expenses(expenses: Array) -> Array:
	var order: Array = [];var groups: Dictionary = {}
	for e in expenses:
		var key: Array = _expense_group_key(str(e.get("label", "Khác")))
		var g: String = key[0]
		if not groups.has(g): order.append(g);groups[g] = {"label": g, "amount": 0, "times": 0, "details": []}
		groups[g]["amount"] = int(groups[g]["amount"]) + int(e.get("amount", 0))
		groups[g]["times"] = int(groups[g]["times"]) + 1
		if str(key[1]) != "":
			for _w in range(int(key[2]) if key.size() > 2 else 1): groups[g]["details"].append(str(key[1]))
	var out: Array = []
	for g in order:
		var d: Dictionary = groups[g]
		var note: = ""
		if int(d["times"]) > 1 or not (d["details"] as Array).is_empty():
			var counts: Dictionary = {};var dorder: Array = []
			for x in d["details"]:
				if not counts.has(x): dorder.append(x);counts[x] = 0
				counts[x] = int(counts[x]) + 1
			var parts: PackedStringArray = []
			for x in dorder: parts.append(("%s ×%d" % [x, int(counts[x])]) if int(counts[x]) > 1 else str(x))
			note = " (%d lần%s)" % [int(d["times"]), (": " + ", ".join(parts)) if not parts.is_empty() else ""] if int(d["times"]) > 1 else (" (" + ", ".join(parts) + ")")
		out.append({"label": d["label"], "amount": d["amount"], "note": note})
	return out


# ---------- Hướng dẫn tân thủ ----------
# Chuỗi chính (ngày đầu): thâu mua -> bày kệ -> mở ca -> giao hàng -> cuối ca.
# Chuỗi tinh luyện: tự bật khi lần đầu có món cần tinh luyện được mở.
const TUT_CORE: Array[String] = ["t_welcome", "t_shelf_tab", "t_place", "t_open", "t_serve", "t_sold", "t_endday"]
const TUT_STEPS: Dictionary = {
	"t_welcome": {"title": "CHÀO MỪNG CHƯỞNG QUẦY", "text": "Mỗi ngày gồm 2 phần: bố trí tiên môn, rồi mở cửa bán hàng.\nBước 1: thâu mua hàng. Bấm + để chọn số lượng, rồi bấm THÂU.", "target": "first_import", "wait": true},
	"t_shelf_tab": {"title": "BÀY HÀNG LÊN KỆ", "text": "Hàng đã vào linh khố. Bấm tab LINH CÁT để bày hàng lên kệ.", "target": "tab_shelves", "wait": true},
	"t_place": {"title": "CHỌN KỆ", "text": "Bấm dấu + ở một kệ trống, rồi chọn món vừa thâu mua. Có thể chỉnh giá bán bằng nút − / +.\nChú ý màu giá: ĐỎ là chạm hoặc vượt giá trần, khách sẽ ngại vào. XANH là thấp hơn giá thâu, bán bị lỗ.", "target": "scroll", "wait": true},
	"t_open": {"title": "MỞ CỬA", "text": "Kệ đã có hàng! Bấm LƯU ĐIỀU CHỈNH · MỞ CA để mở cửa đón khách.", "target": "begin", "wait": true},
	"t_serve": {"title": "PHỤC VỤ KHÁCH", "text": "Khách đã vào. Xem yêu cầu trong khung khách, rồi bấm vào món trên kệ để giao đủ số lượng.\nBấm sai món bị trừ 5 giây kiên nhẫn. Hết kiên nhẫn khách sẽ bỏ về.", "target": "customer", "wait": false},
	"t_sold": {"title": "BÁN THÀNH CÔNG", "text": "Giao đủ món là khách tự thanh toán: bạn nhận linh thạch và XP. Đủ XP sẽ lên cấp, mở thêm vật phẩm và biển hiệu mới.\nNút hai vạch ở góc trên bên trái để tạm dừng hoặc đóng ca sớm.", "target": "", "wait": false},
	"t_endday": {"title": "HẾT CA", "text": "Bảng cuối ca: CHƯỞNG BỘ xem bán hàng và chi tiêu, CHIÊU MỘ tuyển nhân viên, DANH VỌNG xem đánh giá, THƯƠNG HỘI mua nguyên liệu.\nBấm nút dưới cùng để trả lương, thuê mặt bằng và sang ngày mới.", "target": "panel", "wait": false},
	"r_intro": {"title": "TINH LUYỆN", "text": "Bạn đã có món Trung/Thượng phẩm. Mỗi lần giao món này phải TINH LUYỆN, và mỗi lần tinh luyện tốn nguyên liệu (ghi trên thẻ món ở tab Thâu mua).\nBấm tab THƯƠNG HỘI để mua nguyên liệu.", "target": "tab_market", "wait": true},
	"r_market": {"title": "CHỢ THÀNH TRÌ", "text": "Mỗi lần bấm MUA được 1 phần nguyên liệu, giá ngẫu nhiên từ 4.500 đến 850.000 linh thạch.\nMua đủ nguyên liệu trước khi mở ca, thiếu sẽ không tinh luyện được.", "target": "", "wait": false},
	"r_minigame": {"title": "CÁCH TINH LUYỆN", "text": "Chạm và GIỮ nút khi vạch nằm trong vùng XANH. Vạch sang vùng đỏ thì thả tay, chờ vạch quay lại.\nGiữ đủ thời gian là thành công và trừ nguyên liệu. Bấm HỦY thì không mất gì.", "target": "", "wait": false},
	"r_missing": {"title": "THIẾU NGUYÊN LIỆU", "text": "Chưa đủ nguyên liệu nên chưa tinh luyện được món này. Đóng ca, vào THƯƠNG HỘI mua đủ nguyên liệu rồi bán lại sau.", "target": "", "wait": false},
}
var tut_done: Dictionary = {}
var tut_current: String = ""
var tut_layer: Control
var tut_bubble: PanelContainer
var tut_highlight: Panel
var tut_timer: Timer
var tut_paused_game: bool = false
var tab_button_refs: Dictionary = {}
var begin_button_ref: Button

func _tut_event(ev: String) -> void:
	if tut_done.has("skip_all"): return
	match ev:
		"named":
			if day_number == 1 and not tut_done.has("t_welcome"): _tut_show("t_welcome")
		"ordered":
			if tut_current == "t_welcome": _tut_finish(); _tut_show("t_shelf_tab")
		"tab_shelves":
			if tut_current == "t_shelf_tab": _tut_finish(); _tut_show("t_place")
		"placed":
			if tut_current in ["t_welcome", "t_shelf_tab", "t_place"]:
				for k in ["t_welcome", "t_shelf_tab"]: tut_done[k] = true
				_tut_finish(); _tut_show("t_open")
		"opened":
			if tut_current in ["t_welcome", "t_shelf_tab", "t_place", "t_open"]:
				for k in ["t_welcome", "t_shelf_tab", "t_place"]: tut_done[k] = true
				_tut_finish()
			if not tut_done.has("t_serve") and not queue.is_empty(): _tut_show("t_serve")
		"sold":
			if not tut_done.has("t_sold") and tut_done.has("t_serve"): _tut_show("t_sold")
		"end_day":
			if not tut_done.has("t_endday"): _tut_show("t_endday")
		"tab_market":
			if tut_current == "r_intro": _tut_finish(); _tut_show("r_market")
		"minigame":
			if not tut_done.has("r_minigame"): _tut_show("r_minigame")
		"missing_mats":
			if not tut_done.has("r_missing"): _tut_show("r_missing")

func _tut_check_refining() -> void:
	if tut_done.has("skip_all") or tut_done.has("r_intro") or not tut_current.is_empty(): return
	if running or report_overlay == null: return
	for i in range(products.size()):
		if _product_requires_refining(products[i]) and _is_product_available(i):
			_tut_show("r_intro");return

func _tut_show(step: String) -> void:
	if tut_done.has(step) or not TUT_STEPS.has(step): return
	if not tut_current.is_empty() and tut_current != step: _tut_finish(false)
	tut_current = step
	_sfx("pop")
	var info: Dictionary = TUT_STEPS[step]
	if tut_layer == null or not is_instance_valid(tut_layer):
		tut_layer = Control.new();tut_layer.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT);tut_layer.mouse_filter = Control.MOUSE_FILTER_IGNORE;tut_layer.z_index = 400;add_child(tut_layer)
		tut_highlight = Panel.new();tut_highlight.mouse_filter = Control.MOUSE_FILTER_IGNORE
		var hl: = StyleBoxFlat.new();hl.bg_color = Color(1, 0.85, 0.3, 0.08);hl.border_color = Color("f2a13f");hl.set_border_width_all(4);hl.set_corner_radius_all(14)
		tut_highlight.add_theme_stylebox_override("panel", hl);tut_layer.add_child(tut_highlight)
		tut_timer = Timer.new();tut_timer.wait_time = 0.05;tut_timer.timeout.connect(_tut_follow);add_child(tut_timer);tut_timer.start()
	move_child(tut_layer, get_child_count() - 1)
	if is_instance_valid(tut_bubble): tut_bubble.queue_free()
	tut_bubble = PanelContainer.new();tut_bubble.mouse_filter = Control.MOUSE_FILTER_STOP
	var st: = _box(Color("fffaf0"), Color("f2a13f"), 3, 18);st.content_margin_left = 16;st.content_margin_right = 16;st.content_margin_top = 12;st.content_margin_bottom = 12
	tut_bubble.add_theme_stylebox_override("panel", st);tut_bubble.position = Vector2(16, 80);tut_bubble.size = Vector2(508, 10);tut_bubble.custom_minimum_size = Vector2(508, 0);tut_layer.add_child(tut_bubble)
	var col: = VBoxContainer.new();col.add_theme_constant_override("separation", 8);tut_bubble.add_child(col)
	var head: = HBoxContainer.new();col.add_child(head)
	var title: = _label(str(info["title"]), 15, Color("c9558b"));title.size_flags_horizontal = Control.SIZE_EXPAND_FILL;title.autowrap_mode = TextServer.AUTOWRAP_OFF;head.add_child(title)
	var skip: = _button("Bỏ qua", 9);skip.autowrap_mode = TextServer.AUTOWRAP_OFF;skip.custom_minimum_size = Vector2(70, 26);skip.size_flags_vertical = Control.SIZE_SHRINK_CENTER;skip.pressed.connect(_tut_skip_all);head.add_child(skip)
	var body: = _label(str(info["text"]), 12, Color("36556b"));body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;body.size_flags_horizontal = Control.SIZE_EXPAND_FILL;col.add_child(body)
	if not bool(info["wait"]):
		var ok: = _button("ĐÃ HIỂU", 12);ok.custom_minimum_size = Vector2(0, 38);ok.pressed.connect(_tut_ok);col.add_child(ok)
		if running and not paused:
			tut_paused_game = true;paused = true;_set_pause_glyph(true)
	tut_highlight.visible = false
	tut_bubble.reset_size()
	_tut_follow()

func _tut_target_rect() -> Rect2:
	if tut_current.is_empty(): return Rect2()
	match str(TUT_STEPS[tut_current]["target"]):
		"first_import":
			for idx in range(products.size()):
				if import_card_nodes.has(idx) and is_instance_valid(import_card_nodes[idx]) and import_card_nodes[idx].is_visible_in_tree(): return import_card_nodes[idx].get_global_rect()
		"tab_shelves":
			if tab_button_refs.has("shelves") and is_instance_valid(tab_button_refs["shelves"]): return tab_button_refs["shelves"].get_global_rect()
		"tab_market":
			if tab_button_refs.has("market") and is_instance_valid(tab_button_refs["market"]): return tab_button_refs["market"].get_global_rect()
		"scroll":
			if is_instance_valid(close_scroll) and close_scroll.is_visible_in_tree(): return close_scroll.get_global_rect()
		"begin":
			if is_instance_valid(begin_button_ref) and begin_button_ref.is_visible_in_tree(): return begin_button_ref.get_global_rect()
		"customer":
			if is_instance_valid(customer_card): return customer_card.get_global_rect()
		"panel":
			if is_instance_valid(report_panel): return report_panel.get_global_rect()
	return Rect2()

func _tut_follow() -> void:
	if not is_instance_valid(tut_layer) or tut_current.is_empty(): return
	var r: Rect2 = _tut_target_rect()
	var root_inv: = get_global_transform_with_canvas().affine_inverse()
	if r.size == Vector2.ZERO:
		tut_highlight.visible = false
	else:
		var p0: Vector2 = root_inv * r.position
		tut_highlight.visible = str(TUT_STEPS[tut_current]["target"]) != "panel"
		tut_highlight.position = p0 - Vector2(4, 4);tut_highlight.size = r.size + Vector2(8, 8)
	if is_instance_valid(tut_bubble):
		tut_bubble.size = Vector2(508, 0)
		var bubble_h: float = tut_bubble.get_combined_minimum_size().y
		var center_y: float = (root_inv * r.get_center()).y if r.size != Vector2.ZERO else 0.0
		# Đặt khung hướng dẫn tránh vùng đang được chỉ.
		var y: float = 995.0 - bubble_h - 24.0 if (r.size != Vector2.ZERO and center_y < 520.0) else 70.0
		if str(TUT_STEPS[tut_current]["target"]) in ["scroll", "panel"]: y = 995.0 - bubble_h - 24.0
		tut_bubble.position = Vector2(16, y)

func _tut_finish(mark_done: bool = true) -> void:
	if not tut_current.is_empty() and mark_done: tut_done[tut_current] = true
	tut_current = ""
	if is_instance_valid(tut_bubble): tut_bubble.queue_free()
	if is_instance_valid(tut_highlight): tut_highlight.visible = false
	if tut_paused_game:
		tut_paused_game = false
		if running: paused = false;_set_pause_glyph(false)
	_save_game()

func _tut_ok() -> void:
	var step: = tut_current
	_tut_finish()
	if step == "t_endday": call_deferred("_tut_check_refining")

func _tut_skip_all() -> void:
	tut_done["skip_all"] = true
	for k in TUT_STEPS.keys(): tut_done[k] = true
	_tut_finish()
	_show_toast("Đã tắt hướng dẫn.")


# ---------- Âm thanh hiệu ứng (assets/audio/sfx/*.wav, tổng hợp theo âm giai ngũ cung) ----------
const SFX_NAMES: Array[String] = ["click", "tab", "coin", "sell", "deliver", "wrong", "door", "vip", "leave", "levelup", "refine", "unlock", "pop", "endday", "newday"]
const SFX_VOLUME_DB: Dictionary = {"click": -10.0, "tab": -8.0, "door": -6.0, "endday": -4.0}
var sfx_streams: Dictionary = {}
var sfx_players: Array[AudioStreamPlayer] = []
var sfx_muted: bool = false

func _setup_sfx() -> void:
	for n in SFX_NAMES:
		var path: String = "res://assets/audio/sfx/%s.wav" % n
		if ResourceLoader.exists(path): sfx_streams[n] = load(path)
	for i in range(8):
		var pl: = AudioStreamPlayer.new();pl.process_mode = Node.PROCESS_MODE_ALWAYS;pl.bus = "SFX";add_child(pl);sfx_players.append(pl)
	# Mọi nút bấm đều có tiếng "tách" nhẹ.
	get_tree().node_added.connect(_sfx_hook_button)

func _sfx_hook_button(node: Node) -> void:
	if node is BaseButton and not node.has_meta("sfx_hooked"):
		node.set_meta("sfx_hooked", true)
		node.pressed.connect(_sfx.bind("click"))

func _sfx(name: String) -> void:
	if sfx_muted or DisplayServer.get_name() == "headless" or not sfx_streams.has(name): return
	var player: AudioStreamPlayer = null
	for pl in sfx_players:
		if not pl.playing: player = pl;break
	if player == null: player = sfx_players[0];player.stop()
	player.stream = sfx_streams[name]
	player.volume_db = float(SFX_VOLUME_DB.get(name, -3.0))
	player.pitch_scale = randf_range(0.97, 1.03) if name in ["click", "coin", "deliver"] else 1.0
	player.play()


# ---------- Lưu trữ: sao lưu bằng mã 7 ký tự, khôi phục, chơi lại từ đầu ----------
# Bản web gọi window.tmlvBackup (định nghĩa trong index.html): trên claude.ai lưu vào db của artifact,
# chạy bằng start_server.py thì lưu vào thư mục backups/ của server.
var archive_overlay: ColorRect
var archive_status: Label
var archive_code_label: Label
var archive_code_field: LineEdit
var _archive_js_callbacks: Array = []
var _archive_busy: bool = false
var _archive_resetting: bool = false

func _open_archive_panel(restore_only: bool = false) -> void:
	if is_instance_valid(archive_overlay): archive_overlay.queue_free()
	archive_overlay = ColorRect.new();archive_overlay.color = Color(0.08, 0.22, 0.34, 0.6);archive_overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT);archive_overlay.z_index = 450;archive_overlay.mouse_filter = Control.MOUSE_FILTER_STOP;add_child(archive_overlay)
	var panel: = PanelContainer.new();panel.position = Vector2(24, 150 if not restore_only else 300);panel.size = Vector2(492, 0);panel.custom_minimum_size = Vector2(492, 0)
	var st: = _box(Color("f7fbff"), Color("8bc5e8"), 4, 22);st.content_margin_left = 18;st.content_margin_right = 18;st.content_margin_top = 16;st.content_margin_bottom = 16
	panel.add_theme_stylebox_override("panel", st);archive_overlay.add_child(panel)
	var box: = VBoxContainer.new();box.add_theme_constant_override("separation", 8);panel.add_child(box)
	var title: = _label("KHÔI PHỤC TIẾN TRÌNH" if restore_only else "LƯU TRỮ TIÊN MÔN", 20, Color("285b7a"));title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;box.add_child(title)
	if not restore_only:
		box.add_child(_archive_section_title("SAO LƯU"))
		box.add_child(_archive_note("Tạo mã 7 ký tự để chơi tiếp trên máy hoặc trình duyệt khác. Mỗi lần tạo là một mã mới, lưu tiến trình tại thời điểm đó."))
		var make: = _button("TẠO MÃ SAO LƯU", 12);make.custom_minimum_size = Vector2(0, 40);make.pressed.connect(_archive_create);box.add_child(make)
		archive_code_label = _label("", 30, Color("c9558b"));archive_code_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;archive_code_label.visible = false;box.add_child(archive_code_label)
	box.add_child(_archive_section_title("KHÔI PHỤC BẰNG MÃ"))
	box.add_child(_archive_note("Nhập mã 7 ký tự. Tiến trình hiện tại trên máy này sẽ được thay bằng tiến trình trong mã."))
	var row: = HBoxContainer.new();row.add_theme_constant_override("separation", 8);box.add_child(row)
	archive_code_field = LineEdit.new();archive_code_field.max_length = 7;archive_code_field.placeholder_text = "VD: K7M2QX9";archive_code_field.alignment = HORIZONTAL_ALIGNMENT_CENTER;archive_code_field.custom_minimum_size = Vector2(0, 40);archive_code_field.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	archive_code_field.add_theme_font_override("font", UI_FONT_REGULAR);archive_code_field.add_theme_font_size_override("font_size", 18);archive_code_field.add_theme_color_override("font_color", Color("285b7a"))
	archive_code_field.add_theme_stylebox_override("normal", _manual_input_style());archive_code_field.add_theme_stylebox_override("focus", _manual_input_style())
	archive_code_field.text_changed.connect(_archive_upper)
	_mobile_input(archive_code_field, false, false, "Mã sao lưu (7 ký tự)")
	row.add_child(archive_code_field)
	var restore: = _button("KHÔI PHỤC", 11);restore.autowrap_mode = TextServer.AUTOWRAP_OFF;restore.custom_minimum_size = Vector2(110, 40);restore.pressed.connect(_archive_restore);row.add_child(restore)
	archive_status = _label("", 11, Color("6a8ca0"));archive_status.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;archive_status.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;archive_status.size_flags_horizontal = Control.SIZE_EXPAND_FILL;box.add_child(archive_status)
	if not restore_only:
		box.add_child(_archive_section_title("CHƠI LẠI TỪ ĐẦU"))
		var reset: = _button("XÓA TIẾN TRÌNH VÀ CHƠI LẠI", 11);reset.custom_minimum_size = Vector2(0, 38)
		reset.add_theme_stylebox_override("normal", _box(Color("fde6ef"), Color("e8a3c3"), 2, 14));reset.add_theme_color_override("font_color", Color("c9558b"))
		reset.pressed.connect(_archive_confirm_reset);box.add_child(reset)
	var close: = _button("ĐÓNG", 12);close.custom_minimum_size = Vector2(0, 40);close.pressed.connect(func(): if is_instance_valid(archive_overlay): archive_overlay.queue_free());box.add_child(close)
	_sfx("pop")

func _archive_upper(t: String) -> void:
	var up: String = t.to_upper()
	if up != t:
		var caret: int = archive_code_field.caret_column
		archive_code_field.text = up
		archive_code_field.caret_column = caret

func _archive_section_title(text: String) -> Label:
	var l: = _label(text, 12, Color("d979a6"));return l

func _archive_note(text: String) -> Label:
	var l: = _label(text, 10, Color("4e6d80"));l.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;l.size_flags_horizontal = Control.SIZE_EXPAND_FILL;return l

func _archive_set_status(text: String, is_error: bool = false) -> void:
	if is_instance_valid(archive_status):
		archive_status.text = text
		archive_status.add_theme_color_override("font_color", Color("c74f69") if is_error else Color("378d69"))

func _archive_api() -> JavaScriptObject:
	if not OS.has_feature("web"): return null
	return JavaScriptBridge.get_interface("tmlvBackup")

func _archive_payload() -> String:
	_last_save_text = ""
	_save_game()
	var save_text: String = FileAccess.get_file_as_string(GAME_SAVE_PATH) if FileAccess.file_exists(GAME_SAVE_PATH) else ""
	var unlock_text: String = FileAccess.get_file_as_string(PRODUCT_UNLOCK_SAVE_PATH) if FileAccess.file_exists(PRODUCT_UNLOCK_SAVE_PATH) else ""
	if save_text.is_empty(): return ""
	return JSON.stringify({"v": 1, "game": "tien-mon-linh-van", "save": save_text, "unlocks": unlock_text})

func _archive_create() -> void:
	if _archive_busy: return
	var api: = _archive_api()
	if api == null:
		_archive_set_status("Sao lưu bằng mã chỉ có trên bản web.", true);return
	var payload: String = _archive_payload()
	if payload.is_empty():
		_archive_set_status("Chưa có tiến trình để sao lưu. Hãy đặt tên tiên môn trước.", true);return
	_archive_busy = true
	_archive_set_status("Đang tạo mã...")
	var ok: = JavaScriptBridge.create_callback(_on_archive_created)
	var fail: = JavaScriptBridge.create_callback(_on_archive_failed)
	_archive_js_callbacks = [ok, fail]
	api.saveCb(payload, ok, fail)

func _on_archive_created(args: Array) -> void:
	_archive_busy = false
	var code: String = str(args[0]) if args.size() > 0 else ""
	_sfx("unlock")
	if is_instance_valid(archive_code_label):
		archive_code_label.text = code;archive_code_label.visible = true
	_archive_set_status("Mã sao lưu của bạn là %s. Hãy chép lại mã này, nhập ở máy khác để chơi tiếp." % code)
	_show_toast("Đã tạo mã sao lưu %s." % code)

func _on_archive_failed(args: Array) -> void:
	_archive_busy = false
	_sfx("wrong")
	_archive_set_status(str(args[0]) if args.size() > 0 else "Không thực hiện được, thử lại sau.", true)

func _archive_restore() -> void:
	if _archive_busy or not is_instance_valid(archive_code_field): return
	var code: String = archive_code_field.text.strip_edges().to_upper()
	if code.length() != 7:
		_archive_set_status("Mã sao lưu gồm đúng 7 ký tự chữ và số.", true);return
	var api: = _archive_api()
	if api == null:
		_archive_set_status("Khôi phục bằng mã chỉ có trên bản web.", true);return
	_archive_busy = true
	_archive_set_status("Đang tìm mã %s..." % code)
	var ok: = JavaScriptBridge.create_callback(_on_archive_loaded)
	var fail: = JavaScriptBridge.create_callback(_on_archive_failed)
	_archive_js_callbacks = [ok, fail]
	api.loadCb(code, ok, fail)

func _on_archive_loaded(args: Array) -> void:
	_archive_busy = false
	var parsed: Variant = JSON.parse_string(str(args[0]) if args.size() > 0 else "")
	if not parsed is Dictionary or str(parsed.get("game", "")) != "tien-mon-linh-van" or str(parsed.get("save", "")).is_empty():
		_on_archive_failed(["Mã này không chứa tiến trình Tiên Môn Linh Vận hợp lệ."]);return
	var f: = FileAccess.open(GAME_SAVE_PATH, FileAccess.WRITE)
	if f == null:
		_on_archive_failed(["Không ghi được tiến trình trên máy này."]);return
	_archive_resetting = true
	f.store_string(str(parsed["save"]));f.close()
	var unlocks: String = str(parsed.get("unlocks", ""))
	if unlocks.is_empty():
		if FileAccess.file_exists(PRODUCT_UNLOCK_SAVE_PATH): DirAccess.remove_absolute(PRODUCT_UNLOCK_SAVE_PATH)
	else:
		var u: = FileAccess.open(PRODUCT_UNLOCK_SAVE_PATH, FileAccess.WRITE)
		if u != null: u.store_string(unlocks);u.close()
	_archive_set_status("Đã khôi phục! Đang mở lại tiên môn...")
	_sfx("levelup")
	get_tree().create_timer(0.8).timeout.connect(func(): get_tree().reload_current_scene())

func _archive_confirm_reset() -> void:
	var dim: = ColorRect.new();dim.color = Color(0.08, 0.22, 0.34, 0.55);dim.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT);dim.z_index = 460;dim.mouse_filter = Control.MOUSE_FILTER_STOP;add_child(dim)
	var panel: = PanelContainer.new();panel.position = Vector2(40, 360);panel.size = Vector2(460, 0);panel.custom_minimum_size = Vector2(460, 0)
	var st: = _box(Color("fff7fa"), Color("e8a3c3"), 4, 20);st.content_margin_left = 20;st.content_margin_right = 20;st.content_margin_top = 16;st.content_margin_bottom = 16
	panel.add_theme_stylebox_override("panel", st);dim.add_child(panel)
	var box: = VBoxContainer.new();box.add_theme_constant_override("separation", 10);panel.add_child(box)
	var t: = _label("CHƠI LẠI TỪ ĐẦU?", 20, Color("c9558b"));t.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;box.add_child(t)
	var b: = _label("Toàn bộ tiến trình trên máy này (linh thạch, cấp, hàng, nguyên liệu, món đã mở khóa) sẽ bị xóa. Nếu muốn giữ lại, hãy tạo mã sao lưu trước.", 12, Color("36556b"));b.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;b.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;b.size_flags_horizontal = Control.SIZE_EXPAND_FILL;box.add_child(b)
	var row: = HBoxContainer.new();row.add_theme_constant_override("separation", 10);box.add_child(row)
	var cancel: = _button("HỦY", 12);cancel.custom_minimum_size = Vector2(0, 42);cancel.size_flags_horizontal = Control.SIZE_EXPAND_FILL;cancel.pressed.connect(dim.queue_free);row.add_child(cancel)
	var yes: = _button("XÓA VÀ CHƠI LẠI", 12);yes.custom_minimum_size = Vector2(0, 42);yes.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	yes.add_theme_stylebox_override("normal", _box(Color("ec9fc0"), Color("d979a6"), 2, 14));yes.add_theme_color_override("font_color", Color("ffffff"))
	yes.pressed.connect(_archive_reset);row.add_child(yes)

func _archive_reset() -> void:
	_archive_resetting = true
	for path in [GAME_SAVE_PATH, PRODUCT_UNLOCK_SAVE_PATH]:
		if FileAccess.file_exists(path): DirAccess.remove_absolute(path)
	_last_save_text = ""
	running = false
	get_tree().reload_current_scene()


# ---------- Tin tức thành trì: dự báo món bán chạy ngày mai (đúng khoảng 70–85%) ----------
const FORECAST_EVENTS: Dictionary = {
	"đan dược": ["Ngày mai %s mở đại hội tỷ võ, đệ tử bị thương cần nhiều %s.", "Dịch phong hàn lan khắp thành, thầy thuốc đổ xô tìm %s.", "Bí cảnh phía bắc sắp mở, tu sĩ tích trữ %s trước khi vào."],
	"pháp khí": ["Ngày mai %s tuyển đệ tử, người dự thi cần pháp khí như %s.", "Đoàn hộ tống thương đội sắp xuất phát, võ sư săn lùng %s.", "Yêu thú tràn xuống chân núi, tán tu cần %s để phòng thân."],
	"phù triện": ["Đêm mai trăng máu, dân thành mua %s trừ tà.", "%s tổ chức lễ tế tổ, cần nhiều %s.", "Lôi kiếp sắp giáng ở núi Tây, tu sĩ độ kiếp gom %s."],
	"trận đồ": ["%s chuẩn bị dựng hộ sơn đại trận, cần %s.", "Thành chủ ra lệnh gia cố tường thành, thợ trận săn %s.", "Tin đồn ma tu tập kích, các gia tộc tìm mua %s."],
	"phi xa/sí": ["Hội đua phi hành của %s diễn ra ngày mai, ai cũng muốn có %s.", "Đường núi sạt lở, thương nhân cần %s để vượt núi.", "Tiên hội ở đảo Bồng Lai sắp mở, khách xa tìm %s."],
	"linh thú": ["%s mở hội chọi linh thú, giới nuôi thú tìm %s.", "Tiểu thư nhà thành chủ sắp sinh nhật, quý tộc săn %s làm quà.", "Mùa linh thú nhận chủ đến, tán tu tìm %s."],
}
const FORECAST_SECTS: Array[String] = ["Thanh Vân Tông", "Huyết Sát Môn", "Lạc Hà Cốc", "Thiên Kiếm Các", "Vạn Pháp Tự", "Bích Thủy Cung"]
const FORECAST_BOOST_SHARE: = 0.75
var forecast_next: Dictionary = {}
var today_boost: Dictionary = {}

func _make_forecast() -> void:
	if not forecast_next.is_empty() and int(forecast_next.get("day", 0)) == day_number + 1: return
	var pool: Array[int] = []
	for i in range(products.size()):
		if _is_product_available(i): pool.append(i)
	if pool.is_empty(): forecast_next = {};return
	var pid: int = pool.pick_random()
	var cat: String = str(products[pid].get("category", "")).to_lower()
	var lines: Array = FORECAST_EVENTS.get(cat, FORECAST_EVENTS["đan dược"])
	var line: String = str(lines.pick_random())
	var text: String = line % [FORECAST_SECTS.pick_random(), products[pid]["name"]] if line.count("%s") == 2 else line % products[pid]["name"]
	var accuracy: float = randf_range(0.90, 0.95) if _has("fortune") else (randf_range(0.70, 0.85) + (0.10 if _tr("jade") else 0.0))
	var real: = randf() < accuracy
	if _has("fortune") and randf() < 0.1: real = false
	forecast_next = {"day": day_number + 1, "product": pid, "text": text, "real": real, "accuracy": int(round(accuracy * 100.0))}

func _apply_forecast_for_new_day() -> void:
	if not forecast_next.is_empty() and int(forecast_next.get("day", 0)) == day_number + 1:
		today_boost = forecast_next.duplicate(true)
	else:
		today_boost = {}
	forecast_next = {}
	if not today_boost.is_empty():
		call_deferred("_show_toast", "Hôm nay theo tin đồn: %s sẽ bán chạy." % products[int(today_boost["product"])]["name"])

func _forecast_headline(f: Dictionary) -> String:
	return "%s Dự kiến %s bán chạy (độ tin cậy khoảng %d%%)." % [str(f.get("text", "")), products[int(f["product"])]["name"], int(f.get("accuracy", 75))]

func _forecast_result_today() -> Dictionary:
	if today_boost.is_empty() or int(today_boost.get("day", 0)) != day_number: return {}
	var pid: int = int(today_boost["product"])
	return {"product": pid, "real": bool(today_boost.get("real", false)), "sold": int(sold_today.get(str(pid), 0))}

func _add_forecast_line(f: Dictionary) -> void:
	if f.is_empty() or not f.has("product"): return
	var name: String = str(products[int(f["product"])]["name"])
	var verdict: String = "tin ĐÚNG, khách đổ xô mua" if bool(f.get("real", false)) else "tin SAI, sức mua bình thường"
	close_content.add_child(_label("  Tin đồn: %s bán chạy · %s · đã bán %d" % [name, verdict, int(f.get("sold", 0))], 11, Color("8a6bb0")))

func _show_forecast_popup() -> void:
	if forecast_next.is_empty() or int(forecast_next.get("day", 0)) != day_number + 1:
		if not _city_notes().is_empty(): _show_market_popup("TIN TỨC THÀNH TRÌ", _city_notes().strip_edges())
		return
	_show_market_popup("TIN TỨC THÀNH TRÌ", "%s\n\nDự kiến ngày mai %s sẽ bán chạy. Tin đồn đúng khoảng %d%%, hãy cân nhắc thâu mua và bày kệ.%s" % [str(forecast_next["text"]), products[int(forecast_next["product"])]["name"], int(forecast_next.get("accuracy", 75)), _city_notes()])


# ---------- Màu ô giá bán: đỏ = chạm/vượt giá trần, xanh = thấp hơn giá thâu (lỗ) ----------
const PRICE_COLOR_NORMAL: = Color("4e85a6")
const PRICE_COLOR_OVER: = Color("d64545")
const PRICE_COLOR_LOSS: = Color("2e9b5a")

func _price_color(index: int, value: int) -> Color:
	if index < 0 or index >= products.size(): return PRICE_COLOR_NORMAL
	var threshold: int = int(products[index].get("overprice_threshold", 0))
	if threshold > 0 and value >= threshold: return PRICE_COLOR_OVER
	if value < int(products[index].get("cost", 0)): return PRICE_COLOR_LOSS
	return PRICE_COLOR_NORMAL

func _recolor_price_field(text: String, index: int, field: LineEdit) -> void:
	if not is_instance_valid(field): return
	var raw: String = text.strip_edges()
	if not raw.is_valid_int(): return
	field.add_theme_color_override("font_color", _price_color(index, int(raw)))


# ---------- Tam giác đỏ: số món sẽ tiêu tán nếu hôm nay không bán hết ----------
func _expiring_count(container: Dictionary, product_id: int) -> int:
	if product_id < 0 or product_id >= products.size(): return 0
	var product: Dictionary = products[product_id]
	if bool(product.get("permanent_stock", false)): return 0
	var outdated_days: int = maxi(1, int(product.get("outdated_days", DEFAULT_OUTDATED_DAYS)))
	if _has("beastkeeper") and _cat(product_id) == "linh thú": outdated_days += 1
	if _up("beast_yard") >= 2 and _cat(product_id) == "linh thú": outdated_days += 2
	var n: int = 0
	for age in _normalize_stock_ages(container.get("stock_ages", []), int(container.get("stock", 0))):
		if int(age) >= outdated_days: n += 1
	return n

func _expire_badge(count: int, store_style: bool) -> PanelContainer:
	# Vòng tròn cùng kiểu vòng số lượng phía trên, số màu đỏ = số món sẽ tiêu tán nếu hôm nay không bán hết.
	var d: float = 30.0 if store_style else 28.0
	var badge: = PanelContainer.new();badge.custom_minimum_size = Vector2(d, d);badge.size = Vector2(d, d);badge.mouse_filter = Control.MOUSE_FILTER_IGNORE
	badge.tooltip_text = "Số món sẽ tiêu tán nếu hôm nay không bán hết"
	var frame: = _box(Color("fffaf0"), Color("1a1a1a"), 2, int(d / 2.0));frame.content_margin_left = 0;frame.content_margin_right = 0;frame.content_margin_top = 0;frame.content_margin_bottom = 0
	badge.add_theme_stylebox_override("panel", frame)
	var lbl: = _label(str(count), 9, Color("d63c3c"));lbl.name = "Count";lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;lbl.vertical_alignment = VERTICAL_ALIGNMENT_CENTER;lbl.mouse_filter = Control.MOUSE_FILTER_IGNORE;badge.add_child(lbl)
	return badge

# ---------- Cửa sổ lên level: liệt kê vật phẩm vừa mở ----------
func _rarity_accent(p: Dictionary) -> Color:
	# Cùng màu với khung/dòng phân loại ở Thâu mua
	var rarity: = str(p.get("rarity", "Luxury")).to_lower()
	if rarity == "rare": return Color("4f9ed0")
	if rarity == "iconic": return Color("d979a6")
	return Color("7eb9d8")

func _show_level_unlocks(from_level: int, to_level: int) -> void:
	var lines: PackedStringArray = []
	var line_colors: Array = []
	for i in range(products.size()):
		var lv: int = int(products[i].get("unlock_level", 1))
		if lv > from_level and lv <= to_level:
			var grade: String = _product_refining_grade(products[i])
			lines.append("%s · %s" % [str(products[i]["name"]), grade])
			line_colors.append(_rarity_accent(products[i]))
	var body: String = "Tiên môn đã lên LEVEL %d." % to_level
	if lines.is_empty():
		body += "\nChưa có vật phẩm mới ở cấp này."
	else:
		body += "\nBạn đã được mở khóa vật phẩm:"
	var was_running_unpaused: bool = running and not paused
	if was_running_unpaused:
		paused = true;_set_pause_glyph(true)
	_show_market_popup("LÊN LEVEL %d" % to_level, body, lines, line_colors)
	if was_running_unpaused and is_instance_valid(market_popup):
		market_popup.tree_exited.connect(_resume_after_level_popup)

func _resume_after_level_popup() -> void:
	if running:
		paused = false
		_set_pause_glyph(false)

func _on_pause_menu_reset_pressed() -> void:
	pause_menu_panel.visible = false
	if running and not paused:
		paused = true;_set_pause_glyph(true)
	manual_pause = true
	_archive_confirm_reset()


# Chú thích luôn hiện ở Linh Các.
func _shelf_legend() -> PanelContainer:
	var panel: = PanelContainer.new()
	var st: = _box(Color("fffaf0"), Color("e6d3a3"), 1, 12);st.content_margin_left = 10;st.content_margin_right = 10;st.content_margin_top = 6;st.content_margin_bottom = 6
	panel.add_theme_stylebox_override("panel", st)
	var col: = VBoxContainer.new();col.add_theme_constant_override("separation", 3);panel.add_child(col)
	col.add_child(_legend_row(_legend_dot(Color("8bc5e8"), Color("285b7a"), "9"), "Số món đang bày trên kệ"))
	col.add_child(_legend_row(_legend_dot(Color("1a1a1a"), Color("d63c3c"), "4"), "Số món sẽ tiêu tán nếu hôm nay không bán hết"))
	col.add_child(_legend_row(_legend_price(PRICE_COLOR_OVER), "Giá đỏ: chạm hoặc vượt giá trần, khách ngại vào"))
	col.add_child(_legend_row(_legend_price(PRICE_COLOR_LOSS), "Giá xanh: thấp hơn giá thâu, bán bị lỗ"))
	return panel

func _legend_row(icon: Control, text: String) -> HBoxContainer:
	var row: = HBoxContainer.new();row.add_theme_constant_override("separation", 8)
	icon.size_flags_vertical = Control.SIZE_SHRINK_CENTER;row.add_child(icon)
	var l: = _label(text, 9, Color("36556b"));l.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;l.size_flags_horizontal = Control.SIZE_EXPAND_FILL;row.add_child(l)
	return row

func _legend_dot(border: Color, text_color: Color, text: String) -> PanelContainer:
	var b: = PanelContainer.new();b.custom_minimum_size = Vector2(22, 22)
	var f: = _box(Color("fffaf0"), border, 2, 11);f.content_margin_left = 0;f.content_margin_right = 0;f.content_margin_top = 0;f.content_margin_bottom = 0;b.add_theme_stylebox_override("panel", f)
	var l: = _label(text, 8, text_color);l.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;l.vertical_alignment = VERTICAL_ALIGNMENT_CENTER;b.add_child(l)
	return b

func _legend_price(color: Color) -> PanelContainer:
	var b: = PanelContainer.new();b.custom_minimum_size = Vector2(34, 20)
	var f: = _box(Color("f7fbff"), Color("a6d8ee"), 1, 8);f.content_margin_left = 0;f.content_margin_right = 0;f.content_margin_top = 0;f.content_margin_bottom = 0;b.add_theme_stylebox_override("panel", f)
	var l: = _label("15", 9, color);l.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;l.vertical_alignment = VERTICAL_ALIGNMENT_CENTER;b.add_child(l)
	return b


# ---------- Bàn phím ảo nằm trong màn hình game ----------
var _mobile_game_keyboard: Node = null

func _is_mobile_web() -> bool:
	if not OS.has_feature("web"): return false
	if OS.has_feature("web_android") or OS.has_feature("web_ios"): return true
	return bool(JavaScriptBridge.eval("('ontouchstart' in window) || navigator.maxTouchPoints > 0", true))

func _mobile_input(field: LineEdit, numeric: bool, submit: bool, title: String) -> void:
	if not _is_mobile_web(): return
	# Tắt bàn phím hệ điều hành; game tự vẽ bàn phím phủ trong viewport, không resize canvas.
	field.virtual_keyboard_enabled = false
	if _mobile_game_keyboard == null:
		_mobile_game_keyboard = IN_GAME_KEYBOARD_SCRIPT.new()
		add_child(_mobile_game_keyboard)
		# Ô IME ẩn của Godot vẫn nhận focus khi chạm ô nhập: đặt inputmode="none" để điện thoại không bật bàn phím hệ thống.
		JavaScriptBridge.eval("(function(){function f(){document.querySelectorAll('.ime').forEach(function(e){e.setAttribute('inputmode','none');});}f();new MutationObserver(f).observe(document.body,{childList:true,subtree:true});})();", true)
	field.focus_entered.connect(_open_in_game_keyboard.bind(field, numeric, submit, title))
	field.focus_exited.connect(_close_in_game_keyboard.bind(field))

func _open_in_game_keyboard(field: LineEdit, numeric: bool, submit: bool, title: String) -> void:
	if is_instance_valid(_mobile_game_keyboard):
		_mobile_game_keyboard.call("open", field, numeric, submit, title)

func _close_in_game_keyboard(field: LineEdit) -> void:
	if is_instance_valid(_mobile_game_keyboard):
		_mobile_game_keyboard.call("dismiss_for_focus_exit", field)

# ---------- Cài đặt: âm lượng nhạc nền, hiệu ứng âm thanh, cỡ chữ ----------
const SETTINGS_PATH: = "user://tmlv_settings.json"
const FONT_SCALES: = [0.82, 0.88, 0.94, 1.0, 1.08, 1.16, 1.24]
const FONT_SCALE_NAMES: = ["Nhỏ 3", "Nhỏ 2", "Nhỏ 1", "Mặc định", "Lớn 1", "Lớn 2", "Lớn 3"]
const BGM_PATH: = "res://assets/audio/music/bgm.ogg"
var settings: Dictionary = {"music": 0.5, "sfx": 0.8, "font": 3}
var music_player: AudioStreamPlayer
var settings_overlay: ColorRect
var _settings_font_label: Label
var _theme_base_font_size: = -1

func _load_settings() -> void:
	if FileAccess.file_exists(SETTINGS_PATH):
		var d: Variant = JSON.parse_string(FileAccess.get_file_as_string(SETTINGS_PATH))
		if d is Dictionary:
			settings["music"] = clampf(float(d.get("music", 0.5)), 0.0, 1.0)
			settings["sfx"] = clampf(float(d.get("sfx", 0.8)), 0.0, 1.0)
			settings["font"] = clampi(int(d.get("font", 3)), 0, FONT_SCALES.size() - 1)
	_apply_volumes()
	_apply_theme_font_scale()

func _save_settings() -> void:
	var f: = FileAccess.open(SETTINGS_PATH, FileAccess.WRITE)
	if f: f.store_string(JSON.stringify(settings));f.close()

func _set_bus_volume(bus_name: String, v: float) -> void:
	var idx: = AudioServer.get_bus_index(bus_name)
	if idx < 0:
		AudioServer.add_bus();idx = AudioServer.bus_count - 1;AudioServer.set_bus_name(idx, bus_name)
	AudioServer.set_bus_mute(idx, v <= 0.001)
	AudioServer.set_bus_volume_db(idx, linear_to_db(maxf(v, 0.001)))

func _apply_volumes() -> void:
	_set_bus_volume("Music", float(settings["music"]))
	_set_bus_volume("SFX", float(settings["sfx"]))

func _setup_music() -> void:
	if not ResourceLoader.exists(BGM_PATH): return
	var stream: = load(BGM_PATH)
	if stream is AudioStreamOggVorbis: stream.loop = true
	music_player = AudioStreamPlayer.new();music_player.stream = stream;music_player.bus = "Music";music_player.process_mode = Node.PROCESS_MODE_ALWAYS;music_player.volume_db = -4.0
	add_child(music_player);music_player.play()

func _font_scale() -> float:
	return float(FONT_SCALES[int(settings["font"])])

func _apply_theme_font_scale() -> void:
	var ft: = get_node_or_null("/root/ManusFontTheme")
	if ft == null: return
	var th: Theme = ft.get("_theme")
	if th == null: return
	if _theme_base_font_size < 0: _theme_base_font_size = th.default_font_size if th.default_font_size > 0 else 16
	th.default_font_size = maxi(6, roundi(_theme_base_font_size * _font_scale()))

func _font_scale_node(node: Node) -> void:
	if not (node is Control): return
	var c: Control = node
	if not c.has_theme_font_size_override("font_size") or c.has_meta("no_font_scale"): return
	var base: int
	if c.has_meta("fs_base"):
		base = int(c.get_meta("fs_base"))
	else:
		base = c.get_theme_font_size("font_size");c.set_meta("fs_base", base)
	var target: = maxi(6, roundi(base * _font_scale()))
	if c.get_theme_font_size("font_size") != target: c.add_theme_font_size_override("font_size", target)

func _font_scale_tree(node: Node) -> void:
	_font_scale_node(node)
	for ch in node.get_children(): _font_scale_tree(ch)

func _open_settings_panel() -> void:
	if is_instance_valid(settings_overlay): settings_overlay.queue_free()
	settings_overlay = ColorRect.new();settings_overlay.color = Color(0.08, 0.22, 0.34, 0.6);settings_overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT);settings_overlay.z_index = 460;settings_overlay.mouse_filter = Control.MOUSE_FILTER_STOP;add_child(settings_overlay)
	var panel: = PanelContainer.new();panel.position = Vector2(40, 230);panel.size = Vector2(460, 0);panel.custom_minimum_size = Vector2(460, 0)
	var st: = _box(Color("f7fbff"), Color("8bc5e8"), 4, 22);st.content_margin_left = 20;st.content_margin_right = 20;st.content_margin_top = 16;st.content_margin_bottom = 16
	panel.add_theme_stylebox_override("panel", st);settings_overlay.add_child(panel)
	var box: = VBoxContainer.new();box.add_theme_constant_override("separation", 10);panel.add_child(box)
	var title: = _label("CÀI ĐẶT", 20, Color("285b7a"));title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;box.add_child(title)
	box.add_child(_settings_slider_row("Nhạc nền", "music"))
	box.add_child(_settings_slider_row("Hiệu ứng âm thanh", "sfx"))
	var font_title: = _label("Cỡ chữ", 12, Color("285b7a"));box.add_child(font_title)
	var frow: = HBoxContainer.new();frow.add_theme_constant_override("separation", 10);box.add_child(frow)
	var minus: = _button("A−", 12);minus.custom_minimum_size = Vector2(70, 40);minus.pressed.connect(_change_font_step.bind(-1));frow.add_child(minus)
	_settings_font_label = _label(FONT_SCALE_NAMES[int(settings["font"])], 14, Color("c9558b"));_settings_font_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;_settings_font_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL;frow.add_child(_settings_font_label)
	var plus: = _button("A+", 12);plus.custom_minimum_size = Vector2(70, 40);plus.pressed.connect(_change_font_step.bind(1));frow.add_child(plus)
	var close: = _button("ĐÓNG", 12);close.custom_minimum_size = Vector2(0, 42);close.pressed.connect(_close_settings_panel);box.add_child(close)

func _settings_slider_row(text: String, key: String) -> VBoxContainer:
	var v: = VBoxContainer.new();v.add_theme_constant_override("separation", 2)
	var head: = HBoxContainer.new();v.add_child(head)
	var name_l: = _label(text, 12, Color("285b7a"));name_l.size_flags_horizontal = Control.SIZE_EXPAND_FILL;head.add_child(name_l)
	var pct: = _label("%d%%" % roundi(float(settings[key]) * 100), 12, Color("c9558b"));head.add_child(pct)
	var sl: = HSlider.new();sl.min_value = 0;sl.max_value = 100;sl.step = 5;sl.value = roundi(float(settings[key]) * 100);sl.custom_minimum_size = Vector2(0, 30)
	var track: = _box(Color("dff1fb"), Color("a6d8ee"), 1, 6);track.content_margin_top = 4;track.content_margin_bottom = 4
	var fill: = _box(Color("8bc5e8"), Color("8bc5e8"), 1, 6);fill.content_margin_top = 4;fill.content_margin_bottom = 4
	sl.add_theme_stylebox_override("slider", track);sl.add_theme_stylebox_override("grabber_area", fill);sl.add_theme_stylebox_override("grabber_area_highlight", fill)
	sl.value_changed.connect(_on_volume_slider.bind(key, pct))
	v.add_child(sl)
	return v

func _on_volume_slider(value: float, key: String, pct: Label) -> void:
	settings[key] = value / 100.0
	if is_instance_valid(pct): pct.text = "%d%%" % roundi(value)
	_apply_volumes()
	if key == "sfx": _sfx("click")

func _change_font_step(delta: int) -> void:
	var nv: = clampi(int(settings["font"]) + delta, 0, FONT_SCALES.size() - 1)
	if nv == int(settings["font"]): return
	settings["font"] = nv
	_apply_theme_font_scale()
	_font_scale_tree(get_tree().root)
	if is_instance_valid(_settings_font_label): _settings_font_label.text = FONT_SCALE_NAMES[nv]
	_save_settings()

func _close_settings_panel() -> void:
	_save_settings()
	if is_instance_valid(settings_overlay): settings_overlay.queue_free()

func _gear_button() -> Button:
	var b: = _button("", 9);b.custom_minimum_size = Vector2(32, 30);b.tooltip_text = "Cài đặt: âm lượng, cỡ chữ"
	b.icon = load("res://assets/boutique/ui_icons/gear.png");b.expand_icon = true;b.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
	b.add_theme_constant_override("icon_max_width", 18)
	return b


# ---------- Lời / lỗ trong ngày và bảng tổng kết cuối ca ----------
func _record_costs(expenses: Array) -> int:
	# Chi phí thật đã trả bằng linh thạch. "Bán nhầm" không tính vì giá thâu món đó đã nằm trong khoản thâu mua.
	var total: = 0
	for e in expenses:
		if str(e.get("label", "")).begins_with("Bán nhầm") or str(e.get("label", "")).begins_with("Mất hàng"): continue
		total += int(e.get("amount", 0))
	return total

func _record_profit(record: Dictionary) -> int:
	return int(record.get("revenue", 0)) + int(record.get("store_tips", 0)) - _record_costs(record.get("expenses", []))

func _add_profit_line(record: Dictionary) -> void:
	if not record.has("revenue"): return
	var profit: = _record_profit(record)
	var good: = profit >= 0
	var head: = _label("  %s SAU CHI PHÍ · %s%s LT" % ["LỜI" if good else "LỖ", "+" if good else "−", _fmt_thousands(absi(profit))], 12, Color("2e9b5a") if good else Color("d64545"))
	close_content.add_child(head)
	var detail: = _label("  Doanh thu %s + tip cửa hàng %s − chi phí %s" % [_fmt_thousands(int(record.get("revenue", 0))), _fmt_thousands(int(record.get("store_tips", 0))), _fmt_thousands(_record_costs(record.get("expenses", [])))], 10, Color("6a8ca0"))
	detail.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	close_content.add_child(detail)

var day_summary_popup: ColorRect

func _show_day_summary_popup() -> void:
	if is_instance_valid(day_summary_popup): day_summary_popup.queue_free()
	var dim: = ColorRect.new();dim.color = Color(0.08, 0.22, 0.34, 0.5);dim.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT);dim.z_index = 310;dim.mouse_filter = Control.MOUSE_FILTER_STOP;add_child(dim)
	day_summary_popup = dim
	var panel: = PanelContainer.new();panel.position = Vector2(30, 110);panel.size = Vector2(480, 0);panel.custom_minimum_size = Vector2(480, 0)
	var style: = _box(Color("f7fbff"), Color("8bc5e8"), 4, 20);style.content_margin_left = 20;style.content_margin_right = 20;style.content_margin_top = 16;style.content_margin_bottom = 16
	panel.add_theme_stylebox_override("panel", style);dim.add_child(panel)
	var box: = VBoxContainer.new();box.add_theme_constant_override("separation", 8);panel.add_child(box)
	var title: = _label("TỔNG KẾT NGÀY %d" % day_number, 20, Color("285b7a"));title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;box.add_child(title)
	var scroll: = ScrollContainer.new();scroll.custom_minimum_size = Vector2(0, 120);scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED;box.add_child(scroll)
	var list: = VBoxContainer.new();list.size_flags_horizontal = Control.SIZE_EXPAND_FILL;list.add_theme_constant_override("separation", 4);scroll.add_child(list)
	var add: = func(text: String, size: int, color: Color) -> void:
		var l: = _label(text, size, color);l.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;l.size_flags_horizontal = Control.SIZE_EXPAND_FILL;list.add_child(l)
	# Sản phẩm đã bán
	add.call("SẢN PHẨM ĐÃ BÁN · %d đơn" % successful_orders, 13, Color("c9558b"))
	var rows: Array[Dictionary] = []
	for key in sold_today.keys():
		rows.append({"name": products[int(key)]["name"], "quantity": int(sold_today[key])})
	rows.sort_custom(Callable(self, "_sort_stat_product_rows"))
	if rows.is_empty(): add.call("Chưa bán được món nào.", 11, Color("6a8ca0"))
	var total_items: = 0
	for r in rows:
		total_items += int(r["quantity"])
		add.call("- %s × %d" % [r["name"], int(r["quantity"])], 12, Color("36556b"))
	if total_items > 0: add.call("Tổng %d món · doanh thu %s LT" % [total_items, _fmt_thousands(revenue_today)], 11, Color("4e85a6"))
	# Bán nhầm
	add.call("BÁN NHẦM", 13, Color("c9558b"))
	var wrong_order: Array = [];var wrong_count: Dictionary = {};var wrong_sum: Dictionary = {}
	for e in expenses_today:
		var label: String = str(e.get("label", ""))
		if not label.begins_with("Bán nhầm"): continue
		var name: String = label.substr(9).strip_edges()
		if not wrong_count.has(name): wrong_order.append(name);wrong_count[name] = 0;wrong_sum[name] = 0
		wrong_count[name] = int(wrong_count[name]) + 1;wrong_sum[name] = int(wrong_sum[name]) + int(e.get("amount", 0))
	if wrong_order.is_empty(): add.call("Không bán nhầm món nào.", 11, Color("2e9b5a"))
	if not wrong_order.is_empty():
		var wparts: PackedStringArray = [];var wtotal: = 0;var wtimes: = 0
		for n in wrong_order:
			wparts.append("%s ×%d" % [n, int(wrong_count[n])]);wtotal += int(wrong_sum[n]);wtimes += int(wrong_count[n])
		add.call("Bán nhầm %d lần (%s) · mất %s LT tiền hàng" % [wtimes, ", ".join(wparts), _fmt_thousands(wtotal)], 12, Color("d64545"))
	# Sự cố
	var incident_lines: Array = []
	for g in _group_expenses(expenses_today.filter(func(e): return str(e.get("label", "")).begins_with("Sự cố: ") or str(e.get("label", "")).begins_with("Mất hàng: "))):
		var lb: String = str(g["label"])
		incident_lines.append("- %s%s%s" % [lb.substr(lb.find(": ") + 2), g["note"], (" · −%s LT" % _fmt_thousands(int(g["amount"]))) if lb.begins_with("Sự cố") and int(g["amount"]) > 0 else ""])
	if not incident_lines.is_empty():
		add.call("SỰ CỐ", 13, Color("c9558b"))
		for il in incident_lines: add.call(il, 12, Color("b5562f"))
	if _has("accountant"):
		add.call("TRƯỚNG PHÒNG BÁO CÁO", 13, Color("c9558b"))
		for al in _accountant_lines(): add.call(str(al), 12, Color("36556b"))
	# Tips
	add.call("TIPS", 13, Color("c9558b"))
	add.call("Khách thưởng cửa hàng: +%s LT" % _fmt_thousands(store_tips), 12, Color("2e9b5a"))
	add.call("Tip trả nhân viên: %s LT" % _fmt_thousands(tips), 12, Color("36556b"))
	# Lời / lỗ
	var record: = {"revenue": revenue_today, "store_tips": store_tips, "expenses": expenses_today}
	var profit: = _record_profit(record)
	add.call("LỜI / LỖ SAU CHI PHÍ", 13, Color("c9558b"))
	add.call("%s%s LT" % ["+" if profit >= 0 else "−", _fmt_thousands(absi(profit))], 18, Color("2e9b5a") if profit >= 0 else Color("d64545"))
	add.call("Doanh thu %s + tip cửa hàng %s − chi phí %s (thâu mua, thuê mặt bằng, lương, tip nhân viên…)" % [_fmt_thousands(revenue_today), _fmt_thousands(store_tips), _fmt_thousands(_record_costs(expenses_today))], 10, Color("6a8ca0"))
	var ok: = _button("ĐÓNG", 13);ok.custom_minimum_size = Vector2(0, 44);ok.pressed.connect(_close_day_summary_popup);box.add_child(ok)
	_fit_summary_scroll.call_deferred(scroll, list)

func _fit_summary_scroll(scroll: ScrollContainer, list: Control) -> void:
	if is_instance_valid(scroll) and is_instance_valid(list):
		scroll.custom_minimum_size.y = minf(list.get_combined_minimum_size().y + 4, 560.0)

func _close_day_summary_popup() -> void:
	if is_instance_valid(day_summary_popup): day_summary_popup.queue_free()
	_show_forecast_popup()


# ---------- Sự cố ngoài ý muốn ----------
# Không xảy ra trong 3 ngày đầu. Mỗi ngày tối đa 1 sự cố đầu ngày + 1 sự cố trong ca; vài sự cố gắn với hành động (giao nhầm, chợ, thâu lô lớn, bán phi xa, tinh luyện).
const INCIDENT_FREE_DAYS: = 3
const INCIDENT_DAY_CHANCE: = 0.30
const INCIDENT_SHIFT_CHANCE: = 0.30
var incident_state: Dictionary = {"roof_damaged": false, "sign_lost": false, "ward_charm": false, "runaways": [], "rival": {}, "credit": [], "shift_event": "", "shift_event_at": 0.0, "close_early_at": 0.0}
var _incident_queue: Array = []
var _incident_popup: ColorRect
var _incident_paused_shift: bool = false
var _incident_layer: CanvasLayer

func _incidents_on() -> bool:
	return day_number > INCIDENT_FREE_DAYS

func _cat(product_id: int) -> String:
	return str(products[product_id].get("refining_category", products[product_id].get("category", ""))).to_lower()

func _lose_from_shelf(shelf: Dictionary, count: int) -> int:
	var lost: = 0
	for _i in range(count):
		if _consume_stock_unit(shelf): lost += 1
	if int(shelf.get("stock", 0)) <= 0: shelf["product"] = -1
	return lost

func _log_goods_loss(label: String, product_id: int, count: int) -> void:
	if count <= 0: return
	_log_expense("Mất hàng: %s %s x%d" % [label, products[product_id]["name"], count], int(products[product_id].get("cost", 0)) * count)

func _stock_changed() -> void:
	_update_money_display()
	if running and close_content == null: _show_store()
	_update_cards()
	_update_ui()

# Hàng đợi bảng sự cố: hiện lần lượt, tạm dừng ca trong lúc hiện.
func _incident_push(title: String, body: String, buttons: Array = []) -> void:
	_incident_queue.append({"title": title, "body": body, "buttons": buttons})
	if not is_instance_valid(_incident_popup): _incident_show_next()

func _incident_show_next() -> void:
	if _incident_queue.is_empty():
		if _incident_paused_shift and running:
			paused = false;_set_pause_glyph(false)
		_incident_paused_shift = false
		return
	var item: Dictionary = _incident_queue.pop_front()
	if running and not paused:
		paused = true;_set_pause_glyph(true);_incident_paused_shift = true
	_sfx("pop")
	if not is_instance_valid(_incident_layer):
		_incident_layer = CanvasLayer.new();_incident_layer.layer = 5;add_child(_incident_layer)
	var dim: = ColorRect.new();dim.color = Color(0.08, 0.22, 0.34, 0.5);dim.position = Vector2.ZERO;dim.size = Vector2(540, 1000);dim.mouse_filter = Control.MOUSE_FILTER_STOP;_incident_layer.add_child(dim)
	_incident_popup = dim
	var panel: = PanelContainer.new();panel.position = Vector2(36, 300);panel.size = Vector2(468, 0);panel.custom_minimum_size = Vector2(468, 0)
	var style: = _box(Color("fffaf3"), Color("e0a96d"), 4, 20);style.content_margin_left = 20;style.content_margin_right = 20;style.content_margin_top = 16;style.content_margin_bottom = 16
	panel.add_theme_stylebox_override("panel", style);dim.add_child(panel)
	var box: = VBoxContainer.new();box.add_theme_constant_override("separation", 12);panel.add_child(box)
	var title: = _label(str(item["title"]), 19, Color("b5562f"));title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;title.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;box.add_child(title)
	var body: = _label(str(item["body"]), 13, Color("36556b"));body.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;body.size_flags_horizontal = Control.SIZE_EXPAND_FILL;box.add_child(body)
	var buttons: Array = item["buttons"]
	if buttons.is_empty(): buttons = [["ĐÓNG", Callable()]]
	for b in buttons:
		var btn: = _button(str(b[0]), 12);btn.custom_minimum_size = Vector2(0, 44);btn.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		btn.pressed.connect(_incident_button.bind(b[1]));box.add_child(btn)
	panel.modulate.a = 0.0
	_center_incident_panel(panel)

func _incident_button(cb: Callable) -> void:
	if is_instance_valid(_incident_popup): _incident_popup.queue_free()
	_incident_popup = null
	if cb.is_valid(): cb.call()
	_stock_changed()
	_incident_show_next.call_deferred()

func _pay(amount: int, label: String) -> int:
	var paid: = clampi(amount, 0, maxi(0, money))
	if paid <= 0: return 0
	money -= paid
	_log_expense("Sự cố: %s" % label, paid)
	_update_money_display()
	return paid

# ---------- Đầu ngày ----------
func _incidents_new_day() -> void:
	incident_state["shift_event"] = "";incident_state["shift_event_at"] = 0.0;incident_state["close_early_at"] = 0.0
	incident_state["rival"] = {}
	# Linh thú sổng chuồng hôm trước: 50% tự quay về
	var runaways: Array = incident_state.get("runaways", [])
	for pid in runaways:
		if randf() < 0.5:
			var p: Dictionary = products[int(pid)]
			var ages: = _normalize_stock_ages(p.get("stock_ages", []), int(p.get("stock", 0)));ages.append(0)
			p["stock_ages"] = ages;p["stock"] = ages.size()
			_incident_push("LINH THÚ QUAY VỀ", "%s sổng chuồng hôm qua đã tự tìm về linh khố." % p["name"])
		else:
			_incident_push("LINH THÚ KHÔNG VỀ", "%s sổng chuồng hôm qua đã đi mất hẳn." % products[int(pid)]["name"])
	incident_state["runaways"] = []
	# Khách mua chịu: 30% quay lại trả tiền
	var credit: Array = incident_state.get("credit", [])
	for c in credit:
		if randf() < 0.3:
			money += int(c["amount"])
			_incident_push("KHÁCH MUA CHỊU ĐÃ TRẢ", "Người xưng đệ tử Thiên Kiếm Các quay lại trả đủ %s LT cho %s. Hóa ra là thật!" % [_fmt_thousands(int(c["amount"])), c["name"]])
		else:
			_incident_push("KHÁCH MUA CHỊU BIỆT TĂM", "Kẻ xưng đệ tử Thiên Kiếm Các không quay lại. Mất trắng %s." % c["name"])
	incident_state["credit"] = []
	# Nhắc việc còn dang dở
	if bool(incident_state.get("roof_damaged", false)):
		customer_reviews.append({"name": "Khách qua đường", "avatar": 0, "stars": 2, "text": "Mái tiên môn dột lỗ chỗ, nước nhỏ cả lên kệ hàng. Sửa đi chứ!", "items": [], "item_sizes": []})
		_offer_roof_repair(true)
	if bool(incident_state.get("sign_lost", false)):
		_offer_new_sign(true)
	if not _incidents_on(): return
	_guide_once("g_incident")
	var day_chance: = INCIDENT_DAY_CHANCE * (0.5 if _has("fengshui") else 1.0) * (0.7 if _tr("earth_god") else 1.0)
	if randf() < day_chance and _tr("gourd"):
		treasures_placed.erase("gourd");treasures_owned.erase("gourd")
		money += 5000
		_incident_push("HỒ LÔ THU YÊU", "Đêm qua yêu khí kéo tới định quấy phá, hồ lô thu yêu hút gọn một con yêu thú. Bán yêu đan được 5.000 LT. Hồ lô đã vỡ.")
	elif randf() < day_chance:
		var pool: Array[String] = ["theft", "quake", "runaway", "rival"]
		if level >= 3 and day_number > int(buzz.get("until", 0)): pool.append("rumor")
		if not bool(incident_state.get("roof_damaged", false)) and _up("roof") == 0: pool.append("roof")
		if not bool(incident_state.get("sign_lost", false)) and _up("sign") < 3: pool.append("sign")
		if _active_staff_count() > 0 and not _has("cook"): pool.append("staff_eat")
		pool.shuffle()
		for kind in pool:
			if call("_day_incident_" + kind):
				_stat_add("incidents")
				if kind in ["theft", "quake"]: _consign_risk(kind)
				break
	if randf() < (0.6 if _tax_bribe_active() else INCIDENT_SHIFT_CHANCE):
		var shift_pool: Array[String] = ["brawl", "beasts", "patrol", "fake_vip"]
		if _has("beauty"): shift_pool.append_array(["brawl", "brawl"])
		if _tr("seal"): shift_pool.append_array(["patrol", "patrol"])
		if _tax_bribe_active(): shift_pool.append_array(["patrol", "patrol", "patrol"])
		incident_state["shift_event"] = shift_pool.pick_random()
		incident_state["shift_event_at"] = randf_range(10.0 * 60.0, 17.0 * 60.0)

func _cost_scale(base: int, per_level: int) -> int:
	return base + per_level * level

func _day_incident_roof() -> bool:
	_offer_roof_repair(false)
	return true

func _offer_roof_repair(reminder: bool) -> void:
	var cost: = mini(_cost_scale(200, 150), 2000)
	var body: = "Mái tiên môn vẫn còn dột, mỗi ngày để vậy khách lại chê một lượt." if reminder else "Đêm qua bão lớn, mái tiên môn bị tốc một mảng."
	body += "\nSửa ngay tốn %s LT. Để sau thì mỗi ngày bị trừ danh vọng cho tới khi sửa." % _fmt_thousands(cost)
	incident_state["roof_damaged"] = true
	_incident_push("SỬA MÁI TIÊN MÔN", body, [["SỬA NGAY · %s LT" % _fmt_thousands(cost), _repair_roof.bind(cost)], ["ĐỂ SAU", Callable()]])

func _repair_roof(cost: int) -> void:
	# Hết hoặc âm tiền vẫn cho sửa: linh thạch có thể âm, bán hàng trả bù sau.
	money -= cost
	_log_expense("Sự cố: sửa mái tiên môn", cost)
	_update_money_display()
	incident_state["roof_damaged"] = false
	_show_toast("Đã sửa mái tiên môn.")

func _day_incident_theft() -> bool:
	var best: = -1;var best_price: = -1
	for shelf in shelves:
		var pid: = int(shelf.get("product", -1))
		if pid >= 0 and int(shelf.get("stock", 0)) > 0 and int(products[pid]["price"]) > best_price:
			best = pid;best_price = int(products[pid]["price"])
	if best < 0: return false
	if bool(incident_state.get("ward_charm", false)):
		_incident_push("TRỘM ĐÊM", "Đêm qua có kẻ lẻn vào định lấy %s, nhưng Phù trấn môn phát sáng đuổi đi. Không mất gì." % products[best]["name"])
		return true
	if _tr("mirror") or _tr("qilin"):
		_incident_push("TRỘM ĐÊM", "Đêm qua có kẻ lẻn vào định lấy %s, bị %s chiếu sáng dọa chạy mất. Không mất gì." % [products[best]["name"], "gương bát quái" if _tr("mirror") else "kỳ lân trấn trạch"])
		return true
	if _has("guard") or _has("swordsman"):
		_incident_push("TRỘM ĐÊM", "Đêm qua có kẻ lẻn vào định lấy %s, bị %s tóm gọn. Không mất gì." % [products[best]["name"], "hộ viện" if _has("guard") else "tiêu sư"])
		return true
	for shelf in shelves:
		if int(shelf.get("product", -1)) == best and int(shelf.get("stock", 0)) > 0:
			_log_goods_loss("trộm lấy", best, _lose_from_shelf(shelf, 1));break
	var charm: = _cost_scale(1500, 500)
	_incident_push("TRỘM ĐÊM", "Đêm qua trộm lẻn vào lấy mất 1 %s, món giá trị nhất trên kệ.\nMua Phù trấn môn (%s LT) để chặn trộm vĩnh viễn?" % [products[best]["name"], _fmt_thousands(charm)], [["MUA PHÙ TRẤN MÔN · %s LT" % _fmt_thousands(charm), _buy_ward_charm.bind(charm)], ["ĐỂ SAU", Callable()]])
	return true

func _buy_ward_charm(cost: int) -> void:
	if money < cost: _show_toast("Chưa đủ linh thạch mua Phù trấn môn.");return
	_pay(cost, "mua Phù trấn môn")
	incident_state["ward_charm"] = true
	_show_toast("Phù trấn môn đã dán, trộm không vào được nữa.")

func _day_incident_quake() -> bool:
	if _tr("qilin"): return false
	var candidates: Array[int] = []
	for i in range(shelves.size()):
		var pid: = int(shelves[i].get("product", -1))
		if pid >= 0 and int(shelves[i].get("stock", 0)) > 0 and not (_cat(pid) in ["pháp khí", "linh thú"]): candidates.append(i)
	if candidates.is_empty(): return false
	candidates.shuffle()
	var lines: PackedStringArray = []
	for k in range(mini(randi_range(1, 2), candidates.size())):
		var shelf: Dictionary = shelves[candidates[k]]
		var pid: = int(shelf["product"])
		var n: = maxi(1, roundi(int(shelf["stock"]) * randf_range(0.2, 0.4) * (0.5 if _up("roof") >= 3 else 1.0)))
		var lost: = _lose_from_shelf(shelf, n)
		_log_goods_loss("động đất làm vỡ", pid, lost)
		lines.append("Kệ %d · vỡ %d %s" % [candidates[k] + 1, lost, products[pid]["name"]])
	_incident_push("ĐỘNG ĐẤT NHẸ", "Đất rung lúc rạng sáng, kệ hàng đổ nghiêng.\n" + "\n".join(lines) + "\n(Pháp khí và linh thú không hề hấn gì.)")
	return true

func _day_incident_runaway() -> bool:
	for shelf in shelves:
		var pid: = int(shelf.get("product", -1))
		if pid >= 0 and int(shelf.get("stock", 0)) > 0 and _cat(pid) == "linh thú":
			if _has("beastkeeper") or _up("beast_yard") >= 1: return false
			_lose_from_shelf(shelf, 1)
			var r: Array = incident_state.get("runaways", []);r.append(pid);incident_state["runaways"] = r
			_incident_push("LINH THÚ SỔNG CHUỒNG", "1 %s đã sổng chuồng chạy mất. Có thể mai nó tự tìm về… hoặc không." % products[pid]["name"])
			return true
	return false

func _day_incident_rival() -> bool:
	var pid: = -1
	if not daily_statistics.is_empty():
		var sold: Dictionary = daily_statistics[daily_statistics.size() - 1].get("sold", {})
		var best_q: = 0
		for k in sold.keys():
			if int(sold[k]) > best_q and _shelf_product_ids().has(int(k)): best_q = int(sold[k]);pid = int(k)
	if pid < 0:
		var ids: = _shelf_product_ids()
		if ids.is_empty(): return false
		pid = ids.pick_random()
	var rival_price: = maxi(1, int(int(products[pid]["price"]) * 0.8))
	incident_state["rival"] = {"product": pid, "price": rival_price}
	_incident_push("TIỆM ĐỐI THỦ HẠ GIÁ", "Tiệm Vạn Bảo cùng phố bán %s chỉ %s LT.\nHôm nay khách sẽ ít gọi món này ở tiên môn, trừ khi bạn hạ giá xuống %s LT hoặc thấp hơn." % [products[pid]["name"], _fmt_thousands(rival_price), _fmt_thousands(rival_price)])
	return true

func _day_incident_staff_eat() -> bool:
	var targets: Array = []
	for i in range(products.size()):
		if _cat(i) == "đan dược" and int(products[i].get("stock", 0)) > 0: targets.append({"inv": i})
	for shelf in shelves:
		var pid: = int(shelf.get("product", -1))
		if pid >= 0 and int(shelf.get("stock", 0)) > 0 and _cat(pid) == "đan dược": targets.append({"shelf": shelf})
	if targets.is_empty(): return false
	var t: Dictionary = targets.pick_random()
	var n: = randi_range(1, 3)
	var pid2: int
	var lost: = 0
	if t.has("inv"):
		pid2 = int(t["inv"]);lost = _take_inventory_units(pid2, n).size()
	else:
		pid2 = int(t["shelf"]["product"]);lost = _lose_from_shelf(t["shelf"], n)
	_log_goods_loss("nhân viên ăn vụng", pid2, lost)
	_incident_push("NHÂN VIÊN ĂN VỤNG", "Nhân viên lén dùng %d %s trong tiệm để bồi bổ tu vi." % [lost, products[pid2]["name"]])
	return true

func _day_incident_sign() -> bool:
	_offer_new_sign(false)
	return true

func _offer_new_sign(reminder: bool) -> void:
	incident_state["sign_lost"] = true
	if is_instance_valid(level_sign_display): level_sign_display.visible = false
	var cost: = _cost_scale(300, 200)
	var body: = "Tiên môn vẫn chưa có biển hiệu, khách đi ngang không nhận ra." if reminder else "Gió lớn cuốn bay biển hiệu tiên môn."
	body += "\nKhông có biển, khách vào ít hơn khoảng 15%%. Làm biển mới tốn %s LT." % _fmt_thousands(cost)
	_incident_push("BIỂN HIỆU BỊ GIÓ CUỐN", body, [["LÀM BIỂN MỚI · %s LT" % _fmt_thousands(cost), _make_new_sign.bind(cost)], ["ĐỂ SAU", Callable()]])

func _make_new_sign(cost: int) -> void:
	if money < cost: _show_toast("Chưa đủ linh thạch làm biển hiệu.");return
	_pay(cost, "làm biển hiệu mới")
	incident_state["sign_lost"] = false
	if is_instance_valid(level_sign_display): level_sign_display.visible = true
	_show_toast("Biển hiệu mới đã treo lên.")

# ---------- Trong ca ----------
func _incidents_tick() -> void:
	var kind: = str(incident_state.get("shift_event", ""))
	if kind.is_empty() or game_minutes < float(incident_state.get("shift_event_at", 0.0)): return
	incident_state["shift_event"] = ""
	call("_shift_incident_" + kind)
	_stat_add("incidents")

func _shift_incident_brawl() -> void:
	var stocked: Array[int] = []
	for i in range(shelves.size()):
		if int(shelves[i].get("product", -1)) >= 0 and int(shelves[i].get("stock", 0)) > 0: stocked.append(i)
	if stocked.is_empty(): return
	if _blocks_trouble() or _tr("qilin"):
		_show_toast("Một khách say rượu định quậy phá, đã bị mời ra ngoài kịp lúc.");return
	if _tr("screen") and randf() < 0.5:
		_show_toast("Khách say định quậy, nhìn bình phong sơn thủy bỗng tỉnh rượu bỏ đi.");return
	var idx: int = stocked.pick_random()
	var pid: = int(shelves[idx]["product"])
	var lost: = _lose_from_shelf(shelves[idx], 1 if _tr("chime") else randi_range(3, 8))
	_log_goods_loss("khách say làm đổ", pid, lost)
	_incident_push("KHÁCH QUẬY PHÁ", "Một khách say rượu xô đổ kệ %d, vỡ %d %s.\n(Thuê quản lý để mời kẻ quậy phá ra trước khi kịp đổ kệ.)" % [idx + 1, lost, products[pid]["name"]])

func _shift_incident_beasts() -> void:
	incident_state["close_early_at"] = float(GAME_END_MINUTES - 120)
	_incident_push("YÊU THÚ TRÀN XUỐNG THÀNH", "Yêu thú từ núi Tây tràn xuống! Quan phủ lệnh mọi cửa hiệu đóng cửa lúc %02d:00, sớm 2 canh giờ." % int((GAME_END_MINUTES - 120) / 60))

func _shift_incident_patrol() -> void:
	var worst: = -1;var over_amount: = 0
	for pid in _shelf_product_ids():
		var th: = int(products[pid].get("overprice_threshold", 0))
		var price: = int(products[pid]["price"])
		if th > 0 and price >= th and price - th + 1 > over_amount: over_amount = price - th + 1;worst = pid
	if worst < 0:
		_show_toast("Quan phủ đi tuần kiểm định giá: mọi món đều hợp lệ.");return
	if _has("accountant") and randf() < 0.5:
		_show_toast("Tôn tiên sinh nhắc chỉnh giá %s kịp trước khi quan phủ tới." % products[worst]["name"]);return
	var units: = maxi(1, int(sold_today.get(str(worst), 0)))
	var fine: = 5 * over_amount * units
	var paid: = _pay(fine, "phạt bán vượt giá trần %s" % products[worst]["name"])
	_incident_push("QUAN PHỦ KIỂM ĐỊNH", "Quan phủ phát hiện %s bán %s LT, vượt giá trần %s LT.\nPhạt gấp 5 lần phần vượt × %d món đã bán: %s LT." % [products[worst]["name"], _fmt_thousands(int(products[worst]["price"])), _fmt_thousands(int(products[worst].get("overprice_threshold", 0))), units, _fmt_thousands(paid)])

func _shift_incident_fake_vip() -> void:
	var best: = -1;var best_price: = -1
	for pid in _shelf_product_ids():
		if int(products[pid]["price"]) > best_price: best = pid;best_price = int(products[pid]["price"])
	if best < 0: return
	_incident_push("KHÁCH XIN MUA CHỊU", "Một người xưng là đệ tử Thiên Kiếm Các muốn lấy 1 %s (%s LT), hứa mai sẽ trả.\nTừ chối thì làm phật ý danh môn, danh vọng bị ảnh hưởng." % [products[best]["name"], _fmt_thousands(best_price)], [["CHO MUA CHỊU", _give_credit.bind(best)], ["TỪ CHỐI", _refuse_credit]])

func _give_credit(pid: int) -> void:
	for shelf in shelves:
		if int(shelf.get("product", -1)) == pid and int(shelf.get("stock", 0)) > 0:
			_lose_from_shelf(shelf, 1);break
	var c: Array = incident_state.get("credit", []);c.append({"name": products[pid]["name"], "amount": int(products[pid]["price"])});incident_state["credit"] = c
	_show_toast("Đã cho mua chịu 1 %s. Mai xem hắn có quay lại trả không." % products[pid]["name"])

func _refuse_credit() -> void:
	customer_reviews.append({"name": "Đệ tử Thiên Kiếm Các", "avatar": 0, "stars": 2, "text": "Tiên môn nhỏ mà dám không nể mặt Thiên Kiếm Các. Hừ!", "items": [], "item_sizes": []})
	_show_toast("Đã từ chối. Khách phật ý bỏ đi, để lại đánh giá 2 sao.")

# ---------- Gắn với hành động ----------
func _incident_after_wrong_delivery(product_id: int) -> void:
	if not _incidents_on() or randf() >= 0.3: return
	var amount: = 2 * int(products[product_id]["price"])
	var paid: = _pay(amount, "bồi thường khách vì giao nhầm %s" % products[product_id]["name"])
	if paid > 0: _show_toast("Khách nổi giận đòi bồi thường vì giao nhầm %s · −%s LT." % [products[product_id]["name"], _fmt_thousands(paid)])

func _incident_market_scam() -> bool:
	return _incidents_on() and randf() < 1.0 / 15.0

func _incident_robbery(index: int, quantity: int) -> int:
	# Trả về số món bị cướp
	if not _incidents_on() or quantity <= 100 or _has("escort"): return 0
	if randf() >= (0.125 if _has("guard") else 0.25): return 0
	return maxi(1, roundi(quantity * randf_range(0.1, 0.2)))

func _incident_after_checkout(items: Array) -> void:
	if not _incidents_on(): return
	for pid in items:
		if _cat(int(pid)) == "phi xa" and randf() < 0.125:
			var paid: = _pay(int(round(int(products[int(pid)]["price"]) * 0.3)), "khách thử %s đâm vào cột" % products[int(pid)]["name"])
			if paid > 0: _show_toast("Khách thử %s ngay trước tiệm rồi đâm vào cột · bồi thường %s LT." % [products[int(pid)]["name"], _fmt_thousands(paid)])
			return

func _incident_refiner_quit(product_id: int) -> bool:
	if not _incidents_on() or randf() >= 0.05: return false
	var lines: PackedStringArray = []
	for entry in _recipe_for(product_id):
		var name: String = str(entry["name"])
		var lost: = int(ceil(float(entry["qty"]) / 2.0))
		material_stock[name] = maxi(0, int(material_stock.get(name, 0)) - lost)
		lines.append("%s −%d" % [name, lost])
	_incident_push("TIỂU ĐỒNG BỎ VIỆC", "Tiểu Hỏa bỏ ngang giữa chừng, mẻ %s bị hủy. Chỉ thu hồi được một nửa nguyên liệu:\n%s" % [products[product_id]["name"], "\n".join(lines)])
	return true

func _incident_end_day_ledger() -> void:
	if not _incidents_on() or bool(staff.get("manager", false)) or revenue_today <= 0 or randf() >= 0.2: return
	var amount: = maxi(1, roundi(revenue_today * randf_range(0.01, 0.03)))
	_pay(amount, "sai sổ sách cuối ngày")


# ---------- Tạp dịch (nhân viên) ----------
const MAX_ACTIVE_STAFF: = 4
const _PF: = "res://assets/boutique/staff/staff_female.png"
const _PM: = "res://assets/boutique/staff/staff_male.png"
const _PL: = "res://assets/boutique/staff/staff_manager.png"
const STAFF_ORDER: Array[String] = ["cashier", "restocker", "manager", "apprentice", "quick_waiter", "veteran", "beauty", "accountant", "guard", "crier", "barker", "cook", "swordsman", "escort", "acolyte", "alchemist", "vip_host", "merchant", "fortune", "fengshui", "beastkeeper", "elder"]
const STAFF_ROLES: Dictionary = {
	"cashier": {"title": "Tiểu nhị đứng quầy", "name": "Nguyễn Băng Tâm", "portrait": "res://assets/boutique/staff/staff_cashier.png", "wage": 100, "hire": 7500, "level": 1, "pro": "Tự giao hàng và thanh toán cho khách.", "con": "Thỉnh thoảng lấy nhầm size, cuối ngày có thể mắc lỗi bị khách chê."},
	"restocker": {"title": "Hỏa kế bày kệ", "name": "Hoàng Minh Quân", "portrait": _PM, "wage": 100, "hire": 7500, "level": 1, "pro": "Tự lấy hàng trong kho bày lên kệ trống.", "con": "Không phục vụ khách."},
	"manager": {"title": "Chưởng quỹ", "name": "Đặng Nhật Minh", "portrait": "res://assets/boutique/staff/staff_chuong_quy.png", "wage": 400, "hire": 12000, "level": 1, "pro": "Phục vụ khách, bày kệ, chặn khách quậy phá, sai sổ sách và gian thương ăn chặn.", "con": "Lương cao nhất trong ba người đầu."},
	"apprentice": {"title": "Đệ tử mới nhập môn", "name": "Tiểu Bạch", "portrait": "res://assets/boutique/staff/staff_apprentice.png", "wage": 40, "hire": 2000, "level": 1, "pro": "Lương rẻ nhất. Làm đủ 10 ngày thì phục vụ nhanh như tiểu nhị thường.", "con": "10 ngày đầu phục vụ chậm và mỗi ngày làm đổ 0–2 món trên kệ."},
	"quick_waiter": {"title": "Tiểu nhị nhanh nhảu", "name": "Tiểu Lục", "portrait": _PM, "wage": 90, "hire": 4500, "level": 1, "pro": "Giao hàng nhanh gấp đôi tiểu nhị thường.", "con": "10% lần giao bị nhầm món, mất món đó và có thể bị khách đòi bồi thường."},
	"veteran": {"title": "Lão tiểu nhị kỳ cựu", "name": "Lão Hắc", "portrait": _PL, "wage": 130, "hire": 6500, "level": 1, "pro": "Không bao giờ giao nhầm. Khách quý người già, tip thêm 30%.", "con": "Chậm hơn 50%. Mỗi tuần nghỉ ốm 1 ngày mà vẫn lấy lương."},
	"beauty": {"title": "Mỹ nhân đứng quầy", "name": "Lâm Nguyệt Dao", "portrait": _PF, "wage": 150, "hire": 7500, "level": 2, "pro": "Khách vào nhiều hơn 20%, tip tăng 20%.", "con": "Dễ có kẻ gây rối vì ghen (khách quậy phá thường hơn). 15% đánh giá bị trừ 1 sao."},
	"accountant": {"title": "Trướng phòng tiên sinh", "name": "Tôn tiên sinh", "portrait": _PL, "wage": 120, "hire": 6000, "level": 2, "pro": "Cuối ngày báo món bán lỗ và món sắp tiêu tán. Giảm 50% khả năng bị quan phủ phạt. Thuế thương khóa giảm 20%, khai gian khó bị lộ hơn.", "con": "Không phục vụ khách, không bày kệ."},
	"guard": {"title": "Hộ viện", "name": "Thiết Ngưu", "portrait": _PM, "wage": 150, "hire": 7500, "level": 2, "pro": "Chặn trộm đêm và khách quậy phá. Giảm một nửa khả năng bị cướp đường thương.", "con": "Không giúp bán hàng."},
	"crier": {"title": "Mại thoại tiên sinh", "name": "Triệu Khẩu", "portrait": _PM, "wage": 120, "hire": 6000, "level": 2, "pro": "Đứng cửa mời khách, khách vào nhiều hơn 15%.", "con": "Không phục vụ khách."},
	"barker": {"title": "Kẻ rao hàng mồm mép", "name": "Lý Thiệt", "portrait": _PM, "wage": 110, "hire": 5500, "level": 3, "pro": "Khách vào nhiều hơn 25%.", "con": "Hứa quá lời: khách phải chờ quá nửa kiên nhẫn thì 50% bị trừ 1 sao."},
	"cook": {"title": "Bếp núc tạp dịch", "name": "Vương Đại Nương", "portrait": _PF, "wage": 80, "hire": 4000, "level": 3, "pro": "Nấu linh thiện: cả đội không ăn vụng, lão tiểu nhị không ốm.", "con": "Không giúp bán hàng, chỉ đáng thuê khi đông người."},
	"swordsman": {"title": "Tiêu sư giang hồ", "name": "Hàn Phong", "portrait": _PM, "wage": 170, "hire": 8500, "level": 4, "pro": "Chặn trộm đêm và khách quậy phá.", "con": "Tính nóng: 1/12 khả năng mỗi ngày đánh nhầm khách, bị 1 sao."},
	"escort": {"title": "Thương đội tiêu sư", "name": "Mã Uy", "portrait": _PL, "wage": 200, "hire": 10000, "level": 4, "pro": "Lô thâu mua không bị cướp. Thâu từ 50 món giảm 5% giá thâu.", "con": "Lương cao, không giúp bán hàng."},
	"acolyte": {"title": "Tiểu đồng luyện đan", "name": "Tiểu Hỏa", "portrait": _PM, "wage": 130, "hire": 6500, "level": 2, "pro": "Tự tinh luyện thay bạn các món Trung phẩm, không cần chơi mini game.", "con": "1/8 khả năng tinh luyện hỏng, mất nguyên liệu; 5% bỏ dở giữa chừng, mất nửa nguyên liệu. Không làm được Thượng phẩm."},
	"alchemist": {"title": "Luyện đan sư phụ việc", "name": "Cát sư phụ", "portrait": _PL, "wage": 250, "hire": 12500, "level": 6, "pro": "Tự tinh luyện thay bạn mọi món, kể cả Thượng phẩm, không bao giờ bỏ việc.", "con": "Lương cao. Mỗi mẻ khách phải chờ thêm 5 giây."},
	"vip_host": {"title": "Tiểu nhị VIP", "name": "Tô Uyển", "portrait": _PF, "wage": 160, "hire": 8000, "level": 5, "pro": "Khách VIP chờ lâu hơn 10 giây và tip nhiều hơn 50%.", "con": "Chỉ có ích với khách VIP."},
	"merchant": {"title": "Gian thương lão luyện", "name": "Kim Bách Vạn", "portrait": _PL, "wage": 100, "hire": 5000, "level": 5, "pro": "Giá thâu giảm 10%, chợ thành trì bán rẻ hơn 10%.", "con": "15% khả năng mỗi ngày ăn chặn 2–5% doanh thu (chưởng quỹ phát hiện được)."},
	"fortune": {"title": "Thầy bói đầu ngõ", "name": "Bán Tiên", "portrait": _PL, "wage": 140, "hire": 7000, "level": 5, "pro": "Tin tức thành trì đúng 90–95%.", "con": "1/10 lần phán bậy: tin sai hẳn."},
	"fengshui": {"title": "Phong thủy sư", "name": "Gia Cát Tử", "portrait": _PL, "wage": 220, "hire": 11000, "level": 6, "pro": "Giảm một nửa khả năng có sự cố đầu ngày.", "con": "Mỗi tuần một ngày đòi đóng cửa sớm lúc 19:00 để tịnh tâm."},
	"beastkeeper": {"title": "Linh thú sư", "name": "Mộc Linh", "portrait": _PF, "wage": 180, "hire": 9000, "level": 8, "pro": "Linh thú không sổng chuồng, linh thú lâu tiêu tán hơn 1 ngày.", "con": "Chỉ có ích khi bán linh thú."},
	"elder": {"title": "Trưởng lão hưu trí", "name": "Thanh Hư trưởng lão", "portrait": _PL, "wage": 300, "hire": 15000, "level": 8, "pro": "Có tiếng tăm: mỗi ngày thêm 1 lượt khách VIP.", "con": "Không làm việc tay chân, chỉ ngồi uống trà. Lương cao nhất."},
}

func _has(role: String) -> bool:
	return bool(staff.get(role, false))

func _active_staff_count() -> int:
	var n: = 0
	for role in STAFF_ORDER:
		if _has(role): n += 1
	return n

func _veteran_sick() -> bool:
	return _has("veteran") and not _has("cook") and day_number % 7 == 0

func _apprentice_green() -> bool:
	return _has("apprentice") and day_number - int(staff_hired_day.get("apprentice", day_number)) < 10

func _staff_serve_interval() -> float:
	# Thời gian (giây) giữa hai lần nhân viên giao một món; 0 = không ai phục vụ.
	var best: = 0.0
	var options: Array[float] = []
	if _has("cashier"): options.append(1.5)
	if _has("manager"): options.append(1.5)
	if _has("beauty"): options.append(1.5)
	if _has("quick_waiter"): options.append(0.75)
	if _has("veteran") and not _veteran_sick(): options.append(2.25)
	if _has("apprentice"): options.append(3.0 if _apprentice_green() else 1.5)
	for o in options:
		if best == 0.0 or o < best: best = o
	return best

func _staff_quick_is_fastest() -> bool:
	return _has("quick_waiter") and is_equal_approx(_staff_serve_interval(), 0.75)

func _arrival_bonus() -> float:
	var b: = 0.0
	if _has("beauty"): b += 0.20
	if _has("crier"): b += 0.15
	if _has("barker"): b += 0.25
	b += 0.05 * _up("sign")
	if not _festival_today().is_empty() and running: b += float(_festival_today()["crowd"])
	if _tr("lantern") and game_minutes >= 18.0 * 60.0: b += 0.30
	if day_number <= daihoi_boost_until: b += 0.15
	b += _ext8_arrival()
	return b

func _tip_multiplier(customer: Dictionary) -> float:
	var m: = 1.0
	if _has("veteran") and not _veteran_sick(): m += 0.3
	if _has("beauty"): m += 0.2
	if _has("vip_host") and bool(customer.get("vip", false)): m += 0.5
	if _tr("toad"): m += 0.15
	if not _festival_today().is_empty(): m += float(_festival_today()["tip"])
	if _tr("tea_table") and bool(customer.get("vip", false)): m += 0.3
	return m

func _blocks_trouble() -> bool:
	return _has("guard") or _has("swordsman") or _has("manager")

func _staff_new_day() -> void:
	if _has("apprentice") and _apprentice_green():
		var stocked: Array[int] = []
		for i in range(shelves.size()):
			if int(shelves[i].get("product", -1)) >= 0 and int(shelves[i].get("stock", 0)) > 0: stocked.append(i)
		var n: = randi_range(0, 2)
		if n > 0 and not stocked.is_empty():
			var idx: int = stocked.pick_random();var pid: = int(shelves[idx]["product"])
			var lost: = _lose_from_shelf(shelves[idx], n)
			_log_goods_loss("đệ tử mới làm đổ", pid, lost)
			if lost > 0: _show_toast("Tiểu Bạch vụng về làm đổ %d %s." % [lost, products[pid]["name"]])
	if _veteran_sick(): _show_toast("Lão Hắc ốm, hôm nay nghỉ (vẫn lấy lương).")
	if _has("swordsman") and randf() < 1.0 / 12.0:
		customer_reviews.append({"name": "Khách bị đánh nhầm", "avatar": 0, "stars": 1, "text": "Ta chỉ vào xem hàng mà bị tiêu sư của tiên môn tưởng trộm, đánh cho một chưởng. Quá đáng!", "items": [], "item_sizes": []})
	if _has("fengshui") and day_number % 7 == 3:
		incident_state["close_early_at"] = float(GAME_END_MINUTES - 120)
		_incident_push("PHONG THỦY SƯ TỊNH TÂM", "Hôm nay là ngày tịnh tâm của Gia Cát Tử. Tiên môn đóng cửa sớm lúc %02d:00." % int((GAME_END_MINUTES - 120) / 60))
	if _has("elder"): vip_limit_today += 1

func _staff_end_day() -> void:
	if _has("merchant") and not _has("manager") and revenue_today > 0 and randf() < 0.15:
		var amount: = maxi(1, roundi(revenue_today * randf_range(0.02, 0.05)))
		_pay(amount, "gian thương ăn chặn")

func _accountant_lines() -> Array:
	var out: Array = []
	if not _has("accountant"): return out
	for i in range(products.size()):
		var p: Dictionary = products[i]
		var on_shelf: = false
		for shelf in shelves:
			if int(shelf.get("product", -1)) == i and int(shelf.get("stock", 0)) > 0: on_shelf = true
		if on_shelf and int(p["price"]) < int(p.get("cost", 0)): out.append("- %s bán %s LT, thấp hơn giá thâu %s LT" % [p["name"], _fmt_thousands(int(p["price"])), _fmt_thousands(int(p.get("cost", 0)))])
	for i in range(shelves.size()):
		var pid: = int(shelves[i].get("product", -1))
		if pid < 0: continue
		var ex_count: = _expiring_count(shelves[i], pid)
		if ex_count > 0: out.append("- Kệ %d: %d %s sẽ tiêu tán nếu ngày mai không bán hết" % [i + 1, ex_count, products[pid]["name"]])
	if out.is_empty(): out.append("- Sổ sách ổn, không có món bán lỗ hay sắp tiêu tán.")
	return out

# Tự tinh luyện (tiểu đồng / sư phụ). Trả true nếu đã xử lý thay mini game.
func _staff_auto_refine(product_id: int) -> int:
	# 0 = không ai làm thay; 1 = thành công; -1 = hỏng
	var grade: = _product_refining_grade(products[product_id])
	if _has("alchemist"): return 1
	if _has("acolyte") and grade != "Thượng phẩm":
		return -1 if randf() < 0.125 else 1
	return 0


# ---------- Truyền Tin Phù: đơn hàng từ xa ----------
const REMOTE_MIN_LEVEL: = 3
const REMOTE_SECTS: Array[String] = ["Thanh Vân Tông", "Lạc Hà Cốc", "Thiên Kiếm Các", "Vạn Pháp Tự", "Bích Thủy Cung", "Huyết Sát Môn", "Tán tu Bắc Hoang", "Tán tu Nam Cương"]
const REMOTE_METHODS: Dictionary = {
	"caravan": {"name": "Thương đội bộ hành", "extra_days": 1, "fee": 0.03, "rob": 0.25, "level": 1},
	"mudiao": {"name": "Mộc Điểu Phi Xa", "extra_days": 0, "fee": 0.06, "rob": 0.08, "level": 1},
	"teleport": {"name": "Truyền tống trận", "extra_days": 0, "fee": 0.12, "rob": 0.0, "level": 7},
	"beast": {"name": "Linh thú tự nuôi", "extra_days": 0, "fee": 0.0, "rob": 0.05, "level": 1},
}
var remote_offers: Array = []
var remote_active: Array = []
var remote_shipments: Array = []
var sect_rep: Dictionary = {}
var remote_serial: int = 0
var remote_income_today: int = 0

func _remote_max() -> int:
	return clampi(3 + int((level - REMOTE_MIN_LEVEL) / 2), 3, 6) + (1 if _up("dock") >= 2 else 0)

func _remote_busy() -> int:
	return remote_active.size() + remote_shipments.size()

func _is_loose_cultivator(sect: String) -> bool:
	return sect.begins_with("Tán tu")

func _rep(sect: String) -> int:
	return int(sect_rep.get(sect, 0))

func _rep_change(sect: String, delta: int) -> void:
	sect_rep[sect] = clampi(_rep(sect) + delta, -50, 100)

func _remote_generate_offers() -> void:
	remote_offers.clear()
	if level < REMOTE_MIN_LEVEL: return
	var pool: Array[int] = []
	for i in range(products.size()):
		if _is_product_available(i): pool.append(i)
	if pool.is_empty(): return
	for _n in range(randi_range(2, 4)):
		var sect: String = REMOTE_SECTS.pick_random()
		var rep: = _rep(sect)
		var qty_mult: = 1.3 if rep >= 30 else 1.0
		var picks: = pool.duplicate();picks.shuffle()
		var items: Array = []
		var value: = 0
		for k in range(mini(randi_range(1, 3), picks.size())):
			var pid: int = picks[k]
			var q: = int(round(randi_range(5, 50) * qty_mult))
			items.append({"pid": pid, "qty": q})
			value += int(products[pid]["price"]) * q
		var bonus: = randf_range(0.10, 0.40) + (0.2 if rep >= 60 else (0.1 if rep >= 30 else 0.0))
		var dist: = randi_range(1, 2)
		remote_serial += 1
		remote_offers.append({"id": remote_serial, "sect": sect, "items": items, "dist": dist, "limit": dist + randi_range(2, 3), "pay": int(round(value * (1.0 + bonus))), "bonus": int(round(bonus * 100.0)), "exclusive": rep >= 60})

func _remote_items_text(items: Array) -> String:
	var parts: PackedStringArray = []
	for it in items: parts.append("%s ×%d" % [products[int(it["pid"])]["name"], int(it["qty"])])
	return ", ".join(parts)

func _units_available(pid: int) -> int:
	var n: = int(products[pid].get("stock", 0))
	for shelf in shelves:
		if int(shelf.get("product", -1)) == pid: n += int(shelf.get("stock", 0))
	return n

func _has_beast_stock() -> bool:
	for i in range(products.size()):
		if _cat(i) == "linh thú" and _units_available(i) > 0: return true
	return false

func _remote_travel_days(order: Dictionary, method: String) -> int:
	if method == "teleport": return 1
	return maxi(1, int(order["dist"]) + int(REMOTE_METHODS[method]["extra_days"]) - (1 if _up("dock") >= 3 else 0))

func _remote_fee(order: Dictionary, method: String) -> int:
	var f: = float(REMOTE_METHODS[method]["fee"]) * int(order["pay"])
	if _has("merchant"): f *= 0.9
	if _up("dock") >= 1: f *= 0.8
	return int(round(f))

func _remote_spoil_problem(order: Dictionary, travel: int) -> String:
	for it in order["items"]:
		var pid: = int(it["pid"])
		var p: Dictionary = products[pid]
		if bool(p.get("permanent_stock", false)): continue
		var days: = maxi(1, int(p.get("outdated_days", DEFAULT_OUTDATED_DAYS)))
		if travel > days: return "%s chỉ giữ được linh khí %d ngày, đi đường %d ngày sẽ hỏng." % [p["name"], days, travel]
	return ""

func _remote_accept(order_id: int) -> void:
	if _remote_busy() >= _remote_max(): _show_toast("Đã đủ %d đơn truyền tin đang xử lý." % _remote_max());return
	for i in range(remote_offers.size()):
		var o: Dictionary = remote_offers[i]
		if int(o["id"]) != order_id: continue
		var deposit: = int(round(int(o["pay"]) * 0.1))
		if money < deposit: _show_toast("Cần %s LT đặt cọc." % _fmt_thousands(deposit));return
		money -= deposit
		_log_expense("Đặt cọc đơn truyền tin %s" % o["sect"], deposit)
		o["deposit"] = deposit
		o["deadline"] = day_number + int(o["limit"])
		remote_active.append(o)
		remote_offers.remove_at(i)
		_sfx("coin");_update_money_display()
		_show_toast("Đã nhận đơn của %s · hạn giao trước hết ngày %d." % [o["sect"], int(o["deadline"])])
		_show_remote();return

func _remote_ship(order_id: int, method: String) -> void:
	for i in range(remote_active.size()):
		var o: Dictionary = remote_active[i]
		if int(o["id"]) != order_id: continue
		var travel: = _remote_travel_days(o, method)
		var spoil: = _remote_spoil_problem(o, travel)
		if not spoil.is_empty(): _show_toast(spoil);return
		for it in o["items"]:
			if _units_available(int(it["pid"])) < int(it["qty"]): _show_toast("Chưa đủ %s trong kho và trên kệ." % products[int(it["pid"])]["name"]);return
		var fee: = _remote_fee(o, method)
		if money < fee: _show_toast("Cần %s LT phí chở hàng." % _fmt_thousands(fee));return
		# Món cần tinh luyện: phải tinh luyện (mini game) trước khi gửi
		if not bool(o.get("refined", false)):
			var refine_list: Array = []
			for it in o["items"]:
				if _product_requires_refining(products[int(it["pid"])]): refine_list.append({"pid": int(it["pid"]), "qty": int(it["qty"])})
			if not refine_list.is_empty():
				for r in refine_list:
					for entry in _recipe_for(int(r["pid"])):
						var need: = _refine_unit_cost(entry) * int(r["qty"])
						if int(material_stock.get(str(entry["name"]), 0)) < need:
							_show_toast("Thiếu nguyên liệu để tinh luyện %d %s: %s (cần %d, còn %d)." % [int(r["qty"]), products[int(r["pid"])]["name"], entry["name"], need, int(material_stock.get(str(entry["name"]), 0))]);return
				_remote_refine = {"order_id": order_id, "method": method, "list": refine_list, "idx": 0}
				_remote_refine_next()
				return
		if fee > 0:
			money -= fee;_log_expense("Phí chở hàng truyền tin (%s)" % REMOTE_METHODS[method]["name"], fee)
		for it in o["items"]:
			var pid: = int(it["pid"]);var need: = int(it["qty"])
			need -= _take_inventory_units(pid, need).size()
			for shelf in shelves:
				if need <= 0: break
				if int(shelf.get("product", -1)) == pid: need -= _lose_from_shelf(shelf, need)
		o["method"] = method
		o["arrive"] = day_number + travel
		o["delayed"] = false
		remote_shipments.append(o)
		remote_active.remove_at(i)
		_sfx("deliver");_update_money_display()
		_show_toast("Đã gửi hàng cho %s bằng %s · dự kiến tới vào ngày %d." % [o["sect"], REMOTE_METHODS[method]["name"], int(o["arrive"])])
		_show_remote();return

# Gọi đầu mỗi ngày mới (sau khi day_number đã tăng)
func _remote_new_day() -> void:
	remote_income_today = 0
	var lines: PackedStringArray = []
	var still: Array = []
	for o in remote_shipments:
		if int(o["arrive"]) > day_number:
			still.append(o);continue
		var method: String = str(o["method"])
		# Thời tiết xấu: chậm 1 ngày (một lần)
		if method != "teleport" and not bool(o.get("delayed", false)) and randf() < 0.15:
			o["delayed"] = true;o["arrive"] = day_number + 1;still.append(o)
			lines.append("Đơn %s gặp mưa bão, chậm thêm 1 ngày." % o["sect"]);continue
		var sect: String = str(o["sect"])
		var pay: = float(o["pay"])
		var notes: PackedStringArray = []
		var rob_chance: = float(REMOTE_METHODS[method]["rob"])
		if _has("escort"): rob_chance = 0.0
		elif _has("guard"): rob_chance *= 0.5
		if randf() < rob_chance:
			var loss: = randf_range(0.2, 0.5);pay *= (1.0 - loss)
			notes.append("bị cướp mất %d%% hàng" % int(round(loss * 100.0)))
		if method == "caravan":
			for it in o["items"]:
				if _cat(int(it["pid"])) in ["đan dược", "phù triện"] and randf() < 0.1:
					pay *= 0.9;notes.append("vỡ một phần hàng dọc đường");break
		var bail: = randf() < (0.15 if _is_loose_cultivator(sect) else 0.03)
		var late: = int(o["arrive"]) > int(o["deadline"])
		var deposit: = int(o.get("deposit", 0))
		if bail:
			money += deposit;_log_expense("Hoàn cọc đơn %s" % sect, -deposit)
			lines.append("%s nhận hàng rồi bùng tiền! Chỉ lấy lại được cọc %s LT." % [sect, _fmt_thousands(deposit)])
			continue
		var got: = int(round(pay * (0.7 if late else 1.0)))
		money += got;revenue_today += got;remote_income_today += got
		_stat_add("revenue", got);_stat_add("remote_done")
		if level >= TAX_START_LEVEL and method != "teleport":
			var r_tax: = int(round(got * TAX_REMOTE_RATE))
			if r_tax > 0:
				money -= r_tax;_log_expense("Thuế quan truyền tin", r_tax);notes.append("nộp thuế quan %s LT" % _fmt_thousands(r_tax))
		if not late: _stat_add("remote_ontime")
		xp += maxi(1, int(_remote_qty(o) / 2))
		if late:
			_rep_change(sect, -15)
			customer_reviews.append({"name": sect, "avatar": 0, "stars": 2, "text": "Hàng truyền tin tới trễ hạn, làm lỡ việc của bổn môn.", "items": [], "item_sizes": []})
			lines.append("Giao trễ cho %s: nhận %s LT (bị trừ 30%%), mất cọc, uy tín giảm.%s" % [sect, _fmt_thousands(got), (" Đơn " + ", ".join(notes) + ".") if not notes.is_empty() else ""])
		else:
			money += deposit;_log_expense("Hoàn cọc đơn %s" % sect, -deposit)
			_rep_change(sect, 10)
			lines.append("Giao đúng hạn cho %s: +%s LT, hoàn cọc %s LT, uy tín tăng.%s" % [sect, _fmt_thousands(got), _fmt_thousands(deposit), (" Đơn " + ", ".join(notes) + ".") if not notes.is_empty() else ""])
	remote_shipments = still
	# Đơn đã nhận mà quá hạn chưa gửi: hủy, mất cọc
	var keep: Array = []
	for o in remote_active:
		if int(o["deadline"]) < day_number:
			_rep_change(str(o["sect"]), -10)
			lines.append("Đơn của %s quá hạn chưa gửi, bị hủy. Mất cọc %s LT." % [o["sect"], _fmt_thousands(int(o.get("deposit", 0)))])
		else: keep.append(o)
	remote_active = keep
	_remote_generate_offers()
	if not lines.is_empty():
		_incident_push("TIN TRUYỀN VỀ", "\n\n".join(lines))
	if remote_income_today > 0: _check_level()
	_update_money_display()

func _remote_qty(o: Dictionary) -> int:
	var n: = 0
	for it in o["items"]: n += int(it["qty"])
	return n

func _show_remote() -> void:
	if close_content == null: return
	active_close_tab = "remote"
	if _use_tab_page("remote"): return
	call_deferred("_wrap_close_labels")
	close_content.add_child(_section_heading("res://assets/boutique/ui_icons/icon_remote.png", "TRUYỀN TIN · Đơn hàng từ các tông môn ở xa", 12))
	if level < REMOTE_MIN_LEVEL:
		close_content.add_child(_label("Mở từ level %d. Lên level để nhận đơn đặt hàng từ xa." % REMOTE_MIN_LEVEL, 12, Color("6a8ca0")));return
	var head: = _label("Đang xử lý %d/%d đơn · Nhận đơn phải đặt cọc 10%%, giao đúng hạn được hoàn cọc." % [_remote_busy(), _remote_max()], 11, Color("c9558b"));head.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;close_content.add_child(head)
	close_content.add_child(_label("ĐÃ NHẬN · CHỜ GỬI", 13, Color("285b7a")))
	if remote_active.is_empty(): close_content.add_child(_label("Chưa có đơn nào đang chờ gửi.", 11, Color("6a8ca0")))
	for o in remote_active:
		var card2: = _remote_card(o, Color("e0a96d"), false)
		var info2: VBoxContainer = card2.get_meta("info")
		var enough: = true
		var short_parts: PackedStringArray = []
		for it in o["items"]:
			var have: = _units_available(int(it["pid"]))
			var ok_item: = have >= int(it["qty"])
			if not ok_item:
				enough = false;short_parts.append("%s %d" % [products[int(it["pid"])]["name"], int(it["qty"]) - have])
			info2.add_child(_wl("%s %s: có %d/%d" % ["Đủ ·" if ok_item else "Thiếu ·", products[int(it["pid"])]["name"], have, int(it["qty"])], 10, Color("2e8a57") if ok_item else Color("d64545")))

		info2.add_child(_wl("Hạn: phải tới nơi trước hết ngày %d (hôm nay ngày %d)" % [int(o["deadline"]), day_number], 10, Color("b5562f")))
		for m in ["caravan", "mudiao", "teleport", "beast"]:
			var md: Dictionary = REMOTE_METHODS[m]
			var travel: = _remote_travel_days(o, m)
			var fee: = _remote_fee(o, m)
			var text: = "%s · %d ngày · %s" % [md["name"], travel, ("phí %s LT" % _fmt_thousands(fee)) if fee > 0 else "miễn phí"]
			if day_number + travel > int(o["deadline"]): text += " · TRỄ HẠN"
			var reason: = ""
			if level < int(md["level"]): reason = "mở level %d" % int(md["level"])
			elif m == "beast" and not _has_beast_stock(): reason = "cần có linh thú"
			elif not _remote_spoil_problem(o, travel).is_empty(): reason = "hàng sẽ hỏng"
			if reason.is_empty() and not enough: reason = "thiếu hàng"
			if not reason.is_empty(): text += " (" + reason + ")"
			var mb: = _button(text, 9);mb.custom_minimum_size = Vector2(0, 36);mb.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
			mb.disabled = not reason.is_empty() or not enough or money < fee
			mb.pressed.connect(_remote_ship.bind(int(o["id"]), m));info2.add_child(mb)
		close_content.add_child(card2)
	close_content.add_child(_label("ĐƠN MỚI HÔM NAY", 13, Color("285b7a")))
	if remote_offers.is_empty(): close_content.add_child(_label("Chưa có đơn mới. Mai sẽ có phù truyền tin mới.", 11, Color("6a8ca0")))
	for o in remote_offers:
		var card: = _remote_card(o, Color("a6d8ee"))
		var info: VBoxContainer = card.get_meta("info")
		info.add_child(_wl("Đường xa %d ngày · hạn giao %d ngày kể từ khi nhận" % [int(o["dist"]), int(o["limit"])], 10, Color("4e85a6")))
		info.add_child(_wl("Trả %s LT (thưởng %d%%)%s" % [_fmt_thousands(int(o["pay"])), int(o["bonus"]), " · ĐỘC QUYỀN" if bool(o.get("exclusive", false)) else ""], 11, Color("2e8a57")))
		var deposit: = int(round(int(o["pay"]) * 0.1))
		var b: = _button("NHẬN ĐƠN · cọc %s LT" % _fmt_thousands(deposit), 10);b.custom_minimum_size = Vector2(0, 40)
		b.disabled = _remote_busy() >= _remote_max() or money < deposit
		b.pressed.connect(_remote_accept.bind(int(o["id"])));info.add_child(b)
		close_content.add_child(card)
	close_content.add_child(_label("ĐANG TRÊN ĐƯỜNG", 13, Color("285b7a")))
	if remote_shipments.is_empty(): close_content.add_child(_label("Không có đoàn hàng nào đang đi.", 11, Color("6a8ca0")))
	for o in remote_shipments:
		close_content.add_child(_wl("- %s · %s · %s · tới ngày %d%s" % [o["sect"], _remote_items_text(o["items"]), REMOTE_METHODS[str(o["method"])]["name"], int(o["arrive"]), " (sẽ trễ hạn)" if int(o["arrive"]) > int(o["deadline"]) else ""], 11, Color("36556b")))
	close_content.add_child(_label("UY TÍN TÔNG MÔN", 13, Color("285b7a")))
	for sect in REMOTE_SECTS:
		var r: = _rep(sect)
		var tier: = "đơn to hơn, thưởng +10%" if r >= 30 else "đơn thường"
		if r >= 60: tier = "đơn độc quyền, thưởng +20%"
		close_content.add_child(_wl("- %s · uy tín %d · %s" % [sect, r, tier], 10, Color("4e85a6") if r >= 0 else Color("d64545")))

func _wl(text: String, size: int, color: Color) -> Label:
	var l: = _label(text, size, color);l.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;l.size_flags_horizontal = Control.SIZE_EXPAND_FILL;return l

func _remote_card(o: Dictionary, border: Color, show_items: bool = true) -> PanelContainer:
	var card: = PanelContainer.new();card.add_theme_stylebox_override("panel", _box(Color("fbfdff"), border, 2, 12))
	var info: = VBoxContainer.new();info.add_theme_constant_override("separation", 3);card.add_child(info)
	info.add_child(_wl("%s%s" % [o["sect"], " · uy tín %d" % _rep(str(o["sect"]))], 12, Color("285b7a")))
	if show_items: info.add_child(_wl("Cần: " + _remote_items_text(o["items"]), 11, Color("36556b")))
	card.set_meta("info", info)
	return card


# ---------- Tu sửa: nâng cấp tiệm và bảo vật ----------
const UPGRADE_ORDER: Array[String] = ["expand", "counter", "vault", "roof", "sign", "refine_room", "beast_yard", "dock", "portal"]
const UPGRADES: Dictionary = {
	"expand": {"name": "Mở rộng gian hàng", "costs": [15000, 60000, 200000], "levels": [3, 6, 9], "desc": ["+1 ô bảo vật, hàng đợi 6 khách", "+1 ô bảo vật, hàng đợi 7 khách", "+1 ô bảo vật"], "con": "Mỗi bậc tiền thuê mặt bằng tăng 50%."},
	"counter": {"name": "Quầy thu ngân ngọc thạch", "costs": [8000, 30000, 90000], "levels": [1, 1, 1], "desc": ["Khách chờ thêm 3 giây", "Khách chờ thêm 5 giây", "Khách chờ thêm 8 giây"], "con": ""},
	"vault": {"name": "Linh khố trận pháp", "costs": [12000, 45000, 150000], "levels": [1, 1, 1], "desc": ["Hàng trong kho giữ linh khí thêm 1 ngày, kho rộng thêm 150 món", "Thêm 1 ngày nữa (tổng 2), kho rộng thêm 200 món", "Thêm 2 ngày nữa (tổng 4), kho rộng thêm 350 món"], "con": "Mỗi bậc tốn thêm 3% tiền thuê để duy trì trận."},
	"roof": {"name": "Mái ngói lưu ly", "costs": [10000, 40000, 120000], "levels": [1, 1, 1], "desc": ["Không bao giờ phải sửa mái", "20% đánh giá được +1 sao", "Động đất chỉ làm vỡ một nửa"], "con": ""},
	"sign": {"name": "Biển hiệu tiên môn", "costs": [6000, 25000, 80000], "levels": [1, 1, 1], "desc": ["Khách vào thêm 5%", "Khách vào thêm 10%", "Khách vào thêm 15%, biển không bị gió cuốn"], "con": ""},
	"refine_room": {"name": "Phòng tinh luyện riêng", "costs": [20000, 70000, 220000], "levels": [2, 2, 2], "desc": ["Vạch tinh luyện chạy chậm hơn 15%", "Chậm hơn 30%", "Chậm hơn 45%, tốn ít hơn 30% nguyên liệu"], "con": ""},
	"beast_yard": {"name": "Hậu viện linh thú", "costs": [50000, 150000, 400000], "levels": [8, 8, 8], "desc": ["Linh thú không sổng chuồng", "Linh thú lâu tiêu tán hơn 2 ngày", "Linh thú bán thêm 20% giá"], "con": ""},
	"portal": {"name": "Đài truyền tống", "costs": [25000, 90000, 260000], "levels": [4, 6, 9], "desc": ["Đoàn thám hiểm đi về nhanh hơn 1 ngày", "Thêm 1 đoàn thám hiểm cùng lúc", "Tỉ lệ thám hiểm thành công +5%"], "con": ""},
	"dock": {"name": "Bến phi xa", "costs": [30000, 100000, 300000], "levels": [5, 5, 5], "desc": ["Phí chở hàng truyền tin giảm 20%", "Thêm 1 đơn truyền tin cùng lúc", "Chở hàng nhanh hơn 1 ngày"], "con": ""},
}
const TREASURE_ORDER: Array[String] = ["incense", "lantern", "toad", "screen", "mirror", "seal", "earth_god", "tea_table", "chime", "painting", "bowl", "jade", "go_board", "fish_tank", "gourd", "qilin"]
const TREASURES: Dictionary = {
	"incense": {"name": "Lư hương trầm", "cost": 3000, "level": 1, "pro": "Khách chờ thêm 5 giây.", "con": "Mỗi ngày tốn 50 LT trầm."},
	"lantern": {"name": "Đèn lồng linh hỏa", "cost": 5000, "level": 2, "pro": "Sau 18:00 khách vào thêm 30%.", "con": "1/30 khả năng mỗi ngày cháy sém một kệ."},
	"toad": {"name": "Chiêu tài thiềm thừ", "cost": 8000, "level": 2, "pro": "Tip tăng 15%.", "con": "Không có tác dụng gì khác."},
	"screen": {"name": "Bình phong sơn thủy", "cost": 6000, "level": 3, "pro": "Giảm 50% khả năng có khách quậy phá.", "con": "Không giúp bán hàng."},
	"seal": {"name": "Ấn tín quan phủ", "cost": 20000, "level": 5, "pro": "Thuế thương khóa giảm 10%.", "con": "Quan phủ hay ghé tiệm kiểm định giá hơn."},
	"mirror": {"name": "Gương bát quái", "cost": 9000, "level": 3, "pro": "Chặn trộm đêm.", "con": "Khách VIP kiêng gương: cứ 3 ngày bớt 1 lượt VIP."},
	"earth_god": {"name": "Tượng Thổ Địa", "cost": 12000, "level": 4, "pro": "Giảm 30% khả năng có sự cố đầu ngày.", "con": "Cuối ngày cúng 1% doanh thu."},
	"tea_table": {"name": "Bàn trà tiếp khách", "cost": 10000, "level": 4, "pro": "Khách VIP tip thêm 30%, chấm thêm 1 sao.", "con": "Khách thường chờ ít hơn 2 giây."},
	"chime": {"name": "Chuông gió linh ngọc", "cost": 15000, "level": 5, "pro": "Khách quậy phá chỉ làm đổ 1 món.", "con": "Không có."},
	"painting": {"name": "Tranh Tổ sư khai môn", "cost": 25000, "level": 5, "pro": "20% đánh giá được +1 sao.", "con": "Giá cao, không có lợi gì khác."},
	"bowl": {"name": "Tụ Bảo Bồn", "cost": 30000, "level": 6, "pro": "Cuối ngày thường được thêm 1–3% doanh thu.", "con": "1/20 khả năng vỡ bồn, mất 2% doanh thu."},
	"jade": {"name": "Linh Ngọc Chiếu Minh", "cost": 20000, "level": 6, "pro": "Tin tức thành trì đúng thêm 10%.", "con": "Không cộng dồn với thầy bói."},
	"go_board": {"name": "Bàn cờ Thiên Nguyên", "cost": 18000, "level": 8, "pro": "Có trưởng lão: thêm 1 lượt VIP nữa mỗi ngày.", "con": "Chỉ có tác dụng khi đã thuê trưởng lão."},
	"fish_tank": {"name": "Bể cá Nguyệt Quang", "cost": 22000, "level": 11, "pro": "Trứng Nguyệt Quang Ngư bán thêm 50% giá.", "con": "Mỗi ngày tốn 100 LT thức ăn."},
	"gourd": {"name": "Hồ lô thu yêu", "cost": 8000, "level": 7, "pro": "Lần tới có sự cố đầu ngày: bắt được yêu thú, +5.000 LT thay vì mất.", "con": "Dùng một lần rồi vỡ."},
	"qilin": {"name": "Kỳ lân trấn trạch", "cost": 120000, "level": 10, "pro": "Chặn trộm, khách quậy phá và động đất.", "con": "Đắt nhất, chiếm 2 ô."},
}
var shop_up: Dictionary = {}
var treasures_owned: Array = []
var treasures_placed: Array = []

func _up(key: String) -> int:
	return int(shop_up.get(key, 0))

func _tr(key: String) -> bool:
	return treasures_placed.has(key)

func _treasure_slots() -> int:
	return 3 + _up("expand")

func _slots_used() -> int:
	var n: = 0
	for k in treasures_placed: n += 2 if k == "qilin" else 1
	return n

func _queue_cap() -> int:
	return 5 + mini(_up("expand"), 2)

func _daily_rent() -> int:
	return int(round(DAILY_RENT * (1.0 + 0.5 * _up("expand") + 0.03 * _up("vault"))))

func _patience_bonus(vip: bool) -> float:
	var b: float = float([0.0, 3.0, 5.0, 8.0][_up("counter")])
	if not _festival_today().is_empty(): b += float(_festival_today()["patience"])
	if _tr("incense"): b += 5.0
	if _tr("tea_table") and not vip: b -= 2.0
	if weather_today == "nang": b -= 3.0
	return b

func _review_bonus(stars: int, vip: bool) -> int:
	var s2: = stars
	if _up("roof") >= 2 and randf() < 0.2: s2 += 1
	if _tr("painting") and randf() < 0.2: s2 += 1
	if _tr("tea_table") and vip: s2 += 1
	return clampi(s2, 1, 5)

func _buy_upgrade(key: String) -> void:
	var tier: = _up(key)
	if tier >= 3: return
	var info: Dictionary = UPGRADES[key]
	var cost: int = int(info["costs"][tier])
	if level < int(info["levels"][tier]): _show_toast("Mở ở level %d." % int(info["levels"][tier]));return
	if money < cost: _show_toast("Cần %s LT." % _fmt_thousands(cost));return
	money -= cost;_log_expense("Nâng cấp %s bậc %d" % [info["name"], tier + 1], cost)
	shop_up[key] = tier + 1
	if key == "roof": incident_state["roof_damaged"] = false
	if key == "sign" and tier + 1 >= 3 and bool(incident_state.get("sign_lost", false)):
		incident_state["sign_lost"] = false
		if is_instance_valid(level_sign_display): level_sign_display.visible = true
	_sfx("unlock");_update_money_display();_show_toast("Đã nâng %s lên bậc %d." % [info["name"], tier + 1]);_show_upgrades()

func _buy_treasure(key: String) -> void:
	if treasures_owned.has(key): return
	var info: Dictionary = TREASURES[key]
	if level < int(info["level"]): _show_toast("Mở ở level %d." % int(info["level"]));return
	if money < int(info["cost"]): _show_toast("Cần %s LT." % _fmt_thousands(int(info["cost"])));return
	money -= int(info["cost"]);_log_expense("Mua bảo vật %s" % info["name"], int(info["cost"]))
	treasures_owned.append(key)
	if _slots_used() + (2 if key == "qilin" else 1) <= _treasure_slots(): treasures_placed.append(key)
	_sfx("unlock");_update_money_display();_show_toast("Đã mua %s." % info["name"]);_show_upgrades()

func _toggle_treasure(key: String) -> void:
	if treasures_placed.has(key): treasures_placed.erase(key)
	else:
		if _slots_used() + (2 if key == "qilin" else 1) > _treasure_slots(): _show_toast("Hết ô bày bảo vật. Cất bớt một món trước.");return
		treasures_placed.append(key)
	_show_upgrades()

func _sell_treasure(key: String) -> void:
	if not treasures_owned.has(key): return
	var back: = int(int(TREASURES[key]["cost"]) / 2)
	treasures_owned.erase(key);treasures_placed.erase(key)
	money += back
	_show_toast("Đã bán %s, thu về %s LT." % [TREASURES[key]["name"], _fmt_thousands(back)])
	_update_money_display();_show_upgrades()

func _show_upgrades() -> void:
	if close_content == null: return
	active_close_tab = "upgrade"
	if _use_tab_page("upgrade"): return
	call_deferred("_wrap_close_labels")
	close_content.add_child(_section_heading("res://assets/boutique/ui_icons/icon_upgrade.png", "TU SỬA · Nâng cấp tiệm và bày bảo vật", 12))
	close_content.add_child(_label("NÂNG CẤP TIỆM", 13, Color("285b7a")))
	for key in UPGRADE_ORDER:
		var info: Dictionary = UPGRADES[key]
		var tier: = _up(key)
		var card: = PanelContainer.new();card.add_theme_stylebox_override("panel", _box(Color("fbfdff"), Color("6cbf8b") if tier >= 3 else Color("a6d8ee"), 2, 12))
		var row: = HBoxContainer.new();row.add_theme_constant_override("separation", 8);card.add_child(row)
		var col: = VBoxContainer.new();col.size_flags_horizontal = Control.SIZE_EXPAND_FILL;col.add_theme_constant_override("separation", 1);row.add_child(col)
		col.add_child(_wl("%s · bậc %d/3" % [info["name"], tier], 12, Color("285b7a")))
		# Chỉ hiện bậc sắp nâng.
		if tier < 3: col.add_child(_wl("Bậc %d: %s" % [tier + 1, info["desc"][tier]], 10, Color("4e85a6")))
		else: col.add_child(_wl("Đã nâng tối đa.", 10, Color("2e8a57")))
		if str(info["con"]) != "": col.add_child(_wl("Khuyết: " + str(info["con"]), 10, Color("c0583f")))
		var b: Button
		if tier >= 3:
			b = _button("TỐI ĐA", 9);b.disabled = true
		else:
			var cost: int = int(info["costs"][tier]);var need: int = int(info["levels"][tier])
			b = _button(("Lên bậc %d\n%s LT" % [tier + 1, _fmt_thousands(cost)]) if level >= need else ("Mở ở\nlevel %d" % need), 9)
			b.disabled = level < need or money < cost
			b.pressed.connect(_buy_upgrade.bind(key))
		b.custom_minimum_size = Vector2(92, 54);row.add_child(b)
		close_content.add_child(card)
	close_content.add_child(_wl("BẢO VẬT · đang bày %d/%d ô" % [_slots_used(), _treasure_slots()], 13, Color("285b7a")))
	close_content.add_child(_wl("Bảo vật chỉ có tác dụng khi đang bày. Bán lại được một nửa giá.", 10, Color("6a8ca0")))
	for key in TREASURE_ORDER:
		var info2: Dictionary = TREASURES[key]
		var owned: = treasures_owned.has(key)
		var placed: = treasures_placed.has(key)
		var card2: = PanelContainer.new();card2.add_theme_stylebox_override("panel", _box(Color("eaf7ee") if placed else Color("fbfdff"), Color("6cbf8b") if placed else Color("a6d8ee"), 2, 12))
		var row2: = HBoxContainer.new();row2.add_theme_constant_override("separation", 8);card2.add_child(row2)
		var col2: = VBoxContainer.new();col2.size_flags_horizontal = Control.SIZE_EXPAND_FILL;col2.add_theme_constant_override("separation", 1);row2.add_child(col2)
		col2.add_child(_wl("%s%s" % [info2["name"], " · ĐANG BÀY" if placed else (" · trong kho" if owned else "")], 12, Color("285b7a")))
		col2.add_child(_wl("Ưu: " + str(info2["pro"]), 10, Color("2e8a57")))
		col2.add_child(_wl("Khuyết: " + str(info2["con"]), 10, Color("c0583f")))
		var btns: = VBoxContainer.new();btns.add_theme_constant_override("separation", 3);row2.add_child(btns)
		if owned:
			var pb: = _button("Cất đi" if placed else "Bày ra", 9);pb.custom_minimum_size = Vector2(92, 30);pb.pressed.connect(_toggle_treasure.bind(key));btns.add_child(pb)
			var sb: = _button("Bán %s" % _fmt_thousands(int(int(info2["cost"]) / 2)), 9);sb.custom_minimum_size = Vector2(92, 30);sb.pressed.connect(_sell_treasure.bind(key));btns.add_child(sb)
		else:
			var lv: = int(info2["level"])
			var bb: = _button(("Mua\n%s LT" % _fmt_thousands(int(info2["cost"]))) if level >= lv else ("Mở ở\nlevel %d" % lv), 9);bb.custom_minimum_size = Vector2(92, 54)
			bb.disabled = level < lv or money < int(info2["cost"])
			bb.pressed.connect(_buy_treasure.bind(key));btns.add_child(bb)
		close_content.add_child(card2)

# Đầu ngày: chi phí duy trì + sự cố của bảo vật
func _upgrades_new_day() -> void:
	if _tr("incense"): _pay(50, "trầm cho lư hương")
	if _tr("fish_tank"): _pay(100, "thức ăn bể cá Nguyệt Quang")
	if _tr("mirror") and day_number % 3 == 0: vip_limit_today = maxi(0, vip_limit_today - 1)
	if _tr("go_board") and _has("elder"): vip_limit_today += 1
	if _tr("lantern") and randf() < 1.0 / 30.0:
		var stocked: Array[int] = []
		for i in range(shelves.size()):
			if int(shelves[i].get("product", -1)) >= 0 and int(shelves[i].get("stock", 0)) > 0: stocked.append(i)
		if not stocked.is_empty():
			var idx: int = stocked.pick_random();var pid: = int(shelves[idx]["product"])
			var lost: = _lose_from_shelf(shelves[idx], maxi(1, roundi(int(shelves[idx]["stock"]) * 0.2)))
			_log_goods_loss("đèn lồng cháy sém", pid, lost)
			_incident_push("ĐÈN LỒNG BÉN LỬA", "Đèn lồng linh hỏa rơi tàn lửa, cháy sém kệ %d, mất %d %s." % [idx + 1, lost, products[pid]["name"]])

func _upgrades_end_day() -> void:
	if _tr("earth_god") and revenue_today > 0: _pay(maxi(1, roundi(revenue_today * 0.01)), "cúng Thổ Địa")
	if _tr("bowl") and revenue_today > 0:
		if randf() < 0.05: _pay(maxi(1, roundi(revenue_today * 0.02)), "Tụ Bảo Bồn vỡ")
		else:
			var gain: = maxi(1, roundi(revenue_today * randf_range(0.01, 0.03)))
			money += gain;store_tips += gain
			_show_toast("Tụ Bảo Bồn sinh tài lộc · +%s LT." % _fmt_thousands(gain))


# ---------- Thám hiểm: môn khách đi bí cảnh, rừng yêu thú lấy nguyên liệu ----------
const EXPLORE_MIN_LEVEL: = 4
const EXPLORE_ORDER: Array[String] = ["green_forest", "black_wind", "ice_lake", "fire_mountain", "beast_forest", "ancient"]
const EXPLORE_LOCS: Dictionary = {
	"green_forest": {"name": "Rừng Thanh Mộc", "level": 4, "days": 1, "danger": 1, "base": 2, "hint": "Thảo dược, linh mộc cho đan dược Hạ/Trung phẩm."},
	"black_wind": {"name": "Hắc Phong Sơn Cốc", "level": 5, "days": 2, "danger": 2, "base": 2, "hint": "Khoáng thạch, yêu cốt cho pháp khí và trận đồ."},
	"ice_lake": {"name": "Hàn Băng Hồ", "level": 6, "days": 2, "danger": 2, "base": 2, "hint": "Băng tinh, huyền thủy cho phù triện."},
	"fire_mountain": {"name": "Hỏa Diệm Sơn", "level": 7, "days": 3, "danger": 3, "base": 3, "hint": "Hỏa tinh, xích huyết cho đan Thượng phẩm và phi xa. Nên mang phù băng."},
	"beast_forest": {"name": "Vạn Yêu Lâm", "level": 8, "days": 3, "danger": 3, "base": 3, "hint": "Yêu đan, lông vũ linh cầm, trứng hoang cho linh thú."},
	"ancient": {"name": "Bí cảnh Thượng Cổ", "level": 10, "days": 4, "danger": 4, "base": 3, "hint": "Nguyên liệu hiếm cho món LV10–12. Chỉ mở khi Tin tức thành trì báo."},
}
const REALM_NAMES: Array[String] = ["", "Luyện Khí", "Trúc Cơ", "Kim Đan", "Nguyên Anh"]
const ADV_ORDER: Array[String] = ["luu_dai", "ha_lan", "tieu_dao", "moc_ho", "huyen_co", "huyet_anh", "bach_cot"]
const ADVENTURERS: Dictionary = {
	"luu_dai": {"name": "Tán tu Lưu Đại", "realm": 1, "fee": 300, "pro": "Rẻ.", "con": "Dễ bị thương, nhặt ít.", "portrait": "res://assets/boutique/staff/staff_male.png"},
	"ha_lan": {"name": "Dược nữ Hạ Lan", "realm": 2, "fee": 800, "pro": "Rừng Thanh Mộc và Hàn Băng Hồ nhặt thêm 50%.", "con": "Yếu khi đánh nhau, dễ bị thương hơn.", "portrait": "res://assets/boutique/staff/staff_female.png"},
	"tieu_dao": {"name": "Kiếm khách Tiêu Dao", "realm": 2, "fee": 1000, "pro": "Ít bị thương, đánh được yêu thú lớn.", "con": "Hay làm nát thảo dược: ở Rừng Thanh Mộc nhặt ít đi.", "portrait": "res://assets/boutique/staff/staff_male.png"},
	"moc_ho": {"name": "Thợ săn Mộc Hổ", "realm": 2, "fee": 900, "pro": "Vạn Yêu Lâm và Hắc Phong Sơn Cốc nhặt gấp đôi.", "con": "Ở Hàn Băng Hồ không nhặt được gì.", "portrait": "res://assets/boutique/staff/staff_male.png"},
	"huyen_co": {"name": "Đạo sĩ Huyền Cơ", "realm": 3, "fee": 2500, "pro": "Mở rương bí cảnh: thêm 1 nguyên liệu, tăng tỉ lệ thành công.", "con": "Chậm: chuyến đi lâu hơn 1 ngày.", "portrait": "res://assets/boutique/staff/staff_manager.png"},
	"huyet_anh": {"name": "Ma tu Huyết Ảnh", "realm": 3, "fee": 1800, "pro": "Liều mạng: nguyên liệu gấp 1,5 lần.", "con": "15% khả năng ôm hết đồ bỏ trốn.", "portrait": "res://assets/boutique/staff/staff_manager.png"},
	"bach_cot": {"name": "Lão quái Bạch Cốt", "realm": 4, "fee": 8000, "pro": "Mạnh nhất, gần như không thất bại, không bị thương.", "con": "Rất đắt, mỗi tuần chỉ nhận 1 chuyến.", "portrait": "res://assets/boutique/staff/staff_manager.png"},
}
var expeditions: Array = []
var adv_state: Dictionary = {}
var explore_serial: int = 0
var ancient_window: Array = []
var explore_draft: Dictionary = {"loc": "", "members": [], "gear": {}}
var _loot_cache: Dictionary = {}

func _explore_max() -> int:
	return 2 + (1 if _up("portal") >= 2 else 0)

func _loc_materials(loc: String) -> Array:
	if _loot_cache.has(loc): return _loot_cache[loc]
	var out: Array = []
	for i in range(products.size()):
		var p: Dictionary = products[i]
		var cat: = _cat(i);var g: = _product_refining_grade(p);var lv: = int(p.get("unlock_level", 1))
		var where: Array[String] = []
		if lv >= 10: where.append("ancient")
		if cat == "linh thú": where.append("beast_forest")
		elif cat == "phi xa": where.append("fire_mountain")
		elif cat == "đan dược": where.append("fire_mountain" if g == "Thượng phẩm" else "green_forest")
		elif cat in ["pháp khí", "trận đồ"]: where.append("black_wind")
		elif cat == "phù triện": where.append("ice_lake")
		if not where.has(loc): continue
		for entry in _recipe_for(i):
			if not out.has(str(entry["name"])): out.append(str(entry["name"]))
	_loot_cache[loc] = out
	return out

func _adv(key: String) -> Dictionary:
	if not adv_state.has(key): adv_state[key] = {"rest_until": 0, "favor": 0, "last_trip": -99}
	return adv_state[key]

func _adv_busy(key: String) -> String:
	for e in expeditions:
		if (e["members"] as Array).has(key): return "đang đi"
	var st: = _adv(key)
	if int(st["rest_until"]) > day_number: return "dưỡng thương tới ngày %d" % int(st["rest_until"])
	if key == "bach_cot" and day_number - int(st["last_trip"]) < 7: return "nghỉ tới ngày %d" % (int(st["last_trip"]) + 7)
	return ""

func _adv_fee(key: String) -> int:
	var favor: = clampi(int(_adv(key)["favor"]), 0, 50)
	return int(round(int(ADVENTURERS[key]["fee"]) * (1.0 - favor / 100.0)))

func _loc_open(loc: String) -> String:
	var info: Dictionary = EXPLORE_LOCS[loc]
	if level < int(info["level"]): return "mở ở level %d" % int(info["level"])
	if loc == "ancient":
		if ancient_window.size() < 2 or day_number < int(ancient_window[0]) or day_number > int(ancient_window[1]): return "chưa mở, chờ tin"
	return ""

func _gear_items() -> Array:
	var out: Array = []
	for i in range(products.size()):
		if _units_available(i) > 0 and _gear_used_count(i) < _units_available(i): out.append(i)
	return out

func _gear_used_count(pid: int) -> int:
	var n: = 0
	for m in explore_draft["gear"].keys():
		for g in explore_draft["gear"][m]:
			if int(g) == pid: n += 1
	return n

func _draft_power() -> Dictionary:
	var loc: String = str(explore_draft["loc"])
	var members: Array = explore_draft["members"]
	var res: = {"power": 0.0, "danger": 0, "chance": 0.0, "days": 0, "fee": 0, "max_realm": 0}
	if loc.is_empty() or members.is_empty(): return res
	var info: Dictionary = EXPLORE_LOCS[loc]
	var power: = 0.0;var max_realm: = 0;var fee: = 0
	var days: = int(info["days"])
	for m in members:
		var r: = int(ADVENTURERS[m]["realm"]);power += r;max_realm = maxi(max_realm, r);fee += _adv_fee(m)
		for g in explore_draft["gear"].get(m, []):
			var c: = _cat(int(g))
			if c == "pháp khí": power += 1.0
			elif c == "phù triện": power += 0.5
			elif c == "trận đồ": power += 0.5
	if members.has("huyen_co"): days += 1;power += 1.0
	if _draft_has_cat("phi xa") or _draft_has_name("Thần Hành Phù"): days -= 1
	if _up("portal") >= 1: days -= 1
	days = maxi(1, days)
	var chance: = clampf(0.55 + 0.12 * (power - int(info["danger"]) * 1.5), 0.15, 0.95)
	if members.has("bach_cot"): chance = 0.97
	if _up("portal") >= 3: chance = minf(0.98, chance + 0.05)
	res["power"] = power;res["danger"] = int(info["danger"]);res["chance"] = chance;res["days"] = days;res["fee"] = fee;res["max_realm"] = max_realm
	return res

func _draft_has_cat(c: String) -> bool:
	for m in explore_draft["gear"].keys():
		for g in explore_draft["gear"][m]:
			if _cat(int(g)) == c: return true
	return false

func _draft_has_name(n: String) -> bool:
	for m in explore_draft["gear"].keys():
		for g in explore_draft["gear"][m]:
			if str(products[int(g)]["name"]) == n: return true
	return false

func _explore_pick_loc(loc: String) -> void:
	explore_draft["loc"] = loc;_touch_explore()

func _explore_toggle_member(key: String) -> void:
	var members: Array = explore_draft["members"]
	if members.has(key):
		members.erase(key);explore_draft["gear"].erase(key)
	elif members.size() < 3: members.append(key)
	else: _show_toast("Mỗi đoàn tối đa 3 môn khách.")
	_touch_explore()

func _explore_add_gear(key: String, pid: int) -> void:
	var g: Array = explore_draft["gear"].get(key, [])
	if g.size() >= 3: _show_toast("Mỗi môn khách mang tối đa 3 trang bị.");return
	g.append(pid);explore_draft["gear"][key] = g;_touch_explore()

func _explore_remove_gear(key: String, index: int) -> void:
	var g: Array = explore_draft["gear"].get(key, [])
	if index < g.size(): g.remove_at(index)
	explore_draft["gear"][key] = g;_touch_explore()

func _touch_explore() -> void:
	tab_sigs.erase("explore")
	_show_explore()

func _take_any_unit(pid: int) -> bool:
	if not _take_inventory_units(pid, 1).is_empty(): return true
	for shelf in shelves:
		if int(shelf.get("product", -1)) == pid and int(shelf.get("stock", 0)) > 0:
			return _lose_from_shelf(shelf, 1) > 0
	return false

func _explore_depart() -> void:
	var loc: String = str(explore_draft["loc"])
	var members: Array = explore_draft["members"]
	if loc.is_empty() or members.is_empty(): return
	if expeditions.size() >= _explore_max(): _show_toast("Đã có %d đoàn đang đi." % _explore_max());return
	var why: = _loc_open(loc)
	if not why.is_empty(): _show_toast(why);return
	var pw: = _draft_power()
	if int(pw["max_realm"]) < int(pw["danger"]): _show_toast("Cần ít nhất một môn khách cảnh giới %s trở lên." % REALM_NAMES[int(pw["danger"])]);return
	if money < int(pw["fee"]): _show_toast("Cần %s LT phí thuê." % _fmt_thousands(int(pw["fee"])));return
	for m in members:
		if not _adv_busy(m).is_empty(): _show_toast("%s %s." % [ADVENTURERS[m]["name"], _adv_busy(m)]);return
	# Lấy trang bị khỏi kho/kệ
	var gear: Dictionary = {}
	for m in members:
		var taken: Array = []
		for g in explore_draft["gear"].get(m, []):
			if _take_any_unit(int(g)): taken.append(int(g))
		gear[m] = taken
	money -= int(pw["fee"])
	_log_expense("Thuê môn khách đi %s" % EXPLORE_LOCS[loc]["name"], int(pw["fee"]))
	explore_serial += 1
	expeditions.append({"id": explore_serial, "loc": loc, "members": members.duplicate(), "gear": gear, "return_day": day_number + int(pw["days"]), "chance": float(pw["chance"])})
	for m in members:
		if m == "bach_cot": _adv(m)["last_trip"] = day_number
	explore_draft = {"loc": "", "members": [], "gear": {}}
	_sfx("deliver");_update_money_display()
	_show_toast("Đoàn thám hiểm đã lên đường tới %s, về vào ngày %d." % [EXPLORE_LOCS[loc]["name"], day_number + int(pw["days"])])
	_touch_explore()

# Đầu ngày mới
func _explore_new_day() -> void:
	if level >= 10 and (ancient_window.size() < 2 or day_number > int(ancient_window[1])) and randf() < 0.15:
		ancient_window = [day_number + 2, day_number + 4]
		_incident_push("BÍ CẢNH THƯỢNG CỔ SẮP MỞ", "Tin tức thành trì: Bí cảnh Thượng Cổ sẽ mở từ ngày %d đến hết ngày %d. Chuẩn bị môn khách cảnh giới Nguyên Anh và trang bị tốt." % [int(ancient_window[0]), int(ancient_window[1])])
	var still: Array = []
	for e in expeditions:
		if int(e["return_day"]) > day_number: still.append(e)
		else: _expedition_return(e)
	expeditions = still

func _expedition_return(e: Dictionary) -> void:
	if randf() < 0.4:
		var ev: = randi_range(0, 2)
		var title: = "ĐOÀN THÁM HIỂM GẶP CHUYỆN"
		if ev == 0:
			_incident_push(title, "Trên đường về, đoàn ở %s gặp một con yêu thú non bị thương." % EXPLORE_LOCS[e["loc"]]["name"], [["CỨU NÓ · nhận 1 linh thú, ít nguyên liệu hơn", _expedition_finish.bind(e, "rescue")], ["GIẾT LẤY YÊU ĐAN · thêm nguyên liệu", _expedition_finish.bind(e, "kill")]])
		elif ev == 1:
			_incident_push(title, "Một đoàn tán tu khác cùng tranh một gốc linh dược ở %s." % EXPLORE_LOCS[e["loc"]]["name"], [["ĐÁNH · được hết nếu thắng, dễ bị thương", _expedition_finish.bind(e, "fight")], ["CHIA ĐÔI · an toàn", _expedition_finish.bind(e, "share")]])
		else:
			_incident_push(title, "Đoàn phát hiện một rương cổ ở %s, có thể có bẫy." % EXPLORE_LOCS[e["loc"]]["name"], [["MỞ NGAY · may thì thêm đồ hiếm, xui thì bị thương", _expedition_finish.bind(e, "open")], ["BỎ QUA", _expedition_finish.bind(e, "")]])
	else:
		_expedition_finish(e, "")

func _expedition_finish(e: Dictionary, choice: String) -> void:
	var loc: String = str(e["loc"]);var info: Dictionary = EXPLORE_LOCS[loc]
	var members: Array = e["members"];var gear: Dictionary = e["gear"]
	var chance: = float(e["chance"])
	if choice == "fight": chance -= 0.1
	var roll: = randf()
	var great: = roll < chance * 0.10 + (0.1 if choice == "open" and randf() < 0.5 else 0.0)
	var success: = roll < chance
	var lines: PackedStringArray = []
	# Số nguyên liệu
	var count: = float(int(info["base"]) + members.size())
	for m in members:
		if m == "luu_dai": count -= 0.5
		if m == "ha_lan" and loc in ["green_forest", "ice_lake"]: count *= 1.5
		if m == "tieu_dao" and loc == "green_forest": count *= 0.7
		if m == "tieu_dao" and int(info["danger"]) >= 2: count += 1
		if m == "moc_ho" and loc in ["beast_forest", "black_wind"]: count *= 2.0
		if m == "moc_ho" and loc == "ice_lake": count -= 1
		if m == "huyen_co": count += 1
		if m == "huyet_anh": count *= 1.5
	var has_formation: = false;var has_vehicle: = false;var has_beast: = false
	for m in members:
		for g in gear.get(m, []):
			var c: = _cat(int(g))
			if c == "trận đồ": has_formation = true
			if c == "phi xa": has_vehicle = true
			if c == "linh thú": has_beast = true
	if has_formation: count *= 1.2
	if has_vehicle: count *= 1.5
	if choice == "kill": count += 2
	if choice == "rescue": count -= 1
	if choice == "share": count *= 0.6
	if not success: count = count * 0.5 if randf() < 0.5 else 0.0
	if great: count += 2
	var n: = maxi(0, int(round(count)))
	var pool: = _loc_materials(loc)
	var got: Dictionary = {}
	if not pool.is_empty():
		for _i in range(n):
			var mat: String = pool.pick_random();got[mat] = int(got.get(mat, 0)) + 1
		if has_beast and success:
			var mat2: String = pool.pick_random();got[mat2] = int(got.get(mat2, 0)) + 1
	# Ma tu bỏ trốn
	if members.has("huyet_anh") and randf() < 0.15:
		got.clear()
		lines.append("Ma tu Huyết Ảnh ôm hết nguyên liệu và trang bị của hắn bỏ trốn!")
		gear["huyet_anh"] = []
	for mat in got.keys(): material_stock[mat] = int(material_stock.get(mat, 0)) + int(got[mat])
	var got_parts: PackedStringArray = []
	for mat in got.keys(): got_parts.append("%s ×%d" % [mat, int(got[mat])])
	var head: = "THÀNH CÔNG LỚN" if great else ("Thành công" if success else "Thất bại")
	_stat_add("trips")
	if great: _stat_add("great_trips")
	if loc == "ancient" and success: _stat_add("ancient")
	lines.insert(0, "%s ở %s.\nThu được: %s" % [head, info["name"], ", ".join(got_parts) if not got_parts.is_empty() else "không có gì"])
	# Thành công lớn: nhặt được một món bày bán
	if great:
		var cands: Array = []
		for i in range(products.size()):
			if _product_refining_grade(products[i]) != "Hạ phẩm" and int(products[i].get("unlock_level", 1)) <= level + 2: cands.append(i)
		if not cands.is_empty():
			var pid: int = cands.pick_random();var p: Dictionary = products[pid]
			var ages: = _normalize_stock_ages(p.get("stock_ages", []), int(p.get("stock", 0)));ages.append(0);p["stock_ages"] = ages;p["stock"] = ages.size()
			lines.append("Nhặt được 1 %s mang về linh khố." % p["name"])
	if choice == "rescue":
		var beasts: Array = []
		for i in range(products.size()):
			if _cat(i) == "linh thú" and int(products[i].get("unlock_level", 1)) <= level + 3: beasts.append(i)
		if not beasts.is_empty():
			var bp: int = beasts.pick_random();var b: Dictionary = products[bp]
			var ages2: = _normalize_stock_ages(b.get("stock_ages", []), int(b.get("stock", 0)));ages2.append(0);b["stock_ages"] = ages2;b["stock"] = ages2.size()
			lines.append("Yêu thú non được cứu theo về: thêm 1 %s." % b["name"])
	# Bị thương
	var pill_count: = 0;var shield: = false
	for m in members:
		for g in gear.get(m, []):
			if _cat(int(g)) == "đan dược": pill_count += 1
			if str(products[int(g)]["name"]) == "Kim Cương Hộ Thân Phù": shield = true
	for m in members:
		var inj: = 0.08 * int(info["danger"]) - 0.15 * pill_count + (0.05 if not success else 0.0)
		if m == "luu_dai" or m == "ha_lan": inj += 0.1
		if m == "tieu_dao": inj *= 0.5
		if m == "bach_cot": inj = 0.0
		if choice == "fight": inj += 0.15
		if choice == "open" and not great: inj += 0.1
		if randf() < maxf(0.02 if m != "bach_cot" else 0.0, inj):
			if shield:
				shield = false;lines.append("Kim Cương Hộ Thân Phù đỡ một đòn cho %s." % ADVENTURERS[m]["name"]);continue
			var st: = _adv(m);st["rest_until"] = day_number + randi_range(2, 3);st["favor"] = int(st["favor"]) - 5
			var med: = 200 * int(info["danger"])
			_pay(med, "thuốc cho %s bị thương" % ADVENTURERS[m]["name"])
			lines.append("%s bị thương, dưỡng thương tới ngày %d (tiền thuốc %s LT)." % [ADVENTURERS[m]["name"], int(st["rest_until"]), _fmt_thousands(med)])
		elif success:
			var st2: = _adv(m);st2["favor"] = int(st2["favor"]) + 5
			if int(st2["favor"]) >= 30 and randf() < 0.3 and not pool.is_empty():
				var gift: String = pool.pick_random();material_stock[gift] = int(material_stock.get(gift, 0)) + 1
				lines.append("%s quý tiên môn, tặng thêm 1 %s." % [ADVENTURERS[m]["name"], gift])
	# Trang bị mang về
	var back: PackedStringArray = [];var broke: PackedStringArray = []
	for m in members:
		for g in gear.get(m, []):
			var pid2: = int(g);var c2: = _cat(pid2)
			if c2 in ["đan dược", "phù triện"]: continue
			var br: float = {"pháp khí": 0.2, "trận đồ": 0.3, "phi xa": 0.1, "linh thú": 0.0}.get(c2, 0.2)
			if randf() < float(br): broke.append(str(products[pid2]["name"]));continue
			var p2: Dictionary = products[pid2]
			var ages3: = _normalize_stock_ages(p2.get("stock_ages", []), int(p2.get("stock", 0)));ages3.append(0);p2["stock_ages"] = ages3;p2["stock"] = ages3.size()
			back.append(str(p2["name"]))
	if not back.is_empty(): lines.append("Trang bị mang về kho: " + ", ".join(back) + ".")
	if not broke.is_empty(): lines.append("Trang bị hỏng: " + ", ".join(broke) + ".")
	_incident_push("ĐOÀN THÁM HIỂM TRỞ VỀ", "\n".join(lines))
	tab_sigs.erase("explore")

func _show_explore() -> void:
	if close_content == null: return
	active_close_tab = "explore"
	if _use_tab_page("explore"): return
	call_deferred("_wrap_close_labels")
	close_content.add_child(_section_heading("res://assets/boutique/ui_icons/icon_explore.png", "THÁM HIỂM · Thuê môn khách đi lấy nguyên liệu", 12))
	if level < EXPLORE_MIN_LEVEL:
		close_content.add_child(_wl("Mở từ level %d." % EXPLORE_MIN_LEVEL, 12, Color("6a8ca0")));return
	close_content.add_child(_wl("Đang có %d/%d đoàn đi. Trang bị lấy từ kho và kệ: đan dược và phù triện dùng hết, pháp khí, trận đồ, phi xa có thể hỏng, linh thú mang về." % [expeditions.size(), _explore_max()], 10, Color("c9558b")))
	# Chọn nơi
	close_content.add_child(_label("1 · CHỌN NƠI", 13, Color("285b7a")))
	for loc in EXPLORE_ORDER:
		var info: Dictionary = EXPLORE_LOCS[loc]
		var why: = _loc_open(loc)
		var picked: = str(explore_draft["loc"]) == loc
		var text: = "%s%s · %d ngày · nguy hiểm %s\n%s" % ["▶ " if picked else "", info["name"], int(info["days"]), "*".repeat(int(info["danger"])), info["hint"] if why.is_empty() else "(" + why + ")"]
		var b: = _button(text, 9);b.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;b.custom_minimum_size = Vector2(0, 52)
		if picked: b.add_theme_stylebox_override("normal", _box(Color("fde6ef"), Color("d979a6"), 2, 12))
		b.disabled = not why.is_empty();b.pressed.connect(_explore_pick_loc.bind(loc));close_content.add_child(b)
	# Chọn môn khách
	close_content.add_child(_label("2 · CHỌN MÔN KHÁCH (tối đa 3)", 13, Color("285b7a")))
	var members: Array = explore_draft["members"]
	for key in ADV_ORDER:
		var a: Dictionary = ADVENTURERS[key]
		var busy: = _adv_busy(key)
		var sel: = members.has(key)
		var card: = PanelContainer.new();card.add_theme_stylebox_override("panel", _box(Color("eaf7ee") if sel else Color("fbfdff"), Color("6cbf8b") if sel else Color("a6d8ee"), 2, 12))
		var row: = HBoxContainer.new();row.add_theme_constant_override("separation", 8);card.add_child(row)
		row.add_child(_staff_icon(str(a["portrait"]), Vector2(48, 48)))
		var col: = VBoxContainer.new();col.size_flags_horizontal = Control.SIZE_EXPAND_FILL;col.add_theme_constant_override("separation", 1);row.add_child(col)
		col.add_child(_wl("%s · %s · hảo cảm %d" % [a["name"], REALM_NAMES[int(a["realm"])], int(_adv(key)["favor"])], 11, Color("285b7a")))
		col.add_child(_wl("Ưu: " + str(a["pro"]), 10, Color("2e8a57")))
		col.add_child(_wl("Khuyết: " + str(a["con"]), 10, Color("c0583f")))
		col.add_child(_wl(("Phí %s LT/chuyến" % _fmt_thousands(_adv_fee(key))) + ((" · " + busy) if not busy.is_empty() else ""), 10, Color("4e85a6")))
		var mb: = _button("Bỏ chọn" if sel else "Chọn", 9);mb.custom_minimum_size = Vector2(76, 44);mb.disabled = not busy.is_empty() and not sel
		mb.pressed.connect(_explore_toggle_member.bind(key));row.add_child(mb)
		close_content.add_child(card)
		# Trang bị cho người đã chọn
		if sel:
			var gear: Array = explore_draft["gear"].get(key, [])
			var gl: = _wl("   Trang bị (%d/3): %s" % [gear.size(), ", ".join(gear.map(func(g): return str(products[int(g)]["name"]))) if not gear.is_empty() else "chưa có"], 10, Color("36556b"));close_content.add_child(gl)
			var grid: = GridContainer.new();grid.columns = 2;grid.add_theme_constant_override("h_separation", 4);grid.add_theme_constant_override("v_separation", 4)
			for gi in range(gear.size()):
				var rb: = _button("− " + str(products[int(gear[gi])]["name"]), 8);rb.size_flags_horizontal = Control.SIZE_EXPAND_FILL;rb.custom_minimum_size = Vector2(0, 30);rb.pressed.connect(_explore_remove_gear.bind(key, gi));grid.add_child(rb)
			if gear.size() < 3:
				for pid in _gear_items():
					var ab: = _button("+ %s (%d)" % [products[pid]["name"], _units_available(pid) - _gear_used_count(pid)], 8);ab.size_flags_horizontal = Control.SIZE_EXPAND_FILL;ab.custom_minimum_size = Vector2(0, 30);ab.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
					ab.pressed.connect(_explore_add_gear.bind(key, pid));grid.add_child(ab)
			close_content.add_child(grid)
	# Tóm tắt
	close_content.add_child(_label("3 · XUẤT PHÁT", 13, Color("285b7a")))
	var pw: = _draft_power()
	if str(explore_draft["loc"]).is_empty() or members.is_empty():
		close_content.add_child(_wl("Chọn nơi và ít nhất một môn khách.", 10, Color("6a8ca0")))
	else:
		var ok_realm: = int(pw["max_realm"]) >= int(pw["danger"])
		close_content.add_child(_wl("Tỉ lệ thành công ước tính %d%% · đi %d ngày · phí %s LT%s" % [int(round(float(pw["chance"]) * 100.0)), int(pw["days"]), _fmt_thousands(int(pw["fee"])), "" if ok_realm else " · CẦN MÔN KHÁCH " + REALM_NAMES[int(pw["danger"])].to_upper()], 11, Color("2e8a57") if ok_realm else Color("d64545")))
		var go: = _button("XUẤT PHÁT", 13);go.custom_minimum_size = Vector2(0, 44)
		go.disabled = not ok_realm or money < int(pw["fee"]) or expeditions.size() >= _explore_max()
		go.pressed.connect(_explore_depart);close_content.add_child(go)
	close_content.add_child(_label("ĐANG ĐI", 13, Color("285b7a")))
	if expeditions.is_empty(): close_content.add_child(_wl("Không có đoàn nào đang đi.", 10, Color("6a8ca0")))
	for e in expeditions:
		close_content.add_child(_wl("- %s · %s · về ngày %d" % [EXPLORE_LOCS[e["loc"]]["name"], ", ".join((e["members"] as Array).map(func(m): return str(ADVENTURERS[m]["name"]))), int(e["return_day"])], 10, Color("36556b")))


# ---------- Tinh luyện gộp và quá nhiệt ----------
func _refine_unit_cost(entry: Dictionary) -> int:
	return int(entry["qty"]) if _up("refine_room") < 3 else int(ceil(int(entry["qty"]) * 0.7))

func _refine_batch_size(shelf_index: int, product_id: int) -> int:
	var want: = 0
	if not queue.is_empty():
		var c: Dictionary = queue[0]
		var delivered: Array = c.get("delivered_items", [])
		for i in range(c["items"].size()):
			if int(c["items"][i]) == product_id and (i >= delivered.size() or not bool(delivered[i])): want += 1
	var n: = maxi(1, mini(want, int(shelves[shelf_index].get("stock", 0))))
	for entry in _recipe_for(product_id):
		var per: = _refine_unit_cost(entry)
		if per > 0: n = mini(n, int(int(material_stock.get(str(entry["name"]), 0)) / per))
	return maxi(1, n)

func _refine_bad_review(text: String) -> void:
	var who: = "Khách"
	if not queue.is_empty(): who = str(queue[0].get("name", "Khách"))
	customer_reviews.append({"name": who, "avatar": int(queue[0].get("avatar", 0)) if not queue.is_empty() else 0, "stars": 1, "text": text, "items": [], "item_sizes": []})

func _on_refining_minigame_overheated() -> void:
	stats["refine_streak"] = 0
	var delivery: Dictionary = pending_refining_delivery.duplicate()
	pending_refining_delivery.clear()
	_close_refining_minigame()
	if delivery.is_empty(): return
	var shelf_index: int = int(delivery.get("shelf_index", -1))
	var product_id: int = int(delivery.get("product_id", -1))
	var qty: int = maxi(1, int(delivery.get("qty", 1)))
	if shelf_index < 0 or product_id < 0: return
	var name: String = str(products[product_id]["name"])
	var lost: = 0
	if int(shelves[shelf_index].get("product", -1)) == product_id:
		for _k in range(qty):
			if _consume_stock_unit(shelves[shelf_index]): lost += 1
		if int(shelves[shelf_index]["stock"]) <= 0: shelves[shelf_index]["product"] = -1
	var mats_note: = ""
	var mat_parts: PackedStringArray = []
	if not _recipe_for(product_id).is_empty():
		for entry in _recipe_for(product_id):
			var used: = mini(_refine_unit_cost(entry) * qty, int(material_stock.get(str(entry["name"]), 0)))
			if used > 0: mat_parts.append("%s ×%d" % [entry["name"], used])
		for _k in range(qty): _consume_refining_materials(product_id)
		mats_note = " Nguyên liệu của mẻ này cũng mất luôn."
	# Ghi vào Chưởng bộ như một khoản chi phí (tính vào lời/lỗ)
	_log_expense("Sự cố: quá nhiệt %d %s%s" % [lost, name, (" (kèm " + ", ".join(mat_parts) + ")") if not mat_parts.is_empty() else ""], int(products[product_id].get("cost", 0)) * lost)
	_sfx("wrong")
	_refine_bad_review("Chưởng quầy tinh luyện %s quá nhiệt, hỏng cả mẻ ngay trước mặt ta. Tay nghề kém quá!" % name)
	_show_store();_update_cards()
	_incident_push("QUÁ NHIỆT · HỎNG MẺ", "Mẻ %d %s bị quá nhiệt, mất %d món trên kệ và bị khách chê (danh vọng giảm).%s\nLàm lại mẻ khác hay thôi? Không làm lại thì khách chê thêm một lần nữa." % [qty, name, lost, mats_note], [["LÀM LẠI", _refine_retry.bind(delivery)], ["KHÔNG LÀM LẠI", _refine_give_up.bind(name)]])

func _refine_retry(delivery: Dictionary) -> void:
	var shelf_index: int = int(delivery.get("shelf_index", -1))
	var product_id: int = int(delivery.get("product_id", -1))
	if queue.is_empty() or shelf_index < 0 or int(shelves[shelf_index].get("product", -1)) != product_id or int(shelves[shelf_index].get("stock", 0)) <= 0:
		_show_toast("Kệ không còn %s để tinh luyện lại." % products[product_id]["name"])
		_refine_give_up(str(products[product_id]["name"]))
		return
	var source_button: Control = delivery.get("source_button") if is_instance_valid(delivery.get("source_button")) else null
	var size_menu: Control = delivery.get("size_menu") if is_instance_valid(delivery.get("size_menu")) else null
	_open_refining_minigame.call_deferred(shelf_index, product_id, str(delivery.get("selected_size", "")), source_button, size_menu, bool(delivery.get("by_staff", false)))

func _refine_give_up(name: String) -> void:
	_refine_bad_review("Đợi mãi mà chưởng quầy bỏ dở không tinh luyện lại %s cho ta. Thật thất vọng!" % name)
	_show_toast("Không làm lại · danh vọng giảm thêm một lần.")


var manual_pause: bool = false

func _modal_open() -> bool:
	if is_instance_valid(_incident_popup) or not _incident_queue.is_empty(): return true
	if is_instance_valid(market_popup) or is_instance_valid(day_summary_popup): return true
	if is_instance_valid(active_refining_minigame): return true
	if is_instance_valid(settings_overlay) or is_instance_valid(archive_overlay): return true
	if is_instance_valid(pause_menu_panel) and pause_menu_panel.visible: return true
	if tut_paused_game and is_instance_valid(tut_bubble) and tut_bubble.visible: return true
	return false


# ---------- Tinh luyện cho đơn Truyền Tin ----------
var _remote_refine: Dictionary = {}

func _remote_order_by_id(order_id: int) -> Dictionary:
	for o in remote_active:
		if int(o["id"]) == order_id: return o
	return {}

func _remote_refine_next() -> void:
	if _remote_refine.is_empty(): return
	var lst: Array = _remote_refine["list"]
	var idx: int = int(_remote_refine["idx"])
	if idx >= lst.size():
		var o: = _remote_order_by_id(int(_remote_refine["order_id"]))
		var method: String = str(_remote_refine["method"])
		_remote_refine = {}
		if o.is_empty(): return
		o["refined"] = true
		_remote_ship(int(o["id"]), method)
		return
	var pid: int = int(lst[idx]["pid"]);var qty: int = int(lst[idx]["qty"])
	var auto: = _staff_auto_refine(pid)
	if auto != 0:
		for _k in range(qty): _consume_refining_materials(pid)
		if auto < 0:
			_sfx("wrong");_show_toast("Tiểu Hỏa tinh luyện hỏng mẻ %d %s, mất nguyên liệu. Chưa gửi được đơn." % [qty, products[pid]["name"]])
			_remote_refine = {};_touch_remote();return
		_show_toast("%s đã tinh luyện xong %d %s cho đơn truyền tin." % ["Cát sư phụ" if _has("alchemist") else "Tiểu Hỏa", qty, products[pid]["name"]])
		_remote_refine["idx"] = idx + 1
		_remote_refine_next.call_deferred();return
	if is_instance_valid(active_refining_minigame): return
	paused_before_refining = paused
	var minigame: Control = REFINING_MINIGAME_SCRIPT.new()
	minigame.z_index = 200
	minigame.configure(products[pid], day_number, level, store_name, qty, _product_refining_grade(products[pid]) == "Trung phẩm")
	minigame.set_ease(_up("refine_room"))
	minigame.completed.connect(_remote_refine_done)
	minigame.cancelled.connect(_remote_refine_cancel)
	minigame.overheated.connect(_remote_refine_overheat)
	active_refining_minigame = minigame
	add_child(minigame)

func _touch_remote() -> void:
	tab_sigs.erase("remote")
	if active_close_tab == "remote": _show_remote()

func _remote_refine_done() -> void:
	_ach_refine_ok()
	_close_refining_minigame()
	if _remote_refine.is_empty(): return
	var it: Dictionary = _remote_refine["list"][int(_remote_refine["idx"])]
	for _k in range(int(it["qty"])): _consume_refining_materials(int(it["pid"]))
	_sfx("refine")
	_show_toast("Tinh luyện xong %d %s cho đơn truyền tin." % [int(it["qty"]), products[int(it["pid"])]["name"]])
	_remote_refine["idx"] = int(_remote_refine["idx"]) + 1
	_remote_refine_next.call_deferred()

func _remote_refine_cancel() -> void:
	_close_refining_minigame()
	_remote_refine = {}
	_show_toast("Đã hủy tinh luyện · đơn chưa gửi, kho không đổi.")

func _remote_refine_overheat() -> void:
	_close_refining_minigame()
	if _remote_refine.is_empty(): return
	var it: Dictionary = _remote_refine["list"][int(_remote_refine["idx"])]
	var pid: int = int(it["pid"]);var qty: int = int(it["qty"])
	var name: String = str(products[pid]["name"])
	var lost: = 0
	for _k in range(qty):
		if _take_any_unit(pid): lost += 1
	var mat_parts: PackedStringArray = []
	for entry in _recipe_for(pid):
		var used: = mini(_refine_unit_cost(entry) * qty, int(material_stock.get(str(entry["name"]), 0)))
		if used > 0: mat_parts.append("%s ×%d" % [entry["name"], used])
	for _k in range(qty): _consume_refining_materials(pid)
	_log_expense("Sự cố: quá nhiệt %d %s%s" % [lost, name, (" (kèm " + ", ".join(mat_parts) + ")") if not mat_parts.is_empty() else ""], int(products[pid].get("cost", 0)) * lost)
	_sfx("wrong")
	var o: = _remote_order_by_id(int(_remote_refine["order_id"]))
	var sect: String = str(o.get("sect", ""))
	if not sect.is_empty(): _rep_change(sect, -3)
	customer_reviews.append({"name": sect if not sect.is_empty() else "Khách", "avatar": 0, "stars": 1, "text": "Nghe nói tiên môn tinh luyện hỏng cả mẻ hàng của bổn môn. Tay nghề kém quá!", "items": [], "item_sizes": []})
	_touch_remote()
	_incident_push("QUÁ NHIỆT · HỎNG MẺ", "Mẻ %d %s cho đơn của %s bị quá nhiệt, mất %d món, uy tín và danh vọng giảm.%s\nLàm lại hay thôi? Không làm lại thì bị chê thêm một lần nữa." % [qty, name, sect, lost, " Nguyên liệu cũng mất luôn." if not mat_parts.is_empty() else ""], [["LÀM LẠI", _remote_refine_retry], ["KHÔNG LÀM LẠI", _remote_refine_give_up.bind(name)]])

func _remote_refine_retry() -> void:
	if _remote_refine.is_empty(): return
	var it: Dictionary = _remote_refine["list"][int(_remote_refine["idx"])]
	if _units_available(int(it["pid"])) < int(it["qty"]):
		_show_toast("Không còn đủ %s để tinh luyện lại. Thâu mua thêm rồi gửi lại sau." % products[int(it["pid"])]["name"])
		_remote_refine_give_up(str(products[int(it["pid"])]["name"]))
		return
	_remote_refine_next.call_deferred()

func _remote_refine_give_up(name: String) -> void:
	_remote_refine = {}
	customer_reviews.append({"name": "Khách", "avatar": 0, "stars": 1, "text": "Tiên môn bỏ dở không tinh luyện lại %s, đơn hàng trễ nải. Thật thất vọng!" % name, "items": [], "item_sizes": []})
	_show_toast("Không làm lại · danh vọng giảm thêm một lần. Đơn chưa gửi.")
	_touch_remote()


# ---------- Đấu giá Thượng phẩm ----------
# Đưa món Thượng phẩm lên sàn với giá khởi điểm; sang ngày hôm sau các tông môn trả giá.
const AUCTION_START_RATES: Array[float] = [0.8, 1.0, 1.2, 1.5]
const AUCTION_LIST_FEE: = 0.01
const AUCTION_COMMISSION: = 0.12
const AUCTION_BIDDERS: Array[String] = ["Thanh Vân Tông", "Lạc Hà Cốc", "Thiên Kiếm Các", "Vạn Pháp Tự", "Bích Thủy Cung", "Huyết Sát Môn", "Kim gia thương hội", "Hoàng thất Đại Chu", "Một lão tu ẩn danh"]
var auction_lots: Array = []
var auction_serial: int = 0

func _auction_max() -> int:
	return 2 + (1 if level >= 10 else 0)

func _is_top_grade(pid: int) -> bool:
	return _product_refining_grade(products[pid]) == "Thượng phẩm"

func _auction_list(pid: int, rate: float) -> void:
	if auction_lots.size() >= _auction_max(): _show_toast("Sàn đấu giá đã đủ %d món." % _auction_max());return
	if _units_available(pid) <= 0: _show_toast("Không còn %s trong kho và trên kệ." % products[pid]["name"]);return
	var start: = int(round(int(products[pid].get("cost", 0)) * rate))
	var fee: = maxi(1, int(round(start * AUCTION_LIST_FEE)))
	if money < fee: _show_toast("Cần %s LT phí đưa lên sàn." % _fmt_thousands(fee));return
	if not _take_any_unit(pid): return
	money -= fee;_log_expense("Phí đấu giá %s" % products[pid]["name"], fee)
	auction_serial += 1
	auction_lots.append({"id": auction_serial, "pid": pid, "start": start, "day": day_number})
	_sfx("coin");_update_money_display()
	_show_toast("Đã đưa %s lên sàn, giá khởi điểm %s LT. Ngày mai có kết quả." % [products[pid]["name"], _fmt_thousands(start)])
	tab_sigs.erase("auction");_show_auction()

func _auction_withdraw(lot_id: int) -> void:
	for i in range(auction_lots.size()):
		var lot: Dictionary = auction_lots[i]
		if int(lot["id"]) != lot_id: continue
		var p: Dictionary = products[int(lot["pid"])]
		var ages: = _normalize_stock_ages(p.get("stock_ages", []), int(p.get("stock", 0)));ages.append(0);p["stock_ages"] = ages;p["stock"] = ages.size()
		auction_lots.remove_at(i)
		_show_toast("Đã rút %s khỏi sàn, hàng về linh khố (phí đã trả không hoàn)." % p["name"])
		tab_sigs.erase("auction");_show_auction();return

func _auction_new_day() -> void:
	var lines: PackedStringArray = []
	var keep: Array = []
	for lot in auction_lots:
		if int(lot["day"]) >= day_number: keep.append(lot);continue
		var pid: = int(lot["pid"]);var p: Dictionary = products[pid];var start: = int(lot["start"])
		var value: = int(p.get("cost", 0)) * randf_range(1.05, 1.7)
		if _incidents_on() and randf() < 0.1: value *= 0.8
		if start > value * 1.05:
			# Không ai trả giá: hàng quay về linh khố
			var ages: = _normalize_stock_ages(p.get("stock_ages", []), int(p.get("stock", 0)));ages.append(0);p["stock_ages"] = ages;p["stock"] = ages.size()
			lines.append("%s: giá khởi điểm %s LT quá cao, không ai trả giá. Hàng đã về linh khố." % [p["name"], _fmt_thousands(start)])
			continue
		var bidders: = clampi(int(round((value - start) / maxf(1.0, value) * 12.0)) + randi_range(1, 3), 1, 8)
		var final: = int(maxf(start, value * randf_range(0.95, 1.0 + 0.04 * bidders)))
		var winner: String = AUCTION_BIDDERS.pick_random()
		var base_c: = base_costs[pid] if pid < base_costs.size() else int(p.get("cost", 0))
		if final - base_c > 500000:
			var ages_r: = _normalize_stock_ages(p.get("stock_ages", []), int(p.get("stock", 0)));ages_r.append(0);p["stock_ages"] = ages_r;p["stock"] = ages_r.size()
			lines.append("%s: %s thắng với %s LT nhưng sau đó đổi ý, trả lại hàng. Hàng đã về linh khố." % [p["name"], winner, _fmt_thousands(final)])
			continue
		var commission: = int(round(final * AUCTION_COMMISSION))
		var got: = final - commission
		# Doanh thu tính theo giá chốt; hoa hồng 5% ghi là chi phí.
		money += final - commission;revenue_today += final
		_log_expense("Hoa hồng sàn đấu giá %s" % p["name"], commission)
		var a_tax: = int(round(final * TAX_AUCTION_RATE))
		money -= a_tax;_log_expense("Thuế đấu giá", a_tax)
		sold_today[str(pid)] = int(sold_today.get(str(pid), 0)) + 1
		xp += 20
		_stat_add("sold");_stat_add("revenue", final);_stat_add("auction_sold");_stat_max("auction_max", final);_stat_add("sold_" + _cat(pid))
		lines.append("%s: %d người trả giá, %s thắng với %s LT. Trừ 12%% hoa hồng và 3%% thuế, nhận %s LT." % [p["name"], bidders, winner, _fmt_thousands(final), _fmt_thousands(got - a_tax)])
	auction_lots = keep
	if not lines.is_empty():
		_incident_push("KẾT QUẢ ĐẤU GIÁ", "\n\n".join(lines))
		_check_level()
	_update_money_display()

func _show_auction() -> void:
	if close_content == null: return
	active_close_tab = "auction"
	if _use_tab_page("auction"): return
	call_deferred("_wrap_close_labels")
	close_content.add_child(_section_heading("res://assets/boutique/ui_icons/icon_auction.png", "ĐẤU GIÁ · Bán món Thượng phẩm cho các tông môn", 12))
	close_content.add_child(_wl("Đưa món lên sàn với giá khởi điểm theo giá thâu, trả trước 1%% phí. Sang ngày hôm sau các tông môn trả giá: thường bán được 1,05–1,7 lần giá thâu, sàn lấy 12%% hoa hồng. Giá khởi điểm quá cao thì không ai mua, hàng quay về kho. Đang có %d/%d món trên sàn." % [auction_lots.size(), _auction_max()], 10, Color("c9558b")))
	close_content.add_child(_label("ĐANG TRÊN SÀN", 13, Color("285b7a")))
	if auction_lots.is_empty(): close_content.add_child(_wl("Chưa có món nào trên sàn.", 10, Color("6a8ca0")))
	for lot in auction_lots:
		var row: = HBoxContainer.new();row.add_theme_constant_override("separation", 8)
		var t: = _wl("- %s · khởi điểm %s LT · có kết quả ngày %d" % [products[int(lot["pid"])]["name"], _fmt_thousands(int(lot["start"])), int(lot["day"]) + 1], 11, Color("36556b"));row.add_child(t)
		var wb: = _button("Rút về", 9);wb.custom_minimum_size = Vector2(76, 32);wb.pressed.connect(_auction_withdraw.bind(int(lot["id"])));row.add_child(wb)
		close_content.add_child(row)
	close_content.add_child(_label("THƯỢNG PHẨM TRONG KHO", 13, Color("285b7a")))
	var any: = false
	for pid in range(products.size()):
		if not _is_top_grade(pid) or _units_available(pid) <= 0: continue
		any = true
		var p: Dictionary = products[pid]
		var card: = PanelContainer.new();card.add_theme_stylebox_override("panel", _box(Color("fffaf3"), Color("e0a96d"), 2, 12))
		var row2: = HBoxContainer.new();row2.add_theme_constant_override("separation", 8);card.add_child(row2)
		row2.add_child(_product_icon(pid, Vector2(64, 64)))
		var col: = VBoxContainer.new();col.size_flags_horizontal = Control.SIZE_EXPAND_FILL;row2.add_child(col)
		col.add_child(_wl("%s · có %d" % [p["name"], _units_available(pid)], 12, Color("285b7a")))
		col.add_child(_wl("Giá thâu %s LT" % _fmt_thousands(int(p.get("cost", 0))), 10, Color("4e85a6")))
		var grid: = GridContainer.new();grid.columns = 2;grid.add_theme_constant_override("h_separation", 4);grid.add_theme_constant_override("v_separation", 4);col.add_child(grid)
		for rate in AUCTION_START_RATES:
			var start: = int(round(int(p.get("cost", 0)) * rate))
			var b: = _button("Khởi điểm %d%%\n%s LT" % [int(rate * 100), _fmt_thousands(start)], 8);b.size_flags_horizontal = Control.SIZE_EXPAND_FILL;b.custom_minimum_size = Vector2(0, 40)
			b.disabled = auction_lots.size() >= _auction_max() or money < maxi(1, int(round(start * AUCTION_LIST_FEE)))
			b.pressed.connect(_auction_list.bind(pid, rate));grid.add_child(b)
		close_content.add_child(card)
	if not any: close_content.add_child(_wl("Chưa có món Thượng phẩm nào. Mở khóa và thâu mua ở tab Thâu mua (từ level 6).", 10, Color("6a8ca0")))


# ---------- Hướng dẫn cho các hệ thống mới (hiện một lần) ----------
const GUIDES: Dictionary = {
	"g_remote": ["HƯỚNG DẪN · TRUYỀN TIN", "Các tông môn ở xa gửi đơn đặt hàng qua phù truyền tin.\n\n1. ĐƠN MỚI HÔM NAY: xem món cần, hạn giao, tiền trả. Bấm NHẬN ĐƠN và đặt cọc 10%.\n2. ĐÃ NHẬN · CHỜ GỬI: gom đủ hàng trong kho hoặc trên kệ, chọn cách chở. Món cần tinh luyện sẽ hiện mini game trước khi gửi.\n3. Hàng tới đúng hạn: nhận đủ tiền, hoàn cọc, tăng uy tín. Trễ hạn: mất cọc, chỉ nhận 70%.\n\nĐơn chưa nhận sẽ biến mất sang ngày hôm sau. Đường xa có thể gặp cướp, mưa bão, khách bùng tiền."],
	"g_explore": ["HƯỚNG DẪN · THÁM HIỂM", "Thuê môn khách đi bí cảnh, rừng yêu thú để lấy nguyên liệu tinh luyện, rẻ hơn mua ở chợ rất nhiều.\n\n1. Chọn nơi: nơi càng xa càng nguy hiểm, cần môn khách cảnh giới đủ cao.\n2. Chọn tối đa 3 môn khách, mỗi người mang tối đa 3 trang bị lấy từ đồ trong tiệm: đan dược giảm bị thương, pháp khí và phù triện tăng sức đánh, trận đồ và phi xa nhặt thêm nguyên liệu.\n3. Xuất phát: trả phí thuê, đoàn đi vài ngày rồi tự về báo kết quả.\n\nTrên đường có thể gặp sự kiện cho bạn chọn. Môn khách bị thương sẽ phải nghỉ."],
	"g_upgrade": ["HƯỚNG DẪN · TU SỬA", "Dùng linh thạch nâng cấp tiên môn lâu dài.\n\nNÂNG CẤP TIỆM: mỗi loại 3 bậc, ví dụ quầy ngọc thạch cho khách chờ lâu hơn, biển hiệu kéo thêm khách, linh khố giữ hàng lâu hơn.\n\nBẢO VẬT: mua về rồi bày vào ô (mặc định 3 ô). Chỉ món đang bày mới có tác dụng. Mỗi bảo vật có ưu và khuyết riêng, có thể cất đi đổi món khác, bán lại được nửa giá."],
	"g_auction": ["HƯỚNG DẪN · ĐẤU GIÁ", "Bán món Thượng phẩm cho các tông môn qua sàn đấu giá.\n\n1. Chọn món Thượng phẩm trong kho, chọn giá khởi điểm (80–150% giá thâu), trả 1% phí.\n2. Sang ngày hôm sau có kết quả: thường bán được 1,05–1,7 lần giá thâu, sàn lấy 12% hoa hồng.\n3. Giá khởi điểm quá cao thì không ai mua, hàng quay về kho.\n\nKhởi điểm thấp thì nhiều người tranh hơn, giá chốt thường cao hơn."],
	"g_tax": ["HƯỚNG DẪN · THUẾ QUAN PHỦ", "Từ level 4, cứ 7 ngày quan phủ thu thuế thương khóa một lần, tính trên tiền LỜI sau chi phí của 7 ngày đó. Tuần lỗ thì không phải nộp. Doanh thu ngày lễ được miễn.\n\nThuế suất: LV4–5 5%, LV6–7 8%, LV8–9 12%, LV10–12 15%.\n\nKhi thu thuế bạn chọn:\n- Đóng đủ: an toàn. Đóng đủ 4 tuần liền được bằng khen, giảm 2% thuế suất vĩnh viễn (tối đa 3 lần).\n- Khai gian: chỉ nộp 50%, nhưng 25% bị phát hiện, phạt gấp 3 phần trốn.\n- Đút lót: nộp 70%, 10% bị lộ, phạt gấp 5. Trong 7 ngày quan phủ đi tuần dày hơn.\n- Hoãn: dời sang tuần sau, cộng 20% lãi, không được hoãn 2 lần liền.\n\nNgoài ra: đấu giá chịu 3% thuế, đơn truyền tin chịu 2% thuế quan (truyền tống trận được miễn). Trướng phòng tiên sinh giảm 20% thuế, bảo vật Ấn tín quan phủ giảm 10%."],
	"g_shelf_combo": ["KỆ BỘ QUÀ", "Ghép 3 món trong kho thành một bộ quà (Linh Các > Kệ bộ quà). Mỗi bộ lấy 1 món của mỗi loại.\n\nThỉnh thoảng có khách tới mua bộ quà: bấm vào kệ bộ quà để giao cả bộ một lần. Giá bộ cao hơn tổng bán lẻ 20%, khách dễ cho 5 sao hơn.\n\nMón cần tinh luyện sẽ tốn nguyên liệu ngay lúc ghép. Gỡ bộ quà thì hàng quay về kho."],
	"g_shelf_vip": ["BẢO CÁC · KỆ VIP", "Món bày ở kệ VIP chỉ bán cho khách VIP, giá cao hơn 30%.\n\nMỗi ngày có kệ VIP bày hàng thì có thêm 2 lượt khách VIP chỉ mua hàng ở Bảo Các.\n\nLưu ý: mỗi món chỉ bày được ở một kệ, đưa lên kệ VIP thì khách thường không mua được món đó nữa."],
	"g_shelf_consign": ["THIÊN CÁC · KỆ KÝ GỬI", "Các tông môn gửi hàng hiếm nhờ bán. Bạn không cần thâu mua, mỗi món bán được ăn 15% hoa hồng.\n\nMỗi sáng kệ ký gửi trống sẽ có lời mời gửi hàng, vào Linh Các bấm NHẬN hoặc TỪ CHỐI. Hàng ký gửi có hạn 5 ngày, hết hạn chưa bán thì trả lại tông môn.\n\nNếu bị trộm hoặc động đất làm mất, bể hàng ký gửi thì phải đền gấp đôi giá bán."],
	"g_incident": ["SỰ CỐ NGOÀI Ý MUỐN", "Từ hôm nay tiên môn có thể gặp sự cố: trộm đêm, động đất, khách quậy phá, quan phủ kiểm định giá, tiệm đối thủ hạ giá...\n\nMỗi sự cố hiện một bảng, có cái cho bạn chọn cách xử lý. Mọi khoản mất đều ghi vào Chưởng bộ.\n\nGiảm rủi ro bằng cách thuê tạp dịch (hộ viện, chưởng quỹ, tiêu sư...), mua bảo vật (gương bát quái, bình phong, kỳ lân...) hoặc nâng cấp tiệm ở Tu Sửa."],
	"g_festival": ["LỄ HỘI TRONG THÀNH", "Thành trì có lễ hội theo chu kỳ 30 ngày: Tết Nguyên Tiêu, Thất Tịch, Trung Thu, Trùng Dương.\n\nNgày lễ khách đông hơn, mỗi lễ có một món đặc biệt được khách săn lùng và bán thêm 50% giá. Cuối ngày trước lễ sẽ có tin báo, hãy thâu mua và bày sẵn món đó lên kệ."],
}

func _guide_once(key: String) -> void:
	if tut_done.has(key) or not GUIDES.has(key): return
	tut_done[key] = true
	_incident_push(str(GUIDES[key][0]), str(GUIDES[key][1]))
	call_deferred("_save_game")


# ---------- Lễ hội theo mùa (chu kỳ 30 ngày) ----------
const FESTIVALS: Dictionary = {
	7: {"name": "Tết Nguyên Tiêu", "cat": "đan dược", "crowd": 1.0, "vip": 1, "tip": 0.2, "patience": 0.0, "desc": "Khách đông gấp đôi, thả đèn hoa đăng cầu an."},
	14: {"name": "Lễ Thất Tịch", "cat": "linh thú", "crowd": 0.5, "vip": 2, "tip": 0.5, "patience": 0.0, "desc": "Thêm 2 lượt khách VIP, tip tăng 50%, đôi lứa tìm linh thú làm quà."},
	21: {"name": "Tết Trung Thu", "cat": "pháp khí", "crowd": 0.7, "vip": 1, "tip": 0.2, "patience": 5.0, "desc": "Khách đông hơn 70%, chờ thêm 5 giây, các tông môn mua pháp khí tặng đệ tử."},
	28: {"name": "Tết Trùng Dương", "cat": "phù triện", "crowd": 0.5, "vip": 0, "tip": 0.2, "patience": 10.0, "desc": "Khách đông hơn 50%, chờ thêm 10 giây, dân thành leo núi cầu phù trừ tà."},
}
const FESTIVAL_PRICE_BONUS: = 1.5
var festival_featured: int = -1

func _festival_for(day: int) -> Dictionary:
	if day < 5: return {}
	var k: = day % 30
	return FESTIVALS.get(k, {})

func _festival_today() -> Dictionary:
	return _festival_for(day_number)

func _festival_pick_featured(fest: Dictionary) -> int:
	var best: = -1
	for i in range(products.size()):
		if _is_product_available(i) and _cat(i) == str(fest["cat"]):
			if best < 0 or int(products[i].get("unlock_level", 1)) > int(products[best].get("unlock_level", 1)): best = i
	if best < 0:
		for i in range(products.size()):
			if _is_product_available(i): best = i
	return best

func _festival_new_day() -> void:
	var fest: = _festival_today()
	festival_featured = -1
	if fest.is_empty(): return
	festival_featured = _festival_pick_featured(fest)
	vip_limit_today += int(fest["vip"])
	_guide_once("g_festival")
	_incident_push("LỄ HỘI · %s" % str(fest["name"]).to_upper(), "%s\nMón đặc biệt hôm nay: %s, khách săn lùng nhiều và trả thêm 50%% giá." % [fest["desc"], products[festival_featured]["name"] if festival_featured >= 0 else "không có"])

func _festival_tomorrow_note() -> String:
	var f: = _festival_for(day_number + 1)
	if f.is_empty(): return _tax_tomorrow_note()
	var pid: = _festival_pick_featured(f)
	return "\n\nNgày mai là %s! %s Món được săn lùng: %s." % [f["name"], f["desc"], products[pid]["name"] if pid >= 0 else "chưa rõ"]


# ---------- Mục tiêu dài hạn / Thành tựu ----------
var stats: Dictionary = {}
var ach_claimed: Dictionary = {}
var ach_notified: Dictionary = {}
var achievements: Array = []
var ach_last_count: int = -1

func _ach_load() -> void:
	if not achievements.is_empty(): return
	var f: = FileAccess.open("res://config/achievements.json", FileAccess.READ)
	if f == null: return
	var parsed: Variant = JSON.parse_string(f.get_as_text())
	if parsed is Array: achievements = parsed

func _stat_add(key: String, n: int = 1) -> void:
	stats[key] = int(stats.get(key, 0)) + n

func _stat_max(key: String, v: int) -> void:
	if v > int(stats.get(key, 0)): stats[key] = v

func _ach_value(stat: String) -> int:
	match stat:
		"level": return level
		"unlocked":
			var n: = 0
			for i in range(products.size()):
				if _is_product_available(i): n += 1
			return n
		"shelves":
			var s: = 0
			for sh in shelves:
				if bool(sh.get("unlocked", false)): s += 1
			return s
		"upgrade_tiers":
			var t: = 0
			for k in shop_up.keys(): t += int(shop_up[k])
			return t
		"treasures": return treasures_owned.size()
		"staff_active": return _active_staff_count()
		"staff_owned":
			var o: = 0
			for k in staff_owned.keys():
				if bool(staff_owned[k]): o += 1
			return o
		"rep30", "rep60", "rep100":
			var need: = int(stat.substr(3))
			var c: = 0
			for k in sect_rep.keys():
				if int(sect_rep[k]) >= need: c += 1
			return c
		"favor_max":
			var fm: = 0
			for k in adv_state.keys(): fm = maxi(fm, int(adv_state[k].get("favor", 0)))
			return fm
		"money_max": return maxi(int(stats.get("money_max", 0)), money)
	return int(stats.get(stat, 0))

func _ach_done(a: Dictionary) -> bool:
	return _ach_value(str(a["stat"])) >= int(a["target"])

func _ach_check() -> void:
	_ach_load()
	_stat_max("money_max", money)
	var newly: PackedStringArray = []
	var reward_total: = 0
	for a in achievements:
		var id: = str(a["id"])
		if ach_claimed.has(id): continue
		if _ach_done(a):
			# Đạt là cộng thưởng ngay vào tài khoản.
			ach_notified[id] = true;ach_claimed[id] = day_number
			reward_total += int(a["reward"])
			newly.append(str(a["name"]))
	if not newly.is_empty():
		money += reward_total
		tab_sigs.erase("achieve")
		_sfx("levelup")
		if newly.size() == 1: _show_toast("Đạt thành tựu “%s”: +%s LT." % [newly[0], _fmt_thousands(reward_total)])
		else: _show_toast("Đạt %d thành tựu mới: +%s LT." % [newly.size(), _fmt_thousands(reward_total)])
		_update_money_display()
		_update_ui()

func _ach_claimable_count() -> int:
	_ach_load()
	var n: = 0
	for a in achievements:
		if not ach_claimed.has(str(a["id"])) and _ach_done(a): n += 1
	return n

func _ach_claim(id: String) -> void:
	for a in achievements:
		if str(a["id"]) != id: continue
		if ach_claimed.has(id) or not _ach_done(a): return
		ach_claimed[id] = day_number
		var r: = int(a["reward"])
		money += r
		_sfx("coin")
		_show_toast("Nhận thưởng thành tựu “%s”: +%s LT." % [a["name"], _fmt_thousands(r)])
		tab_sigs.erase("achieve")
		_save_game()
		_show_achievements()
		return

func _ach_end_day() -> void:
	_stat_add("days")
	if walked_out == 0 and successful_orders >= 5: _stat_add("perfect_days")
	var wrong: = 0
	for e in expenses_today:
		if str(e.get("label", "")).begins_with("Bán nhầm"): wrong += 1
	if wrong == 0 and successful_orders >= 10: _stat_add("clean_days")
	if not _festival_today().is_empty(): _stat_add("festivals")
	var profit: = _record_profit({"revenue": revenue_today, "store_tips": store_tips, "expenses": expenses_today})
	_stat_max("profit_day_max", profit)
	_ach_check()

func _show_achievements() -> void:
	if close_content == null: return
	active_close_tab = "achieve"
	_ach_check()
	if _use_tab_page("achieve"): return
	_ach_load()
	call_deferred("_wrap_close_labels")
	var done_n: = ach_claimed.size()
	close_content.add_child(_section_heading("res://assets/boutique/ui_icons/icon_achieve.png", "THÀNH TỰU · Đã nhận %d/%d" % [done_n, achievements.size()], 12))
	close_content.add_child(_wl("Mục tiêu dài hạn ngoài việc lên level. Đạt mục tiêu là thưởng linh thạch được cộng ngay vào tài khoản.", 10, Color("c9558b")))
	var ready: Array = [];var going: Array = [];var claimed: Array = []
	for a in achievements:
		var id: = str(a["id"])
		if ach_claimed.has(id): claimed.append(a)
		elif _ach_done(a): ready.append(a)
		else: going.append(a)
	going.sort_custom(func(x, y): return float(_ach_value(str(x["stat"]))) / float(x["target"]) > float(_ach_value(str(y["stat"]))) / float(y["target"]))
	for group in [["CÓ THỂ NHẬN", ready], ["ĐANG THEO ĐUỔI", going], ["ĐÃ NHẬN", claimed]]:
		var list: Array = group[1]
		if list.is_empty(): continue
		close_content.add_child(_label("%s (%d)" % [group[0], list.size()], 13, Color("285b7a")))
		for a in list:
			var id2: = str(a["id"])
			var cur: = mini(_ach_value(str(a["stat"])), int(a["target"]))
			var panel: = PanelContainer.new()
			var is_ready: bool = group[0] == "CÓ THỂ NHẬN"
			var is_claimed: bool = group[0] == "ĐÃ NHẬN"
			panel.add_theme_stylebox_override("panel", _box(Color("fff8e6") if is_ready else (Color("eef3f6") if is_claimed else Color("ffffff")), Color("e0b44a") if is_ready else Color("c9dfee"), 2, 12))
			var m: = MarginContainer.new()
			for side in ["left", "right", "top", "bottom"]: m.add_theme_constant_override("margin_%s" % side, 8)
			panel.add_child(m)
			var row: = HBoxContainer.new();row.add_theme_constant_override("separation", 8);m.add_child(row)
			var col: = VBoxContainer.new();col.size_flags_horizontal = Control.SIZE_EXPAND_FILL;col.add_theme_constant_override("separation", 2);row.add_child(col)
			col.add_child(_wl(str(a["name"]), 12, Color("7a8a96") if is_claimed else Color("285b7a")))
			col.add_child(_wl("%s · thưởng %s LT" % [a["desc"], _fmt_thousands(int(a["reward"]))], 10, Color("6a8ca0")))
			var bar: = ProgressBar.new();bar.max_value = float(a["target"]);bar.value = float(cur);bar.show_percentage = false;bar.custom_minimum_size = Vector2(0, 8)
			bar.add_theme_stylebox_override("background", _box(Color("dfeaf2"), Color("dfeaf2"), 0, 4))
			bar.add_theme_stylebox_override("fill", _box(Color("e0b44a") if not is_claimed else Color("9fb6c4"), Color("e0b44a"), 0, 4))
			col.add_child(bar)
			col.add_child(_label("%s/%s" % [_fmt_thousands(cur), _fmt_thousands(int(a["target"]))], 9, Color("6a8ca0")))
			if is_ready:
				var b: = _button("NHẬN", 10);b.custom_minimum_size = Vector2(72, 36);b.pressed.connect(_ach_claim.bind(id2));row.add_child(b)
			elif is_claimed:
				row.add_child(_label("Ngày %d" % int(ach_claimed[id2]), 9, Color("7a8a96")))
			close_content.add_child(panel)

func _ach_refine_ok() -> void:
	_stat_add("refines")
	_stat_add("refine_streak")
	_stat_max("refine_streak_max", int(stats.get("refine_streak", 0)))


# ---------- Thuế quan phủ (từ level 4) ----------
const TAX_START_LEVEL: = 4
const TAX_PERIOD_DAYS: = 7
const TAX_AUCTION_RATE: = 0.03
const TAX_REMOTE_RATE: = 0.02
var tax_state: Dictionary = {}

func _tax_bribe_active() -> bool:
	return int(tax_state.get("bribe_until", 0)) >= day_number

func _tax_rate() -> float:
	var r: float = 0.05
	if level >= 10: r = 0.15
	elif level >= 8: r = 0.12
	elif level >= 6: r = 0.08
	r = maxf(0.0, r - 0.02 * int(tax_state.get("medals", 0)))
	if _has("accountant"): r *= 0.8
	if _tr("seal"): r *= 0.9
	r *= 1.0 - 0.1 * mini(3, int(tax_state.get("charity", 0)))
	return r

func _tax_due_amount() -> int:
	return int(round(maxf(0.0, float(tax_state.get("profit", 0))) * _tax_rate()))

func _tax_end_day() -> void:
	if level < TAX_START_LEVEL:
		tax_state["profit"] = 0;tax_state["last"] = day_number;return
	if not tax_state.has("last"): tax_state["last"] = day_number - 1
	if not _festival_today().is_empty(): return
	var profit: = _record_profit({"revenue": revenue_today, "store_tips": store_tips, "expenses": expenses_today})
	tax_state["profit"] = int(tax_state.get("profit", 0)) + profit

func _tax_tomorrow_note() -> String:
	if level < TAX_START_LEVEL or not tax_state.has("last"): return ""
	if day_number + 1 - int(tax_state["last"]) < TAX_PERIOD_DAYS: return ""
	var due: = _tax_due_amount() + int(tax_state.get("deferred", 0))
	if due <= 0: return "\n\nNgày mai quan phủ thu thuế, nhưng tuần này chưa có lời nên dự kiến không phải nộp."
	return "\n\nNgày mai quan phủ thu thuế thương khóa, dự kiến khoảng %s LT. Nhớ để dành linh thạch." % _fmt_thousands(due)

func _tax_new_day() -> void:
	_tax_check_audits()
	if level < TAX_START_LEVEL or not tax_state.has("last"): return
	if day_number - int(tax_state["last"]) < TAX_PERIOD_DAYS: return
	var base: = _tax_due_amount()
	var deferred: = int(tax_state.get("deferred", 0))
	tax_state["last"] = day_number;tax_state["profit"] = 0
	_guide_once("g_tax")
	if base + deferred <= 0:
		_incident_push("QUAN PHỦ THU THUẾ", "Sổ sách 7 ngày qua không có lời, tiên môn không phải nộp thuế thương khóa tuần này.")
		return
	tax_state["base"] = base;tax_state["deferred"] = 0;tax_state["charity"] = 0
	var total: = base + deferred
	var body: = "Quan thu thuế tới thu thuế thương khóa 7 ngày.\nThuế suất %d%% trên tiền lời: %s LT." % [int(round(_tax_rate() * 100.0)), _fmt_thousands(base)]
	if deferred > 0: body += "\nCộng khoản hoãn tuần trước (đã tính lãi): %s LT." % _fmt_thousands(deferred)
	body += "\nTổng phải nộp: %s LT." % _fmt_thousands(total)
	var buttons: Array = [["ĐÓNG ĐỦ %s LT" % _fmt_thousands(total), _tax_choose.bind("full", total, deferred)]]
	buttons.append(["KHAI GIAN · nộp %s LT (dễ bị lộ)" % _fmt_thousands(deferred + int(round(base * 0.5))), _tax_choose.bind("evade", total, deferred)])
	buttons.append(["ĐÚT LÓT · nộp %s LT" % _fmt_thousands(deferred + int(round(base * 0.7))), _tax_choose.bind("bribe", total, deferred)])
	if int(tax_state.get("defer_count", 0)) == 0: buttons.append(["HOÃN SANG TUẦN SAU (+20% lãi)", _tax_choose.bind("defer", total, deferred)])
	_incident_push("QUAN PHỦ THU THUẾ", body, buttons)

func _tax_choose(kind: String, total: int, deferred: int) -> void:
	var base: = total - deferred
	var msg: = ""
	match kind:
		"full":
			money -= total;_log_expense("Thuế thương khóa", total)
			tax_state["streak"] = int(tax_state.get("streak", 0)) + 1;tax_state["defer_count"] = 0
			_stat_add("tax_full")
			msg = "Đã nộp đủ %s LT thuế." % _fmt_thousands(total)
			if int(tax_state["streak"]) % 4 == 0 and int(tax_state.get("medals", 0)) < 3:
				tax_state["medals"] = int(tax_state.get("medals", 0)) + 1
				msg += " Quan phủ trao bằng khen thương hộ: thuế suất giảm 2%% vĩnh viễn (đã có %d bằng khen)." % int(tax_state["medals"])
		"evade", "bribe":
			var share: = 0.5 if kind == "evade" else 0.7
			var paid: = deferred + int(round(base * share))
			var hidden: = total - paid
			money -= paid;_log_expense("Thuế thương khóa", paid)
			tax_state["streak"] = 0;tax_state["defer_count"] = 0
			var chance: = 0.25 if kind == "evade" else 0.10
			if _has("accountant"): chance = 0.10 if kind == "evade" else 0.05
			if kind == "bribe": tax_state["bribe_until"] = day_number + 6
			if randf() < chance:
				var audits: Array = tax_state.get("audits", [])
				audits.append({"day": day_number + randi_range(1, 3), "fine": hidden * (3 if kind == "evade" else 5), "kind": kind})
				tax_state["audits"] = audits
			else:
				_stat_add("tax_evade_ok")
			msg = ("Đã khai thấp, chỉ nộp %s LT. Mong là quan phủ không tra sổ..." if kind == "evade" else "Đã dúi phong bì cho quan thu thuế, chỉ nộp %s LT. Mấy ngày tới quan phủ đi tuần dày hơn.") % _fmt_thousands(paid)
		"defer":
			tax_state["deferred"] = int(round(total * 1.2));tax_state["defer_count"] = 1;tax_state["streak"] = 0
			msg = "Đã xin hoãn. Tuần sau phải nộp thêm %s LT (gồm 20%% lãi)." % _fmt_thousands(int(tax_state["deferred"]))
	_show_toast(msg)
	tab_sigs.clear()
	_update_ui()
	call_deferred("_save_game")

func _tax_check_audits() -> void:
	var audits: Array = tax_state.get("audits", [])
	if audits.is_empty(): return
	var keep: Array = []
	for a in audits:
		if int(a["day"]) > day_number: keep.append(a);continue
		var fine: = int(a["fine"])
		money -= fine;_log_expense("Phạt trốn thuế", fine)
		customer_reviews.append({"name": "Quan phủ", "avatar": 0, "stars": 1, "text": "Tiên môn này khai gian thuế, đã bị quan phủ xử phạt. Buôn bán thiếu chữ tín.", "items": [], "item_sizes": []})
		var why: = "khai gian thuế" if str(a["kind"]) == "evade" else "đút lót quan thu thuế"
		_incident_push("BỊ TRA SỔ THUẾ", "Quan phủ phát hiện tiên môn %s! Phạt %s LT, tiếng xấu lan khắp thành (thêm 1 đánh giá 1 sao)." % [why, _fmt_thousands(fine)])
	tax_state["audits"] = keep


# ---------- Kệ đặc biệt: bộ quà, Bảo Các (VIP), Thiên Các (ký gửi) ----------
const COMBO_SHELVES: = 2
const VIP_SHELVES: = 5
const CONSIGN_SHELVES: = 5
const COMBO_BONUS: = 1.2
const VIP_SHELF_BONUS: = 1.3
const CONSIGN_COMMISSION: = 0.15
const COMBO_CUSTOMER_CHANCE: = 0.2
const CONSIGN_CUSTOMER_CHANCE: = 0.15
const CONSIGN_DAYS: = 5
const SHELF_SECTIONS: Array = [
	["", 0, 12, "285b7a", ""],
	["KỆ BỘ QUÀ", 12, 14, "c0702a", "Ghép 3 món thành một bộ quà, khách mua cả bộ trả thêm 20%. Mở từ level 4."],
	["BẢO CÁC · KỆ VIP", 14, 19, "a8841c", "Chỉ khách VIP mua, giá cao hơn 30%, mỗi ngày thêm 2 lượt VIP riêng. Mở từ level 9."],
	["THIÊN CÁC · KỆ KÝ GỬI", 19, 24, "7a5bb5", "Tông môn gửi hàng hiếm nhờ bán, ăn 15% hoa hồng. Mất hoặc bể phải đền gấp đôi. Mở từ level 11."],
]
var vip_zone_left: int = 0

func _shelf_kind_at(i: int) -> String:
	if i < NORMAL_SHELVES: return ""
	if i < NORMAL_SHELVES + COMBO_SHELVES: return "combo"
	if i < NORMAL_SHELVES + COMBO_SHELVES + VIP_SHELVES: return "vip"
	return "consign"

func _shelf_default(i: int) -> Dictionary:
	var kind: = _shelf_kind_at(i)
	var cost: = 0;var lv: = 1
	if kind == "":
		# Kệ 7 giá 15.000 LT, mỗi kệ sau gấp 1,5 lần kệ liền trước.
		cost = 0 if i < FIRST_SHELVES else int(round(15000.0 * pow(1.5, i - FIRST_SHELVES)))
	elif kind == "combo":
		cost = 30000 + (i - NORMAL_SHELVES) * 10000;lv = 4
	elif kind == "vip":
		cost = 400000 + (i - NORMAL_SHELVES - COMBO_SHELVES) * 25000;lv = 9
	else:
		cost = 1500000 + (i - NORMAL_SHELVES - COMBO_SHELVES - VIP_SHELVES) * 125000;lv = 11
	var d: Dictionary = {"product": -1, "stock": 0, "stock_ages": [], "unlocked": i < FIRST_SHELVES, "unlock_cost": cost, "kind": kind, "level": lv}
	if kind == "combo": d["combo"] = [];d["cstock"] = 0;d["pick"] = []
	if kind == "consign": d["cpid"] = -1;d["cstock"] = 0;d["cprice"] = 0;d["csect"] = "";d["cuntil"] = 0;d["offer"] = {}
	return d

func _shelf_title(i: int) -> String:
	match _shelf_kind_at(i):
		"combo": return "BỘ QUÀ %d" % (i - NORMAL_SHELVES + 1)
		"vip": return "VIP %d" % (i - NORMAL_SHELVES - COMBO_SHELVES + 1)
		"consign": return "KÝ GỬI %d" % (i - NORMAL_SHELVES - COMBO_SHELVES - VIP_SHELVES + 1)
	return "KỆ %d" % (i + 1)

func _migrate_shelves(saved: Array) -> void:
	# Ghép kệ cũ vào bố cục mới theo từng loại; kệ thường bị dư thì gỡ hàng về kho và hoàn tiền mở kệ.
	var by_kind: Dictionary = {"": [], "combo": [], "vip": [], "consign": []}
	for sh in saved:
		if sh is Dictionary:
			var k: = str(sh.get("kind", ""))
			if by_kind.has(k): by_kind[k].append(sh)
	shelves.clear()
	var refund: = 0;var returned: = 0
	for i in range(TOTAL_SHELVES):
		var base: = _shelf_default(i)
		var list: Array = by_kind[str(base["kind"])]
		if not list.is_empty():
			var sh: Dictionary = list.pop_front()
			var keep_unlocked: = bool(sh.get("unlocked", false))
			for k in sh.keys(): base[k] = sh[k]
			var d: = _shelf_default(i)
			base["unlock_cost"] = d["unlock_cost"];base["level"] = d["level"];base["kind"] = d["kind"];base["unlocked"] = keep_unlocked or bool(d["unlocked"])
		shelves.append(base)
	for k in by_kind.keys():
		for sh in by_kind[k]:
			if int(sh.get("product", -1)) >= 0 and int(sh.get("stock", 0)) > 0: returned += int(sh["stock"]);_return_shelf_stock_to_inventory(sh)
			if bool(sh.get("unlocked", false)): refund += int(sh.get("unlock_cost", 0))
	if refund > 0 or returned > 0:
		money += refund
		call_deferred("_incident_push", "SẮP XẾP LẠI LINH CÁC", "Linh Các giờ có %d kệ thường và các khu kệ đặc biệt (Bộ quà, Bảo Các, Thiên Các). Các kệ thường dư đã gỡ: hoàn lại %s LT tiền mở kệ, %d món trên đó đã về kho." % [NORMAL_SHELVES, _fmt_thousands(refund), returned])

func _wrap_special(card: Control, kind: String) -> Control:
	if kind == "": return card
	var colors: Dictionary = {"combo": ["ffe3c2", "d98a3d"], "vip": ["ffefb3", "c99a1c"], "consign": ["e6d9ff", "8f6bd1"]}
	var pc: = PanelContainer.new()
	var st: = _box(Color(colors[kind][0]), Color(colors[kind][1]), 3, 12)
	st.content_margin_left = 2;st.content_margin_right = 2;st.content_margin_top = 3;st.content_margin_bottom = 3
	pc.add_theme_stylebox_override("panel", st);pc.add_child(card)
	return pc

func _shelf_card(index: int, shelf: Dictionary, closing: bool) -> Control:
	var kind: = str(shelf.get("kind", ""))
	if kind == "combo" and bool(shelf["unlocked"]): return _wrap_special(_combo_card(index, shelf, closing), kind)
	if kind == "consign" and bool(shelf["unlocked"]): return _wrap_special(_consign_card(index, shelf, closing), kind)
	return _wrap_special(_shelf_card_inner(index, shelf, closing), kind)

func _set_item_src(customer: Dictionary, k: int, kind: String, cprice: int) -> void:
	var srcs: Array = customer.get("src", [])
	var cp: Array = customer.get("cprice", [])
	while srcs.size() < customer["items"].size(): srcs.append("")
	while cp.size() < customer["items"].size(): cp.append(0)
	srcs[k] = kind;cp[k] = cprice
	customer["src"] = srcs;customer["cprice"] = cp

func _vip_shelf_ids() -> Array[int]:
	var ids: Array[int] = []
	for sh in shelves:
		if str(sh.get("kind", "")) == "vip" and bool(sh["unlocked"]) and int(sh["product"]) >= 0 and int(sh["stock"]) > 0 and not ids.has(int(sh["product"])): ids.append(int(sh["product"]))
	return ids

func _consign_ids() -> Array[int]:
	var ids: Array[int] = []
	for sh in shelves:
		if str(sh.get("kind", "")) == "consign" and bool(sh["unlocked"]) and int(sh.get("cstock", 0)) > 0 and not ids.has(int(sh["cpid"])): ids.append(int(sh["cpid"]))
	return ids

func _special_icon_cell(pids: Array, cell: Vector2) -> Control:
	var box: = HBoxContainer.new();box.alignment = BoxContainer.ALIGNMENT_CENTER;box.add_theme_constant_override("separation", 0);box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var w: = cell.x / maxf(1.0, float(pids.size()))
	for pid in pids:
		var t: = TextureRect.new();t.texture = load(str(products[int(pid)]["image"]));t.expand_mode = TextureRect.EXPAND_IGNORE_SIZE;t.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED;t.custom_minimum_size = Vector2(w, cell.y);t.size_flags_vertical = Control.SIZE_SHRINK_CENTER;t.mouse_filter = Control.MOUSE_FILTER_IGNORE;box.add_child(t)
	return box

func _special_button(pids: Array, stock: int, cb: Callable, disabled: bool) -> Control:
	var cell: = Control.new();cell.custom_minimum_size = Vector2(120, 120);cell.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	var b: = Button.new();b.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT);b.disabled = disabled
	var fr: = _box(Color(0, 0, 0, 0), Color("d4a72c"), 3, 14)
	for state in ["normal", "hover", "pressed", "disabled", "focus"]: b.add_theme_stylebox_override(state, fr)
	cell.add_child(b)
	var art: = _special_icon_cell(pids, Vector2(112, 112) if pids.size() == 1 else Vector2(114, 60));art.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT);art.offset_left = 3;art.offset_top = 3;art.offset_right = -3;art.offset_bottom = -3;art.modulate = Color(1, 1, 1, 0.72) if disabled else Color(1, 1, 1, 1);b.add_child(art)
	if cb.is_valid(): b.pressed.connect(cb)
	var badge: = PanelContainer.new();badge.position = Vector2(92, -2);badge.custom_minimum_size = Vector2(30, 30);badge.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var bf: = _box(Color("fffaf0"), Color("d4a72c"), 2, 15);bf.content_margin_left = 0;bf.content_margin_right = 0;bf.content_margin_top = 0;bf.content_margin_bottom = 0;badge.add_theme_stylebox_override("panel", bf)
	var bl: = _label(str(stock), 9, Color("285b7a"));bl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;bl.vertical_alignment = VERTICAL_ALIGNMENT_CENTER;badge.add_child(bl);cell.add_child(badge)
	return cell

func _small_note(text: String, w: int, col: String = "36556b") -> Label:
	var l: = _label(text, 9, Color(col));l.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;l.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART;l.custom_minimum_size = Vector2(w, 0)
	return l

# ----- Bộ quà -----
func _combo_card(index: int, shelf: Dictionary, closing: bool) -> VBoxContainer:
	var w: int = 150 if closing else 170
	var card: = VBoxContainer.new();card.custom_minimum_size = Vector2(w, 108 if closing else 169);card.add_theme_constant_override("separation", 3)
	var title: = _label(_shelf_title(index), 12, Color("c0702a"));title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;card.add_child(title)
	var combo: Array = shelf.get("combo", [])
	var cstock: = int(shelf.get("cstock", 0))
	if not closing:
		if combo.is_empty():
			card.add_child(_small_note("Chưa ghép bộ quà", w, "6a8ca0"));return card
		card.add_child(_special_button(combo, cstock, _deliver_combo.bind(index), cstock <= 0))
		card.add_child(_small_note("Bộ quà · %s LT" % _fmt_thousands(_combo_price(combo)), w))
		return card
	if not combo.is_empty():
		card.add_child(_special_icon_cell(combo, Vector2(w - 8, 46)))
		card.add_child(_small_note("Còn %d bộ · giá %s LT" % [cstock, _fmt_thousands(_combo_price(combo))], w))
		var row: = HBoxContainer.new();row.alignment = BoxContainer.ALIGNMENT_CENTER;row.add_theme_constant_override("separation", 4)
		var add: = _button("+1 BỘ", 9);add.custom_minimum_size = Vector2(66, 28);add.pressed.connect(_combo_add.bind(index, 1));add.disabled = _combo_can_make(combo) <= 0;row.add_child(add)
		var rm: = _button("GỠ", 9);rm.custom_minimum_size = Vector2(52, 28);rm.pressed.connect(_combo_clear.bind(index));row.add_child(rm)
		card.add_child(row)
		return card
	var pick: Array = shelf.get("pick", [])
	if not pick.is_empty(): card.add_child(_special_icon_cell(pick, Vector2(w - 8, 40)))
	card.add_child(_small_note("Chọn %d/3 món trong kho" % pick.size(), w, "6a8ca0"))
	var tg: = _button("ĐÓNG DANH SÁCH" if bool(shelf.get("pick_open", false)) else "CHỌN MÓN", 9);tg.custom_minimum_size = Vector2(w - 6, 28);tg.pressed.connect(_combo_toggle_list.bind(index));card.add_child(tg)
	var list: = VBoxContainer.new();list.add_theme_constant_override("separation", 2);list.visible = bool(shelf.get("pick_open", false))
	for pid in range(products.size()):
		if not _is_product_available(pid) or int(products[pid].get("stock", 0)) <= 0 or _is_top(pid): continue
		var on: = pick.has(pid)
		var b: = _button(("[x] " if on else "") + str(products[pid]["name"]), 9);b.custom_minimum_size = Vector2(w - 6, 26);b.pressed.connect(_combo_toggle_pick.bind(index, pid));list.add_child(b)
	if list.get_child_count() == 0: list.add_child(_small_note("Kho trống · hãy thâu mua trước", w, "6a8ca0"))
	card.add_child(list)
	if pick.size() == 3:
		var n: = _combo_can_make(pick)
		var mk: = _button("GHÉP 1 BỘ", 9);mk.custom_minimum_size = Vector2(w - 6, 28);mk.disabled = n <= 0;mk.pressed.connect(_combo_add.bind(index, 1));card.add_child(mk)
	return card

func _combo_price(combo: Array) -> int:
	var t: = 0.0
	for pid in combo: t += float(products[int(pid)]["price"])
	return int(round(t * COMBO_BONUS))

func _combo_can_make(combo: Array) -> int:
	var n: = 99
	for pid in combo:
		var p: int = int(pid)
		n = mini(n, int(products[p].get("stock", 0)))
		if _product_requires_refining(products[p]) and not _missing_refining_materials(p).is_empty(): n = 0
	return n if combo.size() == 3 else 0

func _combo_toggle_list(index: int) -> void:
	shelves[index]["pick_open"] = not bool(shelves[index].get("pick_open", false))
	tab_sigs.erase("shelves");_show_shelf_adjustments()

func _combo_toggle_pick(index: int, pid: int) -> void:
	var pick: Array = shelves[index].get("pick", [])
	if pick.has(pid): pick.erase(pid)
	elif pick.size() < 3: pick.append(pid)
	else: _show_toast("Bộ quà chỉ gồm 3 món. Bỏ chọn một món trước.");return
	shelves[index]["pick"] = pick
	tab_sigs.erase("shelves");_show_shelf_adjustments()

func _combo_add(index: int, n: int) -> void:
	var sh: Dictionary = shelves[index]
	var combo: Array = sh.get("combo", [])
	if combo.is_empty(): combo = sh.get("pick", []).duplicate()
	if combo.size() != 3: return
	if _combo_can_make(combo) < n: _show_toast("Không đủ hàng trong kho hoặc thiếu nguyên liệu tinh luyện.");return
	for _k in range(n):
		for pid in combo:
			var p: int = int(pid)
			_take_inventory_units(p, 1)
			if _product_requires_refining(products[p]): _consume_refining_materials(p)
	sh["combo"] = combo;sh["pick"] = [];sh["pick_open"] = false;sh["cstock"] = int(sh.get("cstock", 0)) + n
	_sfx("deliver");_show_toast("Đã ghép bộ quà, kệ có %d bộ." % int(sh["cstock"]))
	tab_sigs.erase("shelves");_show_shelf_adjustments()

func _combo_clear(index: int) -> void:
	var sh: Dictionary = shelves[index]
	var n: = int(sh.get("cstock", 0))
	for pid in sh.get("combo", []):
		var p: Dictionary = products[int(pid)]
		var ages: = _normalize_stock_ages(p.get("stock_ages", []), int(p.get("stock", 0)))
		for _k in range(n): ages.append(0)
		p["stock_ages"] = ages;p["stock"] = ages.size()
	sh["combo"] = [];sh["cstock"] = 0;sh["pick"] = []
	_show_toast("Đã gỡ bộ quà, hàng quay về kho.")
	tab_sigs.erase("shelves");_show_shelf_adjustments()

func _deliver_combo(index: int) -> void:
	if not running: _show_toast("Mở cửa ca trước rồi mới giao hàng.");return
	if queue.is_empty(): _show_toast("Chưa có khách đang chờ.");return
	var sh: Dictionary = shelves[index]
	if int(sh.get("cstock", 0)) <= 0: return
	var customer: Dictionary = queue[0]
	if int(customer.get("combo_shelf", -1)) != index:
		_show_toast("Khách này không mua bộ quà.");return
	var delivered: Array = customer.get("delivered_items", [])
	for k in range(customer["items"].size()):
		if not bool(delivered[k]):
			delivered[k] = true;_set_item_src(customer, k, "combo", 0)
	customer["delivered_items"] = delivered;customer["served_by_staff"] = false
	sh["cstock"] = int(sh["cstock"]) - 1
	if int(sh["cstock"]) <= 0: sh["combo"] = []
	_sfx("deliver")
	customer["delivery_animations_pending"] = int(customer.get("delivery_animations_pending", 0)) + 1
	_delivery_animation_completed(int(customer["order_id"]))
	_show_store();_update_ui()

# ----- Ký gửi -----
func _consign_card(index: int, shelf: Dictionary, closing: bool) -> VBoxContainer:
	var w: int = 150 if closing else 170
	var card: = VBoxContainer.new();card.custom_minimum_size = Vector2(w, 108 if closing else 169);card.add_theme_constant_override("separation", 3)
	var title: = _label(_shelf_title(index), 12, Color("7a5bb5"));title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;card.add_child(title)
	var cstock: = int(shelf.get("cstock", 0))
	var pid: = int(shelf.get("cpid", -1))
	if cstock > 0 and pid >= 0:
		if closing:
			card.add_child(_special_icon_cell([pid], Vector2(w - 8, 70)))
			card.add_child(_small_note("%s · còn %d" % [products[pid]["name"], cstock], w))
			card.add_child(_small_note("%s gửi · giá %s LT · hạn hết ngày %d" % [shelf.get("csect", ""), _fmt_thousands(int(shelf["cprice"])), int(shelf["cuntil"])], w, "7a5bb5"))
		else:
			card.add_child(_special_button([pid], cstock, _deliver_consign.bind(index), false))
			card.add_child(_small_note(str(products[pid]["name"]), w))
		return card
	var offer: Dictionary = shelf.get("offer", {})
	if closing and not offer.is_empty():
		var op: = int(offer["pid"])
		card.add_child(_special_icon_cell([op], Vector2(w - 8, 56)))
		card.add_child(_small_note("%s nhờ bán %d %s, giá %s LT/món. Bạn ăn 15%%, hạn %d ngày." % [offer["sect"], int(offer["qty"]), products[op]["name"], _fmt_thousands(int(offer["price"])), CONSIGN_DAYS], w))
		var row: = HBoxContainer.new();row.alignment = BoxContainer.ALIGNMENT_CENTER;row.add_theme_constant_override("separation", 4)
		var ok: = _button("NHẬN", 9);ok.custom_minimum_size = Vector2(64, 28);ok.pressed.connect(_consign_accept.bind(index));row.add_child(ok)
		var no: = _button("TỪ CHỐI", 9);no.custom_minimum_size = Vector2(70, 28);no.pressed.connect(_consign_decline.bind(index));row.add_child(no)
		card.add_child(row)
		return card
	card.add_child(_small_note("Chưa có hàng ký gửi." + (" Sáng mai sẽ có tông môn nhờ gửi." if closing else ""), w, "6a8ca0"))
	return card

func _consign_make_offer(sh: Dictionary) -> void:
	var cands: Array[int] = []
	for i in range(products.size()):
		var g: = _product_refining_grade(products[i])
		if g != "Trung phẩm": continue
		var lv: = int(products[i].get("unlock_level", 1))
		if lv <= mini(12, level + 1) and lv >= level - 4: cands.append(i)
	if cands.is_empty(): return
	var pid: int = cands.pick_random()
	var price: = int(round(float(products[pid].get("cost", 100)) * 1.25))
	sh["offer"] = {"pid": pid, "qty": randi_range(2, 4), "price": price, "sect": REMOTE_SECTS.pick_random()}

func _consign_accept(index: int) -> void:
	var sh: Dictionary = shelves[index]
	var offer: Dictionary = sh.get("offer", {})
	if offer.is_empty(): return
	sh["cpid"] = int(offer["pid"]);sh["cstock"] = int(offer["qty"]);sh["cprice"] = int(offer["price"]);sh["csect"] = str(offer["sect"]);sh["cuntil"] = day_number + CONSIGN_DAYS - 1;sh["csold"] = 0;sh["offer"] = {}
	_sfx("coin");_show_toast("Đã nhận hàng ký gửi của %s." % sh["csect"])
	tab_sigs.erase("shelves");_show_shelf_adjustments()

func _consign_decline(index: int) -> void:
	shelves[index]["offer"] = {}
	_show_toast("Đã từ chối. Sáng mai sẽ có lời mời khác.")
	tab_sigs.erase("shelves");_show_shelf_adjustments()

func _deliver_consign(index: int) -> void:
	if not running: _show_toast("Mở cửa ca trước rồi mới giao hàng.");return
	if queue.is_empty(): _show_toast("Chưa có khách đang chờ.");return
	var sh: Dictionary = shelves[index]
	var pid: = int(sh.get("cpid", -1))
	if pid < 0 or int(sh.get("cstock", 0)) <= 0: return
	var customer: Dictionary = queue[0]
	var k: = _first_undelivered_order_item(customer, pid)
	if k < 0: _show_toast("Khách không cần %s." % products[pid]["name"]);return
	var delivered: Array = customer["delivered_items"];delivered[k] = true;customer["delivered_items"] = delivered
	_set_item_src(customer, k, "consign", int(sh["cprice"]))
	customer["served_by_staff"] = false
	sh["cstock"] = int(sh["cstock"]) - 1;sh["csold"] = int(sh.get("csold", 0)) + 1
	if int(sh["cstock"]) <= 0:
		_rep_change(str(sh["csect"]), 5)
		_show_toast("Đã bán hết hàng ký gửi của %s, uy tín tăng." % sh["csect"])
		sh["cpid"] = -1
	_sfx("deliver")
	customer["delivery_animations_pending"] = int(customer.get("delivery_animations_pending", 0)) + 1
	_delivery_animation_completed(int(customer["order_id"]))
	_show_store();_update_ui()

func _consign_risk(kind: String) -> void:
	for sh in shelves:
		if str(sh.get("kind", "")) != "consign" or int(sh.get("cstock", 0)) <= 0: continue
		if randf() >= 0.3: continue
		var pid: = int(sh["cpid"]);var fine: = int(sh["cprice"]) * 2
		money -= fine;_log_expense("Đền hàng ký gửi", fine)
		sh["cstock"] = int(sh["cstock"]) - 1
		_rep_change(str(sh["csect"]), -10)
		_incident_push("ĐỀN HÀNG KÝ GỬI", "%s làm %s 1 %s của %s. Phải đền gấp đôi giá: %s LT. Uy tín với %s giảm." % ["Trộm đêm qua lấy mất" if kind == "theft" else "Động đất", "mất" if kind == "theft" else "bể", products[pid]["name"], sh["csect"], _fmt_thousands(fine), sh["csect"]])
		if int(sh["cstock"]) <= 0: sh["cpid"] = -1

func _special_shelves_new_day() -> void:
	vip_zone_left = 0
	if not _vip_shelf_ids().is_empty():
		vip_zone_left = 2;vip_limit_today += 2
	var lines: PackedStringArray = []
	for sh in shelves:
		if str(sh.get("kind", "")) != "consign" or not bool(sh["unlocked"]): continue
		if int(sh.get("cstock", 0)) > 0 and day_number > int(sh.get("cuntil", 0)):
			lines.append("Hàng ký gửi của %s hết hạn: trả lại %d %s chưa bán." % [sh["csect"], int(sh["cstock"]), products[int(sh["cpid"])]["name"]])
			sh["cstock"] = 0;sh["cpid"] = -1
		if int(sh.get("cstock", 0)) <= 0 and sh.get("offer", {}).is_empty(): _consign_make_offer(sh)
	if not lines.is_empty(): _incident_push("THIÊN CÁC", "\n".join(lines))

func _center_incident_panel(panel: Control) -> void:
	# Đợi khung tính xong chiều cao rồi đặt giữa màn hình.
	await get_tree().process_frame
	await get_tree().process_frame
	if not is_instance_valid(panel): return
	var vh: = get_viewport().get_visible_rect().size.y
	panel.position.y = maxf(10.0, (vh - panel.size.y) * 0.5)
	panel.modulate.a = 1.0

const TAB_TEXT_START: Dictionary = {"imports": 0.36, "shelves": 0.37, "statistics": 0.385, "staff": 0.375, "reviews": 0.376, "market": 0.368, "auction": 0.39, "upgrade": 0.405, "explore": 0.391, "achieve": 0.39, "remote": 0.36}
var tab_styles: Dictionary = {}

func _refresh_tab_highlight(tab: String) -> void:
	for key in tab_styles.keys():
		var b: Variant = tab_button_refs.get(key, null)
		if b == null or not is_instance_valid(b): continue
		var st: StyleBoxTexture = tab_styles[key][1] if key == tab else tab_styles[key][0]
		for state in ["normal", "hover", "disabled", "focus"]: (b as Button).add_theme_stylebox_override(state, st)


# ---------- Khách có yêu cầu đặc biệt ----------
const COND_CHANCE: = 0.15
const COND_KINDS: Array[String] = ["rush", "careful", "thrifty"]

func _cond_limit(customer: Dictionary) -> float:
	return 12.0 + 3.0 * float(customer["items"].size())

func _cond_text(customer: Dictionary) -> String:
	var ok: = bool(customer.get("cond_ok", true))
	var t: = ""
	match str(customer.get("cond", "")):
		"rush": t = "Đặc biệt · Gấp: giao xong trong %ds" % int(_cond_limit(customer))
		"careful": t = "Đặc biệt · Kỹ tính: không được giao sai món nào"
		"thrifty": t = "Đặc biệt · Tiết kiệm: giá mỗi món phải dưới 90% giá trần"
	if t != "": t += " → tip x2" if ok else " (đã trượt)"
	return t

func _cond_tick(delta: float) -> void:
	if queue.is_empty(): return
	var c: Dictionary = queue[0]
	if str(c.get("cond", "")) != "rush" or not bool(c.get("cond_ok", true)): return
	c["front_time"] = float(c.get("front_time", 0.0)) + delta
	if float(c["front_time"]) > _cond_limit(c):
		c["cond_ok"] = false;displayed_delivery_signature = ""
		_show_toast("Khách gấp đã hết kiên nhẫn chờ: yêu cầu đặc biệt thất bại.")

func _cond_result(customer: Dictionary) -> int:
	# 1 = đạt, -1 = trượt, 0 = không có yêu cầu
	var kind: = str(customer.get("cond", ""))
	if kind == "": return 0
	if not bool(customer.get("cond_ok", true)): return -1
	if kind == "thrifty":
		for pid in customer["items"]:
			var th: = int(products[int(pid)].get("overprice_threshold", 0))
			if th > 0 and float(products[int(pid)]["price"]) > th * 0.9: return -1
	return 1


# ---------- Giá thị trường và hợp đồng nguồn hàng ----------
const MARKET_CATS: Array[String] = ["đan dược", "pháp khí", "phù triện", "trận đồ", "phi xa", "linh thú"]
const CONTRACT_DAYS: = 15
var base_costs: Array[int] = []
var market_idx: Dictionary = {}
var contracts: Dictionary = {}

func _capture_base_costs() -> void:
	base_costs.clear()
	for p in products: base_costs.append(int(p.get("cost", 0)))

func _market_mult(cat: String) -> float:
	var ct: Dictionary = contracts.get(cat, {})
	if not ct.is_empty() and int(ct.get("until", 0)) >= day_number: return float(ct["idx"])
	return float(market_idx.get(cat, 1.0))

func _apply_market_costs() -> void:
	for i in range(mini(products.size(), base_costs.size())):
		products[i]["cost"] = maxi(1, int(round(base_costs[i] * _market_mult(_cat(i)))))

func _market_new_day() -> void:
	for cat in MARKET_CATS:
		var v: = float(market_idx.get(cat, 1.0))
		v = v * randf_range(0.94, 1.07)
		v = lerpf(v, 1.0, 0.12)
		market_idx[cat] = clampf(v, 0.85, 1.20)
	for cat in contracts.keys():
		if int(contracts[cat].get("until", 0)) < day_number: contracts.erase(cat)
	_apply_market_costs()

func _contract_fee() -> int:
	return 2000 + 1000 * level

func _sign_contract(cat: String) -> void:
	if contracts.has(cat): return
	var fee: = _contract_fee()
	if money < fee: _show_toast("Cần %s LT phí ký hợp đồng." % _fmt_thousands(fee));return
	money -= fee;_log_expense("Phí hợp đồng nguồn hàng", fee)
	contracts[cat] = {"idx": float(market_idx.get(cat, 1.0)), "until": day_number + CONTRACT_DAYS}
	_apply_market_costs()
	_sfx("coin");_show_toast("Đã ký hợp đồng %s: giữ giá %d%% trong %d ngày." % [cat, int(round(float(contracts[cat]["idx"]) * 100.0)), CONTRACT_DAYS])
	_update_money_display()
	tab_sigs.clear();_show_import_adjustments()

func _market_block() -> void:
	if market_idx.is_empty(): return
	var head: = _label("GIÁ THÂU THỊ TRƯỜNG HÔM NAY", 12, Color("285b7a"));close_content.add_child(head)
	close_content.add_child(_wl("Giá thâu mỗi loại lên xuống theo ngày. Ký hợp đồng nguồn hàng để giữ nguyên giá hôm nay trong %d ngày (phí %s LT). Giá chợ xuống thì bạn vẫn phải mua theo giá đã ký." % [CONTRACT_DAYS, _fmt_thousands(_contract_fee())], 9, Color("6a8ca0")))
	var grid: = GridContainer.new();grid.columns = 2;grid.add_theme_constant_override("h_separation", 6);grid.add_theme_constant_override("v_separation", 4);close_content.add_child(grid)
	for cat in MARKET_CATS:
		var v: = int(round(float(market_idx.get(cat, 1.0)) * 100.0))
		var row: = HBoxContainer.new();row.size_flags_horizontal = Control.SIZE_EXPAND_FILL;row.add_theme_constant_override("separation", 4)
		var col: Color = Color("2e8a57") if v < 100 else (Color("c0583f") if v > 100 else Color("36556b"))
		var l: = _label("%s %d%%" % [cat.capitalize(), v], 10, col);l.size_flags_horizontal = Control.SIZE_EXPAND_FILL;row.add_child(l)
		var ct: Dictionary = contracts.get(cat, {})
		if not ct.is_empty():
			row.add_child(_label("HĐ %d%% · còn %d ngày" % [int(round(float(ct["idx"]) * 100.0)), int(ct["until"]) - day_number + 1], 9, Color("7a5bb5")))
		else:
			var b: = _button("KÝ HĐ", 9);b.custom_minimum_size = Vector2(74, 28);b.autowrap_mode = TextServer.AUTOWRAP_OFF;b.disabled = level < 2 or money < _contract_fee();b.pressed.connect(_sign_contract.bind(cat));row.add_child(b)
		grid.add_child(row)


# ---------- Thương lái chào hàng (có thể là hàng giả) ----------
var trader_offer: Dictionary = {}

func _trader_new_day() -> void:
	trader_offer = {}
	if level < 3 or day_number <= INCIDENT_FREE_DAYS or randf() >= 0.25: return
	var cands: Array[int] = []
	for i in range(products.size()):
		if _is_product_available(i) and not _product_requires_refining(products[i]): cands.append(i)
	if cands.is_empty(): return
	var pid: int = cands.pick_random()
	var cost: = int(products[pid]["cost"])
	var qty: = randi_range(10, 30) if cost < 2000 else randi_range(1, 3)
	var disc: = randf_range(0.5, 0.7)
	trader_offer = {"pid": pid, "qty": qty, "total": maxi(1, int(round(cost * qty * disc))), "fake": randf() < 0.4, "checked": false}
	_trader_popup()

func _trader_popup() -> void:
	if trader_offer.is_empty(): return
	var pid: = int(trader_offer["pid"])
	var total: = int(trader_offer["total"])
	var fee: = maxi(200, int(round(total * 0.05)))
	var body: = "Một thương lái lạ ghé tiệm, chào bán %d %s chỉ %s LT (rẻ hơn giá thâu %d%%).\nHàng rẻ bất thường, có thể là hàng giả. Bán phải hàng giả mà bị phát hiện sẽ bị quan phủ phạt gấp 3 giá bán và mất danh vọng." % [int(trader_offer["qty"]), products[pid]["name"], _fmt_thousands(total), int(round((1.0 - float(total) / float(maxi(1, int(products[pid]["cost"]) * int(trader_offer["qty"])))) * 100.0))]
	var buttons: Array = [["MUA %s LT" % _fmt_thousands(total), _trader_buy]]
	if _has("accountant") or bool(trader_offer.get("checked", false)):
		body += "\n\n%s: hàng %s." % ["Trướng phòng tiên sinh xem qua" if _has("accountant") else "Kết quả giám định", "GIẢ" if bool(trader_offer["fake"]) else "THẬT"]
	else:
		buttons.append(["GIÁM ĐỊNH (phí %s LT)" % _fmt_thousands(fee), _trader_inspect.bind(fee)])
	buttons.append(["BỎ QUA", _trader_skip])
	_incident_push("THƯƠNG LÁI CHÀO HÀNG", body, buttons)

func _trader_inspect(fee: int) -> void:
	money -= fee;_log_expense("Phí giám định hàng", fee)
	trader_offer["checked"] = true
	_update_money_display()
	_trader_popup()

func _trader_skip() -> void:
	trader_offer = {}

func _trader_buy() -> void:
	if trader_offer.is_empty(): return
	var pid: = int(trader_offer["pid"]);var qty: = int(trader_offer["qty"]);var total: = int(trader_offer["total"])
	if money < total: _show_toast("Không đủ linh thạch.");return
	if _warehouse_used() + qty > _warehouse_cap(): _show_toast("Linh khố không đủ chỗ cho lô hàng này.");return
	money -= total;_log_expense("Thâu mua %s" % products[pid]["name"], total)
	var p: Dictionary = products[pid]
	var ages: = _normalize_stock_ages(p.get("stock_ages", []), int(p.get("stock", 0)))
	for _k in range(qty): ages.append(0)
	p["stock_ages"] = ages;p["stock"] = ages.size()
	if bool(trader_offer["fake"]): p["fake_units"] = int(p.get("fake_units", 0)) + qty
	_push_stock_to_existing_shelf(pid)
	_sfx("coin");_show_toast("Đã mua %d %s của thương lái." % [qty, p["name"]])
	trader_offer = {}
	_update_money_display();tab_sigs.clear()

func _fake_goods_check(customer: Dictionary) -> void:
	var srcs: Array = customer.get("src", [])
	for k in range(customer["items"].size()):
		var pid: = int(customer["items"][k])
		if k < srcs.size() and str(srcs[k]) == "consign": continue
		var p: Dictionary = products[pid]
		var fakes: = int(p.get("fake_units", 0))
		if fakes <= 0: continue
		p["fake_units"] = fakes - 1
		if randf() < 0.25:
			var fine: = int(p["price"]) * 3
			money -= fine;_log_expense("Phạt bán hàng giả", fine)
			customer_reviews.append({"name": "Quan phủ", "avatar": 0, "stars": 1, "text": "Tiên môn bán %s giả, đã bị quan phủ xử phạt." % p["name"], "items": [], "item_sizes": []})
			_incident_push("BỊ PHÁT HIỆN HÀNG GIẢ", "Khách mang %s về mới biết là hàng giả, báo lên quan phủ. Phạt %s LT và mất danh vọng." % [p["name"], _fmt_thousands(fine)])


# ---------- Đại hội Tiên Môn (mỗi 30 ngày, ngày 15 của tháng) ----------
var daihoi: Dictionary = {}
var daihoi_titles: int = 0
var daihoi_boost_until: int = 0
var vip_served_today: int = 0

func _recent_avg(key: String, n: int = 7) -> float:
	var t: = 0.0;var c: = 0
	for i in range(daily_statistics.size() - 1, -1, -1):
		if c >= n: break
		t += float(daily_statistics[i].get(key, 0));c += 1
	return t / float(c) if c > 0 else 0.0

func _daihoi_new_day() -> void:
	vip_served_today = 0
	daihoi = {}
	if day_number % 30 != 15: return
	var kinds: Array[String] = ["orders", "cat", "nowalk", "vip", "revenue"]
	var kind: String = kinds.pick_random()
	var d: Dictionary = {"kind": kind}
	match kind:
		"orders":
			d["target"] = maxi(20, int(round(_recent_avg("orders") * 1.15)));d["text"] = "Hoàn thành %d đơn trong ca." % int(d["target"])
		"cat":
			var cats: Array[String] = []
			for pid in _shelf_product_ids():
				if not cats.has(_cat(pid)): cats.append(_cat(pid))
			if cats.is_empty(): cats.append("đan dược")
			d["cat"] = cats.pick_random();d["target"] = 15 + level * 2;d["text"] = "Bán %d món %s trong ca." % [int(d["target"]), d["cat"]]
		"nowalk":
			d["target"] = 15;d["text"] = "Không để khách nào bỏ về hoặc hẹn lần sau, và hoàn thành ít nhất 15 đơn."
		"vip":
			vip_limit_today += 1;d["target"] = vip_limit_today;d["text"] = "Phục vụ đủ %d khách VIP trong ca." % int(d["target"])
		"revenue":
			d["target"] = maxi(2000, int(round(_recent_avg("revenue") * 1.25)));d["text"] = "Doanh thu trong ca đạt %s LT." % _fmt_thousands(int(d["target"]))
	d["reward"] = 2500 * level
	daihoi = d
	_incident_push("ĐẠI HỘI TIÊN MÔN LẦN %d" % (int(day_number / 30) + 1), "Hôm nay các tiên môn trong thành tranh tài buôn bán!\n\nĐề thi: %s\n\nĐạt đề: thưởng %s LT, danh hiệu Quán quân Đại hội, và khách kéo tới đông hơn 15%% trong 3 ngày." % [d["text"], _fmt_thousands(int(d["reward"]))])

func _daihoi_progress() -> int:
	match str(daihoi.get("kind", "")):
		"orders": return successful_orders
		"cat":
			var n: = 0
			for k in sold_today.keys():
				if _cat(int(k)) == str(daihoi["cat"]): n += int(sold_today[k])
			return n
		"nowalk": return successful_orders if walked_out == 0 else -1
		"vip": return vip_served_today
		"revenue": return revenue_today
	return 0

func _daihoi_end_day() -> void:
	if daihoi.is_empty(): return
	var prog: = _daihoi_progress()
	var ok: = prog >= int(daihoi["target"])
	if ok:
		var r: = int(daihoi["reward"])
		money += r;daihoi_titles += 1;daihoi_boost_until = day_number + 3
		_stat_add("daihoi_win")
		_incident_push("ĐẠI HỘI TIÊN MÔN · QUÁN QUÂN", "Tiên môn đạt đề thi (%s)!\nThưởng %s LT. Danh hiệu Quán quân Đại hội: %d lần. 3 ngày tới khách kéo tới đông hơn 15%%." % [str(daihoi["text"]), _fmt_thousands(r), daihoi_titles])
	else:
		_incident_push("ĐẠI HỘI TIÊN MÔN · KẾT QUẢ", "Tiên môn chưa đạt đề thi (%s). Kết quả: %s.\nHẹn đại hội lần sau." % [str(daihoi["text"]), "có khách bỏ về" if prog < 0 else _fmt_thousands(prog)])
	daihoi = {}


# ---------- Thư từ buổi sáng ----------
const LETTER_FLAVOR: Array = [
	["Tiểu nhị trà lâu đối diện", "Hôm qua khách bàn tán tiệm ta bày hàng đẹp nhất phố. Chưởng quầy cứ giữ phong độ nhé!"],
	["Một kiếm tu vô danh", "Viên đan mua hôm trước đã cứu ta một mạng trong bí cảnh. Đa tạ tiên môn."],
	["Bà lão bán bánh bao đầu ngõ", "Sáng nay ta hấp dư một xửng, gửi sang mời mọi người trong tiệm."],
	["Thư sinh trọ cạnh tiệm", "Tiệm mở đến khuya, đèn sáng cả con phố, ta ôn thi cũng đỡ buồn."],
	["Vạn Bảo Lâu", "Nghe nói quý tiệm làm ăn khấm khá. Đừng vội mừng, bổn lâu sắp nhập lô hàng mới."],
	["Quan phủ", "Nhắc các tiệm trong thành niêm yết giá rõ ràng, không bán vượt giá trần."],
	["Đệ tử Thanh Vân Tông", "Sư phụ dặn mua hàng ở tiệm này cho yên tâm. Hẹn ngày gần nhất ghé."],
	["Lão chưởng quầy về hưu", "Buôn bán cốt ở chữ tín. Đừng vì lời nhỏ mà bán hàng không rõ gốc gác."],
	["Một khách quen", "Hôm qua tiểu nhị nhà ngươi tính sai tiền thối, ta trả lại rồi đấy. Nhớ dặn dò người làm."],
	["Hội thương nhân thành trì", "Mùa này đường thương lộ nhiều cướp, các tiệm nên chọn cách chở hàng cẩn thận."],
]

func _letter_new_day() -> void:
	if day_number <= 2 or randf() >= 0.45: return
	var sender: = "";var text: = ""
	var opts: Array = []
	for k in range(1, 4):
		var f: = _festival_for(day_number + k)
		if not f.is_empty(): opts.append(["Tiểu nhị trà lâu", "Nghe đồn %d ngày nữa là %s. %s Chưởng quầy nhớ chuẩn bị hàng." % [k, f["name"], f["desc"]]]);break
	var dm: = day_number % 30
	if dm >= 12 and dm < 15: opts.append(["Thương hội thành trì", "Kính mời quý tiên môn dự Đại hội Tiên Môn sau %d ngày nữa. Đề thi sẽ công bố sáng hôm đó." % (15 - dm)])
	if level >= TAX_START_LEVEL and tax_state.has("last"):
		var left: = TAX_PERIOD_DAYS - (day_number - int(tax_state["last"]))
		if left >= 1 and left <= 2: opts.append(["Quan phủ", "Còn %d ngày nữa đến kỳ thu thuế thương khóa. Đề nghị tiên môn chuẩn bị sổ sách." % left])
	if randf() < 0.3:
		var gift: = 150 * level
		opts.append(["Một khách quen", "Cảm ơn tiên môn thời gian qua. Gửi chút quà mọn %s LT." % _fmt_thousands(gift), "money", gift])
	if randf() < 0.2 and not material_names.is_empty():
		var m: String = material_names.pick_random()
		opts.append(["Lão dược nông trên núi", "Lão hái được ít %s, gửi biếu tiên môn 1 phần." % m, "mat", m])
	if opts.is_empty() or randf() < 0.35: opts.append(LETTER_FLAVOR.pick_random())
	var pick: Array = opts.pick_random()
	sender = str(pick[0]);text = str(pick[1])
	if pick.size() > 2:
		if str(pick[2]) == "money": money += int(pick[3]);_update_money_display()
		elif str(pick[2]) == "mat": material_stock[str(pick[3])] = int(material_stock.get(str(pick[3]), 0)) + 1
	_incident_push("THƯ SÁNG NAY", "Từ: %s\n\n%s" % [sender, text])


# ---------- Mở rộng 8 mục: thời tiết, giờ vàng, thanh lý, ca đêm, hội viên, danh nhân, tin đồn xấu, trả hàng ----------
const WEATHER: Dictionary = {
	"deep": {"name": "Trời đẹp", "desc": "Khách đi lại bình thường.", "arrival": 0.0, "fav": []},
	"mua": {"name": "Mưa dầm", "desc": "Khách ít hơn 15%, phù triện và phi xa bán chạy.", "arrival": -0.15, "fav": ["phù triện", "phi xa"]},
	"nang": {"name": "Nắng gắt", "desc": "Khách chờ ít hơn 3 giây, đan dược bán chạy.", "arrival": 0.0, "fav": ["đan dược"]},
	"suong": {"name": "Sương mù", "desc": "Khách ít hơn 10%, trận đồ bán chạy.", "arrival": -0.10, "fav": ["trận đồ"]},
	"tuyet": {"name": "Tuyết rơi", "desc": "Khách ít hơn 10%, linh thú và pháp khí bán chạy, linh thú bán đắt hơn 20%.", "arrival": -0.10, "fav": ["linh thú", "pháp khí"]},
}
var weather_today: String = "deep"
var weather_tomorrow: String = ""
var golden: Dictionary = {"hour": 15, "disc": 0.0}
var golden_announced: bool = false
var night_plan: bool = false
var night_today: bool = false
var night_announced: bool = false
var members: Dictionary = {}
var member_visits: Dictionary = {}
var promo_until: int = 0
var promo_start: int = 0
var promo_cd: int = 0
var promo_scandal: bool = false
var buzz: Dictionary = {}
var liq_used_today: int = 0
var pending_returns: Array = []

func _ext8_load(e: Dictionary) -> void:
	if e.is_empty(): return
	golden = e.get("golden", golden);night_plan = bool(e.get("night_plan", false))
	members = e.get("members", {});member_visits = e.get("visits", {})
	promo_until = int(e.get("promo_until", 0));promo_cd = int(e.get("promo_cd", 0));promo_scandal = bool(e.get("promo_scandal", false))
	buzz = e.get("buzz", {});weather_today = str(e.get("w_today", "deep"));weather_tomorrow = str(e.get("w_tom", ""))
	promo_start = promo_until - 1
	investments = e.get("invest", []);invest_offers = e.get("inv_offers", []);charity_day = int(e.get("charity_day", 0))

func _roll_weather() -> String:
	var r: = randf()
	if r < 0.40: return "deep"
	if r < 0.60: return "mua"
	if r < 0.80: return "nang"
	if r < 0.90: return "suong"
	return "tuyet"

func _weather_favored(eligible: Array[int]) -> Array[int]:
	var out: Array[int] = []
	var fav: Array = WEATHER.get(weather_today, {}).get("fav", [])
	if fav.is_empty(): return out
	for pid in eligible:
		if fav.has(_cat(pid)): out.append(pid)
	return out

func _city_notes() -> String:
	var t: = _festival_tomorrow_note()
	if weather_tomorrow != "":
		var w: Dictionary = WEATHER[weather_tomorrow]
		t += "\n\nThời tiết ngày mai: %s. %s" % [w["name"], w["desc"]]
	return t

func _ext8_end_day() -> void:
	weather_tomorrow = _roll_weather()
	if promo_scandal and day_number == promo_until:
		promo_scandal = false
		for _k in range(3): customer_reviews.append({"name": "Lời đồn", "avatar": 0, "stars": 1, "text": "Danh nhân quảng bá cho tiệm này dính bê bối, ta không tin hàng ở đây nữa.", "items": [], "item_sizes": []})
		buzz = {"until": day_number + 3, "mod": -0.2}
		_incident_push("DANH NHÂN DÍNH BÊ BỐI", "Vị danh nhân vừa quảng bá cho tiên môn bị phanh phui bê bối. Tiếng xấu vạ lây: thêm 3 đánh giá 1 sao, khách ít hơn 20% trong 3 ngày tới.")

func _ext8_new_day() -> void:
	weather_today = weather_tomorrow if weather_tomorrow != "" else _roll_weather()
	weather_tomorrow = ""
	golden_announced = false;night_announced = false;liq_used_today = 0;pending_returns.clear()
	night_today = night_plan and level >= 6 and (_has("guard") or _has("swordsman"))
	if promo_start <= day_number and day_number <= promo_until: vip_limit_today += 2
	var w: Dictionary = WEATHER[weather_today]
	call_deferred("_show_toast", "Thời tiết hôm nay: %s. %s" % [w["name"], w["desc"]])

func _ext8_arrival() -> float:
	var b: = float(WEATHER.get(weather_today, {}).get("arrival", 0.0))
	if _golden_active(): b += 1.0
	if promo_start <= day_number and day_number <= promo_until and running: b += 0.4
	if not buzz.is_empty() and day_number <= int(buzz.get("until", 0)): b += float(buzz.get("mod", 0.0))
	return maxf(-0.6, b)

func _golden_active() -> bool:
	return running and float(golden.get("disc", 0.0)) > 0.0 and int(game_minutes / 60.0) == int(golden.get("hour", 15))

func _ext8_price_mult(pid: int, customer: Dictionary) -> float:
	var m: = 1.0
	if _golden_active(): m *= 1.0 - float(golden.get("disc", 0.0))
	if night_today and game_minutes >= float(GAME_END_MINUTES): m *= 1.3
	if bool(customer.get("member", false)): m *= 0.95
	if weather_today == "tuyet" and _cat(pid) == "linh thú": m *= 1.2
	return m

func _shift_end_minutes() -> float:
	return 24.0 * 60.0 - 1.0 if night_today else float(GAME_END_MINUTES)

func _night_tick() -> void:
	if _golden_active() and not golden_announced:
		golden_announced = true
		_show_toast("GIỜ VÀNG bắt đầu: giảm %d%%, khách kéo tới gấp đôi trong 1 giờ!" % int(round(float(golden["disc"]) * 100.0)))
	if night_today and not night_announced and game_minutes >= float(GAME_END_MINUTES):
		night_announced = true
		_show_toast("CA ĐÊM bắt đầu: khách ma tu, yêu tộc trả giá cao hơn 30%. Cẩn thận quậy phá!")
		if randf() < 0.4 and str(incident_state.get("shift_event", "")) == "":
			incident_state["shift_event"] = ["brawl", "patrol"].pick_random()
			incident_state["shift_event_at"] = randf_range(21.5 * 60.0, 23.5 * 60.0)
	_returns_tick()

# ----- Hội viên và khách trả hàng -----
func _ext8_after_checkout(customer: Dictionary, by_staff: bool) -> void:
	var cid: = str(int(customer.get("character_id", -1)))
	if cid != "-1":
		member_visits[cid] = int(member_visits.get(cid, 0)) + 1
		if not members.has(cid) and int(member_visits[cid]) >= 3:
			var chance: = clampf(0.3 + 0.15 * (_avg_stars() - 3.0), 0.1, 0.7)
			if randf() < chance:
				members[cid] = true
				call_deferred("_show_toast", "%s đã làm thẻ hội viên của tiên môn!" % customer.get("name", "Khách"))
	if day_number > INCIDENT_FREE_DAYS and not by_staff and randf() < 0.04:
		var srcs: Array = customer.get("src", [])
		var opts: Array[int] = []
		for k in range(customer["items"].size()):
			var sk: = str(srcs[k]) if k < srcs.size() else ""
			if sk == "": opts.append(k)
		if not opts.is_empty():
			var k2: int = opts.pick_random();var pid: = int(customer["items"][k2])
			pending_returns.append({"t": game_minutes + randf_range(60.0, 180.0), "pid": pid, "price": int(products[pid]["price"]), "name": str(customer.get("name", "Khách"))})

func _avg_stars() -> float:
	if customer_reviews.is_empty(): return 4.0
	var t: = 0
	for r in customer_reviews: t += int(r.get("stars", 4))
	return float(t) / float(customer_reviews.size())

func _returns_tick() -> void:
	if pending_returns.is_empty(): return
	var r: Dictionary = pending_returns[0]
	if game_minutes < float(r["t"]): return
	pending_returns.pop_front()
	var pid: = int(r["pid"]);var price: = int(r["price"])
	var has_stock: = _bot_free_units(pid) > 0
	var buttons: Array = [["HOÀN TIỀN %s LT" % _fmt_thousands(price), _return_refund.bind(r)], ["TỪ CHỐI", _return_refuse.bind(r)]]
	if has_stock: buttons.insert(1, ["ĐỔI MÓN KHÁC", _return_swap.bind(r)])
	_incident_push("KHÁCH TRẢ HÀNG", "%s quay lại, muốn trả 1 %s vừa mua (%s LT).\nHoàn tiền: giữ danh vọng, món về kho. Đổi món khác: tốn 1 món nhưng khách vui (4 sao). Từ chối: khách cho 1 sao." % [r["name"], products[pid]["name"], _fmt_thousands(price)], buttons)

func _bot_free_units(pid: int) -> int:
	var n: = int(products[pid].get("stock", 0))
	for sh in shelves:
		if int(sh.get("product", -1)) == pid: n += int(sh.get("stock", 0))
	return n

func _return_review(r: Dictionary, stars: int, text: String) -> void:
	customer_reviews.append({"name": str(r["name"]), "avatar": 0, "stars": stars, "text": text, "items": [], "item_sizes": []})

func _return_refund(r: Dictionary) -> void:
	var pid: = int(r["pid"]);var price: = int(r["price"])
	money -= price;_log_expense("Hoàn tiền khách trả hàng", price)
	var p: Dictionary = products[pid]
	var ages: = _normalize_stock_ages(p.get("stock_ages", []), int(p.get("stock", 0)));ages.append(0);p["stock_ages"] = ages;p["stock"] = ages.size()
	_update_money_display();_update_ui()

func _return_swap(r: Dictionary) -> void:
	_consume_one(int(r["pid"]))
	_log_expense("Đổi hàng cho khách %s" % products[int(r["pid"])]["name"], int(products[int(r["pid"])].get("cost", 0)))
	_return_review(r, 4, "Tiệm đổi hàng cho ta nhanh gọn, phục vụ chu đáo.")
	_show_store();_update_ui()

func _return_refuse(r: Dictionary) -> void:
	_return_review(r, 1, "Hàng có vấn đề mà tiệm không chịu đổi trả. Thất vọng!")

# ----- Tin đồn xấu -----
func _day_incident_rumor() -> bool:
	var cost: = 3000 * level
	_incident_push("TIN ĐỒN XẤU", "Có kẻ tung tin khắp thành rằng tiên môn bán đan giả. Khách bắt đầu xì xào.", [["CHI TIỀN LÀM SÁNG TỎ (%s LT)" % _fmt_thousands(cost), _rumor_pay.bind(cost)], ["MỜI QUAN PHỦ KIỂM ĐỊNH CÔNG KHAI (đóng cửa hôm nay)", _rumor_inspect], ["MẶC KỆ", _rumor_ignore]])
	return true

func _rumor_pay(cost: int) -> void:
	money -= cost;_log_expense("Sự cố: dẹp tin đồn xấu", cost)
	_show_toast("Đã chi tiền dẹp tin đồn.");_update_money_display()

func _rumor_inspect() -> void:
	incident_state["close_early_at"] = float(GAME_START_MINUTES) + 1.0
	var fakes: = 0
	for p in products:
		var f: = int(p.get("fake_units", 0))
		if f > 0:
			fakes += f;p["fake_units"] = 0
	if fakes > 0:
		var fine: = 2000 * level + fakes * 200
		money -= fine;_log_expense("Phạt bán hàng giả", fine)
		for _k in range(3): customer_reviews.append({"name": "Quan phủ", "avatar": 0, "stars": 1, "text": "Quan phủ kiểm định phát hiện hàng giả trong kho tiên môn.", "items": [], "item_sizes": []})
		buzz = {"until": day_number + 5, "mod": -0.25}
		_incident_push("KIỂM ĐỊNH CÔNG KHAI", "Quan phủ phát hiện %d món hàng giả trong kho! Phạt %s LT, tin đồn thành sự thật, khách ít hơn 25%% trong 5 ngày." % [fakes, _fmt_thousands(fine)])
	else:
		for _k in range(3): customer_reviews.append({"name": "Quan phủ", "avatar": 0, "stars": 5, "text": "Quan phủ kiểm định công khai: hàng của tiên môn hoàn toàn chính phẩm.", "items": [], "item_sizes": []})
		buzz = {"until": day_number + 3, "mod": 0.10}
		_incident_push("KIỂM ĐỊNH CÔNG KHAI", "Quan phủ xác nhận hàng của tiên môn là chính phẩm. Tiên môn đóng cửa hôm nay, nhưng 3 ngày tới khách tin tưởng hơn (thêm 10% khách).")

func _rumor_ignore() -> void:
	buzz = {"until": day_number + 4, "mod": -0.2}
	_show_toast("Mặc kệ tin đồn: khách ít hơn 20% trong 5 ngày.")

# ----- Bảng kế hoạch trong Linh Các -----
func _plan_block() -> void:
	close_content.add_child(_label("KẾ HOẠCH NGÀY MAI", 12, Color("285b7a")))
	if weather_tomorrow != "":
		var w: Dictionary = WEATHER[weather_tomorrow]
		close_content.add_child(_wl("Thời tiết ngày mai: %s. %s" % [w["name"], w["desc"]], 10, Color("4e85a6")))
	var g: = HBoxContainer.new();g.add_theme_constant_override("separation", 4)
	var gl: = _label("Giờ vàng", 10, Color("c0702a"));gl.custom_minimum_size = Vector2(70, 0);g.add_child(gl)
	var prev: = _button("<", 11);prev.custom_minimum_size = Vector2(34, 28);prev.pressed.connect(_golden_shift.bind(-1));g.add_child(prev)
	var hl: = _label("%02d:00–%02d:00" % [int(golden["hour"]), int(golden["hour"]) + 1], 10, Color("36556b"));hl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;hl.custom_minimum_size = Vector2(96, 0);g.add_child(hl)
	var nx: = _button(">", 11);nx.custom_minimum_size = Vector2(34, 28);nx.pressed.connect(_golden_shift.bind(1));g.add_child(nx)
	var d: = int(round(float(golden["disc"]) * 100.0))
	var db: = _button("TẮT" if d == 0 else "GIẢM %d%%" % d, 9);db.custom_minimum_size = Vector2(84, 28);db.pressed.connect(_golden_cycle);g.add_child(db)
	close_content.add_child(g)
	close_content.add_child(_wl("Trong giờ vàng mọi món giảm giá, khách kéo tới gấp đôi. Hợp để đẩy hàng sắp tiêu tán.", 9, Color("6a8ca0")))
	var nrow: = HBoxContainer.new();nrow.add_theme_constant_override("separation", 6)
	var can_night: = level >= 6 and (_has("guard") or _has("swordsman"))
	var nl: = _wl("Ca đêm 21h–24h: khách trả giá cao hơn 30%%, dễ có quậy phá. %s" % ("" if can_night else "(Cần level 6 và đang thuê Hộ viện hoặc Tiêu sư giang hồ)"), 9, Color("7a5bb5"));nl.size_flags_horizontal = Control.SIZE_EXPAND_FILL;nrow.add_child(nl)
	var nb: = _button("ĐANG BẬT" if night_plan else "BẬT CA ĐÊM", 9);nb.custom_minimum_size = Vector2(112, 30);nb.autowrap_mode = TextServer.AUTOWRAP_OFF;nb.disabled = not can_night and not night_plan;nb.pressed.connect(_night_toggle);nrow.add_child(nb)
	close_content.add_child(nrow)
	var exp_n: = _expiring_total()
	var lrow: = HBoxContainer.new();lrow.add_theme_constant_override("separation", 6)
	var cap: = 60 - liq_used_today
	var ll: = _wl("Thanh lý hàng sắp tiêu tán cho hàng rong, giá 40%% giá thâu (tối đa 60 món mỗi ngày). Đang có %d món sắp tiêu tán." % exp_n, 9, Color("6a8ca0"));ll.size_flags_horizontal = Control.SIZE_EXPAND_FILL;lrow.add_child(ll)
	var lb: = _button("THANH LÝ", 9);lb.custom_minimum_size = Vector2(112, 30);lb.disabled = exp_n <= 0 or cap <= 0;lb.pressed.connect(_liquidate);lrow.add_child(lb)
	close_content.add_child(lrow)

func _golden_shift(d: int) -> void:
	golden["hour"] = clampi(int(golden["hour"]) + d, 8, 20)
	tab_sigs.erase("shelves");_show_shelf_adjustments()

func _golden_cycle() -> void:
	var cur: = float(golden["disc"])
	golden["disc"] = 0.1 if cur == 0.0 else (0.2 if cur < 0.15 else 0.0)
	tab_sigs.erase("shelves");_show_shelf_adjustments()

func _night_toggle() -> void:
	night_plan = not night_plan
	tab_sigs.erase("shelves");_show_shelf_adjustments()

func _expiring_total() -> int:
	var n: = 0
	for i in range(products.size()): n += _expiring_count(products[i], i)
	for sh in shelves:
		var pid: = int(sh.get("product", -1))
		if pid >= 0: n += _expiring_count(sh, pid)
	return n

func _liquidate_container(c: Dictionary, pid: int, limit: int) -> int:
	if limit <= 0 or pid < 0: return 0
	var exp_n: = _expiring_count(c, pid)
	if exp_n <= 0: return 0
	var outdated: = int(products[pid].get("outdated_days", DEFAULT_OUTDATED_DAYS))
	var ages: = _normalize_stock_ages(c.get("stock_ages", []), int(c.get("stock", 0)))
	ages.sort();ages.reverse()
	var removed: = 0
	while removed < limit and not ages.is_empty() and removed < exp_n:
		ages.pop_front();removed += 1
	c["stock_ages"] = ages;c["stock"] = ages.size()
	return removed

func _liquidate() -> void:
	var cap: = 60 - liq_used_today
	var gain: = 0;var n: = 0
	for i in range(products.size()):
		var r: = _liquidate_container(products[i], i, cap - n)
		n += r;gain += int(round(int(products[i]["cost"]) * 0.4)) * r
	for sh in shelves:
		var pid: = int(sh.get("product", -1))
		if pid < 0: continue
		var r2: = _liquidate_container(sh, pid, cap - n)
		n += r2;gain += int(round(int(products[pid]["cost"]) * 0.4)) * r2
		if int(sh["stock"]) <= 0: sh["product"] = -1
	if n <= 0: return
	liq_used_today += n
	money += gain;revenue_today += gain
	_sfx("coin");_show_toast("Đã thanh lý %d món, thu về %s LT." % [n, _fmt_thousands(gain)])
	_update_money_display();tab_sigs.clear();_show_shelf_adjustments()

# ----- Danh vọng: hội viên, mời danh nhân -----
func _fame_block() -> void:
	close_content.add_child(_label("Hội viên: %d khách · được giảm 5%%, chờ lâu hơn 5 giây, hay quay lại." % members.size(), 11, Color("c0702a")))
	var fee: = 5000 * level
	var row: = HBoxContainer.new();row.add_theme_constant_override("separation", 6)
	var txt: = ""
	if promo_start <= day_number and day_number <= promo_until: txt = "Danh nhân đang quảng bá cho tiên môn tới hết ngày %d." % promo_until
	elif day_number < promo_cd: txt = "Có thể mời danh nhân lại từ ngày %d." % promo_cd
	else: txt = "Mời danh nhân quảng bá 2 ngày: khách tăng 40%, thêm 2 lượt VIP mỗi ngày. Có rủi ro danh nhân dính bê bối."
	var l: = _wl(txt, 10, Color("36556b"));l.size_flags_horizontal = Control.SIZE_EXPAND_FILL;row.add_child(l)
	var b: = _button("MỜI · %s LT" % _fmt_thousands(fee), 9);b.custom_minimum_size = Vector2(110, 32);b.disabled = day_number < promo_cd or money < fee;b.pressed.connect(_invite_celebrity.bind(fee));row.add_child(b)
	close_content.add_child(row)

func _invite_celebrity(fee: int) -> void:
	if money < fee or day_number < promo_cd: return
	money -= fee;_log_expense("Mời danh nhân quảng bá", fee)
	promo_start = day_number + 1;promo_until = day_number + 2;promo_cd = day_number + 8
	promo_scandal = randf() < 0.10
	_sfx("coin");_show_toast("Đã mời danh nhân, quảng bá trong ngày %d và %d." % [promo_start, promo_until])
	_update_money_display();tab_sigs.clear();_show_reviews()


func _is_top(pid: int) -> bool:
	return pid >= 0 and pid < products.size() and _product_refining_grade(products[pid]) == "Thượng phẩm"


# ---------- Sức chứa Linh khố ----------
const WAREHOUSE_BASE: = 300

func _warehouse_cap() -> int:
	return WAREHOUSE_BASE + [0, 150, 350, 700][_up("vault")]

func _warehouse_used() -> int:
	var n: = 0
	for p in products: n += int(p.get("stock", 0))
	return n


# ---------- Góp vốn thương đội ----------
const INVEST_ROUTES: Array = [
	{"name": "Thương đội ven biển", "days": 5, "min": 0.15, "max": 0.30, "risk": 0.10},
	{"name": "Thương đội Tây Vực", "days": 7, "min": 0.30, "max": 0.60, "risk": 0.25},
	{"name": "Thương thuyền Nam Hải", "days": 6, "min": 0.20, "max": 0.45, "risk": 0.18},
	{"name": "Đoàn buôn Bắc Hoang", "days": 7, "min": 0.40, "max": 0.80, "risk": 0.35},
]
const INVEST_MAX_ACTIVE: = 2
var investments: Array = []
var invest_offers: Array = []

func _invest_new_day() -> void:
	var lines: PackedStringArray = []
	var keep: Array = []
	for inv in investments:
		if int(inv["until"]) > day_number: keep.append(inv);continue
		var amt: = int(inv["amount"])
		if randf() < float(inv["risk"]):
			lines.append("%s bị cướp giữa đường, mất trắng %s LT tiền góp." % [inv["name"], _fmt_thousands(amt)])
		else:
			var rate: = randf_range(float(inv["min"]), float(inv["max"]))
			var back: = int(round(amt * (1.0 + rate)))
			money += back;revenue_today += back - amt
			lines.append("%s trở về thuận lợi: hoàn vốn %s LT, lời %d%% (+%s LT)." % [inv["name"], _fmt_thousands(amt), int(round(rate * 100.0)), _fmt_thousands(back - amt)])
	investments = keep
	invest_offers.clear()
	if level >= 4:
		var pool: = INVEST_ROUTES.duplicate()
		pool.shuffle()
		for k in range(2): invest_offers.append(pool[k].duplicate())
	if not lines.is_empty(): _incident_push("THƯƠNG ĐỘI TRỞ VỀ", "\n\n".join(lines))

func _invest_amounts() -> Array[int]:
	var base: = 10000
	if level >= 7: base = 50000
	if level >= 9: base = 200000
	return [base, base * 3, base * 10]

func _invest_block() -> void:
	close_content.add_child(_label("GÓP VỐN THƯƠNG ĐỘI", 16, Color("285b7a")))
	if level < 4:
		close_content.add_child(_wl("Mở từ level 4: góp linh thạch vào thương đội đi xa, về có lời nhưng có thể bị cướp mất trắng.", 10, Color("6a8ca0")));return
	close_content.add_child(_wl("Góp linh thạch vào một chuyến thương đội, đến hạn sẽ hoàn vốn kèm tiền lời, nhưng có thể bị cướp mất trắng. Tối đa %d chuyến cùng lúc." % INVEST_MAX_ACTIVE, 10, Color("6a8ca0")))
	for inv in investments:
		close_content.add_child(_wl("Đang góp: %s · %s LT · về vào ngày %d" % [inv["name"], _fmt_thousands(int(inv["amount"])), int(inv["until"])], 10, Color("7a5bb5")))
	for oi in range(invest_offers.size()):
		var o: Dictionary = invest_offers[oi]
		var card: = PanelContainer.new();card.add_theme_stylebox_override("panel", _box(Color("fbfdff"), Color("a6d8ee"), 2, 12))
		var col: = VBoxContainer.new();col.add_theme_constant_override("separation", 3);card.add_child(col)
		col.add_child(_wl("%s · %d ngày · lời %d–%d%% · rủi ro bị cướp %d%%" % [o["name"], int(o["days"]), int(float(o["min"]) * 100.0), int(float(o["max"]) * 100.0), int(float(o["risk"]) * 100.0)], 11, Color("285b7a")))
		var row: = HBoxContainer.new();row.add_theme_constant_override("separation", 6);col.add_child(row)
		for amt in _invest_amounts():
			var b: = _button("GÓP %s" % _fmt_thousands(amt), 9);b.custom_minimum_size = Vector2(0, 30);b.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			b.disabled = money < amt or investments.size() >= INVEST_MAX_ACTIVE
			b.pressed.connect(_invest.bind(oi, amt));row.add_child(b)
		close_content.add_child(card)

func _invest(oi: int, amt: int) -> void:
	if oi >= invest_offers.size() or money < amt or investments.size() >= INVEST_MAX_ACTIVE: return
	var o: Dictionary = invest_offers[oi]
	money -= amt;_log_expense("Góp vốn %s" % o["name"], amt)
	var inv: = o.duplicate();inv["amount"] = amt;inv["until"] = day_number + int(o["days"])
	investments.append(inv);invest_offers.remove_at(oi)
	_sfx("coin");_show_toast("Đã góp %s LT vào %s, về vào ngày %d." % [_fmt_thousands(amt), o["name"], int(inv["until"])])
	_update_money_display();tab_sigs.clear();_show_market()


# ---------- Phát chẩn từ thiện ----------
var charity_day: int = 0

func _charity_block() -> void:
	close_content.add_child(_label("PHÁT CHẨN", 12, Color("2e8a57")))
	var exp_n: = _expiring_total()
	var gift: = 2000 * level
	var txt: = "Mỗi ngày phát chẩn được 1 lần. Danh vọng tăng, có thêm đánh giá 5 sao, và quan phủ giảm 10% thuế kỳ tới (tối đa 30%)."
	if charity_day == day_number: txt = "Hôm nay tiên môn đã phát chẩn rồi."
	close_content.add_child(_wl(txt, 10, Color("36556b")))
	var row: = HBoxContainer.new();row.add_theme_constant_override("separation", 6)
	var b1: = _button("PHÁT %d MÓN SẮP TIÊU TÁN" % exp_n, 9);b1.custom_minimum_size = Vector2(0, 32);b1.size_flags_horizontal = Control.SIZE_EXPAND_FILL;b1.disabled = exp_n < 5 or charity_day == day_number;b1.pressed.connect(_charity_goods);row.add_child(b1)
	var b2: = _button("QUYÊN %s LT" % _fmt_thousands(gift), 9);b2.custom_minimum_size = Vector2(0, 32);b2.size_flags_horizontal = Control.SIZE_EXPAND_FILL;b2.disabled = money < gift or charity_day == day_number;b2.pressed.connect(_charity_money.bind(gift));row.add_child(b2)
	close_content.add_child(row)

func _charity_effect(stars_n: int, what: String) -> void:
	charity_day = day_number
	tax_state["charity"] = mini(3, int(tax_state.get("charity", 0)) + 1)
	for _k in range(stars_n): customer_reviews.append({"name": "Dân nghèo trong thành", "avatar": 0, "stars": 5, "text": "Tiên môn phát chẩn %s, thật là bậc nhân nghĩa." % what, "items": [], "item_sizes": []})
	_stat_add("charity")
	_sfx("coin");_show_toast("Đã phát chẩn. Danh vọng tăng, quan phủ ghi nhận (giảm thuế kỳ tới).")
	_update_money_display();tab_sigs.clear();_show_reviews()

func _charity_goods() -> void:
	if charity_day == day_number: return
	var n: = 0
	for i in range(products.size()):
		var e: = _expiring_count(products[i], i)
		if e > 0: n += _liquidate_container(products[i], i, e)
	for sh in shelves:
		var pid: = int(sh.get("product", -1))
		if pid < 0: continue
		var e2: = _expiring_count(sh, pid)
		if e2 > 0: n += _liquidate_container(sh, pid, e2)
		if int(sh["stock"]) <= 0: sh["product"] = -1
	if n <= 0: return
	_charity_effect(clampi(int(n / 10) + 1, 1, 3), "%d món hàng" % n)

func _charity_money(gift: int) -> void:
	if charity_day == day_number or money < gift: return
	money -= gift;_log_expense("Phát chẩn từ thiện", gift)
	_charity_effect(2, "linh thạch")
