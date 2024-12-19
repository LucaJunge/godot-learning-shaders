@tool
extends StaticBody3D

@onready var exhibit_title: Label3D = $ExhibitTitle
@onready var exhibit_number: Label3D = $ExhibitNumber

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
