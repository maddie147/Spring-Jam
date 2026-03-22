extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	# Count how many nodes are in the "flowers" group
	var flowers_in_scene = get_tree().get_nodes_in_group("flower").size()
	GameData.max_flowers_in_level = flowers_in_scene
	GameData.update_flower_count(0)
	print("Level started: Counter reset to 0")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
