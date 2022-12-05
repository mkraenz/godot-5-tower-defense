extends Node

const Spikes = preload("res://Towers/Spikes.tscn")

onready var ray = $Ray
var spawn_point = Vector2.ZERO


func _unhandled_input(event: InputEvent) -> void:
	var world := get_tree().current_scene
	if event is InputEventMouseMotion:
		var mouse_position = event.position
		print(mouse_position)
		ray.global_position = mouse_position
		ray.force_raycast_update() # don't wait for next physics frame but immediately get the collision data
		if ray.is_colliding():
			var collision_point = ray.get_collision_point()
			spawn_point = collision_point
			# TODO create projected tower
			# collide projected tower with other towers (mask: towers)
			# if no collision -> green (can spawn new tower)
			# if collision -> red (cannot spawn new tower)
	

	if event.is_action_pressed("select"):
		# TODO use a camera and make it work
		var mouse_position = event.position
		# adapted code for 3.5 from https://godotengine.org/qa/3719/how-to-get-a-node-by-mouse-click comment by luislodosm 
		var space_state = world.get_world_2d().direct_space_state
		var collision_objects = space_state.intersect_point(mouse_position, 1)
		if collision_objects:
			var collider = collision_objects[0].collider
			print(collider.name)
		else:

			print('no hit')
			var spikes = Spikes.instance()
			spikes.global_position = spawn_point
			world.add_child(spikes)
