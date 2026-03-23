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
	pass
	
