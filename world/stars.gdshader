shader_type canvas_item;

float random(vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}

uniform float size = 32;

void fragment() {
	vec2 v = UV / TEXTURE_PIXEL_SIZE;

	vec2 v_div_size = floor(v / vec2(size));
	vec2 v_mod_size = mod(v, vec2(size));

	vec2 star_pos = floor(vec2(4.) + vec2(
		random(v_div_size),
		random(-v_div_size)
	) * vec2(size - 8.));

	COLOR.xyz = vec3(1. - step(1., max(
		distance(star_pos.x, v_mod_size.x),
		distance(star_pos.y, v_mod_size.y)
	))) * random(v_div_size);

	//if (v_mod_size.x < 1. || v_mod_size.y < 1.) {
		//COLOR.xyz *= 0.;
	//}
}
