shader_type spatial;

uniform float my_variable = 0.0;

void vertex() {
	VERTEX.y += my_variable;
	// Called for every vertex the material is visible on.
}

void fragment() {
	ALBEDO = NORMAL;
	// Called for every pixel the material is visible on.
}