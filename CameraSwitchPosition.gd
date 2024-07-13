extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if has_overlapping_bodies():
		for camera in get_tree().get_nodes_in_group(&"Camera"):
			camera.position = $Node3D.global_position
			camera.rotation = rotation
