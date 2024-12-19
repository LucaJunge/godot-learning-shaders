shader_type spatial;

uniform float offset_from_ground = 0.5;
uniform float waves = 8.0;
uniform float speed = 2.0;
uniform float wave_height = 0.5;

void vertex() {
	// Changing the waves parameter changes how warped the sphere is
	VERTEX.y += offset_from_ground + sin(VERTEX.x * waves + TIME * speed) * wave_height;
}

void fragment() {
	ALBEDO = vec3(0.8, 0.5, 0.0);
	METALLIC = 1.0;
	ROUGHNESS = 0.1;
}
