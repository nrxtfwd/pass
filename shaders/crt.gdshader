shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float scanline_intensity : hint_range(0.0, 1.0) = 0.3;
uniform float warp : hint_range(0.0, 0.1) = 0.02;

vec2 uv_curve(vec2 uv) {
    uv = uv * 2.0 - 1.0;
    vec2 offset = abs(uv.yx) / vec2(6.0, 4.0);
    uv += uv * offset * offset;
    uv = uv * 0.5 + 0.5;
    return uv;
}

void fragment() {
    vec2 uv = uv_curve(SCREEN_UV);
    
    vec4 col = texture(SCREEN_TEXTURE, uv);
    
    if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0);
    } else {
        float scanline = sin(uv.y * 800.0) * scanline_intensity;
        col.rgb -= scanline;
        COLOR = col;
    }
}