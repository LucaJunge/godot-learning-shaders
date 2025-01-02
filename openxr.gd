extends Node

signal focus_lost
signal focus_gained
signal pose_recentered

@export var maximum_refresh_rate: int = 90

@onready var viewport: Viewport = get_viewport()
@onready var environment: Environment = %WorldEnvironment.environment
@onready var openxr_handler: Node = %OpenXR
var openxr_interface: XRInterface
var xr_is_focussed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	openxr_interface = XRServer.find_interface("OpenXR")

	if openxr_interface and openxr_interface.is_initialized():
		initialize_openxr()


func initialize_openxr() -> void:
	# Enable XR on our viewport
	get_viewport().use_xr = true

	# Make sure v-sync is off, v-sync is handled by OpenXR
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

	# Enable V"res://main.tscn"RS
	if RenderingServer.get_rendering_device():
		viewport.vrs_mode = Viewport.VRS_XR
	elif int(ProjectSettings.get_setting("xr/openxr/foveation_level")) == 0:
		push_warning("OpenXR: Recommend setting Foveation level to High in Project Settings")

	# Enable Passthrough
	environment.background_mode = Environment.BG_COLOR
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.5, 0.5, 0.5)

	# Connect the OpenXR events
	openxr_interface.session_begun.connect(_on_openxr_session_begun)
	openxr_interface.session_visible.connect(_on_openxr_visible_state)
	openxr_interface.session_focussed.connect(_on_openxr_focussed_state)
	openxr_interface.session_stopping.connect(_on_openxr_stopping)
	openxr_interface.pose_recentered.connect(_on_openxr_pose_recentered)


func _on_openxr_session_begun() -> void:
	# Get the reported refresh rate
	var current_refresh_rate: float = openxr_interface.get_display_refresh_rate()
	#if current_refresh_rate > 0:
	#	print("OpenXR: Refresh rate reported as ", str(current_refresh_rate))
	#else:
	#	print("OpenXR: No refresh rate given by XR runtime")

	# See if we have a better refresh rate available
	var new_rate: float = current_refresh_rate
	var available_rates: Array = openxr_interface.get_available_display_refresh_rates()
	if available_rates.size() == 0:
		print("OpenXR: Target does not support refresh rate extension")
	elif available_rates.size() == 1:
		# Only one available, so use it
		new_rate = available_rates[0]
	else:
		for rate: float in available_rates:
			if rate > new_rate and rate <= maximum_refresh_rate:
				new_rate = rate

	# Did we find a better rate?
	if current_refresh_rate != new_rate:
		print("OpenXR: Setting refresh rate to ", str(new_rate))
		openxr_interface.set_display_refresh_rate(new_rate)
		current_refresh_rate = new_rate

	# Match the physics rate
	Engine.physics_ticks_per_second = int(current_refresh_rate)


func _on_openxr_visible_state() -> void:
	# We always pass this state at startup,
	# but the second time we get this it means our player took the headset off
	if xr_is_focussed:
		xr_is_focussed = false

		# Pause our game
		get_tree().paused = true

		focus_lost.emit()


func _on_openxr_focussed_state() -> void:
	xr_is_focussed = true

	# unpause our game
	get_tree().paused = false

	focus_gained.emit()


func _on_openxr_stopping() -> void:
	# on_openxr_stopping.emit()
	# Our session is being stopped.
	print("OpenXR: Stopping session")


func _on_openxr_pose_recentered() -> void:
	# User recentered view, we have to react to this by recentering the view
	# This is game implementation dependent
	pose_recentered.emit()
