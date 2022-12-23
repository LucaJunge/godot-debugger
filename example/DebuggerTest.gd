extends Control

onready var debugger = get_node("MarginContainer/Debugger")

onready var unix_time = Time.get_unix_time_from_system()

var _timer = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var bug = get_node("Bug")
	var label = get_node("Label")
	
	# Add your properties
	debugger.add_input(debugger, "font_size", "Font Size")
	debugger.add_monitor(bug, "position", "Bug Position")
	debugger.add_monitor(bug, "scale", "Bug Scale")
	debugger.add_monitor(bug, "rotation_degrees", "Bug Rotation")
	debugger.add_monitor(label, "text", "Text")
	debugger.add_monitor(self, "unix_time", "Unix Time")

	
	#TODO: debugger.set_rate(30) # 30 times a second, down to 1 times a second maybe?
	# Set up the timer for a manual debugger update
	_timer = Timer.new()
	add_child(_timer)
	
	_timer.connect("timeout", self, "update_debugger")
	_timer.set_wait_time(0.5)
	_timer.set_one_shot(false)
	_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	unix_time = Time.get_unix_time_from_system()
	
	# You can update the debugger in the process function, or manually
	#debugger.update()

func update_debugger():
	#print("update")
	debugger.update()
