extends MarginContainer

onready var list = get_node("%ContentList")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func addMonitor(scene) -> void:
	print(scene)
	print("added new Monitor")
	
	list.add_child(scene)
