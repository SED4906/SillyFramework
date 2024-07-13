extends VFlowContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group(&"CharacterInfo")

var consecutive_count = 0

func update_duts(duts):
	consecutive_count = 0
	$StatsLines/Consecutive.text = ""
	$StatsLines/BitsCollected.text = "() " + str(duts)

func collected_duts(duts):
	consecutive_count += duts
	if duts == 10:
		$StatsLines/Consecutive.modulate = Color(0.4,0.4,0.4)
	elif duts == 100:
		$StatsLines/Consecutive.modulate = Color(0.9,0.6,0.2)
	elif duts == 1000:
		$StatsLines/Consecutive.modulate = Color(0.1,0.1,1.0)
	elif duts == 10000:
		$StatsLines/Consecutive.modulate = Color(0.9,0.1,1.0)
	else:
		$StatsLines/Consecutive.modulate = Color(1.0,1.0,1.0)
	$StatsLines/Consecutive.text = " + " + str(consecutive_count)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
