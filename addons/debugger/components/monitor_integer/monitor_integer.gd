extends PanelContainer

onready var identifier = get_node("%identifier")
onready var value = get_node("%value")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func init(obj, property, _identifier) -> void:
	identifier.text = str(_identifier)
	value.text = str(obj[property])
	
func update() -> void:
	pass
