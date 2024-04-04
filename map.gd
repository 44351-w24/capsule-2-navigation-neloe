extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	
	if event is InputEventMouseButton:
		if event.button_index == 4:
			$Follower.movement_speed += 20
		elif event.button_index == 5:
			$Follower.movement_speed -= 20
		elif not event.pressed :
			#print(event.global_position, 
			#	  $tiles.local_to_map(to_local(event.global_position)))
			#print($tiles.get_cell_atlas_coords(0, 
			#$tiles.local_to_map(to_local(event.global_position))))
			var tile_coord = $tiles.local_to_map(to_local(event.global_position))
			if $tiles.get_cell_atlas_coords(0, tile_coord).x == 1:
				$Follower.set_movement_target(tile_coord*64 + Vector2i(32, 32))
