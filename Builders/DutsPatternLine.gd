@tool

extends Node3D

@export var width = 2
@export var length = 5
@export var gap = 0.25
@export var gap_length = 0.25
@export var step_up = 0.0
@export var pattern_type_1 = 0
@export var pattern_type_2 = 1
@export var pattern_type_last = 2
@export var special_last_dut = true

var duts = preload("res://Objects/dut.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for strip in range(width):
		for point in range(length):
			var pos3d = Vector3(strip * gap - (width * gap) / 2, step_up * point, point * gap_length)
			var dut = duts.instantiate()
			dut.position = pos3d
			dut.bit_type = pattern_type_last if point+1 == length and special_last_dut else pattern_type_1 if (point + strip) % 2 == 0 else pattern_type_2
			dut.set_meta(&"WhichStrip", strip)
			dut.set_meta(&"WhichPoint", point)
			add_child(dut)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.is_editor_hint():
		var last_strip = 0
		var last_point = 0
		for dut in get_children():
			var strip = dut.get_meta(&"WhichStrip")
			if strip < width:
				dut.queue_free()
				continue
			var point = dut.get_meta(&"WhichPoint")
			if point < length:
				dut.queue_free()
				continue
			var pos3d = Vector3(strip * gap - (width * gap) / 2, step_up * point, point * gap_length)
			dut.position = pos3d
			dut.bit_type = pattern_type_last if point+1 == length else pattern_type_1 if (point + strip) % 2 == 0 else pattern_type_2
			if last_strip < strip: last_strip = strip
			if last_point < point: last_point = point
		for strip in range(last_strip,width):
			for point in range(last_point,length):
				var pos3d = Vector3(strip * gap - (width * gap) / 2, step_up * point, point * gap_length)
				var dut = duts.instantiate()
				dut.position = pos3d
				dut.bit_type = pattern_type_last if point+1 == length and special_last_dut else pattern_type_1 if (point + strip) % 2 == 0 else pattern_type_2
				dut.set_meta(&"WhichStrip", strip)
				dut.set_meta(&"WhichPoint", point)
				add_child(dut)
