extends Node

const grid_size_pixels = 32

# Points to top left corner of grid tile
func grid_to_coordinates(grid_coordinate: Vector2i ) -> Vector2:
	var game_coordinate : Vector2 = grid_coordinate*grid_size_pixels
	return game_coordinate
	
func coordinates_to_grid(pixel_coordinates: Vector2) -> Vector2i:
	var grid_coordinates: Vector2i
	grid_coordinates = pixel_coordinates/grid_size_pixels
	if pixel_coordinates.x < 0:
		grid_coordinates.x -= 1
	if pixel_coordinates.y < 0:
		grid_coordinates.y -= 1
	return grid_coordinates

func snap_to_grid(pixel_coordinates: Vector2) -> Vector2:
	return grid_to_coordinates(coordinates_to_grid(pixel_coordinates))
