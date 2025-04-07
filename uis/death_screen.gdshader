shader_type canvas_item;

varying vec4 vertex_color;
uniform float t = 0.;

void vertex() {
	vertex_color = COLOR;
}

void fragment() {
	vec2 v = UV + vec2(t);
	if (UV.x > .5 && UV.x < .8) {
		COLOR = textureLod(TEXTURE, v + vec2(t * .3, 0.), 0.) * vertex_color * vertex_color;
	} else{
		COLOR = textureLod(TEXTURE, v, 0.) * vertex_color;
	}
}
