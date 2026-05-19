extends Node3D
@export var npc_scene: PackedScene
@export var body_materials : Array[Material]
@export var head_materials : Array[Material]
@export var hat_materials : Array[Material]
@export var hatband_materials : Array[Material]
@export var enemy_count = 3
@onready var camera = $Player/XRCamera3D
@onready var enemies = $Enemies
var xr_interface: XRInterface

func _ready():
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialized successfully")
		# Turn off v-sync!
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		# Change our main viewport to output to the HMD
		get_viewport().use_xr = true
		spawn_enemies()
	else:
		print("OpenXR not initialized, please check if your headset is connected")
func generate_random_appearance():
	return {
		"body": body_materials.pick_random(),
		"head": head_materials.pick_random(),
		"hat": hat_materials.pick_random(),
		"hatband": hatband_materials.pick_random()
	}
func spawn_enemies():
	for i in range(enemy_count):
		var npc = npc_scene.instantiate()
		var camera_forward = -camera.global_transform.basis.z
		var camera_right = camera.global_transform.basis.x
		var forward_distance = randf_range(3.0, 6.0)
		var side_offset = randf_range(-2.0, 2.0)
		var height_offset = randf_range(-0.5, 0.5)
		npc.global_position = camera.global_position + camera_forward * forward_distance + camera_right * side_offset + Vector3(0, height_offset, 0)
		enemies.add_child(npc)
		npc.apply_appearance(generate_random_appearance())
func restart_game():
	for child in enemies.get_children():
		if child.is_in_group("enemy"):
			child.queue_free()
	spawn_enemies()
