extends Node2D

const building_exterior_scene: PackedScene = \
preload("res://Buildings/building_exterior.tscn")
#Maybe avoid preloading, keeps node in memory even after use

var player_entered_count: int = 0
var alpha_modulation_velocity : float = 5
var building_parts_dict: Dictionary[Vector2i,Area2D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	add_building_part(Vector2i(1,1))
	add_building_part(Vector2i(1,2))
	add_building_part(Vector2i(2,2))
	add_building_part(Vector2i(3,2))
	add_building_part(Vector2i(3,1))
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (player_entered_count):
		$building_front_wall.modulate.a =\
		clampf($building_front_wall.modulate.a-alpha_modulation_velocity*delta,0,1)
	else:
		$building_front_wall.modulate.a =\
		clampf($building_front_wall.modulate.a+alpha_modulation_velocity*delta,0,1)
	if Input.is_action_just_pressed("select"):
		add_building_part_on_click(get_global_mouse_position())

func _building_part_entered(_area: Area2D) -> void:
	player_entered_count+=1
	#print(player_entered_count)

func _building_part_exited(_area: Area2D) -> void:
	player_entered_count-=1

func add_building_part(grid_position: Vector2i) -> void:
	for already_placed_part:Vector2i in building_parts_dict.keys():
		if already_placed_part == grid_position:
			print("Part already placed here: "+ str(grid_position))
			return
	building_parts_dict[grid_position] = \
	building_exterior_scene.instantiate()
	
	building_parts_dict[grid_position].position = \
	Global.grid_to_coordinates(grid_position)
	
	building_parts_dict[grid_position].connect("area_entered",_building_part_entered)
	building_parts_dict[grid_position].connect("area_exited",_building_part_exited)
	
	add_child(building_parts_dict[grid_position])
	update_building()
	
func add_building_part_on_click(coordinate_position: Vector2) -> void:
	add_building_part(Global.coordinates_to_grid(coordinate_position))
	
func update_building() -> void:
	var maximum_y_value: Dictionary[int,int]
	for building_parts: Vector2i in building_parts_dict.keys():
		if !maximum_y_value.has(building_parts.x):
			maximum_y_value[building_parts.x] = building_parts.y
			continue
		elif maximum_y_value[building_parts.x] >= building_parts.y:
			continue
		else:
			maximum_y_value[building_parts.x] = building_parts.y
	maximum_y_value.sort()
	for building_parts: Vector2i in building_parts_dict.keys():
		if building_parts.y == maximum_y_value[building_parts.x]\
		and maximum_y_value.keys()[0]!=building_parts.x \
		and maximum_y_value.keys()[-1]!=building_parts.x:
			building_parts_dict[building_parts].reparent($building_front_wall)
			print(maximum_y_value.keys()[0])
			print(building_parts.x)
		else:
			building_parts_dict[building_parts].reparent($building_always_visible)
