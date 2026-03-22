extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -360.0
const GRAVITY = 900.00
const FALL_GRAVITY = 1100.00

var was_in_air := false
var just_landed := false
var is_landing := false
var can_pick_up_watering_can := false
var has_watering_can := false
var is_picking_up := false
var nearby_pickup_object = null

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func play_state_animation(base_name: String) -> void:
	if has_watering_can:
		animated_sprite.play(base_name + "_Can")
	else:
		animated_sprite.play(base_name)

func _physics_process(delta: float) -> void:
	if is_picking_up:
		velocity.x = 0
		move_and_slide()
		return

	if Input.is_action_just_pressed("interact") and can_pick_up_watering_can and not has_watering_can:
		start_pickup()
		return
		
	# Add the gravity.
	if not is_on_floor():
		if velocity.y < 0:
			velocity.y += GRAVITY * delta
		else:
			velocity.y += FALL_GRAVITY * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#Get the input direction: -1, 0, 1
	var direction := Input.get_axis("Left", "Right")
	
	#Flip the sprite
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	#Apply Movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# Detect landing AFTER movement
	just_landed = is_on_floor() and was_in_air

	#Play animations
	if just_landed and not is_landing:
		is_landing = true
		play_state_animation("Land")
	elif is_landing:
		pass
	elif not is_on_floor():
		if velocity.y <0:
			play_state_animation("Jump")
		else:
			play_state_animation("Fall")
	else:
		if direction == 0:
			play_state_animation("Idle")
		else:
			play_state_animation("Run")

	# Save air state for next frame
	was_in_air = not is_on_floor()

func start_pickup() -> void:
	is_picking_up = true
	velocity = Vector2.ZERO
	animated_sprite.play("Pickup_Can")

func set_nearby_pickup(obj) -> void:
	if has_watering_can:
		return
	can_pick_up_watering_can = true
	nearby_pickup_object = obj

func clear_nearby_pickup(obj) -> void:
	if nearby_pickup_object == obj:
		can_pick_up_watering_can = false
		nearby_pickup_object = null

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "Land" or animated_sprite.animation == "Land_Can":
		is_landing = false

	if animated_sprite.animation == "Pickup_Can":
		is_picking_up = false
		has_watering_can = true

		if nearby_pickup_object != null:
			nearby_pickup_object.collect_watering_can()

		can_pick_up_watering_can = false
