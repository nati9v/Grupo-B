shader_type canvas_item;

uniform float intensity = 0.02;
uniform float speed = 8.0;
uniform float block_size = 0.05;

void fragment() {
    vec2 uv = UV;

    float block = floor(uv.y / block_size);
    float offset = sin(block * 12.9898 + TIME * speed) * intensity;
	
	float t = fract(TIME * 1.0);
	float glitch_on = smoothstep(0.6, 0.8, t) * (1.0 - smoothstep(0.8, 1.0, t));
    uv.x += offset * glitch_on;

    COLOR = texture(TEXTURE, uv);
}