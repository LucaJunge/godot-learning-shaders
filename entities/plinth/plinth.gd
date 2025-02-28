@tool
extends StaticBody3D

@onready var exhibit_title: Label3D = $ExhibitTitle
@onready var exhibit_number: Label3D = $ExhibitNumber

var current_exhibit: Node = null

## Scene file to display as the exhibit
@export var exhibit: PackedScene:
	get:
		return exhibit
	set(value):
		exhibit = value
		set_exhibit()

## An optional prefix placed at the left side of the plinth
@export var prefix: String:
	get:
		return prefix
	set(value):
		prefix = value
		set_label3d()

## An optional title placed on the center of the plinth
@export var title: String:
	get:
		return title
	set(value):
		title = value
		set_label3d()

## Shortcut to the shader file of the exhibit
@export var shader_file: Shader

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_label3d()

func set_label3d():
	if exhibit_title and exhibit_number:
		if not prefix.is_empty() and not title.is_empty():
			exhibit_title.text = title
			exhibit_number.text = prefix

func set_exhibit():
	# remove the old exhibit if present
	if current_exhibit:
		remove_child(current_exhibit)
		shader_file = null
		
	if exhibit != null:
		var scene_node = exhibit.instantiate()
		scene_node.position.y = 2
		current_exhibit = scene_node
		shader_file = get_first_shader_file(scene_node)
		add_child(scene_node)

func get_first_shader_file(node):
	var shader_file: Shader = null
	
	for i: Node in node.get_children():
		if i.mesh and i.mesh.material and i.mesh.material.shader != null:
			shader_file = i.mesh.material.shader
		
	return shader_file
