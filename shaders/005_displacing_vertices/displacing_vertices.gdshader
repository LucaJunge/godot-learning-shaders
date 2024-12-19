shader_type spatial;

uniform float waves = 3.0;

void vertex() {
	// Changing the waves parameter changes how warped the sphere is
	VERTEX.y += 0.5 + sin(VERTEX.x * waves + TIME * 4.0) * 0.35;
}

void fragment() {
	ALBEDO = vec3(0.1, 0.2, 0.6);
}
