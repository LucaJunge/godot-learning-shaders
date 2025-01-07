shader_type spatial;
render_mode unshaded;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, repeat_disable, filter_nearest;
uniform float blur_power: hint_range(0.0, 0.2, 0.001) = 0.05;
uniform sampler2D noise_texture;

vec2 noise(vec2 uv) {
	return texture(noise_texture, uv).xy - 0.5;
}

void fragment() {
	vec2 uv = SCREEN_UV;
	ALBEDO.rgb = texture(SCREEN_TEXTURE, uv + noise(uv)).rgb * blur_power;
}