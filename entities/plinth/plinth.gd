@tool
extends StaticBody3D

@onready var exhibit_title: Label3D = $ExhibitTitle
@onready var exhibit_number: Label3D = $ExhibitNumber

var current_exhibit: Node = null

@export_group("Exhibit Settings")
@export var exhibit: PackedScene:
	get:
		return exhibit
	set(value):
		exhibit = value
		set_exhibit()

@export var prefix: String:
	get:
		return prefix
	set(value):
		prefix = value
		set_label3d()

@export var title: String:
	get:
		return title
	set(value):
		title = value
		set_label3d()

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
		
	if exhibit != null:
		var scene_node = exhibit.instantiate()
		scene_node.position.y = 2
		current_exhibit = scene_node
		add_child(scene_node)
