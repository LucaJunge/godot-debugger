tool
extends EditorPlugin


func _enter_tree() -> void:
	add_custom_type("Debugger", "Control", preload("debugger.gd"), preload("icon-16.png"))


func _exit_tree() -> void:
	remove_custom_type("Debugger")
