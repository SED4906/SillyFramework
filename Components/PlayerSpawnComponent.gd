class_name PlayerSpawnComponent extends Node

@export var is_enabled: bool = true

func _enter_tree() -> void:
	self.add_to_group(&"PlayerRespawnPoints")

func _exit_tree() -> void:
	pass

func find_respawn_point(player: PlayerCharacter):
	var closest_spawn = null
	var closest_distance = 999999.0 # we will hopefully never have a level this massive.
	for spawn_point in get_children():
		var spawn_distance = (player.get_last_position()-spawn_point.position).length()
		if (closest_spawn != null and spawn_distance < closest_distance) or closest_spawn == null:
			closest_spawn = spawn_point
			closest_distance = spawn_distance
	return closest_spawn.position
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
