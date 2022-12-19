extends PanelContainer
# MONITOR VECTOR2

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
	value_label.text = str("%.2f, %.2f" % [ obj[property].x, obj[property].y ])
