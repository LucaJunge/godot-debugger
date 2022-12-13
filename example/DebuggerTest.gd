extends Control

onready var debugger = get_node("Debugger")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var bug = get_node("Sprite")
	debugger.add(bug, "position", "Bug Position")
	debugger.add(bug, "scale", "Bug Scale")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
