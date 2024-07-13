extends Node3D

var completion = 0
@export var threshold = 10000
var current_total_duts = 0
var completed = false
# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_tree().get_first_node_in_group(&"PlayerCharacters")
	if player != null:
		player.is_active = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func collect_duts(type):
	var collect_count = pow(10,type+1)
	current_total_duts += collect_count
	completion = current_total_duts / threshold
	if not completed:
		$"Control/SubViewportContainer/CompletionIndicator".completion = completion
	if completion >= 1.0:
		completed = true
	get_tree().get_first_node_in_group(&"CharacterInfo").collected_duts(collect_count)
