extends Node

signal flower_count_changed(new_count, total_count)

var total_flower_count = 0
var max_flowers_in_level = 0


func update_flower_count(new_value):
	total_flower_count = new_value
	flower_count_changed.emit(total_flower_count, max_flowers_in_level)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
