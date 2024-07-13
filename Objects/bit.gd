@tool
extends Node3D

var collected = false
@export var bit_type = 0
@export var is_enabled = true

static var pitch_scaler = 1.0
const pitch_reset_time = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$MeshInstance3D.set_instance_shader_parameter("bit_type", bit_type)
	set_meta(&"Enabled", is_enabled)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.is_editor_hint():
		$MeshInstance3D.set_instance_shader_parameter("bit_type", bit_type)
		return
	is_enabled = get_meta(&"Enabled")
	visible = is_enabled
	if not collected and $MeshInstance3D/Area.has_overlapping_areas() and is_enabled:
		var pitch_resetter = get_tree().get_first_node_in_group(&"PitchResetter")
		if pitch_resetter != null:
			pitch_resetter.start(pitch_reset_time)
			pitch_resetter.consecutive_duts_collected += 1
		$Collect.pitch_scale = pitch_scaler
		$Collect.play()
		pitch_scaler += 0.04166
		if bit_type == 2:
			$CollectBlue.play()
		elif bit_type >= 3:
			$CollectPurple.play()
		collected = true
		$MeshInstance3D.visible = false
		get_tree().root.get_node("Level").collect_duts(bit_type)


func _on_pitch_resetter_timeout():
	pitch_scaler = 1.0
