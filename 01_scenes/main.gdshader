shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	float a = 0.0;
	for (int i=-1; i<=1; i++) {
		for (int j=-1; j<=1; j++) {
			vec2 offset = vec2(float(i), float(j));
			vec2 uv = SCREEN_UV + SCREEN_PIXEL_SIZE * offset;
			a = max(a, texture(screen_texture, uv).a);
		}
	}
	COLOR.rgb = texture(screen_texture, SCREEN_UV).rgb;
	COLOR.a = a;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
