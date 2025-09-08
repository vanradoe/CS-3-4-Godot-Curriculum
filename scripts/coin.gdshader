shader_type canvas_item;

uniform vec4 color: source_color;

void fragment() {
    vec4 base_color = texture(TEXTURE, UV);
	float gray = dot(base_color.rgb, vec3(0.299, 0.587, 0.114));
	COLOR = vec4(gray * color.rgb, base_color.a);
}
