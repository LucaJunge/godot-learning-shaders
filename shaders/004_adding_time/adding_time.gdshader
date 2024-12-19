shader_type spatial;

void vertex() {
	VERTEX.y += 0.5 + sin(TIME * 3.0) * 0.35;
}

void fragment() {
	ALBEDO = vec3(0.1, 0.2, 0.6);
}