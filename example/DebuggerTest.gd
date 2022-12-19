extends Control

onready var debugger = get_node("Debugger")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var bug = get_node("Sprite")
	var label = get_node("Label")
	
	debugger.addMonitor(bug, "position", "Bug Position")
	debugger.addMonitor(bug, "scale", "Bug Scale")
	debugger.addMonitor(label, "text", "Text")

	#debugger.set_rate(30) # 30 times a second, down to 1 times a second maybe?
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	debugger.update()
	pass
