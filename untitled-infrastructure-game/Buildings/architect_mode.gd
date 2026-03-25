extends Node2D

const new_building: PackedScene = preload("res://Buildings/building.tscn")
const camera_speed : float = 10
var architect_mode_active: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	architect_mode_active = can_process()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_camera(delta)
	set_highlight_position()
	
	#$highlight.position = get_global_mouse_position()
	
func move_camera(delta: float) -> void:
	var camera_velocity : Vector2 = Vector2.ZERO
	var viewport_rectangle : Rect2 = get_viewport_rect()
	var viewport_top_left : Vector2 = -viewport_rectangle.size/2
	var viewport_bottom_right : Vector2 = viewport_rectangle.size/2
	var viewport_horizontal_margin : float = viewport_rectangle.size.x*0.1
	var viewport_vertical_margin : float = viewport_rectangle.size.y*0.1
	if (get_local_mouse_position().x<viewport_top_left.x+viewport_horizontal_margin):
		camera_velocity.x -= 1
	if (get_local_mouse_position().x>viewport_bottom_right.x-viewport_horizontal_margin):
		camera_velocity.x += 1
	if (get_local_mouse_position().y<viewport_top_left.y+viewport_vertical_margin):
		camera_velocity.y -= 1
	if (get_local_mouse_position().y>viewport_bottom_right.y-viewport_vertical_margin):
		camera_velocity.y += 1

	if camera_velocity.length() > 0:
		camera_velocity = camera_velocity.normalized() * camera_speed
	
	position += camera_velocity*delta*camera_speed
	
func set_highlight_position() -> void:
	$highlight.position = \
	Global.snap_to_grid(get_global_mouse_position())-position

func toggle_architecture_mode() -> void:
	if architect_mode_active:
		hide()
		process_mode = Node.PROCESS_MODE_DISABLED
	else:
		show()
		process_mode = Node.PROCESS_MODE_PAUSABLE
		$architect_camera.make_current()

func toggle_architecture_mode_off() -> void:
	hide()
	process_mode = Node.PROCESS_MODE_DISABLED
	
func toggle_architecture_mode_on() -> void:
	show()
	process_mode = Node.PROCESS_MODE_PAUSABLE
	$architect_camera.make_current()
