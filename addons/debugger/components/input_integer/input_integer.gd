extends PanelContainer
# INPUT INTEGER

onready var identifier_label = get_node("%identifier")
onready var value_label = get_node("%value")

var obj: Object = Object()
var property: String = ""
var identifier: String = ""

func init(_obj: Object, _property: String, _identifier: String) -> void:
	obj = _obj
	property = _property
		
	# Set identifier
	identifier_label.text = str(_identifier)
	
	# Set value to specific text representation
	value_label.text = str(obj[property])

func update() -> void:
	value_label.text = str(obj[property])

func _on_value_text_changed(new_text: String) -> void:
	obj[property] = int(new_text)
	pass # Replace with function body.
