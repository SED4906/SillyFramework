class_name InteractableComponent extends Node3D

func _enter_tree() -> void:
	# This component can only be a child of a Node3D
	assert(get_parent() is MeshInstance3D)
	get_parent().set_meta(&"InteractableComponent", self) # Register
	var area = Area3D.new()
	var collision = CollisionShape3D.new()
	collision.shape = SphereShape3D.new()
	collision.shape.radius = 0.5
	

func _exit_tree() -> void:
	owner.remove_meta(&"InteractableComponent") # Unregister

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
