extends Control

onready var ui = preload("ui.tscn").instance()
onready var list = ui.get_node("%ContentList")

# Types of Monitors and Input
onready var debugger_monitor_integer = preload("res://addons/debugger/components/monitor_integer/monitor_integer.tscn")


# dragging
var drag_start: Vector2 = Vector2(0, 0)
var drag_end: Vector2 = Vector2(0, 0)

export var panel_padding: int = 10
var monitor: Dictionary = {}
var container: VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.editor_hint:
		return
		
	init()
	
func init() -> void:
	
	# Some settings
	ui.rect_min_size = Vector2(300, 500)
	# padding...
	# update rate...
	# theming...
	# etc.
	
	self.add_child(ui)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Engine.editor_hint:
		return

func remove(_object: String) -> bool:
	return false

func addMonitor(obj, property, identifier) -> void:
	# chose the correct monitor type (integer, vector2, etc..)
	
	# if a vector, if a real...
	if typeof(obj[property]) == TYPE_VECTOR2:
		print("is vector")
		print(typeof(obj[property]))
		
		var new_monitor = debugger_monitor_integer.instance()
		
		# add it first, so the child elements are instantiated
		list.add_child(new_monitor)
		
		# the monitors should have an init function that sets label and value
		# and also an update function
		new_monitor.init(obj, property, identifier)
	pass
