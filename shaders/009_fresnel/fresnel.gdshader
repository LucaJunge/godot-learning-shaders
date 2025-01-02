shader_type spatial;

uniform vec3 base_color : source_color = vec3(0.173, 0.731, 0.541);
uniform vec3 fresnel_color : source_color = vec3(0.887, 0, 1.0);
uniform float fresnel_strength = 2.0;
uniform float fresnel_amount = 1.0;

float fresnel(vec3 normal, vec3 view) {
	return pow((1.0 - clamp(dot(normal, view), 0.0, 1.0)), fresnel_amount);
}

void vertex() {
	//VERTEX.y += 0.5 + sin(VERTEX.x * 10.0 + TIME * 20.0) * 0.3;
}

void fragment() {
	float fresnel_value = fresnel(NORMAL, VIEW) * fresnel_strength;
	vec3 fresnel = fresnel_value * fresnel_color;
	
	ALBEDO = base_color + fresnel;
	ROUGHNESS = 0.05;
}