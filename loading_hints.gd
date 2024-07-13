extends HFlowContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var time = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	$Label.modulate.a = 0.75 + cos(time*10.0)/4.0
	$SubViewportContainer/SubViewport/Sprite3D.rotate_y(delta)
