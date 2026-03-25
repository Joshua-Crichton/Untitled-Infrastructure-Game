extends Area2D

@export var speed : float = 200

#var screen_size
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#screen_size = get_viewport_rect().size
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player_movement(delta)

func player_movement(delta: float) -> void:
	var velocity : Vector2 = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta

func toggle_player_on() -> void:
	hide()
	collision_layer = 0
	process_mode = Node.PROCESS_MODE_DISABLED
	
func toggle_player_off() -> void:
	$player_camera.make_current()
	show()
	collision_layer = 1
	process_mode = Node.PROCESS_MODE_PAUSABLE
