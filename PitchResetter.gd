extends Timer

var consecutive_duts_collected = 0
const consecutive_duts_threshold = 8

func _enter_tree():
	self.add_to_group(&"PitchResetter")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timeout():
	get_tree().get_first_node_in_group(&"CharacterInfo").update_duts(get_tree().root.get_node("Level").current_total_duts)
	if consecutive_duts_collected >= consecutive_duts_threshold:
		$Finish.play()
	consecutive_duts_collected = 0
