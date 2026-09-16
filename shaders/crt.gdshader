shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

uniform float warp_amount : hint_range(0.0, 5.0) = 0.3;
uniform float aberration_amount : hint_range(0.0, 0.05) = 0.005;
uniform float scanline_intensity : hint_range(0.0, 1.0) = 0.2;
uniform float vignette_intensity : hint_range(0.0, 2.0) = 1.0;

vec2 warp(vec2 uv) {
	uv = uv * 2.0 - 1.0;
	vec2 offset = abs(uv.yx) / vec2(6.0, 4.0);
	uv += uv * offset * offset * warp_amount;
	uv = uv * 0.5 + 0.5;
	return uv;
}

void fragment() {
	vec2 uv = warp(UV);
	
	if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
		discard;
	}
	
	float r = texture(screen_texture, uv + vec2(aberration_amount, 0.0)).r;
	float g = texture(screen_texture, uv).g;
	float b = texture(screen_texture, uv - vec2(aberration_amount, 0.0)).b;
	vec3 col = vec3(r, g, b);
	
	float scanline = sin(uv.y * 800.0) * scanline_intensity;
	col -= scanline;
	
	vec2 vu = uv * (1.0 - uv.yx);
	float vignette = vu.x * vu.y * 15.0;
	vignette = pow(vignette, vignette_intensity);
	col *= vignette;
	
	COLOR = vec4(col, 1.0);
}