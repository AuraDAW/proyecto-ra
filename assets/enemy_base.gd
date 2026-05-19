extends CharacterBody3D

@onready var body_mesh = $EnemyModel/Body
@onready var head_mesh = $EnemyModel/Head
@onready var hat_mesh = $EnemyModel/Hat
@onready var hatband_mesh = $EnemyModel/HatBand
func _ready():
	add_to_group("enemy")
func apply_appearance(data):
	body_mesh.material_override = data["body"]
	head_mesh.material_override = data["head"]
	hat_mesh.material_override = data["hat"]
	hatband_mesh.material_override = data["hatband"]
