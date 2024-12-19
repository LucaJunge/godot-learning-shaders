shader_type spatial;

void vertex() {
	VERTEX.y += 0.5;
}

void fragment() {
	ALBEDO = vec3(0.1, 0.2, 0.6);
}