extends Control

onready var draggable_texture = preload("icon-16.png")

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
	print("Debugger ready")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Engine.editor_hint:
		return
		
	for identifier in monitor:
		var dict = monitor[identifier]
		
		var object = dict.object
		var property_string = dict.property
		
		var property = object[property_string]
		var element = dict.element
		
		# check for different types
		if typeof(property) == TYPE_VECTOR2:
			element.text = "x: %.2f, y: %.2f" % [property.x, property.y]

func add(_object: Node, _property: String, identifier: String = "") -> void:
	
	# add label
	var label = Label.new()
	label.text = identifier
	container.add_child(label)
	
	monitor[identifier] = {"object": _object, "property": _property, "element": label}
	print("added %s to debugger" % identifier)

func remove(_object: String) -> bool:
	return false

func init() -> void:
	
	# Panel
	var panel_container = PanelContainer.new()
	var panel_hbox = VBoxContainer.new()
	var margin_container = MarginContainer.new()
	container = VBoxContainer.new()
	
	# Heading and Draggable
	var heading_container = HBoxContainer.new()
	heading_container.name = "Heading Container"
	
	var heading_label = Label.new()
	heading_label.text = "DEBUGEER"
	heading_label.valign = VALIGN_CENTER
	heading_label.size_flags_horizontal = SIZE_EXPAND_FILL
	
	var heading_draggable = TextureButton.new()
	heading_draggable.texture_normal = draggable_texture
	#heading_draggable.connect("button_down", self, "on_button_down")
	
	heading_container.size_flags_horizontal = SIZE_EXPAND_FILL
	heading_container.add_child(heading_draggable)
	heading_container.add_child(heading_label)
	
	margin_container.add_constant_override("margin_top", panel_padding)
	margin_container.add_constant_override("margin_right", panel_padding)
	margin_container.add_constant_override("margin_bottom", panel_padding)
	margin_container.add_constant_override("margin_left", panel_padding)
	
	# 1st level layout
	panel_container.add_child(margin_container)
	
	margin_container.add_child(panel_hbox)
	
	# 2nd level layout
	panel_hbox.add_child(heading_container)
	
	# 3rd level layout
	container.name = "DebugContainer"
	panel_hbox.add_child(container)
	
	
	self.add_child(panel_container)

func on_button_down(event) -> void:
	drag_start = event.position
	print(drag_start)
	print("on click")
	pass
