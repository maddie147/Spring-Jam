extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameData.flower_count_changed.connect(_on_flower_count_changed)


func _on_flower_count_changed(new_count, total_count):
	text = "Flowers: %d / %d" % [new_count, total_count]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
