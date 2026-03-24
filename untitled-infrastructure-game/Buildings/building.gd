extends CanvasGroup

const building_exterior_scene: PackedScene = preload("res://Buildings/building_exterior.tscn")

var player_entered_count: int = 0
var alpha_modulation_velocity = 5
var building_parts_dict: Dictionary[Vector2i,Area2D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	add_building_part(Vector2i(1,1))
	add_building_part(Vector2i(1,2))
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (player_entered_count):
		modulate.a = clampf(modulate.a-alpha_modulation_velocity*delta,0,1)
	else:
		modulate.a = clampf(modulate.a+alpha_modulation_velocity*delta,0,1)

func _building_part_entered(area: Area2D):
	player_entered_count+=1

func _building_part_exited(area: Area2D):
	player_entered_count-=1

func add_building_part(grid_position: Vector2i) -> void:
	for already_placed_part in building_parts_dict.keys():
		if already_placed_part == grid_position:
			print("Part already placed here: "+ str(grid_position))
			return
	building_parts_dict[grid_position] = building_exterior_scene.instantiate()
	building_parts_dict[grid_position].position = \
	Global.grid_2_coordinates(grid_position)
	building_parts_dict[grid_position].connect("area_entered",_building_part_entered)
	building_parts_dict[grid_position].connect("area_exited",_building_part_exited)
	add_child(building_parts_dict[grid_position])
	

	
	
	
	
	
	
