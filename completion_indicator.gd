extends SubViewport

@export var completion: float = 0.0
var completed = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Progress.mesh.material.set_shader_parameter("completion", completion)
	if not completed and completion >= 1.0:
		$AudioStreamPlayer.play()
		completed = true
