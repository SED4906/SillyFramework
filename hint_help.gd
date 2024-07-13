extends HFlowContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group(&"HintHelp")
	modulate.a = 0.0

var time = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	modulate.a -= delta
	time += delta
	$Label.modulate.a = 0.75 + cos(time*10.0)/4.0

var icon_current = ""

func set_hint_icon(icon):
	if icon_current != icon:
		$Spinner.texture = load(icon)
		icon_current = icon

func set_hint_text(text):
	$Label.text = text
	modulate.a = 1.0
