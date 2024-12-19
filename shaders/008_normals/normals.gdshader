shader_type spatial;

// To send data from the vertex to the fragment (or light) processor function,
// varyings are used. They are set for every primitive vertex in the vertex processor,
// and the value is interpolated for every pixel in the fragment processor.
varying vec3 color;

void vertex() {
	color = NORMAL;
}

void fragment() {
	ALBEDO = color;
}