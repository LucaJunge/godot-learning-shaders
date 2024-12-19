shader_type spatial;

/**
 * This is a documentation comment.
 * These lines will appear in the inspector when hovering over the shader parameters
 * You can use [b]BBCode[/b] [i]formatting[/i] in the comment.
 * The Offset From Ground shifts the model up and down.
 */
uniform float offset_from_ground = 0.5;

/**
 * This parameter influcenes the amount of waves
 */
uniform float waves = 8.0;
uniform float speed = 2.0;
uniform float wave_height = 0.5;

void vertex() {
	// Changing the waves parameter changes how warped the sphere is
	VERTEX.y += offset_from_ground + sin(VERTEX.x * waves + TIME * speed) * wave_height;
}

void fragment() {
	ALBEDO = vec3(0.1, 0.2, 0.6);
}
