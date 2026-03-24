extends Node

const player_sprite: PackedScene = preload("res://player.tscn")

var player = player_sprite.instantiate()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.position=Global.grid_2_coordinates(Vector2i(5,5))
	add_child(player)
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	start_or_stop_architecture_mode()
	
func start_or_stop_architecture_mode():
	if Input.is_action_just_pressed("switch_to_architecture_mode")\
	and $architect_mode.process_mode == Node.PROCESS_MODE_PAUSABLE:
		print("Architecture Stopped")
		$architect_mode.hide()
		$architect_mode.process_mode = Node.PROCESS_MODE_DISABLED
	elif Input.is_action_just_pressed("switch_to_architecture_mode")\
	and $architect_mode.process_mode == Node.PROCESS_MODE_DISABLED:
		print("Architecture Started")
		$architect_mode.show()
		$architect_mode.process_mode = Node.PROCESS_MODE_PAUSABLE
