tool
extends PanelContainer

# Types of Monitors and Input
onready var debugger_monitor_integer = preload("res://addons/debugger/components/monitor_integer/monitor_integer.tscn")
onready var debugger_monitor_vector2 = preload("res://addons/debugger/components/monitor_vector2/monitor_vector2.tscn")
onready var debugger_monitor_string = preload("res://addons/debugger/components/monitor_string/monitor_string.tscn")
onready var debugger_monitor_float = preload("res://addons/debugger/components/monitor_float/monitor_float.tscn")
# ...
# ...

onready var ui = preload("ui.tscn").instance()
onready var list = ui.get_node("%ContentList")
onready var monitors = []

export var panel_padding: int = 10
export var width: float = 150 setget set_width, get_width

func set_width(val: float) -> void:
	self.rect_size.x = val

func get_width() -> float:
	return self.rect_size.x

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
	init()
	
func init() -> void:
	
	# Some settings
	self.rect_min_size = Vector2(150, 200)
	self.set("custom_styles/panel", StyleBoxEmpty.new())
	
	ui.rect_min_size = Vector2(150, 200)
	
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

func addMonitor(obj: Object, property: String, identifier: String) -> void:
	# chose the correct monitor type (integer, vector2, etc..)
	
	# if a vector, if a real...
	var new_monitor = get_monitor_of_type(obj, property)
	list.add_child(new_monitor)
	
	new_monitor.init(obj, property, identifier)
	monitors.append(new_monitor)

# this should return a configured instance of a specific type according to the parameter
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
