extends Area2D

var alpha_modulation_velocity = 5
var player_inside

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_inside:
		#modulate.a = lerpf(modulate.a,0,alpha_modulation_velocity*delta)
		modulate.a = clampf(modulate.a-alpha_modulation_velocity*delta,0,1)
	else:
		modulate.a = clampf(modulate.a+alpha_modulation_velocity*delta,0,1)


#func _on_area_entered(area: Area2D) -> void:
#	player_inside = true
	


#func _on_area_exited(area: Area2D) -> void:
#	player_inside = false
