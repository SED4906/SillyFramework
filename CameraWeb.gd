extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	for vertex in get_children():
		vertex.add_to_group(&"CameraWeb")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
