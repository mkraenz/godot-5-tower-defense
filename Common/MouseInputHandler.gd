extends Node2D

const Spikes = preload("res://Towers/Spikes.tscn")

onready var ray = $Ray
onready var nexus = Nexus

var far_off_screen = Vector2(-10000, -10000)
var spawn_point = Vector2.ZERO
var blueprint = null
onready var cam: Camera2D = get_node("/root/World/Cam") 

func _ready() -> void:
	var spikes = Spikes.instance()
	spikes.global_position = far_off_screen
	blueprint = spikes

func _unhandled_input(event: InputEvent) -> void:
	var world := get_tree().current_scene

	if not blueprint.is_inside_tree():
		world.add_child(blueprint)
		blueprint.turn_into_blueprint()

	if event is InputEventMouseMotion:
		# to get the world coordinates, we have to correct the mouse position by the cam position
		ray.global_position = get_global_mouse_position()
		ray.force_raycast_update() # don't wait for next physics frame but immediately get the collision data
		if ray.is_colliding():
			var collision_point = ray.get_collision_point()
			spawn_point = collision_point
			blueprint.global_position = spawn_point
			blueprint.update_placeable()
			# TODO 
			# X create projected tower
			# X collide projected tower with other towers (mask: towers)
			# X if no collision -> green (can spawn new tower)
			# X if collision -> red (cannot spawn new tower)
			# on click and if green -> spawn
	

	# TODO use a camera and make it work, too
	if event.is_action_pressed("select"):
		if blueprint.can_be_placed and nexus.can_buy(blueprint.costs):
			place_instance()

		# adapted code for 3.5 from https://godotengine.org/qa/3719/how-to-get-a-node-by-mouse-click comment by luislodosm 
		# var mouse_position = event.positionK
		# var space_state = world.get_world_2d().direct_space_state
		# var collision_objects = space_state.intersect_point(mouse_position, 1)
		# if collision_objects:
		# 	var collider = collision_objects[0].collider
		# 	print(collider.name)
		# else:

		# 	print('no hit')

func place_instance() -> void:
	var instance = Spikes.instance()
	instance.global_position = blueprint.global_position
	get_tree().current_scene.add_child(instance)
	nexus.add_money(-blueprint.costs)
