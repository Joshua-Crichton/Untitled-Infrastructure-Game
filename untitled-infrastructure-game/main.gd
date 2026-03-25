extends Node

#const player_sprite: PackedScene = preload("res://player.tscn")
#
#var player : Area2D = player_sprite.instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#player.position=Global.grid_to_coordinates(Vector2i(5,5))
	#add_child(player)
	$player/player_camera.make_current()
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	toggle_architecture_mode()
	
func toggle_architecture_mode() -> void:
	if Input.is_action_just_pressed("switch_to_architecture_mode")\
	and $architect_mode.architect_mode_active:
		print("Architecture Stopped")
		$player.toggle_player_on()
		$architect_mode.toggle_architecture_mode_off()
	elif Input.is_action_just_pressed("switch_to_architecture_mode")\
	and !$architect_mode.architect_mode_active:
		print("Architecture Started")
		$architect_mode.position = $player.position
		$architect_mode.toggle_architecture_mode_on()
		$player.toggle_player_off()
