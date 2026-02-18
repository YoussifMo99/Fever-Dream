shader_type canvas_item;

uniform float blur_amount : hint_range(0.0, 10.0) = 2.0;

void fragment() {
	vec4 col = vec4(0.0);
	col += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(-SCREEN_PIXEL_SIZE.x, -SCREEN_PIXEL_SIZE.y) * blur_amount);
	col += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE.x, -SCREEN_PIXEL_SIZE.y) * blur_amount);
	col += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(-SCREEN_PIXEL_SIZE.x, SCREEN_PIXEL_SIZE.y) * blur_amount);
	col += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE.x, SCREEN_PIXEL_SIZE.y) * blur_amount);
	COLOR = col / 4.0 * COLOR;
}