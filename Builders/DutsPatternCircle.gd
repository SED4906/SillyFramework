@tool
extends Node3D

@export var radius = 1.0
@export var width = 2
@export var gap = 0.25
@export var points = 10
@export var pattern_type_1 = 0
@export var pattern_type_2 = 1

var duts = preload("res://Objects/dut.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for ring in range(width):
		for point in range(points):
			var pos2d = Vector2.from_angle(2*PI*point/points) * (radius + gap * ring);
			var pos3d = Vector3(pos2d.x, 0.0, pos2d.y)
			var dut = duts.instantiate()
			dut.position = pos3d
			dut.bit_type = pattern_type_1 if (point + ring) % 2 == 0 else pattern_type_2
			dut.set_meta(&"WhichRing", ring)
			dut.set_meta(&"WhichPoint", point)
			add_child(dut)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.is_editor_hint():
		var last_ring = 0
		var last_point = 0
		for dut in get_children():
			var ring = dut.get_meta(&"WhichRing")
			if ring < width:
				dut.queue_free()
				continue
			var point = dut.get_meta(&"WhichPoint")
			if point < points:
				dut.queue_free()
				continue
			var pos2d = Vector2.from_angle(2*PI*point/points) * (radius + gap * ring);
			var pos3d = Vector3(pos2d.x, 0.0, pos2d.y)
			dut.position = pos3d
			dut.bit_type = pattern_type_1 if (point + ring) % 2 == 0 else pattern_type_2
			if last_ring < ring: last_ring = ring
			if last_point < point: last_point = point
		for ring in range(last_ring,width):
			for point in range(last_point,points):
				var pos2d = Vector2.from_angle(2*PI*point/points) * (radius + gap * ring);
				var pos3d = Vector3(pos2d.x, 0.0, pos2d.y)
				var dut = duts.instantiate()
				dut.position = pos3d
				dut.bit_type = pattern_type_1 if (point + ring) % 2 == 0 else pattern_type_2
				dut.set_meta(&"WhichRing", ring)
				dut.set_meta(&"WhichPoint", point)
				add_child(dut)
