extends Node

const Spikes = preload("res://Towers/Spikes.tscn")

func _unhandled_input(event: InputEvent) -> void:
	var world := get_tree().current_scene
	if event is InputEventMouseMotion:
		var mouse_position = event.position
		var ray = RayCast2D.new()
		ray.global_position = mouse_position
		world.add_child(ray)
		ray.cast_to = Vector2.DOWN * 10000
		ray.force_raycast_update() # don't wait for next physics frame but immediately get the collision data
		if ray.is_colliding():
			var collision_point = ray.get_collision_point()
			print(collision_point)
		ray.queue_free()
	

	if event.is_action_pressed("select"):
		# TODO use a camera and make it work
		var mouse_position = event.position
		print(get_tree().current_scene.get_world_2d().direct_space_state)
		var space_state = get_tree().current_scene.get_world_2d().direct_space_state
		var collision_objects = space_state.intersect_point(mouse_position, 1)
		if collision_objects:
			var collider = collision_objects[0].collider
			print(collider.name)
		else:

			print('no hit')
			var spikes = Spikes.instance()
			spikes.global_position = mouse_position
			get_tree().current_scene.add_child(spikes)
