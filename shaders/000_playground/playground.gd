@tool
extends Node3D

@export var my_variable: float = 1.0:
	set(value):
		my_variable = value
		shader_material.set_shader_parameter("my_variable", value)

@onready var shader_material = $MeshInstance3D.mesh.material

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
