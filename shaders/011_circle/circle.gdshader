shader_type spatial;
render_mode cull_disabled;

/*
	We define the center position of our circle and then ask each pixel how far from that
	center position it is. This will give the pixel a value between 0 – 1.
	We can then ask the pixel if its value is lower or higher than a predefined value.
	If it is higher we will set the pixel to white
	and if it is lower we will set it to black.
*/ 
float circle(vec2 position, float radius, float feather) {
	return smoothstep(radius, radius + feather, length(position - vec2(0.5)));
}

void fragment() {
	ALBEDO.rgb = vec3( circle(UV, 0.3, 0.0) );
}