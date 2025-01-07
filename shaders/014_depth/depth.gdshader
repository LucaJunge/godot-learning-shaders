shader_type spatial;
render_mode unshaded, depth_draw_never, cull_disabled;

uniform float depth_factor: hint_range(0.0, 256.0, 0.1) = 80.0;
uniform float pow_factor: hint_range(0.0, 10.0, 0.1) = 1.0;
uniform sampler2D depth_texture : hint_depth_texture;

void fragment() {
	// Read the depth from the SCREEN_UV
	float depth = texture(depth_texture, SCREEN_UV).x;

	// Normalize the device coordiantes
	// See (https://docs.godotengine.org/en/latest/tutorials/shaders/advanced_postprocessing.html)
	// for details on Vulkan vs. OpenGL coordinates

	// Puts the normalized device coordinates into X and Y and the depth coordinates into Z
	vec3 ndc = vec3(SCREEN_UV * 2.0 - 1.0, depth);

	// Convert NDC to view space (also known as camera space or eye space)
	// View Space gives positions relative to the camera, so Z will give the
	// distance from the camera to the point
	vec4 view = INV_PROJECTION_MATRIX * vec4(ndc, 1.0);
	
	// Transforms the homogeneous coordinates into 3D space
	// this is a common line in 3D graphics
	view.xyz /= view.w;
	
	// negate the z value due to vulkans coordinate system
	float linear_depth = -view.z;

	ALBEDO = vec3(linear_depth / depth_factor);
}
