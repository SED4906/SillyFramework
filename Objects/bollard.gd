extends MeshInstance3D

var is_used = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_used: return
	if $Interaction/Area3D.has_overlapping_bodies():
		for hinter in get_tree().get_nodes_in_group(&"HintHelp"):
			hinter.set_hint_icon("res://Images/HelpIcons/purplepink_interactables.png")
			hinter.set_hint_text("Characters that blush these colors can use these.")
	if Input.is_action_pressed("interact") and $Interaction/Area3D.has_overlapping_bodies():
		for child in get_children():
			if child.has_meta(&"Enabled"):
				child.set_meta(&"Enabled", true)
		is_used = true
