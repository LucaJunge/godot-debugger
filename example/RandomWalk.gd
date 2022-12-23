extends Sprite

var factor: float = 0.5
var walk_distance: float = 3.15
var scale_distance: float = 0.05

func _ready() -> void:
	randomize()

func _process(_delta: float) -> void:
	position += random_walk(walk_distance)
	
	var rs = (randi() % 10 + 5) / 10.0
	scale = 2 * Vector2(rs, rs)
	
	var rot = randi() % 30 + 1
	if rotation_degrees > 0:
		rotation_degrees -= rot
	else:
		rotation_degrees += rot

func random_walk(distance: float) -> Vector2:
	var next_walk = Vector2(0, 0)
	
	randomize()
	
	if randf() > factor:
		next_walk.x += distance
	else:
		next_walk.x -= distance
	
	randomize()
	
	if randf() > factor:
		next_walk.y += distance
	else:
		next_walk.y -= distance
	
	return next_walk
