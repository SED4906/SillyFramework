class_name BakedCollisionComponent extends MeshInstance3D

@export var is_enabled: bool = true

func _enter_tree() -> void:
	self.create_trimesh_collision()

func _exit_tree() -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
