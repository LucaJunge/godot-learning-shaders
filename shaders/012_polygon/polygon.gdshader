shader_type spatial;
render_mode cull_disabled;

vec4 polygon(vec2 uv, float width, int sides)
{
	// UV goes from [0 , 1], we multiply by two ( [0, 2] ) and subtract one [ -1, 1]
	// So the range is centered
	uv = uv * 2.0 - 1.0;

	// Get the angle from the point to the center, starting with 0 at the middle left side
	float angle = atan(uv.x, uv.y);

	float radius = TAU / float(sides);

	float dist = cos(floor(0.5 + angle / radius) * radius - angle) * length(uv);

	float poly = step(width, dist);

	return vec4(vec3(poly), 1.0);
}

void fragment() {
	// Multiply [0, 1] range of sine to [0, 7]
	float side_value = 7.0 * sin(TIME);

	// shift the value to half = [3, 10]
	side_value = side_value + 3.0;

	ALBEDO = vec3(polygon(UV, 0.3, clamp(int(side_value), 3, 9)).rgb);
}