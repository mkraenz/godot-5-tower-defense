extends Node2D

export (PackedScene) var Spawn

onready var spawn_timer = $SpawnTimer

func _on_SpawnTimer_timeout() -> void:
	spawn_object()

func spawn_object() -> void:
	var spawn = Spawn.instance()
	spawn.global_position = global_position
	get_tree().current_scene.add_child(spawn)

