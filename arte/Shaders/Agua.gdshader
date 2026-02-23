shader_type canvas_item;

uniform sampler2D noise_texture : repeat_enable;
uniform vec2 speed = vec2(0.1, 0.0);
uniform float wave_strength = 0.02;
uniform float alpha : hint_range(0.0, 1.0) = 0.7;

void fragment() {
    vec2 noise = texture(noise_texture, UV + speed * TIME).rg;
    noise = noise * 2.0 - 1.0;

    vec2 distorted_uv = UV + noise * wave_strength;

    COLOR = texture(TEXTURE, distorted_uv);
    COLOR.a *= alpha;
}