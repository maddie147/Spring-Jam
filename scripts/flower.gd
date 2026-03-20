extends Area2D


@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite = $AnimatedSprite2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact = Callable(self, "_toggle_flower")


func _toggle_flower():
	sprite.frame = 1
	print("flower watered")
	GameData.total_flower_count += 1
	print("Total watered: ", GameData.total_flower_count)
	remove_child(sprite)
	get_tree().current_scene.add_child(sprite)
	sprite.global_position = global_position + Vector2(0, -16)
	queue_free()
	#animated_sprite_2d.play("default")
	#animated_sprite_2d.stop()
