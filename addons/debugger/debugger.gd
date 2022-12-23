tool
extends PanelContainer

# theme
var _theme = preload("res://addons/debugger/resources/debugger_theme.tres")

# Types of Monitors and Input
onready var debugger_monitor_integer = preload("res://addons/debugger/components/monitor_integer/monitor_integer.tscn")
onready var debugger_monitor_vector2 = preload("res://addons/debugger/components/monitor_vector2/monitor_vector2.tscn")
onready var debugger_monitor_string = preload("res://addons/debugger/components/monitor_string/monitor_string.tscn")
onready var debugger_monitor_float = preload("res://addons/debugger/components/monitor_float/monitor_float.tscn")

onready var debugger_input_integer = preload("res://addons/debugger/components/input_integer/input_integer.tscn")

# ...

onready var ui = preload("ui.tscn").instance()

onready var list = ui.get_node("%ContentList")
onready var scroll_bar = ui.get_node("%ScrollContainer/_v_scroll")
onready var content_margin = ui.get_node("%ScrollContainer/MarginContainer")
onready var drag_button = ui.get_node("%DragButton")

onready var monitors = []
onready var inputs = []

export var panel_padding: int = 10
export var size: Vector2 = Vector2(350, 350) setget set_width, get_width
export var font_size: int = 14 setget set_font_size, get_font_size

var drag_start: Vector2 = Vector2(0, 0)
var drag_pressed: bool = false

func set_width(val: Vector2) -> void:
	size = val
	self.rect_size = val

func get_width() -> Vector2:
	return size

func set_font_size(val: int) -> void:
	font_size = clamp(val, 1, 100)
	
	# set the font size(s)
	var theme_types = _theme.get_font_types()
	
	for theme_type in theme_types:
		
		var font_list = _theme.get_font_list(theme_type)
		
		for font in font_list:
			var _font: Font = _theme.get_font(font, theme_type)
			_font.size = font_size

func get_font_size() -> int:
	return font_size
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# If the debugger is in editor mode
	if Engine.editor_hint:
		init()
		
		# Do stuff only in editor
		# ...
		print("Debugger in Editor")
		
		return
	
	# else start normal
	else:
		init()
	
func init() -> void:
	
	# Set width
	#self.rect_min_size = Vector2(width.x, width.y)
	#self.rect_size = Vector2(width.x, width.y)
	
	# remove background of the margin container surrounding the debugger
	self.set("custom_styles/panel", StyleBoxEmpty.new())
	
	# set the theme
	self.set("theme", _theme)
	
	ui.rect_min_size = Vector2(size.x, size.y)
	ui.rect_size = Vector2(size.x, size.y)
	
	# add drag button events
	drag_button.connect("gui_input", self, "on_drag_input")
	
	# add scroll container v scroll hack to add margin
	scroll_bar.connect("visibility_changed", self, "toggle_scrollbar_margin")
	
	# padding...
	# update rate...
	# theming...
	# etc.
	
	self.add_child(ui)

func update() -> void:
	for monitor in monitors:
		monitor.update()


func remove(_object: String) -> bool:
	return false

func add_monitor(obj: Object, property: String, identifier: String) -> void:
	
	# Choose the correct monitor type (integer, vector2, etc..)
	var new_monitor = get_monitor_of_type(obj, property)
	
	# Remove the debugger help message on the first add
	list.get_node("%HelpLabel").visible = false
	
	list.add_child(new_monitor)
	
	new_monitor.init(obj, property, identifier)
	monitors.append(new_monitor)

# This returns a configured monitor instance for the given control
func get_monitor_of_type(obj, property) -> Control:
	
	var new_monitor
	
	match typeof(obj[property]):
		TYPE_VECTOR2:
			new_monitor = debugger_monitor_vector2.instance()
		TYPE_STRING:
			new_monitor = debugger_monitor_string.instance()
		TYPE_INT:
			new_monitor = debugger_monitor_integer.instance()
		TYPE_REAL:
			new_monitor = debugger_monitor_float.instance()
			
	return new_monitor

func add_input(obj: Object, property: String, identifier: String) -> void:
	
	# Choose the correct input type (integer, vector2, etc...)
	var new_input = get_input_of_type(obj, property)
	
	list.get_node("%HelpLabel").visible = false
	
	list.add_child(new_input)
	
	new_input.init(obj, property, identifier)
	inputs.append(new_input)

func get_input_of_type(obj, property) -> Control:
	
	var new_input
	
	match typeof(obj[property]):
		#TYPE_VECTOR2:
			#new_monitor = debugger_monitor_vector2.instance()
		#TYPE_STRING:
			#new_monitor = debugger_monitor_string.instance()
		TYPE_INT:
			new_input = debugger_input_integer.instance()
		#TYPE_REAL:
			#new_monitor = debugger_monitor_float.instance()
			
	return new_input

func on_drag_input(event: InputEvent):
	
	# On left button click pressed
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		drag_pressed = true
		if not drag_start:
			drag_start = event.position
	
	# On left button click released
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and not event.pressed:
		drag_pressed = false
		
	# On button drag
	if event is InputEventMouseMotion and drag_pressed:
		if drag_start:
			self.rect_size.x += event.position.x

# Toggle the margin between the scrollbar and the content
func toggle_scrollbar_margin() -> void:
	if scroll_bar.visible:
		content_margin.set("custom_constants/margin_right", scroll_bar.rect_size.x)
		# set the margin to the double amount, to account for margin between scroll bar and its container
	else:
		content_margin.set("custom_constants/margin_right", 0)
		print("not visible")
